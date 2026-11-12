// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_activities_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Mirrors `sosyolobi-web-2/src/hooks/useMapActivities.ts`.

@ProviderFor(mapActivities)
final mapActivitiesProvider = MapActivitiesFamily._();

/// Mirrors `sosyolobi-web-2/src/hooks/useMapActivities.ts`.

final class MapActivitiesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ActivityMapItem>>,
          List<ActivityMapItem>,
          FutureOr<List<ActivityMapItem>>
        >
    with
        $FutureModifier<List<ActivityMapItem>>,
        $FutureProvider<List<ActivityMapItem>> {
  /// Mirrors `sosyolobi-web-2/src/hooks/useMapActivities.ts`.
  MapActivitiesProvider._({
    required MapActivitiesFamily super.from,
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
         name: r'mapActivitiesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$mapActivitiesHash();

  @override
  String toString() {
    return r'mapActivitiesProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<List<ActivityMapItem>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ActivityMapItem>> create(Ref ref) {
    final argument =
        this.argument
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
    return mapActivities(
      ref,
      latitude: argument.latitude,
      longitude: argument.longitude,
      radiusMeters: argument.radiusMeters,
      categoryId: argument.categoryId,
      genderPreference: argument.genderPreference,
      isFree: argument.isFree,
      fromDate: argument.fromDate,
      toDate: argument.toDate,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is MapActivitiesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$mapActivitiesHash() => r'e790ce8fe9bd0b984168edfaa0fecc76f772106a';

/// Mirrors `sosyolobi-web-2/src/hooks/useMapActivities.ts`.

final class MapActivitiesFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<ActivityMapItem>>,
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
  MapActivitiesFamily._()
    : super(
        retry: null,
        name: r'mapActivitiesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Mirrors `sosyolobi-web-2/src/hooks/useMapActivities.ts`.

  MapActivitiesProvider call({
    required double latitude,
    required double longitude,
    int radiusMeters = 10000,
    String? categoryId,
    GenderPreference? genderPreference,
    bool? isFree,
    DateTime? fromDate,
    DateTime? toDate,
  }) => MapActivitiesProvider._(
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
  String toString() => r'mapActivitiesProvider';
}

/// All-categories variant (no `categoryId`) so map category chip counts
/// (item 5) can be derived client-side, same rationale as
/// `nearbyActivitiesAllCategories`.

@ProviderFor(mapActivitiesAllCategories)
final mapActivitiesAllCategoriesProvider = MapActivitiesAllCategoriesFamily._();

/// All-categories variant (no `categoryId`) so map category chip counts
/// (item 5) can be derived client-side, same rationale as
/// `nearbyActivitiesAllCategories`.

final class MapActivitiesAllCategoriesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ActivityMapItem>>,
          List<ActivityMapItem>,
          FutureOr<List<ActivityMapItem>>
        >
    with
        $FutureModifier<List<ActivityMapItem>>,
        $FutureProvider<List<ActivityMapItem>> {
  /// All-categories variant (no `categoryId`) so map category chip counts
  /// (item 5) can be derived client-side, same rationale as
  /// `nearbyActivitiesAllCategories`.
  MapActivitiesAllCategoriesProvider._({
    required MapActivitiesAllCategoriesFamily super.from,
    required ({
      double latitude,
      double longitude,
      int radiusMeters,
      GenderPreference? genderPreference,
      bool? isFree,
      DateTime? fromDate,
      DateTime? toDate,
    })
    super.argument,
  }) : super(
         retry: null,
         name: r'mapActivitiesAllCategoriesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$mapActivitiesAllCategoriesHash();

  @override
  String toString() {
    return r'mapActivitiesAllCategoriesProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<List<ActivityMapItem>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ActivityMapItem>> create(Ref ref) {
    final argument =
        this.argument
            as ({
              double latitude,
              double longitude,
              int radiusMeters,
              GenderPreference? genderPreference,
              bool? isFree,
              DateTime? fromDate,
              DateTime? toDate,
            });
    return mapActivitiesAllCategories(
      ref,
      latitude: argument.latitude,
      longitude: argument.longitude,
      radiusMeters: argument.radiusMeters,
      genderPreference: argument.genderPreference,
      isFree: argument.isFree,
      fromDate: argument.fromDate,
      toDate: argument.toDate,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is MapActivitiesAllCategoriesProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$mapActivitiesAllCategoriesHash() =>
    r'9cbd3bcc06f32a8234f0b32358fadcce5651ad37';

/// All-categories variant (no `categoryId`) so map category chip counts
/// (item 5) can be derived client-side, same rationale as
/// `nearbyActivitiesAllCategories`.

final class MapActivitiesAllCategoriesFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<ActivityMapItem>>,
          ({
            double latitude,
            double longitude,
            int radiusMeters,
            GenderPreference? genderPreference,
            bool? isFree,
            DateTime? fromDate,
            DateTime? toDate,
          })
        > {
  MapActivitiesAllCategoriesFamily._()
    : super(
        retry: null,
        name: r'mapActivitiesAllCategoriesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// All-categories variant (no `categoryId`) so map category chip counts
  /// (item 5) can be derived client-side, same rationale as
  /// `nearbyActivitiesAllCategories`.

  MapActivitiesAllCategoriesProvider call({
    required double latitude,
    required double longitude,
    int radiusMeters = 10000,
    GenderPreference? genderPreference,
    bool? isFree,
    DateTime? fromDate,
    DateTime? toDate,
  }) => MapActivitiesAllCategoriesProvider._(
    argument: (
      latitude: latitude,
      longitude: longitude,
      radiusMeters: radiusMeters,
      genderPreference: genderPreference,
      isFree: isFree,
      fromDate: fromDate,
      toDate: toDate,
    ),
    from: this,
  );

  @override
  String toString() => r'mapActivitiesAllCategoriesProvider';
}
