// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'activity_join_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ActivityJoinRequest {

 String get id; String get activityId; PublicProfile get user; String? get message;@ActivityRequestStatusConverter() ActivityRequestStatus get status; DateTime get createdAt; DateTime? get respondedAt;
/// Create a copy of ActivityJoinRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActivityJoinRequestCopyWith<ActivityJoinRequest> get copyWith => _$ActivityJoinRequestCopyWithImpl<ActivityJoinRequest>(this as ActivityJoinRequest, _$identity);

  /// Serializes this ActivityJoinRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActivityJoinRequest&&(identical(other.id, id) || other.id == id)&&(identical(other.activityId, activityId) || other.activityId == activityId)&&(identical(other.user, user) || other.user == user)&&(identical(other.message, message) || other.message == message)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.respondedAt, respondedAt) || other.respondedAt == respondedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,activityId,user,message,status,createdAt,respondedAt);

@override
String toString() {
  return 'ActivityJoinRequest(id: $id, activityId: $activityId, user: $user, message: $message, status: $status, createdAt: $createdAt, respondedAt: $respondedAt)';
}


}

/// @nodoc
abstract mixin class $ActivityJoinRequestCopyWith<$Res>  {
  factory $ActivityJoinRequestCopyWith(ActivityJoinRequest value, $Res Function(ActivityJoinRequest) _then) = _$ActivityJoinRequestCopyWithImpl;
@useResult
$Res call({
 String id, String activityId, PublicProfile user, String? message,@ActivityRequestStatusConverter() ActivityRequestStatus status, DateTime createdAt, DateTime? respondedAt
});


$PublicProfileCopyWith<$Res> get user;

}
/// @nodoc
class _$ActivityJoinRequestCopyWithImpl<$Res>
    implements $ActivityJoinRequestCopyWith<$Res> {
  _$ActivityJoinRequestCopyWithImpl(this._self, this._then);

  final ActivityJoinRequest _self;
  final $Res Function(ActivityJoinRequest) _then;

/// Create a copy of ActivityJoinRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? activityId = null,Object? user = null,Object? message = freezed,Object? status = null,Object? createdAt = null,Object? respondedAt = freezed,}) {
  return _then(ActivityJoinRequest(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,activityId: null == activityId ? _self.activityId : activityId // ignore: cast_nullable_to_non_nullable
as String,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as PublicProfile,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ActivityRequestStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,respondedAt: freezed == respondedAt ? _self.respondedAt : respondedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of ActivityJoinRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PublicProfileCopyWith<$Res> get user {
  
  return $PublicProfileCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [ActivityJoinRequest].
extension ActivityJoinRequestPatterns on ActivityJoinRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ActivityJoinRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ActivityJoinRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ActivityJoinRequest value)  $default,){
final _that = this;
switch (_that) {
case _ActivityJoinRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ActivityJoinRequest value)?  $default,){
final _that = this;
switch (_that) {
case _ActivityJoinRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String activityId,  PublicProfile user,  String? message, @ActivityRequestStatusConverter()  ActivityRequestStatus status,  DateTime createdAt,  DateTime? respondedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ActivityJoinRequest() when $default != null:
return $default(_that.id,_that.activityId,_that.user,_that.message,_that.status,_that.createdAt,_that.respondedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String activityId,  PublicProfile user,  String? message, @ActivityRequestStatusConverter()  ActivityRequestStatus status,  DateTime createdAt,  DateTime? respondedAt)  $default,) {final _that = this;
switch (_that) {
case _ActivityJoinRequest():
return $default(_that.id,_that.activityId,_that.user,_that.message,_that.status,_that.createdAt,_that.respondedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String activityId,  PublicProfile user,  String? message, @ActivityRequestStatusConverter()  ActivityRequestStatus status,  DateTime createdAt,  DateTime? respondedAt)?  $default,) {final _that = this;
switch (_that) {
case _ActivityJoinRequest() when $default != null:
return $default(_that.id,_that.activityId,_that.user,_that.message,_that.status,_that.createdAt,_that.respondedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ActivityJoinRequest implements ActivityJoinRequest {
  const _ActivityJoinRequest({required this.id, required this.activityId, required this.user, this.message, @ActivityRequestStatusConverter() required this.status, required this.createdAt, this.respondedAt});
  factory _ActivityJoinRequest.fromJson(Map<String, dynamic> json) => _$ActivityJoinRequestFromJson(json);

@override final  String id;
@override final  String activityId;
@override final  PublicProfile user;
@override final  String? message;
@override@ActivityRequestStatusConverter() final  ActivityRequestStatus status;
@override final  DateTime createdAt;
@override final  DateTime? respondedAt;

/// Create a copy of ActivityJoinRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActivityJoinRequestCopyWith<_ActivityJoinRequest> get copyWith => __$ActivityJoinRequestCopyWithImpl<_ActivityJoinRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ActivityJoinRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActivityJoinRequest&&(identical(other.id, id) || other.id == id)&&(identical(other.activityId, activityId) || other.activityId == activityId)&&(identical(other.user, user) || other.user == user)&&(identical(other.message, message) || other.message == message)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.respondedAt, respondedAt) || other.respondedAt == respondedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,activityId,user,message,status,createdAt,respondedAt);

@override
String toString() {
  return 'ActivityJoinRequest(id: $id, activityId: $activityId, user: $user, message: $message, status: $status, createdAt: $createdAt, respondedAt: $respondedAt)';
}


}

/// @nodoc
abstract mixin class _$ActivityJoinRequestCopyWith<$Res> implements $ActivityJoinRequestCopyWith<$Res> {
  factory _$ActivityJoinRequestCopyWith(_ActivityJoinRequest value, $Res Function(_ActivityJoinRequest) _then) = __$ActivityJoinRequestCopyWithImpl;
@override @useResult
$Res call({
 String id, String activityId, PublicProfile user, String? message,@ActivityRequestStatusConverter() ActivityRequestStatus status, DateTime createdAt, DateTime? respondedAt
});


@override $PublicProfileCopyWith<$Res> get user;

}
/// @nodoc
class __$ActivityJoinRequestCopyWithImpl<$Res>
    implements _$ActivityJoinRequestCopyWith<$Res> {
  __$ActivityJoinRequestCopyWithImpl(this._self, this._then);

  final _ActivityJoinRequest _self;
  final $Res Function(_ActivityJoinRequest) _then;

/// Create a copy of ActivityJoinRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? activityId = null,Object? user = null,Object? message = freezed,Object? status = null,Object? createdAt = null,Object? respondedAt = freezed,}) {
  return _then(_ActivityJoinRequest(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,activityId: null == activityId ? _self.activityId : activityId // ignore: cast_nullable_to_non_nullable
as String,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as PublicProfile,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ActivityRequestStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,respondedAt: freezed == respondedAt ? _self.respondedAt : respondedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of ActivityJoinRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PublicProfileCopyWith<$Res> get user {
  
  return $PublicProfileCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}

// dart format on
