// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppNotification _$AppNotificationFromJson(Map<String, dynamic> json) =>
    _AppNotification(
      id: json['id'] as String,
      type: const NotificationTypeConverter().fromJson(
        (json['type'] as num).toInt(),
      ),
      title: json['title'] as String,
      message: json['message'] as String?,
      relatedActivityId: json['relatedActivityId'] as String?,
      relatedActivityTitle: json['relatedActivityTitle'] as String?,
      isRead: json['isRead'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$AppNotificationToJson(_AppNotification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': const NotificationTypeConverter().toJson(instance.type),
      'title': instance.title,
      'message': instance.message,
      'relatedActivityId': instance.relatedActivityId,
      'relatedActivityTitle': instance.relatedActivityTitle,
      'isRead': instance.isRead,
      'createdAt': instance.createdAt.toIso8601String(),
    };
