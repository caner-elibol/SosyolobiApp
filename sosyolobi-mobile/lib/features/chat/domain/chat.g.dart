// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChatRoom _$ChatRoomFromJson(Map<String, dynamic> json) => _ChatRoom(
  id: json['id'] as String,
  activityId: json['activityId'] as String,
  status: const ChatRoomStatusConverter().fromJson(
    (json['status'] as num).toInt(),
  ),
  createdAt: DateTime.parse(json['createdAt'] as String),
  closedAt: json['closedAt'] == null
      ? null
      : DateTime.parse(json['closedAt'] as String),
);

Map<String, dynamic> _$ChatRoomToJson(_ChatRoom instance) => <String, dynamic>{
  'id': instance.id,
  'activityId': instance.activityId,
  'status': const ChatRoomStatusConverter().toJson(instance.status),
  'createdAt': instance.createdAt.toIso8601String(),
  'closedAt': instance.closedAt?.toIso8601String(),
};

_ChatMessageReplyPreview _$ChatMessageReplyPreviewFromJson(
  Map<String, dynamic> json,
) => _ChatMessageReplyPreview(
  id: json['id'] as String,
  senderDisplayName: json['senderDisplayName'] as String,
  content: json['content'] as String,
);

Map<String, dynamic> _$ChatMessageReplyPreviewToJson(
  _ChatMessageReplyPreview instance,
) => <String, dynamic>{
  'id': instance.id,
  'senderDisplayName': instance.senderDisplayName,
  'content': instance.content,
};

_ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) => _ChatMessage(
  id: json['id'] as String,
  chatRoomId: json['chatRoomId'] as String,
  senderUserId: json['senderUserId'] as String,
  senderDisplayName: json['senderDisplayName'] as String,
  senderAvatarUrl: json['senderAvatarUrl'] as String?,
  content: json['content'] as String,
  replyTo: json['replyTo'] == null
      ? null
      : ChatMessageReplyPreview.fromJson(
          json['replyTo'] as Map<String, dynamic>,
        ),
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$ChatMessageToJson(_ChatMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'chatRoomId': instance.chatRoomId,
      'senderUserId': instance.senderUserId,
      'senderDisplayName': instance.senderDisplayName,
      'senderAvatarUrl': instance.senderAvatarUrl,
      'content': instance.content,
      'replyTo': instance.replyTo,
      'createdAt': instance.createdAt.toIso8601String(),
    };

_ChatUnreadSummary _$ChatUnreadSummaryFromJson(Map<String, dynamic> json) =>
    _ChatUnreadSummary(
      activityId: json['activityId'] as String,
      activityTitle: json['activityTitle'] as String,
      chatRoomId: json['chatRoomId'] as String,
      unreadCount: (json['unreadCount'] as num).toInt(),
    );

Map<String, dynamic> _$ChatUnreadSummaryToJson(_ChatUnreadSummary instance) =>
    <String, dynamic>{
      'activityId': instance.activityId,
      'activityTitle': instance.activityTitle,
      'chatRoomId': instance.chatRoomId,
      'unreadCount': instance.unreadCount,
    };
