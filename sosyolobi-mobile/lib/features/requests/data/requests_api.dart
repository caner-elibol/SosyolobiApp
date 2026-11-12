import 'package:dio/dio.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_client.dart';
import '../../../core/network/envelope.dart';
import '../domain/activity_join_request.dart';

part 'requests_api.g.dart';

@riverpod
RequestsApi requestsApi(Ref ref) => RequestsApi(ref.watch(apiClientProvider));

class RequestsApi {
  RequestsApi(this._dio);

  final Dio _dio;

  Future<ActivityJoinRequest> join(String activityId, {String? message}) async {
    final response = await guardDio(() => _dio.post<Map<String, dynamic>>(
          '/api/activities/$activityId/requests',
          data: {if (message != null) 'message': message},
        ));
    return unwrap(response, (json) => ActivityJoinRequest.fromJson(json as Map<String, dynamic>));
  }

  Future<void> cancel(String requestId) async {
    await guardDio(() => _dio.post<Map<String, dynamic>>('/api/activity-requests/$requestId/cancel'));
  }

  Future<void> approve(String requestId) async {
    await guardDio(() => _dio.post<Map<String, dynamic>>('/api/activity-requests/$requestId/approve'));
  }

  Future<void> reject(String requestId) async {
    await guardDio(() => _dio.post<Map<String, dynamic>>('/api/activity-requests/$requestId/reject'));
  }

  Future<List<ActivityJoinRequest>> sent() async {
    final response = await guardDio(() => _dio.get<Map<String, dynamic>>('/api/activity-requests/sent'));
    return unwrapList(response, (json) => ActivityJoinRequest.fromJson(json as Map<String, dynamic>));
  }

  Future<List<ActivityJoinRequest>> forActivity(String activityId) async {
    final response = await guardDio(() => _dio.get<Map<String, dynamic>>('/api/activities/$activityId/requests'));
    return unwrapList(response, (json) => ActivityJoinRequest.fromJson(json as Map<String, dynamic>));
  }
}
