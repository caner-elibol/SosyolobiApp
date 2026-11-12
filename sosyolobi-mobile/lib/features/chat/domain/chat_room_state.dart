import 'chat.dart';

class ChatRoomState {
  const ChatRoomState({required this.messages, required this.closed});

  final List<ChatMessage> messages;
  final bool closed;

  ChatRoomState copyWith({List<ChatMessage>? messages, bool? closed}) {
    return ChatRoomState(messages: messages ?? this.messages, closed: closed ?? this.closed);
  }
}
