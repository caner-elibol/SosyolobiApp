import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/domain/category.dart';
import '../../../core/router/route_paths.dart';
import '../../../core/utils/date_filters.dart';
import '../../../core/widgets/async_value_widget.dart';
import '../../../core/widgets/empty_state.dart';
import '../../map/application/current_location_provider.dart';
import '../../map/domain/current_location.dart';
import '../../map/presentation/widgets/date_range_filter_row.dart';
import '../../map/presentation/widgets/filter_chips.dart';
import '../application/activities_providers.dart';
import '../application/categories_provider.dart';
import '../domain/activity.dart';
import 'widgets/activity_card.dart';

class ActivitiesListScreen extends ConsumerStatefulWidget {
  const ActivitiesListScreen({super.key});

  @override
  ConsumerState<ActivitiesListScreen> createState() => _ActivitiesListScreenState();
}

class _ActivitiesListScreenState extends ConsumerState<ActivitiesListScreen> {
  String? _selectedCategoryId;
  String _search = '';
  DateFilterKey _dateFilter = DateFilterKey.all;
  bool _weekendOnly = false;

  List<Activity> _applySearch(List<Activity> activities) {
    final query = _search.trim().toLowerCase();
    if (query.isEmpty) return activities;
    return activities.where((a) {
      return a.title.toLowerCase().contains(query) ||
          a.createdByDisplayName.toLowerCase().contains(query) ||
          a.categoryName.toLowerCase().contains(query) ||
          a.addressText.toLowerCase().contains(query);
    }).toList();
  }

  List<Activity> _applyWeekend(List<Activity> activities) {
    if (!_weekendOnly) return activities;
    return activities.where((a) => DateFilters.isWeekend(a.eventDate)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final locationAsync = ref.watch(currentLocationProvider);
    final categoriesAsync = ref.watch(categoriesProvider);
    final range = DateFilters.rangeFor(_dateFilter);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: TextField(
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search, size: 20),
              hintText: 'Etkinlik, kategori veya konum ara...',
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
          data: (categories) => locationAsync.maybeWhen(
            data: (location) => _CategoryChips(
              categories: categories,
              selected: _selectedCategoryId,
              onSelect: (id) => setState(() => _selectedCategoryId = id),
              location: location,
              fromDate: range.fromDate,
              toDate: range.toDate,
            ),
            orElse: () => FilterChipsRow(categories: categories, selected: _selectedCategoryId, onSelect: (id) => setState(() => _selectedCategoryId = id)),
          ),
          orElse: () => const SizedBox(height: 44),
        ),
        Expanded(
          child: AsyncValueWidget<CurrentLocation>(
            value: locationAsync,
            data: (location) => _buildResults(location, range.fromDate, range.toDate),
          ),
        ),
      ],
    );
  }

  Widget _buildResults(CurrentLocation location, DateTime? fromDate, DateTime? toDate) {
    final activitiesAsync = ref.watch(
      nearbyActivitiesProvider(
        latitude: location.latitude,
        longitude: location.longitude,
        categoryId: _selectedCategoryId,
        fromDate: fromDate,
        toDate: toDate,
      ),
    );

    return AsyncValueWidget<List<Activity>>(
      value: activitiesAsync,
      data: (activities) {
        final filtered = _applyWeekend(_applySearch(activities));
        if (filtered.isEmpty) {
          return const EmptyStateWidget(
            icon: Icons.search_off,
            title: 'Etkinlik bulunamadı',
            description: 'Arama kelimesini veya filtreyi değiştirin.',
          );
        }
        return RefreshIndicator(
          onRefresh: () async => ref.invalidate(nearbyActivitiesProvider),
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            itemCount: filtered.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final activity = filtered[index];
              return ActivityCard(
                activity: activity,
                onTap: () => context.push(RoutePaths.activityDetail(activity.id)),
              );
            },
          ),
        );
      },
    );
  }
}

class _CategoryChips extends ConsumerWidget {
  const _CategoryChips({
    required this.categories,
    required this.selected,
    required this.onSelect,
    required this.location,
    required this.fromDate,
    required this.toDate,
  });

  final List<Category> categories;
  final String? selected;
  final ValueChanged<String?> onSelect;
  final CurrentLocation location;
  final DateTime? fromDate;
  final DateTime? toDate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allAsync = ref.watch(
      nearbyActivitiesAllCategoriesProvider(
        latitude: location.latitude,
        longitude: location.longitude,
        fromDate: fromDate,
        toDate: toDate,
      ),
    );
    final counts = allAsync.maybeWhen(
      data: (activities) {
        final map = <String, int>{};
        for (final activity in activities) {
          map[activity.categoryId] = (map[activity.categoryId] ?? 0) + 1;
        }
        return map;
      },
      orElse: () => null,
    );

    return FilterChipsRow(categories: categories, selected: selected, onSelect: onSelect, counts: counts);
  }
}
