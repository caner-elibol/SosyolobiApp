// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Friend _$FriendFromJson(Map<String, dynamic> json) => _Friend(
  friendsSinceUtc: DateTime.parse(json['friendsSinceUtc'] as String),
  user: PublicProfile.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$FriendToJson(_Friend instance) => <String, dynamic>{
  'friendsSinceUtc': instance.friendsSinceUtc.toIso8601String(),
  'user': instance.user,
};

_FriendRequest _$FriendRequestFromJson(Map<String, dynamic> json) =>
    _FriendRequest(
      id: json['id'] as String,
      status: const FriendRequestStatusConverter().fromJson(
        (json['status'] as num).toInt(),
      ),
      createdAt: DateTime.parse(json['createdAt'] as String),
      respondedAt: json['respondedAt'] == null
          ? null
          : DateTime.parse(json['respondedAt'] as String),
      user: PublicProfile.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FriendRequestToJson(_FriendRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': const FriendRequestStatusConverter().toJson(instance.status),
      'createdAt': instance.createdAt.toIso8601String(),
      'respondedAt': instance.respondedAt?.toIso8601String(),
      'user': instance.user,
    };
