// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_join_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ActivityJoinRequest _$ActivityJoinRequestFromJson(Map<String, dynamic> json) =>
    _ActivityJoinRequest(
      id: json['id'] as String,
      activityId: json['activityId'] as String,
      user: PublicProfile.fromJson(json['user'] as Map<String, dynamic>),
      message: json['message'] as String?,
      status: const ActivityRequestStatusConverter().fromJson(
        (json['status'] as num).toInt(),
      ),
      createdAt: DateTime.parse(json['createdAt'] as String),
      respondedAt: json['respondedAt'] == null
          ? null
          : DateTime.parse(json['respondedAt'] as String),
    );

Map<String, dynamic> _$ActivityJoinRequestToJson(
  _ActivityJoinRequest instance,
) => <String, dynamic>{
  'id': instance.id,
  'activityId': instance.activityId,
  'user': instance.user,
  'message': instance.message,
  'status': const ActivityRequestStatusConverter().toJson(instance.status),
  'createdAt': instance.createdAt.toIso8601String(),
  'respondedAt': instance.respondedAt?.toIso8601String(),
};
