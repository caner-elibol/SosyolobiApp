import 'package:dio/dio.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_client.dart';
import '../../../core/network/envelope.dart';
import '../domain/notification.dart';

part 'notifications_api.g.dart';

@riverpod
NotificationsApi notificationsApi(Ref ref) => NotificationsApi(ref.watch(apiClientProvider));

class NotificationsApi {
  NotificationsApi(this._dio);

  final Dio _dio;

  Future<List<AppNotification>> getAll() async {
    final response = await guardDio(() => _dio.get<Map<String, dynamic>>('/api/notifications'));
    return unwrapList(response, (json) => AppNotification.fromJson(json as Map<String, dynamic>));
  }

  Future<void> markRead(String id) async {
    await guardDio(() => _dio.post<Map<String, dynamic>>('/api/notifications/$id/read'));
  }

  Future<void> markAllRead() async {
    await guardDio(() => _dio.post<Map<String, dynamic>>('/api/notifications/read-all'));
  }
}
