// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_activity_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreateActivityRequest _$CreateActivityRequestFromJson(
  Map<String, dynamic> json,
) => _CreateActivityRequest(
  categoryId: json['categoryId'] as String,
  title: json['title'] as String,
  description: json['description'] as String?,
  eventDate: DateTime.parse(json['eventDate'] as String),
  neededPeopleCount: (json['neededPeopleCount'] as num).toInt(),
  pricePerPerson: (json['pricePerPerson'] as num?)?.toDouble(),
  skillLevel: json['skillLevel'] == null
      ? SkillLevel.any
      : const SkillLevelConverter().fromJson(
          (json['skillLevel'] as num).toInt(),
        ),
  genderPreference: json['genderPreference'] == null
      ? GenderPreference.any
      : const GenderPreferenceConverter().fromJson(
          (json['genderPreference'] as num).toInt(),
        ),
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
  addressText: json['addressText'] as String,
  addressDetailPrivate: json['addressDetailPrivate'] as String?,
);

Map<String, dynamic> _$CreateActivityRequestToJson(
  _CreateActivityRequest instance,
) => <String, dynamic>{
  'categoryId': instance.categoryId,
  'title': instance.title,
  'description': instance.description,
  'eventDate': instance.eventDate.toIso8601String(),
  'neededPeopleCount': instance.neededPeopleCount,
  'pricePerPerson': instance.pricePerPerson,
  'skillLevel': const SkillLevelConverter().toJson(instance.skillLevel),
  'genderPreference': const GenderPreferenceConverter().toJson(
    instance.genderPreference,
  ),
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'addressText': instance.addressText,
  'addressDetailPrivate': instance.addressDetailPrivate,
};
