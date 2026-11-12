// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Category _$CategoryFromJson(Map<String, dynamic> json) => _Category(
  id: json['id'] as String,
  name: json['name'] as String,
  slug: json['slug'] as String,
  iconName: json['iconName'] as String?,
  color: json['color'] as String?,
  imageUrl: json['imageUrl'] as String?,
  sortOrder: (json['sortOrder'] as num).toInt(),
);

Map<String, dynamic> _$CategoryToJson(_Category instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'slug': instance.slug,
  'iconName': instance.iconName,
  'color': instance.color,
  'imageUrl': instance.imageUrl,
  'sortOrder': instance.sortOrder,
};
