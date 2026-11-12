import 'package:dio/dio.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_client.dart';
import '../../../core/network/envelope.dart';
import '../domain/activity.dart';
import '../domain/create_activity_request.dart';

part 'activities_api.g.dart';

@riverpod
ActivitiesApi activitiesApi(Ref ref) => ActivitiesApi(ref.watch(apiClientProvider));

class ActivitiesApi {
  ActivitiesApi(this._dio);

  final Dio _dio;

  Future<Activity> create(CreateActivityRequest request) async {
    final response = await guardDio(() => _dio.post<Map<String, dynamic>>('/api/activities', data: request.toJson()));
    return unwrap(response, (json) => Activity.fromJson(json as Map<String, dynamic>));
  }

  Future<List<Activity>> getMineUpcoming() async {
    final response = await guardDio(() => _dio.get<Map<String, dynamic>>('/api/activities/mine'));
    return unwrapList(response, (json) => Activity.fromJson(json as Map<String, dynamic>));
  }

  Future<List<Activity>> getNearby({
    required double latitude,
    required double longitude,
    int radiusMeters = 10000,
    String? categoryId,
    DateTime? fromDate,
    DateTime? toDate,
  }) async {
    final response = await guardDio(() => _dio.get<Map<String, dynamic>>(
          '/api/activities/nearby',
          queryParameters: {
            'latitude': latitude,
            'longitude': longitude,
            'radiusMeters': radiusMeters,
            if (categoryId != null) 'categoryId': categoryId,
            if (fromDate != null) 'fromDate': fromDate.toUtc().toIso8601String(),
            if (toDate != null) 'toDate': toDate.toUtc().toIso8601String(),
          },
        ));
    return unwrapList(response, (json) => Activity.fromJson(json as Map<String, dynamic>));
  }

  Future<ActivityDetail> getById(String id) async {
    final response = await guardDio(() => _dio.get<Map<String, dynamic>>('/api/activities/$id'));
    return unwrap(response, (json) => ActivityDetail.fromJson(json as Map<String, dynamic>));
  }

  Future<void> cancel(String id) async {
    await guardDio(() => _dio.post<Map<String, dynamic>>('/api/activities/$id/cancel'));
  }

  Future<void> complete(String id) async {
    await guardDio(() => _dio.post<Map<String, dynamic>>('/api/activities/$id/complete'));
  }
}
