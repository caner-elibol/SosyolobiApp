import 'package:dio/dio.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/domain/enums.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/envelope.dart';
import '../../activities/domain/activity.dart';

part 'map_activities_api.g.dart';

@riverpod
MapActivitiesApi mapActivitiesApi(Ref ref) => MapActivitiesApi(ref.watch(apiClientProvider));

class MapActivitiesApi {
  MapActivitiesApi(this._dio);

  final Dio _dio;

  Future<List<ActivityMapItem>> getMapItems({
    required double latitude,
    required double longitude,
    int radiusMeters = 10000,
    String? categoryId,
    GenderPreference? genderPreference,
    bool? isFree,
    DateTime? fromDate,
    DateTime? toDate,
  }) async {
    final response = await guardDio(() => _dio.get<Map<String, dynamic>>(
          '/api/activities/map',
          queryParameters: {
            'latitude': latitude,
            'longitude': longitude,
            'radiusMeters': radiusMeters,
            if (categoryId != null) 'categoryId': categoryId,
            if (genderPreference != null) 'genderPreference': genderPreference.toJson(),
            if (isFree != null) 'isFree': isFree,
            if (fromDate != null) 'fromDate': fromDate.toUtc().toIso8601String(),
            if (toDate != null) 'toDate': toDate.toUtc().toIso8601String(),
          },
        ));
    return unwrapList(response, (json) => ActivityMapItem.fromJson(json as Map<String, dynamic>));
  }

  Future<PagedResult<ActivityMapItem>> getMapItemsPaged({
    required double latitude,
    required double longitude,
    int radiusMeters = 10000,
    String? categoryId,
    GenderPreference? genderPreference,
    bool? isFree,
    DateTime? fromDate,
    DateTime? toDate,
    required int page,
    required int pageSize,
  }) async {
    final response = await guardDio(() => _dio.get<Map<String, dynamic>>(
          '/api/activities/map/paged',
          queryParameters: {
            'latitude': latitude,
            'longitude': longitude,
            'radiusMeters': radiusMeters,
            if (categoryId != null) 'categoryId': categoryId,
            if (genderPreference != null) 'genderPreference': genderPreference.toJson(),
            if (isFree != null) 'isFree': isFree,
            if (fromDate != null) 'fromDate': fromDate.toUtc().toIso8601String(),
            if (toDate != null) 'toDate': toDate.toUtc().toIso8601String(),
            'page': page,
            'pageSize': pageSize,
          },
        ));
    return unwrapPaged(response, (json) => ActivityMapItem.fromJson(json as Map<String, dynamic>));
  }
}
