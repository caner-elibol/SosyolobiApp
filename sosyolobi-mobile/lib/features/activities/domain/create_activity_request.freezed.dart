// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_activity_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreateActivityRequest {

 String get categoryId; String get title; String? get description; DateTime get eventDate; int get neededPeopleCount; double? get pricePerPerson;@SkillLevelConverter() SkillLevel get skillLevel;@GenderPreferenceConverter() GenderPreference get genderPreference; double get latitude; double get longitude; String get addressText; String? get addressDetailPrivate;
/// Create a copy of CreateActivityRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateActivityRequestCopyWith<CreateActivityRequest> get copyWith => _$CreateActivityRequestCopyWithImpl<CreateActivityRequest>(this as CreateActivityRequest, _$identity);

  /// Serializes this CreateActivityRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateActivityRequest&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.eventDate, eventDate) || other.eventDate == eventDate)&&(identical(other.neededPeopleCount, neededPeopleCount) || other.neededPeopleCount == neededPeopleCount)&&(identical(other.pricePerPerson, pricePerPerson) || other.pricePerPerson == pricePerPerson)&&(identical(other.skillLevel, skillLevel) || other.skillLevel == skillLevel)&&(identical(other.genderPreference, genderPreference) || other.genderPreference == genderPreference)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.addressText, addressText) || other.addressText == addressText)&&(identical(other.addressDetailPrivate, addressDetailPrivate) || other.addressDetailPrivate == addressDetailPrivate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,categoryId,title,description,eventDate,neededPeopleCount,pricePerPerson,skillLevel,genderPreference,latitude,longitude,addressText,addressDetailPrivate);

@override
String toString() {
  return 'CreateActivityRequest(categoryId: $categoryId, title: $title, description: $description, eventDate: $eventDate, neededPeopleCount: $neededPeopleCount, pricePerPerson: $pricePerPerson, skillLevel: $skillLevel, genderPreference: $genderPreference, latitude: $latitude, longitude: $longitude, addressText: $addressText, addressDetailPrivate: $addressDetailPrivate)';
}


}

/// @nodoc
abstract mixin class $CreateActivityRequestCopyWith<$Res>  {
  factory $CreateActivityRequestCopyWith(CreateActivityRequest value, $Res Function(CreateActivityRequest) _then) = _$CreateActivityRequestCopyWithImpl;
@useResult
$Res call({
 String categoryId, String title, String? description, DateTime eventDate, int neededPeopleCount, double? pricePerPerson,@SkillLevelConverter() SkillLevel skillLevel,@GenderPreferenceConverter() GenderPreference genderPreference, double latitude, double longitude, String addressText, String? addressDetailPrivate
});




}
/// @nodoc
class _$CreateActivityRequestCopyWithImpl<$Res>
    implements $CreateActivityRequestCopyWith<$Res> {
  _$CreateActivityRequestCopyWithImpl(this._self, this._then);

  final CreateActivityRequest _self;
  final $Res Function(CreateActivityRequest) _then;

/// Create a copy of CreateActivityRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? categoryId = null,Object? title = null,Object? description = freezed,Object? eventDate = null,Object? neededPeopleCount = null,Object? pricePerPerson = freezed,Object? skillLevel = null,Object? genderPreference = null,Object? latitude = null,Object? longitude = null,Object? addressText = null,Object? addressDetailPrivate = freezed,}) {
  return _then(CreateActivityRequest(
categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,eventDate: null == eventDate ? _self.eventDate : eventDate // ignore: cast_nullable_to_non_nullable
as DateTime,neededPeopleCount: null == neededPeopleCount ? _self.neededPeopleCount : neededPeopleCount // ignore: cast_nullable_to_non_nullable
as int,pricePerPerson: freezed == pricePerPerson ? _self.pricePerPerson : pricePerPerson // ignore: cast_nullable_to_non_nullable
as double?,skillLevel: null == skillLevel ? _self.skillLevel : skillLevel // ignore: cast_nullable_to_non_nullable
as SkillLevel,genderPreference: null == genderPreference ? _self.genderPreference : genderPreference // ignore: cast_nullable_to_non_nullable
as GenderPreference,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,addressText: null == addressText ? _self.addressText : addressText // ignore: cast_nullable_to_non_nullable
as String,addressDetailPrivate: freezed == addressDetailPrivate ? _self.addressDetailPrivate : addressDetailPrivate // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateActivityRequest].
extension CreateActivityRequestPatterns on CreateActivityRequest {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateActivityRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateActivityRequest() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateActivityRequest value)  $default,){
final _that = this;
switch (_that) {
case _CreateActivityRequest():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateActivityRequest value)?  $default,){
final _that = this;
switch (_that) {
case _CreateActivityRequest() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String categoryId,  String title,  String? description,  DateTime eventDate,  int neededPeopleCount,  double? pricePerPerson, @SkillLevelConverter()  SkillLevel skillLevel, @GenderPreferenceConverter()  GenderPreference genderPreference,  double latitude,  double longitude,  String addressText,  String? addressDetailPrivate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateActivityRequest() when $default != null:
return $default(_that.categoryId,_that.title,_that.description,_that.eventDate,_that.neededPeopleCount,_that.pricePerPerson,_that.skillLevel,_that.genderPreference,_that.latitude,_that.longitude,_that.addressText,_that.addressDetailPrivate);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String categoryId,  String title,  String? description,  DateTime eventDate,  int neededPeopleCount,  double? pricePerPerson, @SkillLevelConverter()  SkillLevel skillLevel, @GenderPreferenceConverter()  GenderPreference genderPreference,  double latitude,  double longitude,  String addressText,  String? addressDetailPrivate)  $default,) {final _that = this;
switch (_that) {
case _CreateActivityRequest():
return $default(_that.categoryId,_that.title,_that.description,_that.eventDate,_that.neededPeopleCount,_that.pricePerPerson,_that.skillLevel,_that.genderPreference,_that.latitude,_that.longitude,_that.addressText,_that.addressDetailPrivate);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String categoryId,  String title,  String? description,  DateTime eventDate,  int neededPeopleCount,  double? pricePerPerson, @SkillLevelConverter()  SkillLevel skillLevel, @GenderPreferenceConverter()  GenderPreference genderPreference,  double latitude,  double longitude,  String addressText,  String? addressDetailPrivate)?  $default,) {final _that = this;
switch (_that) {
case _CreateActivityRequest() when $default != null:
return $default(_that.categoryId,_that.title,_that.description,_that.eventDate,_that.neededPeopleCount,_that.pricePerPerson,_that.skillLevel,_that.genderPreference,_that.latitude,_that.longitude,_that.addressText,_that.addressDetailPrivate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreateActivityRequest implements CreateActivityRequest {
  const _CreateActivityRequest({required this.categoryId, required this.title, this.description, required this.eventDate, required this.neededPeopleCount, this.pricePerPerson, @SkillLevelConverter() this.skillLevel = SkillLevel.any, @GenderPreferenceConverter() this.genderPreference = GenderPreference.any, required this.latitude, required this.longitude, required this.addressText, this.addressDetailPrivate});
  factory _CreateActivityRequest.fromJson(Map<String, dynamic> json) => _$CreateActivityRequestFromJson(json);

@override final  String categoryId;
@override final  String title;
@override final  String? description;
@override final  DateTime eventDate;
@override final  int neededPeopleCount;
@override final  double? pricePerPerson;
@override@JsonKey()@SkillLevelConverter() final  SkillLevel skillLevel;
@override@JsonKey()@GenderPreferenceConverter() final  GenderPreference genderPreference;
@override final  double latitude;
@override final  double longitude;
@override final  String addressText;
@override final  String? addressDetailPrivate;

/// Create a copy of CreateActivityRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateActivityRequestCopyWith<_CreateActivityRequest> get copyWith => __$CreateActivityRequestCopyWithImpl<_CreateActivityRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateActivityRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateActivityRequest&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.eventDate, eventDate) || other.eventDate == eventDate)&&(identical(other.neededPeopleCount, neededPeopleCount) || other.neededPeopleCount == neededPeopleCount)&&(identical(other.pricePerPerson, pricePerPerson) || other.pricePerPerson == pricePerPerson)&&(identical(other.skillLevel, skillLevel) || other.skillLevel == skillLevel)&&(identical(other.genderPreference, genderPreference) || other.genderPreference == genderPreference)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.addressText, addressText) || other.addressText == addressText)&&(identical(other.addressDetailPrivate, addressDetailPrivate) || other.addressDetailPrivate == addressDetailPrivate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,categoryId,title,description,eventDate,neededPeopleCount,pricePerPerson,skillLevel,genderPreference,latitude,longitude,addressText,addressDetailPrivate);

@override
String toString() {
  return 'CreateActivityRequest(categoryId: $categoryId, title: $title, description: $description, eventDate: $eventDate, neededPeopleCount: $neededPeopleCount, pricePerPerson: $pricePerPerson, skillLevel: $skillLevel, genderPreference: $genderPreference, latitude: $latitude, longitude: $longitude, addressText: $addressText, addressDetailPrivate: $addressDetailPrivate)';
}


}

/// @nodoc
abstract mixin class _$CreateActivityRequestCopyWith<$Res> implements $CreateActivityRequestCopyWith<$Res> {
  factory _$CreateActivityRequestCopyWith(_CreateActivityRequest value, $Res Function(_CreateActivityRequest) _then) = __$CreateActivityRequestCopyWithImpl;
@override @useResult
$Res call({
 String categoryId, String title, String? description, DateTime eventDate, int neededPeopleCount, double? pricePerPerson,@SkillLevelConverter() SkillLevel skillLevel,@GenderPreferenceConverter() GenderPreference genderPreference, double latitude, double longitude, String addressText, String? addressDetailPrivate
});




}
/// @nodoc
class __$CreateActivityRequestCopyWithImpl<$Res>
    implements _$CreateActivityRequestCopyWith<$Res> {
  __$CreateActivityRequestCopyWithImpl(this._self, this._then);

  final _CreateActivityRequest _self;
  final $Res Function(_CreateActivityRequest) _then;

/// Create a copy of CreateActivityRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? categoryId = null,Object? title = null,Object? description = freezed,Object? eventDate = null,Object? neededPeopleCount = null,Object? pricePerPerson = freezed,Object? skillLevel = null,Object? genderPreference = null,Object? latitude = null,Object? longitude = null,Object? addressText = null,Object? addressDetailPrivate = freezed,}) {
  return _then(_CreateActivityRequest(
categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,eventDate: null == eventDate ? _self.eventDate : eventDate // ignore: cast_nullable_to_non_nullable
as DateTime,neededPeopleCount: null == neededPeopleCount ? _self.neededPeopleCount : neededPeopleCount // ignore: cast_nullable_to_non_nullable
as int,pricePerPerson: freezed == pricePerPerson ? _self.pricePerPerson : pricePerPerson // ignore: cast_nullable_to_non_nullable
as double?,skillLevel: null == skillLevel ? _self.skillLevel : skillLevel // ignore: cast_nullable_to_non_nullable
as SkillLevel,genderPreference: null == genderPreference ? _self.genderPreference : genderPreference // ignore: cast_nullable_to_non_nullable
as GenderPreference,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,addressText: null == addressText ? _self.addressText : addressText // ignore: cast_nullable_to_non_nullable
as String,addressDetailPrivate: freezed == addressDetailPrivate ? _self.addressDetailPrivate : addressDetailPrivate // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
