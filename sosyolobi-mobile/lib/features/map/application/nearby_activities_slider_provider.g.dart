// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nearby_activities_slider_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Backs the Keşfet tab's paginated "Yakınımdaki Etkinlikler" slider —
/// unlike [mapActivitiesProvider] (unpaged, needed for map pins + category
/// counts), this fetches one page at a time via
/// `GET /api/activities/map/paged` and accumulates pages in [loadMore].
/// A new family instance (different filter args) always starts fresh at
/// page 1, so changing a filter "resets" pagination for free.

@ProviderFor(NearbyActivitiesSlider)
final nearbyActivitiesSliderProvider = NearbyActivitiesSliderFamily._();

/// Backs the Keşfet tab's paginated "Yakınımdaki Etkinlikler" slider —
/// unlike [mapActivitiesProvider] (unpaged, needed for map pins + category
/// counts), this fetches one page at a time via
/// `GET /api/activities/map/paged` and accumulates pages in [loadMore].
/// A new family instance (different filter args) always starts fresh at
/// page 1, so changing a filter "resets" pagination for free.
final class NearbyActivitiesSliderProvider
    extends
        $AsyncNotifierProvider<
          NearbyActivitiesSlider,
          PagedResult<ActivityMapItem>
        > {
  /// Backs the Keşfet tab's paginated "Yakınımdaki Etkinlikler" slider —
  /// unlike [mapActivitiesProvider] (unpaged, needed for map pins + category
  /// counts), this fetches one page at a time via
  /// `GET /api/activities/map/paged` and accumulates pages in [loadMore].
  /// A new family instance (different filter args) always starts fresh at
  /// page 1, so changing a filter "resets" pagination for free.
  NearbyActivitiesSliderProvider._({
    required NearbyActivitiesSliderFamily super.from,
    required ({
      double latitude,
      double longitude,
      int radiusMeters,
      String? categoryId,
      GenderPreference? genderPreference,
      bool? isFree,
      DateTime? fromDate,
      DateTime? toDate,
    })
    super.argument,
  }) : super(
         retry: null,
         name: r'nearbyActivitiesSliderProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$nearbyActivitiesSliderHash();

  @override
  String toString() {
    return r'nearbyActivitiesSliderProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  NearbyActivitiesSlider create() => NearbyActivitiesSlider();

  @override
  bool operator ==(Object other) {
    return other is NearbyActivitiesSliderProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$nearbyActivitiesSliderHash() =>
    r'e1a389ead4522f53ebd8fa77d8bf17448c0c9bfc';

/// Backs the Keşfet tab's paginated "Yakınımdaki Etkinlikler" slider —
/// unlike [mapActivitiesProvider] (unpaged, needed for map pins + category
/// counts), this fetches one page at a time via
/// `GET /api/activities/map/paged` and accumulates pages in [loadMore].
/// A new family instance (different filter args) always starts fresh at
/// page 1, so changing a filter "resets" pagination for free.

final class NearbyActivitiesSliderFamily extends $Family
    with
        $ClassFamilyOverride<
          NearbyActivitiesSlider,
          AsyncValue<PagedResult<ActivityMapItem>>,
          PagedResult<ActivityMapItem>,
          FutureOr<PagedResult<ActivityMapItem>>,
          ({
            double latitude,
            double longitude,
            int radiusMeters,
            String? categoryId,
            GenderPreference? genderPreference,
            bool? isFree,
            DateTime? fromDate,
            DateTime? toDate,
          })
        > {
  NearbyActivitiesSliderFamily._()
    : super(
        retry: null,
        name: r'nearbyActivitiesSliderProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Backs the Keşfet tab's paginated "Yakınımdaki Etkinlikler" slider —
  /// unlike [mapActivitiesProvider] (unpaged, needed for map pins + category
  /// counts), this fetches one page at a time via
  /// `GET /api/activities/map/paged` and accumulates pages in [loadMore].
  /// A new family instance (different filter args) always starts fresh at
  /// page 1, so changing a filter "resets" pagination for free.

  NearbyActivitiesSliderProvider call({
    required double latitude,
    required double longitude,
    int radiusMeters = 10000,
    String? categoryId,
    GenderPreference? genderPreference,
    bool? isFree,
    DateTime? fromDate,
    DateTime? toDate,
  }) => NearbyActivitiesSliderProvider._(
    argument: (
      latitude: latitude,
      longitude: longitude,
      radiusMeters: radiusMeters,
      categoryId: categoryId,
      genderPreference: genderPreference,
      isFree: isFree,
      fromDate: fromDate,
      toDate: toDate,
    ),
    from: this,
  );

  @override
  String toString() => r'nearbyActivitiesSliderProvider';
}

/// Backs the Keşfet tab's paginated "Yakınımdaki Etkinlikler" slider —
/// unlike [mapActivitiesProvider] (unpaged, needed for map pins + category
/// counts), this fetches one page at a time via
/// `GET /api/activities/map/paged` and accumulates pages in [loadMore].
/// A new family instance (different filter args) always starts fresh at
/// page 1, so changing a filter "resets" pagination for free.

abstract class _$NearbyActivitiesSlider
    extends $AsyncNotifier<PagedResult<ActivityMapItem>> {
  late final _$args =
      ref.$arg
          as ({
            double latitude,
            double longitude,
            int radiusMeters,
            String? categoryId,
            GenderPreference? genderPreference,
            bool? isFree,
            DateTime? fromDate,
            DateTime? toDate,
          });
  double get latitude => _$args.latitude;
  double get longitude => _$args.longitude;
  int get radiusMeters => _$args.radiusMeters;
  String? get categoryId => _$args.categoryId;
  GenderPreference? get genderPreference => _$args.genderPreference;
  bool? get isFree => _$args.isFree;
  DateTime? get fromDate => _$args.fromDate;
  DateTime? get toDate => _$args.toDate;

  FutureOr<PagedResult<ActivityMapItem>> build({
    required double latitude,
    required double longitude,
    int radiusMeters = 10000,
    String? categoryId,
    GenderPreference? genderPreference,
    bool? isFree,
    DateTime? fromDate,
    DateTime? toDate,
  });
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<PagedResult<ActivityMapItem>>,
              PagedResult<ActivityMapItem>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<PagedResult<ActivityMapItem>>,
                PagedResult<ActivityMapItem>
              >,
              AsyncValue<PagedResult<ActivityMapItem>>,
              Object?,
              Object?
            >;
    return element.handleCreate(
      ref,
      () => build(
        latitude: _$args.latitude,
        longitude: _$args.longitude,
        radiusMeters: _$args.radiusMeters,
        categoryId: _$args.categoryId,
        genderPreference: _$args.genderPreference,
        isFree: _$args.isFree,
        fromDate: _$args.fromDate,
        toDate: _$args.toDate,
      ),
    );
  }
}
