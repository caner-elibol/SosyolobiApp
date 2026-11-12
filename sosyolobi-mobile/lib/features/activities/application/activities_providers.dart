import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/activities_api.dart';
import '../domain/activity.dart';
import '../domain/create_activity_request.dart';
import 'map_activities_invalidation.dart';

part 'activities_providers.g.dart';

@riverpod
Future<List<Activity>> nearbyActivities(
  Ref ref, {
  required double latitude,
  required double longitude,
  int radiusMeters = 10000,
  String? categoryId,
  DateTime? fromDate,
  DateTime? toDate,
}) {
  return ref.watch(activitiesApiProvider).getNearby(
        latitude: latitude,
        longitude: longitude,
        radiusMeters: radiusMeters,
        categoryId: categoryId,
        fromDate: fromDate,
        toDate: toDate,
      );
}

@riverpod
Future<List<Activity>> nearbyActivitiesAllCategories(
  Ref ref, {
  required double latitude,
  required double longitude,
  int radiusMeters = 10000,
  DateTime? fromDate,
  DateTime? toDate,
}) {
  return ref.watch(activitiesApiProvider).getNearby(
        latitude: latitude,
        longitude: longitude,
        radiusMeters: radiusMeters,
        fromDate: fromDate,
        toDate: toDate,
      );
}

@riverpod
Future<ActivityDetail> activityDetail(Ref ref, String id) {
  return ref.watch(activitiesApiProvider).getById(id);
}

@riverpod
Future<List<Activity>> joinedUpcomingActivities(Ref ref) {
  return ref.watch(activitiesApiProvider).getMineUpcoming();
}

@riverpod
class CreateActivityController extends _$CreateActivityController {
  @override
  FutureOr<void> build() {}

  Future<Activity> submit(CreateActivityRequest request) async {
    final keepAliveLink = ref.keepAlive();
    state = const AsyncLoading();
    try {
      final activity = await ref.read(activitiesApiProvider).create(request);
      state = const AsyncData(null);
      invalidateMapActivityCaches(ref);
      return activity;
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      rethrow;
    } finally {
      keepAliveLink.close();
    }
  }
}
