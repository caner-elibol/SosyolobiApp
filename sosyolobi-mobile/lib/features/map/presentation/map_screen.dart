import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:maplibre_gl/maplibre_gl.dart' show LatLng;

import '../../../core/domain/category.dart';
import '../../../core/domain/enums.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/router/route_paths.dart';
import '../../../core/theme/colors.dart';
import '../../../core/utils/date_filters.dart';
import '../../../core/widgets/empty_state.dart';
import '../../activities/application/activities_providers.dart';
import '../../activities/application/categories_provider.dart';
import '../../activities/domain/activity.dart';
import '../../activities/presentation/widgets/activity_card.dart';
import '../application/current_location_provider.dart';
import '../application/map_activities_provider.dart';
import '../application/nearby_activities_slider_provider.dart';
import '../domain/current_location.dart';
import 'map_explore_screen.dart';
import 'widgets/date_range_filter_row.dart';
import 'widgets/filter_chips.dart';
import 'widgets/location_permission_card.dart';
import 'widgets/map_filter_dropdowns.dart';
import 'widgets/map_preview_card.dart';
import 'widgets/create_activity_promo_card.dart';
import 'widgets/nearby_activity_card.dart';

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  String? _selectedCategoryId;
  int _radiusMeters = 10000;
  GenderPreference? _genderPreference;
  bool? _isFree;
  String _search = '';
  DateFilterKey _dateFilter = DateFilterKey.all;
  bool _weekendOnly = false;
  bool _loadingMoreNearby = false;

  List<ActivityMapItem> _applyClientFilters(List<ActivityMapItem> items) {
    var result = items;
    final query = _search.trim().toLowerCase();
    if (query.isNotEmpty) {
      result = result.where((a) => a.title.toLowerCase().contains(query) || a.categoryName.toLowerCase().contains(query)).toList();
    }
    if (_weekendOnly) {
      result = result.where((a) => DateFilters.isWeekend(a.eventDate)).toList();
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final locationAsync = ref.watch(currentLocationProvider);
    final categoriesAsync = ref.watch(categoriesProvider);

    return Scaffold(
      body: SafeArea(
        child: locationAsync.when(
          data: (location) => _buildContent(location, categoriesAsync),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                error is ApiException ? error.message : 'Konum alınamadı.',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(CurrentLocation location, AsyncValue<List<Category>> categoriesAsync) {
    final range = DateFilters.rangeFor(_dateFilter);
    final mapActivitiesAsync = ref.watch(
      mapActivitiesProvider(
        latitude: location.latitude,
        longitude: location.longitude,
        radiusMeters: _radiusMeters,
        categoryId: _selectedCategoryId,
        genderPreference: _genderPreference,
        isFree: _isFree,
        fromDate: range.fromDate,
        toDate: range.toDate,
      ),
    );
    final allCategoriesAsync = ref.watch(
      mapActivitiesAllCategoriesProvider(
        latitude: location.latitude,
        longitude: location.longitude,
        radiusMeters: _radiusMeters,
        genderPreference: _genderPreference,
        isFree: _isFree,
        fromDate: range.fromDate,
        toDate: range.toDate,
      ),
    );
    final categoryCounts = allCategoriesAsync.maybeWhen(
      data: (items) {
        final map = <String, int>{};
        for (final item in items) {
          map[item.categoryName] = (map[item.categoryName] ?? 0) + 1;
        }
        return map;
      },
      orElse: () => null,
    );

    final sliderAsync = ref.watch(
      nearbyActivitiesSliderProvider(
        latitude: location.latitude,
        longitude: location.longitude,
        radiusMeters: _radiusMeters,
        categoryId: _selectedCategoryId,
        genderPreference: _genderPreference,
        isFree: _isFree,
        fromDate: range.fromDate,
        toDate: range.toDate,
      ),
    );
    final joinedAsync = ref.watch(joinedUpcomingActivitiesProvider);

    final userLatLng = LatLng(location.latitude, location.longitude);
    final showPermissionCard = location.isFallback && location.permissionState != LocationPermissionState.deniedForever;
    final filteredItems = _applyClientFilters(mapActivitiesAsync.value ?? const []);
    final filteredSliderItems = _applyClientFilters(sliderAsync.value?.items ?? const []);

    return ListView(
      padding: const EdgeInsets.only(bottom: 24),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: TextField(
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search, size: 20),
              hintText: 'Etkinlik veya kategori ara...',
            ),
            onChanged: (value) => setState(() => _search = value),
          ),
        ),
        const SizedBox(height: 8),
        DateRangeFilterRow(
          selected: _dateFilter,
          onSelect: (key) => setState(() => _dateFilter = key),
          weekendOnly: _weekendOnly,
          onWeekendOnlyChanged: (v) => setState(() => _weekendOnly = v),
        ),
        categoriesAsync.maybeWhen(
          data: (categories) => Padding(
            padding: const EdgeInsets.only(top: 4),
            child: FilterChipsRow(
              categories: categories,
              selected: _selectedCategoryId,
              onSelect: (id) => setState(() => _selectedCategoryId = id),
              counts: categoryCounts == null ? null : {for (final c in categories) c.id: categoryCounts[c.name] ?? 0},
            ),
          ),
          orElse: () => const SizedBox(height: 44),
        ),
        MapFilterDropdownsRow(
          radiusMeters: _radiusMeters,
          onRadiusChanged: (v) => setState(() => _radiusMeters = v),
          gender: _genderPreference,
          onGenderChanged: (v) => setState(() => _genderPreference = v),
          isFree: _isFree,
          onIsFreeChanged: (v) => setState(() => _isFree = v),
        ),
        if (showPermissionCard)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: LocationPermissionCard(
              onAllow: () => ref.read(currentLocationProvider.notifier).refresh(),
            ),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: MapPreviewCard(
            activityCount: mapActivitiesAsync.value == null ? null : filteredItems.length,
            onExpand: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => MapExploreScreen(
                  initialCenter: userLatLng,
                  userLocation: userLatLng,
                  initialCategoryId: _selectedCategoryId,
                  initialRadiusMeters: _radiusMeters,
                  initialGenderPreference: _genderPreference,
                  initialIsFree: _isFree,
                  initialDateFilter: _dateFilter,
                  initialWeekendOnly: _weekendOnly,
                ),
              ),
            ),
          ),
        ),
        joinedAsync.maybeWhen(
          data: (joined) {
            if (joined.isEmpty) return const SizedBox.shrink();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Text('Katıldığım Etkinlikler', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                ),
                SizedBox(
                  height: 172,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: joined.length,
                    separatorBuilder: (context, index) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      final activity = joined[index];
                      return SizedBox(
                        width: 260,
                        child: ActivityCard(
                          activity: activity,
                          onTap: () => context.push(RoutePaths.activityDetail(activity.id)),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
          orElse: () => const SizedBox.shrink(),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Yakındaki Etkinlikler', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              mapActivitiesAsync.maybeWhen(
                data: (items) => InkWell(
                  onTap: () => context.push(RoutePaths.activities),
                  child: Text('${filteredItems.length} etkinlik', style: const TextStyle(fontSize: 13, color: AppColors.mutedForeground, decoration: TextDecoration.underline)),
                ),
                orElse: () => const SizedBox.shrink(),
              ),
            ],
          ),
        ),
        sliderAsync.when(
          data: (paged) {
            final items = filteredSliderItems;
            if (items.isEmpty) {
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: EmptyStateWidget(
                  icon: Icons.location_off_outlined,
                  title: 'Yakında etkinlik bulunamadı',
                  description: 'Arama yarıçapını artırın veya filtre kaldırın.',
                ),
              );
            }
            void maybeLoadMore() {
              if (_loadingMoreNearby || !paged.hasNextPage) return;
              setState(() => _loadingMoreNearby = true);
              ref
                  .read(
                    nearbyActivitiesSliderProvider(
                      latitude: location.latitude,
                      longitude: location.longitude,
                      radiusMeters: _radiusMeters,
                      categoryId: _selectedCategoryId,
                      genderPreference: _genderPreference,
                      isFree: _isFree,
                      fromDate: range.fromDate,
                      toDate: range.toDate,
                    ).notifier,
                  )
                  .loadMore()
                  .whenComplete(() {
                if (mounted) setState(() => _loadingMoreNearby = false);
              });
            }

            return SizedBox(
              height: 262,
              child: NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  if (notification.metrics.pixels >= notification.metrics.maxScrollExtent - 300) {
                    maybeLoadMore();
                  }
                  return false;
                },
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: items.length + (_loadingMoreNearby ? 1 : 0),
                  separatorBuilder: (context, index) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    if (index == items.length) {
                      return const SizedBox(
                        width: 40,
                        child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
                      );
                    }
                    final item = items[index];
                    return SizedBox(
                      width: 220,
                      child: NearbyActivityCard(item: item, onTap: () => context.push(RoutePaths.activityDetail(item.id))),
                    );
                  },
                ),
              ),
            );
          },
          loading: () => const Padding(padding: EdgeInsets.all(24), child: Center(child: CircularProgressIndicator())),
          error: (error, stack) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              error is ApiException ? error.message : 'Etkinlikler yüklenemedi.',
              style: const TextStyle(color: AppColors.destructive),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: CreateActivityPromoCard(onTap: () => context.push(RoutePaths.activityCreate)),
        ),
      ],
    );
  }
}
