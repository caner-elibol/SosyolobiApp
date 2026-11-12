// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'activity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Activity {

 String get id; String get createdByUserId; String get createdByDisplayName; String? get createdByAvatarUrl; String get categoryId; String get categoryName; String? get categoryImageUrl; String get title; String? get description; DateTime get eventDate; int get neededPeopleCount; int get currentPeopleCount; double? get pricePerPerson;@SkillLevelConverter() SkillLevel get skillLevel;@GenderPreferenceConverter() GenderPreference get genderPreference;@ActivityStatusConverter() ActivityStatus get status; double get latitude; double get longitude; String get addressText; double? get distanceMeters; DateTime get createdAt;
/// Create a copy of Activity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActivityCopyWith<Activity> get copyWith => _$ActivityCopyWithImpl<Activity>(this as Activity, _$identity);

  /// Serializes this Activity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Activity&&(identical(other.id, id) || other.id == id)&&(identical(other.createdByUserId, createdByUserId) || other.createdByUserId == createdByUserId)&&(identical(other.createdByDisplayName, createdByDisplayName) || other.createdByDisplayName == createdByDisplayName)&&(identical(other.createdByAvatarUrl, createdByAvatarUrl) || other.createdByAvatarUrl == createdByAvatarUrl)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&(identical(other.categoryImageUrl, categoryImageUrl) || other.categoryImageUrl == categoryImageUrl)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.eventDate, eventDate) || other.eventDate == eventDate)&&(identical(other.neededPeopleCount, neededPeopleCount) || other.neededPeopleCount == neededPeopleCount)&&(identical(other.currentPeopleCount, currentPeopleCount) || other.currentPeopleCount == currentPeopleCount)&&(identical(other.pricePerPerson, pricePerPerson) || other.pricePerPerson == pricePerPerson)&&(identical(other.skillLevel, skillLevel) || other.skillLevel == skillLevel)&&(identical(other.genderPreference, genderPreference) || other.genderPreference == genderPreference)&&(identical(other.status, status) || other.status == status)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.addressText, addressText) || other.addressText == addressText)&&(identical(other.distanceMeters, distanceMeters) || other.distanceMeters == distanceMeters)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,createdByUserId,createdByDisplayName,createdByAvatarUrl,categoryId,categoryName,categoryImageUrl,title,description,eventDate,neededPeopleCount,currentPeopleCount,pricePerPerson,skillLevel,genderPreference,status,latitude,longitude,addressText,distanceMeters,createdAt]);

@override
String toString() {
  return 'Activity(id: $id, createdByUserId: $createdByUserId, createdByDisplayName: $createdByDisplayName, createdByAvatarUrl: $createdByAvatarUrl, categoryId: $categoryId, categoryName: $categoryName, categoryImageUrl: $categoryImageUrl, title: $title, description: $description, eventDate: $eventDate, neededPeopleCount: $neededPeopleCount, currentPeopleCount: $currentPeopleCount, pricePerPerson: $pricePerPerson, skillLevel: $skillLevel, genderPreference: $genderPreference, status: $status, latitude: $latitude, longitude: $longitude, addressText: $addressText, distanceMeters: $distanceMeters, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $ActivityCopyWith<$Res>  {
  factory $ActivityCopyWith(Activity value, $Res Function(Activity) _then) = _$ActivityCopyWithImpl;
@useResult
$Res call({
 String id, String createdByUserId, String createdByDisplayName, String? createdByAvatarUrl, String categoryId, String categoryName, String? categoryImageUrl, String title, String? description, DateTime eventDate, int neededPeopleCount, int currentPeopleCount, double? pricePerPerson,@SkillLevelConverter() SkillLevel skillLevel,@GenderPreferenceConverter() GenderPreference genderPreference,@ActivityStatusConverter() ActivityStatus status, double latitude, double longitude, String addressText, double? distanceMeters, DateTime createdAt
});




}
/// @nodoc
class _$ActivityCopyWithImpl<$Res>
    implements $ActivityCopyWith<$Res> {
  _$ActivityCopyWithImpl(this._self, this._then);

  final Activity _self;
  final $Res Function(Activity) _then;

/// Create a copy of Activity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? createdByUserId = null,Object? createdByDisplayName = null,Object? createdByAvatarUrl = freezed,Object? categoryId = null,Object? categoryName = null,Object? categoryImageUrl = freezed,Object? title = null,Object? description = freezed,Object? eventDate = null,Object? neededPeopleCount = null,Object? currentPeopleCount = null,Object? pricePerPerson = freezed,Object? skillLevel = null,Object? genderPreference = null,Object? status = null,Object? latitude = null,Object? longitude = null,Object? addressText = null,Object? distanceMeters = freezed,Object? createdAt = null,}) {
  return _then(Activity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,createdByUserId: null == createdByUserId ? _self.createdByUserId : createdByUserId // ignore: cast_nullable_to_non_nullable
as String,createdByDisplayName: null == createdByDisplayName ? _self.createdByDisplayName : createdByDisplayName // ignore: cast_nullable_to_non_nullable
as String,createdByAvatarUrl: freezed == createdByAvatarUrl ? _self.createdByAvatarUrl : createdByAvatarUrl // ignore: cast_nullable_to_non_nullable
as String?,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,categoryName: null == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String,categoryImageUrl: freezed == categoryImageUrl ? _self.categoryImageUrl : categoryImageUrl // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,eventDate: null == eventDate ? _self.eventDate : eventDate // ignore: cast_nullable_to_non_nullable
as DateTime,neededPeopleCount: null == neededPeopleCount ? _self.neededPeopleCount : neededPeopleCount // ignore: cast_nullable_to_non_nullable
as int,currentPeopleCount: null == currentPeopleCount ? _self.currentPeopleCount : currentPeopleCount // ignore: cast_nullable_to_non_nullable
as int,pricePerPerson: freezed == pricePerPerson ? _self.pricePerPerson : pricePerPerson // ignore: cast_nullable_to_non_nullable
as double?,skillLevel: null == skillLevel ? _self.skillLevel : skillLevel // ignore: cast_nullable_to_non_nullable
as SkillLevel,genderPreference: null == genderPreference ? _self.genderPreference : genderPreference // ignore: cast_nullable_to_non_nullable
as GenderPreference,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ActivityStatus,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,addressText: null == addressText ? _self.addressText : addressText // ignore: cast_nullable_to_non_nullable
as String,distanceMeters: freezed == distanceMeters ? _self.distanceMeters : distanceMeters // ignore: cast_nullable_to_non_nullable
as double?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Activity].
extension ActivityPatterns on Activity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Activity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Activity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Activity value)  $default,){
final _that = this;
switch (_that) {
case _Activity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Activity value)?  $default,){
final _that = this;
switch (_that) {
case _Activity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String createdByUserId,  String createdByDisplayName,  String? createdByAvatarUrl,  String categoryId,  String categoryName,  String? categoryImageUrl,  String title,  String? description,  DateTime eventDate,  int neededPeopleCount,  int currentPeopleCount,  double? pricePerPerson, @SkillLevelConverter()  SkillLevel skillLevel, @GenderPreferenceConverter()  GenderPreference genderPreference, @ActivityStatusConverter()  ActivityStatus status,  double latitude,  double longitude,  String addressText,  double? distanceMeters,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Activity() when $default != null:
return $default(_that.id,_that.createdByUserId,_that.createdByDisplayName,_that.createdByAvatarUrl,_that.categoryId,_that.categoryName,_that.categoryImageUrl,_that.title,_that.description,_that.eventDate,_that.neededPeopleCount,_that.currentPeopleCount,_that.pricePerPerson,_that.skillLevel,_that.genderPreference,_that.status,_that.latitude,_that.longitude,_that.addressText,_that.distanceMeters,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String createdByUserId,  String createdByDisplayName,  String? createdByAvatarUrl,  String categoryId,  String categoryName,  String? categoryImageUrl,  String title,  String? description,  DateTime eventDate,  int neededPeopleCount,  int currentPeopleCount,  double? pricePerPerson, @SkillLevelConverter()  SkillLevel skillLevel, @GenderPreferenceConverter()  GenderPreference genderPreference, @ActivityStatusConverter()  ActivityStatus status,  double latitude,  double longitude,  String addressText,  double? distanceMeters,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _Activity():
return $default(_that.id,_that.createdByUserId,_that.createdByDisplayName,_that.createdByAvatarUrl,_that.categoryId,_that.categoryName,_that.categoryImageUrl,_that.title,_that.description,_that.eventDate,_that.neededPeopleCount,_that.currentPeopleCount,_that.pricePerPerson,_that.skillLevel,_that.genderPreference,_that.status,_that.latitude,_that.longitude,_that.addressText,_that.distanceMeters,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String createdByUserId,  String createdByDisplayName,  String? createdByAvatarUrl,  String categoryId,  String categoryName,  String? categoryImageUrl,  String title,  String? description,  DateTime eventDate,  int neededPeopleCount,  int currentPeopleCount,  double? pricePerPerson, @SkillLevelConverter()  SkillLevel skillLevel, @GenderPreferenceConverter()  GenderPreference genderPreference, @ActivityStatusConverter()  ActivityStatus status,  double latitude,  double longitude,  String addressText,  double? distanceMeters,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Activity() when $default != null:
return $default(_that.id,_that.createdByUserId,_that.createdByDisplayName,_that.createdByAvatarUrl,_that.categoryId,_that.categoryName,_that.categoryImageUrl,_that.title,_that.description,_that.eventDate,_that.neededPeopleCount,_that.currentPeopleCount,_that.pricePerPerson,_that.skillLevel,_that.genderPreference,_that.status,_that.latitude,_that.longitude,_that.addressText,_that.distanceMeters,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Activity implements Activity {
  const _Activity({required this.id, required this.createdByUserId, required this.createdByDisplayName, this.createdByAvatarUrl, required this.categoryId, required this.categoryName, this.categoryImageUrl, required this.title, this.description, required this.eventDate, required this.neededPeopleCount, required this.currentPeopleCount, this.pricePerPerson, @SkillLevelConverter() required this.skillLevel, @GenderPreferenceConverter() required this.genderPreference, @ActivityStatusConverter() required this.status, required this.latitude, required this.longitude, required this.addressText, this.distanceMeters, required this.createdAt});
  factory _Activity.fromJson(Map<String, dynamic> json) => _$ActivityFromJson(json);

@override final  String id;
@override final  String createdByUserId;
@override final  String createdByDisplayName;
@override final  String? createdByAvatarUrl;
@override final  String categoryId;
@override final  String categoryName;
@override final  String? categoryImageUrl;
@override final  String title;
@override final  String? description;
@override final  DateTime eventDate;
@override final  int neededPeopleCount;
@override final  int currentPeopleCount;
@override final  double? pricePerPerson;
@override@SkillLevelConverter() final  SkillLevel skillLevel;
@override@GenderPreferenceConverter() final  GenderPreference genderPreference;
@override@ActivityStatusConverter() final  ActivityStatus status;
@override final  double latitude;
@override final  double longitude;
@override final  String addressText;
@override final  double? distanceMeters;
@override final  DateTime createdAt;

/// Create a copy of Activity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActivityCopyWith<_Activity> get copyWith => __$ActivityCopyWithImpl<_Activity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ActivityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Activity&&(identical(other.id, id) || other.id == id)&&(identical(other.createdByUserId, createdByUserId) || other.createdByUserId == createdByUserId)&&(identical(other.createdByDisplayName, createdByDisplayName) || other.createdByDisplayName == createdByDisplayName)&&(identical(other.createdByAvatarUrl, createdByAvatarUrl) || other.createdByAvatarUrl == createdByAvatarUrl)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&(identical(other.categoryImageUrl, categoryImageUrl) || other.categoryImageUrl == categoryImageUrl)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.eventDate, eventDate) || other.eventDate == eventDate)&&(identical(other.neededPeopleCount, neededPeopleCount) || other.neededPeopleCount == neededPeopleCount)&&(identical(other.currentPeopleCount, currentPeopleCount) || other.currentPeopleCount == currentPeopleCount)&&(identical(other.pricePerPerson, pricePerPerson) || other.pricePerPerson == pricePerPerson)&&(identical(other.skillLevel, skillLevel) || other.skillLevel == skillLevel)&&(identical(other.genderPreference, genderPreference) || other.genderPreference == genderPreference)&&(identical(other.status, status) || other.status == status)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.addressText, addressText) || other.addressText == addressText)&&(identical(other.distanceMeters, distanceMeters) || other.distanceMeters == distanceMeters)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,createdByUserId,createdByDisplayName,createdByAvatarUrl,categoryId,categoryName,categoryImageUrl,title,description,eventDate,neededPeopleCount,currentPeopleCount,pricePerPerson,skillLevel,genderPreference,status,latitude,longitude,addressText,distanceMeters,createdAt]);

@override
String toString() {
  return 'Activity(id: $id, createdByUserId: $createdByUserId, createdByDisplayName: $createdByDisplayName, createdByAvatarUrl: $createdByAvatarUrl, categoryId: $categoryId, categoryName: $categoryName, categoryImageUrl: $categoryImageUrl, title: $title, description: $description, eventDate: $eventDate, neededPeopleCount: $neededPeopleCount, currentPeopleCount: $currentPeopleCount, pricePerPerson: $pricePerPerson, skillLevel: $skillLevel, genderPreference: $genderPreference, status: $status, latitude: $latitude, longitude: $longitude, addressText: $addressText, distanceMeters: $distanceMeters, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$ActivityCopyWith<$Res> implements $ActivityCopyWith<$Res> {
  factory _$ActivityCopyWith(_Activity value, $Res Function(_Activity) _then) = __$ActivityCopyWithImpl;
@override @useResult
$Res call({
 String id, String createdByUserId, String createdByDisplayName, String? createdByAvatarUrl, String categoryId, String categoryName, String? categoryImageUrl, String title, String? description, DateTime eventDate, int neededPeopleCount, int currentPeopleCount, double? pricePerPerson,@SkillLevelConverter() SkillLevel skillLevel,@GenderPreferenceConverter() GenderPreference genderPreference,@ActivityStatusConverter() ActivityStatus status, double latitude, double longitude, String addressText, double? distanceMeters, DateTime createdAt
});




}
/// @nodoc
class __$ActivityCopyWithImpl<$Res>
    implements _$ActivityCopyWith<$Res> {
  __$ActivityCopyWithImpl(this._self, this._then);

  final _Activity _self;
  final $Res Function(_Activity) _then;

/// Create a copy of Activity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? createdByUserId = null,Object? createdByDisplayName = null,Object? createdByAvatarUrl = freezed,Object? categoryId = null,Object? categoryName = null,Object? categoryImageUrl = freezed,Object? title = null,Object? description = freezed,Object? eventDate = null,Object? neededPeopleCount = null,Object? currentPeopleCount = null,Object? pricePerPerson = freezed,Object? skillLevel = null,Object? genderPreference = null,Object? status = null,Object? latitude = null,Object? longitude = null,Object? addressText = null,Object? distanceMeters = freezed,Object? createdAt = null,}) {
  return _then(_Activity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,createdByUserId: null == createdByUserId ? _self.createdByUserId : createdByUserId // ignore: cast_nullable_to_non_nullable
as String,createdByDisplayName: null == createdByDisplayName ? _self.createdByDisplayName : createdByDisplayName // ignore: cast_nullable_to_non_nullable
as String,createdByAvatarUrl: freezed == createdByAvatarUrl ? _self.createdByAvatarUrl : createdByAvatarUrl // ignore: cast_nullable_to_non_nullable
as String?,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,categoryName: null == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String,categoryImageUrl: freezed == categoryImageUrl ? _self.categoryImageUrl : categoryImageUrl // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,eventDate: null == eventDate ? _self.eventDate : eventDate // ignore: cast_nullable_to_non_nullable
as DateTime,neededPeopleCount: null == neededPeopleCount ? _self.neededPeopleCount : neededPeopleCount // ignore: cast_nullable_to_non_nullable
as int,currentPeopleCount: null == currentPeopleCount ? _self.currentPeopleCount : currentPeopleCount // ignore: cast_nullable_to_non_nullable
as int,pricePerPerson: freezed == pricePerPerson ? _self.pricePerPerson : pricePerPerson // ignore: cast_nullable_to_non_nullable
as double?,skillLevel: null == skillLevel ? _self.skillLevel : skillLevel // ignore: cast_nullable_to_non_nullable
as SkillLevel,genderPreference: null == genderPreference ? _self.genderPreference : genderPreference // ignore: cast_nullable_to_non_nullable
as GenderPreference,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ActivityStatus,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,addressText: null == addressText ? _self.addressText : addressText // ignore: cast_nullable_to_non_nullable
as String,distanceMeters: freezed == distanceMeters ? _self.distanceMeters : distanceMeters // ignore: cast_nullable_to_non_nullable
as double?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$ActivityDetail {

 String get id; String get createdByUserId; String get createdByDisplayName; String? get createdByAvatarUrl; String get categoryId; String get categoryName; String? get categoryImageUrl; String get title; String? get description; DateTime get eventDate; int get neededPeopleCount; int get currentPeopleCount; double? get pricePerPerson;@SkillLevelConverter() SkillLevel get skillLevel;@GenderPreferenceConverter() GenderPreference get genderPreference;@ActivityStatusConverter() ActivityStatus get status; double get latitude; double get longitude; String get addressText; double? get distanceMeters; DateTime get createdAt; String? get addressDetailPrivate; List<PublicProfile> get participants;@ActivityRequestStatusConverter() ActivityRequestStatus? get myRequestStatus;
/// Create a copy of ActivityDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActivityDetailCopyWith<ActivityDetail> get copyWith => _$ActivityDetailCopyWithImpl<ActivityDetail>(this as ActivityDetail, _$identity);

  /// Serializes this ActivityDetail to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActivityDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.createdByUserId, createdByUserId) || other.createdByUserId == createdByUserId)&&(identical(other.createdByDisplayName, createdByDisplayName) || other.createdByDisplayName == createdByDisplayName)&&(identical(other.createdByAvatarUrl, createdByAvatarUrl) || other.createdByAvatarUrl == createdByAvatarUrl)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&(identical(other.categoryImageUrl, categoryImageUrl) || other.categoryImageUrl == categoryImageUrl)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.eventDate, eventDate) || other.eventDate == eventDate)&&(identical(other.neededPeopleCount, neededPeopleCount) || other.neededPeopleCount == neededPeopleCount)&&(identical(other.currentPeopleCount, currentPeopleCount) || other.currentPeopleCount == currentPeopleCount)&&(identical(other.pricePerPerson, pricePerPerson) || other.pricePerPerson == pricePerPerson)&&(identical(other.skillLevel, skillLevel) || other.skillLevel == skillLevel)&&(identical(other.genderPreference, genderPreference) || other.genderPreference == genderPreference)&&(identical(other.status, status) || other.status == status)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.addressText, addressText) || other.addressText == addressText)&&(identical(other.distanceMeters, distanceMeters) || other.distanceMeters == distanceMeters)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.addressDetailPrivate, addressDetailPrivate) || other.addressDetailPrivate == addressDetailPrivate)&&const DeepCollectionEquality().equals(other.participants, participants)&&(identical(other.myRequestStatus, myRequestStatus) || other.myRequestStatus == myRequestStatus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,createdByUserId,createdByDisplayName,createdByAvatarUrl,categoryId,categoryName,categoryImageUrl,title,description,eventDate,neededPeopleCount,currentPeopleCount,pricePerPerson,skillLevel,genderPreference,status,latitude,longitude,addressText,distanceMeters,createdAt,addressDetailPrivate,const DeepCollectionEquality().hash(participants),myRequestStatus]);

@override
String toString() {
  return 'ActivityDetail(id: $id, createdByUserId: $createdByUserId, createdByDisplayName: $createdByDisplayName, createdByAvatarUrl: $createdByAvatarUrl, categoryId: $categoryId, categoryName: $categoryName, categoryImageUrl: $categoryImageUrl, title: $title, description: $description, eventDate: $eventDate, neededPeopleCount: $neededPeopleCount, currentPeopleCount: $currentPeopleCount, pricePerPerson: $pricePerPerson, skillLevel: $skillLevel, genderPreference: $genderPreference, status: $status, latitude: $latitude, longitude: $longitude, addressText: $addressText, distanceMeters: $distanceMeters, createdAt: $createdAt, addressDetailPrivate: $addressDetailPrivate, participants: $participants, myRequestStatus: $myRequestStatus)';
}


}

/// @nodoc
abstract mixin class $ActivityDetailCopyWith<$Res>  {
  factory $ActivityDetailCopyWith(ActivityDetail value, $Res Function(ActivityDetail) _then) = _$ActivityDetailCopyWithImpl;
@useResult
$Res call({
 String id, String createdByUserId, String createdByDisplayName, String? createdByAvatarUrl, String categoryId, String categoryName, String? categoryImageUrl, String title, String? description, DateTime eventDate, int neededPeopleCount, int currentPeopleCount, double? pricePerPerson,@SkillLevelConverter() SkillLevel skillLevel,@GenderPreferenceConverter() GenderPreference genderPreference,@ActivityStatusConverter() ActivityStatus status, double latitude, double longitude, String addressText, double? distanceMeters, DateTime createdAt, String? addressDetailPrivate, List<PublicProfile> participants,@ActivityRequestStatusConverter() ActivityRequestStatus? myRequestStatus
});




}
/// @nodoc
class _$ActivityDetailCopyWithImpl<$Res>
    implements $ActivityDetailCopyWith<$Res> {
  _$ActivityDetailCopyWithImpl(this._self, this._then);

  final ActivityDetail _self;
  final $Res Function(ActivityDetail) _then;

/// Create a copy of ActivityDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? createdByUserId = null,Object? createdByDisplayName = null,Object? createdByAvatarUrl = freezed,Object? categoryId = null,Object? categoryName = null,Object? categoryImageUrl = freezed,Object? title = null,Object? description = freezed,Object? eventDate = null,Object? neededPeopleCount = null,Object? currentPeopleCount = null,Object? pricePerPerson = freezed,Object? skillLevel = null,Object? genderPreference = null,Object? status = null,Object? latitude = null,Object? longitude = null,Object? addressText = null,Object? distanceMeters = freezed,Object? createdAt = null,Object? addressDetailPrivate = freezed,Object? participants = null,Object? myRequestStatus = freezed,}) {
  return _then(ActivityDetail(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,createdByUserId: null == createdByUserId ? _self.createdByUserId : createdByUserId // ignore: cast_nullable_to_non_nullable
as String,createdByDisplayName: null == createdByDisplayName ? _self.createdByDisplayName : createdByDisplayName // ignore: cast_nullable_to_non_nullable
as String,createdByAvatarUrl: freezed == createdByAvatarUrl ? _self.createdByAvatarUrl : createdByAvatarUrl // ignore: cast_nullable_to_non_nullable
as String?,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,categoryName: null == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String,categoryImageUrl: freezed == categoryImageUrl ? _self.categoryImageUrl : categoryImageUrl // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,eventDate: null == eventDate ? _self.eventDate : eventDate // ignore: cast_nullable_to_non_nullable
as DateTime,neededPeopleCount: null == neededPeopleCount ? _self.neededPeopleCount : neededPeopleCount // ignore: cast_nullable_to_non_nullable
as int,currentPeopleCount: null == currentPeopleCount ? _self.currentPeopleCount : currentPeopleCount // ignore: cast_nullable_to_non_nullable
as int,pricePerPerson: freezed == pricePerPerson ? _self.pricePerPerson : pricePerPerson // ignore: cast_nullable_to_non_nullable
as double?,skillLevel: null == skillLevel ? _self.skillLevel : skillLevel // ignore: cast_nullable_to_non_nullable
as SkillLevel,genderPreference: null == genderPreference ? _self.genderPreference : genderPreference // ignore: cast_nullable_to_non_nullable
as GenderPreference,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ActivityStatus,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,addressText: null == addressText ? _self.addressText : addressText // ignore: cast_nullable_to_non_nullable
as String,distanceMeters: freezed == distanceMeters ? _self.distanceMeters : distanceMeters // ignore: cast_nullable_to_non_nullable
as double?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,addressDetailPrivate: freezed == addressDetailPrivate ? _self.addressDetailPrivate : addressDetailPrivate // ignore: cast_nullable_to_non_nullable
as String?,participants: null == participants ? _self.participants : participants // ignore: cast_nullable_to_non_nullable
as List<PublicProfile>,myRequestStatus: freezed == myRequestStatus ? _self.myRequestStatus : myRequestStatus // ignore: cast_nullable_to_non_nullable
as ActivityRequestStatus?,
  ));
}

}


/// Adds pattern-matching-related methods to [ActivityDetail].
extension ActivityDetailPatterns on ActivityDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ActivityDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ActivityDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ActivityDetail value)  $default,){
final _that = this;
switch (_that) {
case _ActivityDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ActivityDetail value)?  $default,){
final _that = this;
switch (_that) {
case _ActivityDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String createdByUserId,  String createdByDisplayName,  String? createdByAvatarUrl,  String categoryId,  String categoryName,  String? categoryImageUrl,  String title,  String? description,  DateTime eventDate,  int neededPeopleCount,  int currentPeopleCount,  double? pricePerPerson, @SkillLevelConverter()  SkillLevel skillLevel, @GenderPreferenceConverter()  GenderPreference genderPreference, @ActivityStatusConverter()  ActivityStatus status,  double latitude,  double longitude,  String addressText,  double? distanceMeters,  DateTime createdAt,  String? addressDetailPrivate,  List<PublicProfile> participants, @ActivityRequestStatusConverter()  ActivityRequestStatus? myRequestStatus)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ActivityDetail() when $default != null:
return $default(_that.id,_that.createdByUserId,_that.createdByDisplayName,_that.createdByAvatarUrl,_that.categoryId,_that.categoryName,_that.categoryImageUrl,_that.title,_that.description,_that.eventDate,_that.neededPeopleCount,_that.currentPeopleCount,_that.pricePerPerson,_that.skillLevel,_that.genderPreference,_that.status,_that.latitude,_that.longitude,_that.addressText,_that.distanceMeters,_that.createdAt,_that.addressDetailPrivate,_that.participants,_that.myRequestStatus);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String createdByUserId,  String createdByDisplayName,  String? createdByAvatarUrl,  String categoryId,  String categoryName,  String? categoryImageUrl,  String title,  String? description,  DateTime eventDate,  int neededPeopleCount,  int currentPeopleCount,  double? pricePerPerson, @SkillLevelConverter()  SkillLevel skillLevel, @GenderPreferenceConverter()  GenderPreference genderPreference, @ActivityStatusConverter()  ActivityStatus status,  double latitude,  double longitude,  String addressText,  double? distanceMeters,  DateTime createdAt,  String? addressDetailPrivate,  List<PublicProfile> participants, @ActivityRequestStatusConverter()  ActivityRequestStatus? myRequestStatus)  $default,) {final _that = this;
switch (_that) {
case _ActivityDetail():
return $default(_that.id,_that.createdByUserId,_that.createdByDisplayName,_that.createdByAvatarUrl,_that.categoryId,_that.categoryName,_that.categoryImageUrl,_that.title,_that.description,_that.eventDate,_that.neededPeopleCount,_that.currentPeopleCount,_that.pricePerPerson,_that.skillLevel,_that.genderPreference,_that.status,_that.latitude,_that.longitude,_that.addressText,_that.distanceMeters,_that.createdAt,_that.addressDetailPrivate,_that.participants,_that.myRequestStatus);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String createdByUserId,  String createdByDisplayName,  String? createdByAvatarUrl,  String categoryId,  String categoryName,  String? categoryImageUrl,  String title,  String? description,  DateTime eventDate,  int neededPeopleCount,  int currentPeopleCount,  double? pricePerPerson, @SkillLevelConverter()  SkillLevel skillLevel, @GenderPreferenceConverter()  GenderPreference genderPreference, @ActivityStatusConverter()  ActivityStatus status,  double latitude,  double longitude,  String addressText,  double? distanceMeters,  DateTime createdAt,  String? addressDetailPrivate,  List<PublicProfile> participants, @ActivityRequestStatusConverter()  ActivityRequestStatus? myRequestStatus)?  $default,) {final _that = this;
switch (_that) {
case _ActivityDetail() when $default != null:
return $default(_that.id,_that.createdByUserId,_that.createdByDisplayName,_that.createdByAvatarUrl,_that.categoryId,_that.categoryName,_that.categoryImageUrl,_that.title,_that.description,_that.eventDate,_that.neededPeopleCount,_that.currentPeopleCount,_that.pricePerPerson,_that.skillLevel,_that.genderPreference,_that.status,_that.latitude,_that.longitude,_that.addressText,_that.distanceMeters,_that.createdAt,_that.addressDetailPrivate,_that.participants,_that.myRequestStatus);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ActivityDetail implements ActivityDetail {
  const _ActivityDetail({required this.id, required this.createdByUserId, required this.createdByDisplayName, this.createdByAvatarUrl, required this.categoryId, required this.categoryName, this.categoryImageUrl, required this.title, this.description, required this.eventDate, required this.neededPeopleCount, required this.currentPeopleCount, this.pricePerPerson, @SkillLevelConverter() required this.skillLevel, @GenderPreferenceConverter() required this.genderPreference, @ActivityStatusConverter() required this.status, required this.latitude, required this.longitude, required this.addressText, this.distanceMeters, required this.createdAt, this.addressDetailPrivate, required  List<PublicProfile> participants, @ActivityRequestStatusConverter() this.myRequestStatus}): _participants = participants;
  factory _ActivityDetail.fromJson(Map<String, dynamic> json) => _$ActivityDetailFromJson(json);

@override final  String id;
@override final  String createdByUserId;
@override final  String createdByDisplayName;
@override final  String? createdByAvatarUrl;
@override final  String categoryId;
@override final  String categoryName;
@override final  String? categoryImageUrl;
@override final  String title;
@override final  String? description;
@override final  DateTime eventDate;
@override final  int neededPeopleCount;
@override final  int currentPeopleCount;
@override final  double? pricePerPerson;
@override@SkillLevelConverter() final  SkillLevel skillLevel;
@override@GenderPreferenceConverter() final  GenderPreference genderPreference;
@override@ActivityStatusConverter() final  ActivityStatus status;
@override final  double latitude;
@override final  double longitude;
@override final  String addressText;
@override final  double? distanceMeters;
@override final  DateTime createdAt;
@override final  String? addressDetailPrivate;
 final  List<PublicProfile> _participants;
@override List<PublicProfile> get participants {
  if (_participants is EqualUnmodifiableListView) return _participants;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_participants);
}

@override@ActivityRequestStatusConverter() final  ActivityRequestStatus? myRequestStatus;

/// Create a copy of ActivityDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActivityDetailCopyWith<_ActivityDetail> get copyWith => __$ActivityDetailCopyWithImpl<_ActivityDetail>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ActivityDetailToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActivityDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.createdByUserId, createdByUserId) || other.createdByUserId == createdByUserId)&&(identical(other.createdByDisplayName, createdByDisplayName) || other.createdByDisplayName == createdByDisplayName)&&(identical(other.createdByAvatarUrl, createdByAvatarUrl) || other.createdByAvatarUrl == createdByAvatarUrl)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&(identical(other.categoryImageUrl, categoryImageUrl) || other.categoryImageUrl == categoryImageUrl)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.eventDate, eventDate) || other.eventDate == eventDate)&&(identical(other.neededPeopleCount, neededPeopleCount) || other.neededPeopleCount == neededPeopleCount)&&(identical(other.currentPeopleCount, currentPeopleCount) || other.currentPeopleCount == currentPeopleCount)&&(identical(other.pricePerPerson, pricePerPerson) || other.pricePerPerson == pricePerPerson)&&(identical(other.skillLevel, skillLevel) || other.skillLevel == skillLevel)&&(identical(other.genderPreference, genderPreference) || other.genderPreference == genderPreference)&&(identical(other.status, status) || other.status == status)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.addressText, addressText) || other.addressText == addressText)&&(identical(other.distanceMeters, distanceMeters) || other.distanceMeters == distanceMeters)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.addressDetailPrivate, addressDetailPrivate) || other.addressDetailPrivate == addressDetailPrivate)&&const DeepCollectionEquality().equals(other._participants, _participants)&&(identical(other.myRequestStatus, myRequestStatus) || other.myRequestStatus == myRequestStatus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,createdByUserId,createdByDisplayName,createdByAvatarUrl,categoryId,categoryName,categoryImageUrl,title,description,eventDate,neededPeopleCount,currentPeopleCount,pricePerPerson,skillLevel,genderPreference,status,latitude,longitude,addressText,distanceMeters,createdAt,addressDetailPrivate,const DeepCollectionEquality().hash(_participants),myRequestStatus]);

@override
String toString() {
  return 'ActivityDetail(id: $id, createdByUserId: $createdByUserId, createdByDisplayName: $createdByDisplayName, createdByAvatarUrl: $createdByAvatarUrl, categoryId: $categoryId, categoryName: $categoryName, categoryImageUrl: $categoryImageUrl, title: $title, description: $description, eventDate: $eventDate, neededPeopleCount: $neededPeopleCount, currentPeopleCount: $currentPeopleCount, pricePerPerson: $pricePerPerson, skillLevel: $skillLevel, genderPreference: $genderPreference, status: $status, latitude: $latitude, longitude: $longitude, addressText: $addressText, distanceMeters: $distanceMeters, createdAt: $createdAt, addressDetailPrivate: $addressDetailPrivate, participants: $participants, myRequestStatus: $myRequestStatus)';
}


}

/// @nodoc
abstract mixin class _$ActivityDetailCopyWith<$Res> implements $ActivityDetailCopyWith<$Res> {
  factory _$ActivityDetailCopyWith(_ActivityDetail value, $Res Function(_ActivityDetail) _then) = __$ActivityDetailCopyWithImpl;
@override @useResult
$Res call({
 String id, String createdByUserId, String createdByDisplayName, String? createdByAvatarUrl, String categoryId, String categoryName, String? categoryImageUrl, String title, String? description, DateTime eventDate, int neededPeopleCount, int currentPeopleCount, double? pricePerPerson,@SkillLevelConverter() SkillLevel skillLevel,@GenderPreferenceConverter() GenderPreference genderPreference,@ActivityStatusConverter() ActivityStatus status, double latitude, double longitude, String addressText, double? distanceMeters, DateTime createdAt, String? addressDetailPrivate, List<PublicProfile> participants,@ActivityRequestStatusConverter() ActivityRequestStatus? myRequestStatus
});




}
/// @nodoc
class __$ActivityDetailCopyWithImpl<$Res>
    implements _$ActivityDetailCopyWith<$Res> {
  __$ActivityDetailCopyWithImpl(this._self, this._then);

  final _ActivityDetail _self;
  final $Res Function(_ActivityDetail) _then;

/// Create a copy of ActivityDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? createdByUserId = null,Object? createdByDisplayName = null,Object? createdByAvatarUrl = freezed,Object? categoryId = null,Object? categoryName = null,Object? categoryImageUrl = freezed,Object? title = null,Object? description = freezed,Object? eventDate = null,Object? neededPeopleCount = null,Object? currentPeopleCount = null,Object? pricePerPerson = freezed,Object? skillLevel = null,Object? genderPreference = null,Object? status = null,Object? latitude = null,Object? longitude = null,Object? addressText = null,Object? distanceMeters = freezed,Object? createdAt = null,Object? addressDetailPrivate = freezed,Object? participants = null,Object? myRequestStatus = freezed,}) {
  return _then(_ActivityDetail(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,createdByUserId: null == createdByUserId ? _self.createdByUserId : createdByUserId // ignore: cast_nullable_to_non_nullable
as String,createdByDisplayName: null == createdByDisplayName ? _self.createdByDisplayName : createdByDisplayName // ignore: cast_nullable_to_non_nullable
as String,createdByAvatarUrl: freezed == createdByAvatarUrl ? _self.createdByAvatarUrl : createdByAvatarUrl // ignore: cast_nullable_to_non_nullable
as String?,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,categoryName: null == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String,categoryImageUrl: freezed == categoryImageUrl ? _self.categoryImageUrl : categoryImageUrl // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,eventDate: null == eventDate ? _self.eventDate : eventDate // ignore: cast_nullable_to_non_nullable
as DateTime,neededPeopleCount: null == neededPeopleCount ? _self.neededPeopleCount : neededPeopleCount // ignore: cast_nullable_to_non_nullable
as int,currentPeopleCount: null == currentPeopleCount ? _self.currentPeopleCount : currentPeopleCount // ignore: cast_nullable_to_non_nullable
as int,pricePerPerson: freezed == pricePerPerson ? _self.pricePerPerson : pricePerPerson // ignore: cast_nullable_to_non_nullable
as double?,skillLevel: null == skillLevel ? _self.skillLevel : skillLevel // ignore: cast_nullable_to_non_nullable
as SkillLevel,genderPreference: null == genderPreference ? _self.genderPreference : genderPreference // ignore: cast_nullable_to_non_nullable
as GenderPreference,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ActivityStatus,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,addressText: null == addressText ? _self.addressText : addressText // ignore: cast_nullable_to_non_nullable
as String,distanceMeters: freezed == distanceMeters ? _self.distanceMeters : distanceMeters // ignore: cast_nullable_to_non_nullable
as double?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,addressDetailPrivate: freezed == addressDetailPrivate ? _self.addressDetailPrivate : addressDetailPrivate // ignore: cast_nullable_to_non_nullable
as String?,participants: null == participants ? _self._participants : participants // ignore: cast_nullable_to_non_nullable
as List<PublicProfile>,myRequestStatus: freezed == myRequestStatus ? _self.myRequestStatus : myRequestStatus // ignore: cast_nullable_to_non_nullable
as ActivityRequestStatus?,
  ));
}


}


/// @nodoc
mixin _$ActivityMapItem {

 String get id; String get title; String get categoryName; String? get categoryImageUrl;@ActivityStatusConverter() ActivityStatus get status; double get latitude; double get longitude; DateTime get eventDate; int get neededPeopleCount; double? get pricePerPerson; double get distanceMeters;
/// Create a copy of ActivityMapItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActivityMapItemCopyWith<ActivityMapItem> get copyWith => _$ActivityMapItemCopyWithImpl<ActivityMapItem>(this as ActivityMapItem, _$identity);

  /// Serializes this ActivityMapItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActivityMapItem&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&(identical(other.categoryImageUrl, categoryImageUrl) || other.categoryImageUrl == categoryImageUrl)&&(identical(other.status, status) || other.status == status)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.eventDate, eventDate) || other.eventDate == eventDate)&&(identical(other.neededPeopleCount, neededPeopleCount) || other.neededPeopleCount == neededPeopleCount)&&(identical(other.pricePerPerson, pricePerPerson) || other.pricePerPerson == pricePerPerson)&&(identical(other.distanceMeters, distanceMeters) || other.distanceMeters == distanceMeters));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,categoryName,categoryImageUrl,status,latitude,longitude,eventDate,neededPeopleCount,pricePerPerson,distanceMeters);

@override
String toString() {
  return 'ActivityMapItem(id: $id, title: $title, categoryName: $categoryName, categoryImageUrl: $categoryImageUrl, status: $status, latitude: $latitude, longitude: $longitude, eventDate: $eventDate, neededPeopleCount: $neededPeopleCount, pricePerPerson: $pricePerPerson, distanceMeters: $distanceMeters)';
}


}

/// @nodoc
abstract mixin class $ActivityMapItemCopyWith<$Res>  {
  factory $ActivityMapItemCopyWith(ActivityMapItem value, $Res Function(ActivityMapItem) _then) = _$ActivityMapItemCopyWithImpl;
@useResult
$Res call({
 String id, String title, String categoryName, String? categoryImageUrl,@ActivityStatusConverter() ActivityStatus status, double latitude, double longitude, DateTime eventDate, int neededPeopleCount, double? pricePerPerson, double distanceMeters
});




}
/// @nodoc
class _$ActivityMapItemCopyWithImpl<$Res>
    implements $ActivityMapItemCopyWith<$Res> {
  _$ActivityMapItemCopyWithImpl(this._self, this._then);

  final ActivityMapItem _self;
  final $Res Function(ActivityMapItem) _then;

/// Create a copy of ActivityMapItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? categoryName = null,Object? categoryImageUrl = freezed,Object? status = null,Object? latitude = null,Object? longitude = null,Object? eventDate = null,Object? neededPeopleCount = null,Object? pricePerPerson = freezed,Object? distanceMeters = null,}) {
  return _then(ActivityMapItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,categoryName: null == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String,categoryImageUrl: freezed == categoryImageUrl ? _self.categoryImageUrl : categoryImageUrl // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ActivityStatus,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,eventDate: null == eventDate ? _self.eventDate : eventDate // ignore: cast_nullable_to_non_nullable
as DateTime,neededPeopleCount: null == neededPeopleCount ? _self.neededPeopleCount : neededPeopleCount // ignore: cast_nullable_to_non_nullable
as int,pricePerPerson: freezed == pricePerPerson ? _self.pricePerPerson : pricePerPerson // ignore: cast_nullable_to_non_nullable
as double?,distanceMeters: null == distanceMeters ? _self.distanceMeters : distanceMeters // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [ActivityMapItem].
extension ActivityMapItemPatterns on ActivityMapItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ActivityMapItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ActivityMapItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ActivityMapItem value)  $default,){
final _that = this;
switch (_that) {
case _ActivityMapItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ActivityMapItem value)?  $default,){
final _that = this;
switch (_that) {
case _ActivityMapItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String categoryName,  String? categoryImageUrl, @ActivityStatusConverter()  ActivityStatus status,  double latitude,  double longitude,  DateTime eventDate,  int neededPeopleCount,  double? pricePerPerson,  double distanceMeters)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ActivityMapItem() when $default != null:
return $default(_that.id,_that.title,_that.categoryName,_that.categoryImageUrl,_that.status,_that.latitude,_that.longitude,_that.eventDate,_that.neededPeopleCount,_that.pricePerPerson,_that.distanceMeters);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String categoryName,  String? categoryImageUrl, @ActivityStatusConverter()  ActivityStatus status,  double latitude,  double longitude,  DateTime eventDate,  int neededPeopleCount,  double? pricePerPerson,  double distanceMeters)  $default,) {final _that = this;
switch (_that) {
case _ActivityMapItem():
return $default(_that.id,_that.title,_that.categoryName,_that.categoryImageUrl,_that.status,_that.latitude,_that.longitude,_that.eventDate,_that.neededPeopleCount,_that.pricePerPerson,_that.distanceMeters);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String categoryName,  String? categoryImageUrl, @ActivityStatusConverter()  ActivityStatus status,  double latitude,  double longitude,  DateTime eventDate,  int neededPeopleCount,  double? pricePerPerson,  double distanceMeters)?  $default,) {final _that = this;
switch (_that) {
case _ActivityMapItem() when $default != null:
return $default(_that.id,_that.title,_that.categoryName,_that.categoryImageUrl,_that.status,_that.latitude,_that.longitude,_that.eventDate,_that.neededPeopleCount,_that.pricePerPerson,_that.distanceMeters);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ActivityMapItem implements ActivityMapItem {
  const _ActivityMapItem({required this.id, required this.title, required this.categoryName, this.categoryImageUrl, @ActivityStatusConverter() required this.status, required this.latitude, required this.longitude, required this.eventDate, required this.neededPeopleCount, this.pricePerPerson, required this.distanceMeters});
  factory _ActivityMapItem.fromJson(Map<String, dynamic> json) => _$ActivityMapItemFromJson(json);

@override final  String id;
@override final  String title;
@override final  String categoryName;
@override final  String? categoryImageUrl;
@override@ActivityStatusConverter() final  ActivityStatus status;
@override final  double latitude;
@override final  double longitude;
@override final  DateTime eventDate;
@override final  int neededPeopleCount;
@override final  double? pricePerPerson;
@override final  double distanceMeters;

/// Create a copy of ActivityMapItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActivityMapItemCopyWith<_ActivityMapItem> get copyWith => __$ActivityMapItemCopyWithImpl<_ActivityMapItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ActivityMapItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActivityMapItem&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&(identical(other.categoryImageUrl, categoryImageUrl) || other.categoryImageUrl == categoryImageUrl)&&(identical(other.status, status) || other.status == status)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.eventDate, eventDate) || other.eventDate == eventDate)&&(identical(other.neededPeopleCount, neededPeopleCount) || other.neededPeopleCount == neededPeopleCount)&&(identical(other.pricePerPerson, pricePerPerson) || other.pricePerPerson == pricePerPerson)&&(identical(other.distanceMeters, distanceMeters) || other.distanceMeters == distanceMeters));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,categoryName,categoryImageUrl,status,latitude,longitude,eventDate,neededPeopleCount,pricePerPerson,distanceMeters);

@override
String toString() {
  return 'ActivityMapItem(id: $id, title: $title, categoryName: $categoryName, categoryImageUrl: $categoryImageUrl, status: $status, latitude: $latitude, longitude: $longitude, eventDate: $eventDate, neededPeopleCount: $neededPeopleCount, pricePerPerson: $pricePerPerson, distanceMeters: $distanceMeters)';
}


}

/// @nodoc
abstract mixin class _$ActivityMapItemCopyWith<$Res> implements $ActivityMapItemCopyWith<$Res> {
  factory _$ActivityMapItemCopyWith(_ActivityMapItem value, $Res Function(_ActivityMapItem) _then) = __$ActivityMapItemCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String categoryName, String? categoryImageUrl,@ActivityStatusConverter() ActivityStatus status, double latitude, double longitude, DateTime eventDate, int neededPeopleCount, double? pricePerPerson, double distanceMeters
});




}
/// @nodoc
class __$ActivityMapItemCopyWithImpl<$Res>
    implements _$ActivityMapItemCopyWith<$Res> {
  __$ActivityMapItemCopyWithImpl(this._self, this._then);

  final _ActivityMapItem _self;
  final $Res Function(_ActivityMapItem) _then;

/// Create a copy of ActivityMapItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? categoryName = null,Object? categoryImageUrl = freezed,Object? status = null,Object? latitude = null,Object? longitude = null,Object? eventDate = null,Object? neededPeopleCount = null,Object? pricePerPerson = freezed,Object? distanceMeters = null,}) {
  return _then(_ActivityMapItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,categoryName: null == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String,categoryImageUrl: freezed == categoryImageUrl ? _self.categoryImageUrl : categoryImageUrl // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ActivityStatus,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,eventDate: null == eventDate ? _self.eventDate : eventDate // ignore: cast_nullable_to_non_nullable
as DateTime,neededPeopleCount: null == neededPeopleCount ? _self.neededPeopleCount : neededPeopleCount // ignore: cast_nullable_to_non_nullable
as int,pricePerPerson: freezed == pricePerPerson ? _self.pricePerPerson : pricePerPerson // ignore: cast_nullable_to_non_nullable
as double?,distanceMeters: null == distanceMeters ? _self.distanceMeters : distanceMeters // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
