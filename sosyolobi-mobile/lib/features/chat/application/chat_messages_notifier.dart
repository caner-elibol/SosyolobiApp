import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:signalr_netcore/signalr_client.dart';

import '../../../core/config/app_config.dart';
import '../../../core/network/api_client.dart';
import '../../../core/realtime/hub_connection_factory.dart';
import '../data/chat_api.dart';
import '../domain/chat.dart';
import '../domain/chat_room_state.dart';
import 'chat_unread_provider.dart';

part 'chat_messages_notifier.g.dart';

@riverpod
class ChatMessagesNotifier extends _$ChatMessagesNotifier {
  HubConnection? _connection;

  @override
  Future<ChatRoomState> build(String roomId) async {
    final page = await ref.read(chatApiProvider).getMessages(roomId);
    final messages = page.items.reversed.toList();

    ref.onDispose(_disconnectHub);
    unawaited(_connectHub(roomId));

    ref.read(chatApiProvider).markRead(roomId);

    return ChatRoomState(messages: messages, closed: false);
  }

  Future<void> _connectHub(String roomId) async {
    final tokenStorage = ref.read(tokenStorageProvider);
    final connection = buildHubConnection(AppConfig.chatHubUrl, tokenStorage);
    _connection = connection;

    connection.on('ReceiveMessage', (arguments) {
      final json = arguments?.first as Map<String, dynamic>?;
      if (json == null) return;
      final message = ChatMessage.fromJson(json);
      if (message.chatRoomId != roomId) return;
      final current = state.value;
      if (current == null || current.messages.any((m) => m.id == message.id)) return;
      state = AsyncData(current.copyWith(messages: [...current.messages, message]));
      ref.read(chatApiProvider).markRead(roomId);
      ref.read(chatUnreadProvider.notifier).markRead(roomId);
    });

    connection.on('RoomClosed', (arguments) {
      final json = arguments?.first as Map<String, dynamic>?;
      if (json == null || json['id'] != roomId) return;
      final current = state.value;
      if (current == null) return;
      state = AsyncData(current.copyWith(closed: true));
    });

    try {
      await connection.start();
      await connection.invoke('JoinRoom', args: [roomId]);
    } catch (_) {
    }
  }

  Future<void> _disconnectHub() async {
    final connection = _connection;
    _connection = null;
    if (connection == null) return;
    try {
      await connection.invoke('LeaveRoom', args: [roomId]);
    } catch (_) {}
    try {
      await connection.stop();
    } catch (_) {}
  }

  Future<ChatMessage> sendMessage({required String content, String? replyToMessageId}) async {
    final message = await ref.read(chatApiProvider).sendMessage(roomId, content: content, replyToMessageId: replyToMessageId);
    final current = state.value;
    if (current != null && !current.messages.any((m) => m.id == message.id)) {
      state = AsyncData(current.copyWith(messages: [...current.messages, message]));
    }
    return message;
  }
}
