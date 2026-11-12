import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/domain/enum_converters.dart';
import '../../../core/domain/enums.dart';

part 'chat.freezed.dart';
part 'chat.g.dart';

@freezed
abstract class ChatRoom with _$ChatRoom {
  const factory ChatRoom({
    required String id,
    required String activityId,
    @ChatRoomStatusConverter() required ChatRoomStatus status,
    required DateTime createdAt,
    DateTime? closedAt,
  }) = _ChatRoom;

  factory ChatRoom.fromJson(Map<String, dynamic> json) => _$ChatRoomFromJson(json);
}

@freezed
abstract class ChatMessageReplyPreview with _$ChatMessageReplyPreview {
  const factory ChatMessageReplyPreview({
    required String id,
    required String senderDisplayName,
    required String content,
  }) = _ChatMessageReplyPreview;

  factory ChatMessageReplyPreview.fromJson(Map<String, dynamic> json) => _$ChatMessageReplyPreviewFromJson(json);
}

@freezed
abstract class ChatMessage with _$ChatMessage {
  const factory ChatMessage({
    required String id,
    required String chatRoomId,
    required String senderUserId,
    required String senderDisplayName,
    String? senderAvatarUrl,
    required String content,
    ChatMessageReplyPreview? replyTo,
    required DateTime createdAt,
  }) = _ChatMessage;

  factory ChatMessage.fromJson(Map<String, dynamic> json) => _$ChatMessageFromJson(json);
}

@freezed
abstract class ChatUnreadSummary with _$ChatUnreadSummary {
  const factory ChatUnreadSummary({
    required String activityId,
    required String activityTitle,
    required String chatRoomId,
    required int unreadCount,
  }) = _ChatUnreadSummary;

  factory ChatUnreadSummary.fromJson(Map<String, dynamic> json) => _$ChatUnreadSummaryFromJson(json);
}
