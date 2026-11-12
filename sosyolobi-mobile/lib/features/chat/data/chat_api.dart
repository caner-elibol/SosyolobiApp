import 'package:dio/dio.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_client.dart';
import '../../../core/network/envelope.dart';
import '../domain/chat.dart';

part 'chat_api.g.dart';

@riverpod
ChatApi chatApi(Ref ref) => ChatApi(ref.watch(apiClientProvider));

class ChatApi {
  ChatApi(this._dio);

  final Dio _dio;

  Future<ChatRoom> getRoom(String activityId) async {
    final response = await guardDio(() => _dio.get<Map<String, dynamic>>('/api/activities/$activityId/chat-room'));
    return unwrap(response, (json) => ChatRoom.fromJson(json as Map<String, dynamic>));
  }

  Future<PagedResult<ChatMessage>> getMessages(String roomId, {int page = 1, int pageSize = 50}) async {
    final response = await guardDio(() => _dio.get<Map<String, dynamic>>(
          '/api/chat-rooms/$roomId/messages',
          queryParameters: {'page': page, 'pageSize': pageSize},
        ));
    return unwrapPaged(response, (json) => ChatMessage.fromJson(json as Map<String, dynamic>));
  }

  Future<ChatMessage> sendMessage(String roomId, {required String content, String? replyToMessageId}) async {
    final response = await guardDio(() => _dio.post<Map<String, dynamic>>(
          '/api/chat-rooms/$roomId/messages',
          data: {'content': content, if (replyToMessageId != null) 'replyToMessageId': replyToMessageId},
        ));
    return unwrap(response, (json) => ChatMessage.fromJson(json as Map<String, dynamic>));
  }

  Future<List<ChatUnreadSummary>> unreadSummary() async {
    final response = await guardDio(() => _dio.get<Map<String, dynamic>>('/api/chat-rooms/unread-summary'));
    return unwrapList(response, (json) => ChatUnreadSummary.fromJson(json as Map<String, dynamic>));
  }

  Future<void> markRead(String roomId) async {
    await guardDio(() => _dio.post<Map<String, dynamic>>('/api/chat-rooms/$roomId/read'));
  }
}
