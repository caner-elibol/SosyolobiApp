// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activities_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Mirrors `sosyolobi-web-2/src/hooks/useNearbyActivities.ts`.

@ProviderFor(nearbyActivities)
final nearbyActivitiesProvider = NearbyActivitiesFamily._();

/// Mirrors `sosyolobi-web-2/src/hooks/useNearbyActivities.ts`.

final class NearbyActivitiesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Activity>>,
          List<Activity>,
          FutureOr<List<Activity>>
        >
    with $FutureModifier<List<Activity>>, $FutureProvider<List<Activity>> {
  /// Mirrors `sosyolobi-web-2/src/hooks/useNearbyActivities.ts`.
  NearbyActivitiesProvider._({
    required NearbyActivitiesFamily super.from,
    required ({
      double latitude,
      double longitude,
      int radiusMeters,
      String? categoryId,
      DateTime? fromDate,
      DateTime? toDate,
    })
    super.argument,
  }) : super(
         retry: null,
         name: r'nearbyActivitiesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$nearbyActivitiesHash();

  @override
  String toString() {
    return r'nearbyActivitiesProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<List<Activity>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Activity>> create(Ref ref) {
    final argument =
        this.argument
            as ({
              double latitude,
              double longitude,
              int radiusMeters,
              String? categoryId,
              DateTime? fromDate,
              DateTime? toDate,
            });
    return nearbyActivities(
      ref,
      latitude: argument.latitude,
      longitude: argument.longitude,
      radiusMeters: argument.radiusMeters,
      categoryId: argument.categoryId,
      fromDate: argument.fromDate,
      toDate: argument.toDate,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is NearbyActivitiesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$nearbyActivitiesHash() => r'09f2d0f8f1104c1d085a74cf6462a12d24bbebea';

/// Mirrors `sosyolobi-web-2/src/hooks/useNearbyActivities.ts`.

final class NearbyActivitiesFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<Activity>>,
          ({
            double latitude,
            double longitude,
            int radiusMeters,
            String? categoryId,
            DateTime? fromDate,
            DateTime? toDate,
          })
        > {
  NearbyActivitiesFamily._()
    : super(
        retry: null,
        name: r'nearbyActivitiesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Mirrors `sosyolobi-web-2/src/hooks/useNearbyActivities.ts`.

  NearbyActivitiesProvider call({
    required double latitude,
    required double longitude,
    int radiusMeters = 10000,
    String? categoryId,
    DateTime? fromDate,
    DateTime? toDate,
  }) => NearbyActivitiesProvider._(
    argument: (
      latitude: latitude,
      longitude: longitude,
      radiusMeters: radiusMeters,
      categoryId: categoryId,
      fromDate: fromDate,
      toDate: toDate,
    ),
    from: this,
  );

  @override
  String toString() => r'nearbyActivitiesProvider';
}

/// Fetches nearby activities across **all** categories (no `categoryId`
/// filter) so category chip counts (item 5) and the category-filtered view
/// can both derive from one client-side-grouped fetch — mirrors web's
/// "fetch all categories together, group client-side" approach (no new
/// backend count endpoint).

@ProviderFor(nearbyActivitiesAllCategories)
final nearbyActivitiesAllCategoriesProvider =
    NearbyActivitiesAllCategoriesFamily._();

/// Fetches nearby activities across **all** categories (no `categoryId`
/// filter) so category chip counts (item 5) and the category-filtered view
/// can both derive from one client-side-grouped fetch — mirrors web's
/// "fetch all categories together, group client-side" approach (no new
/// backend count endpoint).

final class NearbyActivitiesAllCategoriesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Activity>>,
          List<Activity>,
          FutureOr<List<Activity>>
        >
    with $FutureModifier<List<Activity>>, $FutureProvider<List<Activity>> {
  /// Fetches nearby activities across **all** categories (no `categoryId`
  /// filter) so category chip counts (item 5) and the category-filtered view
  /// can both derive from one client-side-grouped fetch — mirrors web's
  /// "fetch all categories together, group client-side" approach (no new
  /// backend count endpoint).
  NearbyActivitiesAllCategoriesProvider._({
    required NearbyActivitiesAllCategoriesFamily super.from,
    required ({
      double latitude,
      double longitude,
      int radiusMeters,
      DateTime? fromDate,
      DateTime? toDate,
    })
    super.argument,
  }) : super(
         retry: null,
         name: r'nearbyActivitiesAllCategoriesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$nearbyActivitiesAllCategoriesHash();

  @override
  String toString() {
    return r'nearbyActivitiesAllCategoriesProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<List<Activity>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Activity>> create(Ref ref) {
    final argument =
        this.argument
            as ({
              double latitude,
              double longitude,
              int radiusMeters,
              DateTime? fromDate,
              DateTime? toDate,
            });
    return nearbyActivitiesAllCategories(
      ref,
      latitude: argument.latitude,
      longitude: argument.longitude,
      radiusMeters: argument.radiusMeters,
      fromDate: argument.fromDate,
      toDate: argument.toDate,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is NearbyActivitiesAllCategoriesProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$nearbyActivitiesAllCategoriesHash() =>
    r'9a4bb044caa1e1ccbce074b20574b9dac7e6ed2c';

/// Fetches nearby activities across **all** categories (no `categoryId`
/// filter) so category chip counts (item 5) and the category-filtered view
/// can both derive from one client-side-grouped fetch — mirrors web's
/// "fetch all categories together, group client-side" approach (no new
/// backend count endpoint).

final class NearbyActivitiesAllCategoriesFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<Activity>>,
          ({
            double latitude,
            double longitude,
            int radiusMeters,
            DateTime? fromDate,
            DateTime? toDate,
          })
        > {
  NearbyActivitiesAllCategoriesFamily._()
    : super(
        retry: null,
        name: r'nearbyActivitiesAllCategoriesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Fetches nearby activities across **all** categories (no `categoryId`
  /// filter) so category chip counts (item 5) and the category-filtered view
  /// can both derive from one client-side-grouped fetch — mirrors web's
  /// "fetch all categories together, group client-side" approach (no new
  /// backend count endpoint).

  NearbyActivitiesAllCategoriesProvider call({
    required double latitude,
    required double longitude,
    int radiusMeters = 10000,
    DateTime? fromDate,
    DateTime? toDate,
  }) => NearbyActivitiesAllCategoriesProvider._(
    argument: (
      latitude: latitude,
      longitude: longitude,
      radiusMeters: radiusMeters,
      fromDate: fromDate,
      toDate: toDate,
    ),
    from: this,
  );

  @override
  String toString() => r'nearbyActivitiesAllCategoriesProvider';
}

/// Mirrors `sosyolobi-web-2/src/hooks/useCreateActivity.ts`'s `useActivity`.

@ProviderFor(activityDetail)
final activityDetailProvider = ActivityDetailFamily._();

/// Mirrors `sosyolobi-web-2/src/hooks/useCreateActivity.ts`'s `useActivity`.

final class ActivityDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<ActivityDetail>,
          ActivityDetail,
          FutureOr<ActivityDetail>
        >
    with $FutureModifier<ActivityDetail>, $FutureProvider<ActivityDetail> {
  /// Mirrors `sosyolobi-web-2/src/hooks/useCreateActivity.ts`'s `useActivity`.
  ActivityDetailProvider._({
    required ActivityDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'activityDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$activityDetailHash();

  @override
  String toString() {
    return r'activityDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<ActivityDetail> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ActivityDetail> create(Ref ref) {
    final argument = this.argument as String;
    return activityDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ActivityDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$activityDetailHash() => r'565c0e0ffb8c40d033062309367610ae932ff0cd';

/// Mirrors `sosyolobi-web-2/src/hooks/useCreateActivity.ts`'s `useActivity`.

final class ActivityDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<ActivityDetail>, String> {
  ActivityDetailFamily._()
    : super(
        retry: null,
        name: r'activityDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Mirrors `sosyolobi-web-2/src/hooks/useCreateActivity.ts`'s `useActivity`.

  ActivityDetailProvider call(String id) =>
      ActivityDetailProvider._(argument: id, from: this);

  @override
  String toString() => r'activityDetailProvider';
}

/// Backs the Keşfet tab's "Katıldığım Etkinlikler" slider — upcoming
/// activities the user participates in (organizer or approved participant),
/// via `GET /api/activities/mine`. Queried through `ActivityParticipants` on
/// the backend, not `ActivityRequests`, so self-created activities (which
/// never generate a join request for their own creator) are included too.

@ProviderFor(joinedUpcomingActivities)
final joinedUpcomingActivitiesProvider = JoinedUpcomingActivitiesProvider._();

/// Backs the Keşfet tab's "Katıldığım Etkinlikler" slider — upcoming
/// activities the user participates in (organizer or approved participant),
/// via `GET /api/activities/mine`. Queried through `ActivityParticipants` on
/// the backend, not `ActivityRequests`, so self-created activities (which
/// never generate a join request for their own creator) are included too.

final class JoinedUpcomingActivitiesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Activity>>,
          List<Activity>,
          FutureOr<List<Activity>>
        >
    with $FutureModifier<List<Activity>>, $FutureProvider<List<Activity>> {
  /// Backs the Keşfet tab's "Katıldığım Etkinlikler" slider — upcoming
  /// activities the user participates in (organizer or approved participant),
  /// via `GET /api/activities/mine`. Queried through `ActivityParticipants` on
  /// the backend, not `ActivityRequests`, so self-created activities (which
  /// never generate a join request for their own creator) are included too.
  JoinedUpcomingActivitiesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'joinedUpcomingActivitiesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$joinedUpcomingActivitiesHash();

  @$internal
  @override
  $FutureProviderElement<List<Activity>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Activity>> create(Ref ref) {
    return joinedUpcomingActivities(ref);
  }
}

String _$joinedUpcomingActivitiesHash() =>
    r'050d747cf2d54b59a7c913c4e5dbfcbbe0ca9494';

/// Mirrors `useCreateActivity`'s mutation — on success, invalidates
/// nearby/map activity caches the way `qc.invalidateQueries` does on web.

@ProviderFor(CreateActivityController)
final createActivityControllerProvider = CreateActivityControllerProvider._();

/// Mirrors `useCreateActivity`'s mutation — on success, invalidates
/// nearby/map activity caches the way `qc.invalidateQueries` does on web.
final class CreateActivityControllerProvider
    extends $AsyncNotifierProvider<CreateActivityController, void> {
  /// Mirrors `useCreateActivity`'s mutation — on success, invalidates
  /// nearby/map activity caches the way `qc.invalidateQueries` does on web.
  CreateActivityControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'createActivityControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$createActivityControllerHash();

  @$internal
  @override
  CreateActivityController create() => CreateActivityController();
}

String _$createActivityControllerHash() =>
    r'bb354ddd94bf13449bd9e21d76cb3410858faf55';

/// Mirrors `useCreateActivity`'s mutation — on success, invalidates
/// nearby/map activity caches the way `qc.invalidateQueries` does on web.

abstract class _$CreateActivityController extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
