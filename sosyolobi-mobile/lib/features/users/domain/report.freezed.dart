// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'report.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreateReportRequest {

 String? get reportedUserId; String? get reportedActivityId; String get reason; String? get details;
/// Create a copy of CreateReportRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateReportRequestCopyWith<CreateReportRequest> get copyWith => _$CreateReportRequestCopyWithImpl<CreateReportRequest>(this as CreateReportRequest, _$identity);

  /// Serializes this CreateReportRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateReportRequest&&(identical(other.reportedUserId, reportedUserId) || other.reportedUserId == reportedUserId)&&(identical(other.reportedActivityId, reportedActivityId) || other.reportedActivityId == reportedActivityId)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.details, details) || other.details == details));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,reportedUserId,reportedActivityId,reason,details);

@override
String toString() {
  return 'CreateReportRequest(reportedUserId: $reportedUserId, reportedActivityId: $reportedActivityId, reason: $reason, details: $details)';
}


}

/// @nodoc
abstract mixin class $CreateReportRequestCopyWith<$Res>  {
  factory $CreateReportRequestCopyWith(CreateReportRequest value, $Res Function(CreateReportRequest) _then) = _$CreateReportRequestCopyWithImpl;
@useResult
$Res call({
 String? reportedUserId, String? reportedActivityId, String reason, String? details
});




}
/// @nodoc
class _$CreateReportRequestCopyWithImpl<$Res>
    implements $CreateReportRequestCopyWith<$Res> {
  _$CreateReportRequestCopyWithImpl(this._self, this._then);

  final CreateReportRequest _self;
  final $Res Function(CreateReportRequest) _then;

/// Create a copy of CreateReportRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? reportedUserId = freezed,Object? reportedActivityId = freezed,Object? reason = null,Object? details = freezed,}) {
  return _then(CreateReportRequest(
reportedUserId: freezed == reportedUserId ? _self.reportedUserId : reportedUserId // ignore: cast_nullable_to_non_nullable
as String?,reportedActivityId: freezed == reportedActivityId ? _self.reportedActivityId : reportedActivityId // ignore: cast_nullable_to_non_nullable
as String?,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,details: freezed == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateReportRequest].
extension CreateReportRequestPatterns on CreateReportRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateReportRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateReportRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateReportRequest value)  $default,){
final _that = this;
switch (_that) {
case _CreateReportRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateReportRequest value)?  $default,){
final _that = this;
switch (_that) {
case _CreateReportRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? reportedUserId,  String? reportedActivityId,  String reason,  String? details)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateReportRequest() when $default != null:
return $default(_that.reportedUserId,_that.reportedActivityId,_that.reason,_that.details);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? reportedUserId,  String? reportedActivityId,  String reason,  String? details)  $default,) {final _that = this;
switch (_that) {
case _CreateReportRequest():
return $default(_that.reportedUserId,_that.reportedActivityId,_that.reason,_that.details);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? reportedUserId,  String? reportedActivityId,  String reason,  String? details)?  $default,) {final _that = this;
switch (_that) {
case _CreateReportRequest() when $default != null:
return $default(_that.reportedUserId,_that.reportedActivityId,_that.reason,_that.details);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreateReportRequest implements CreateReportRequest {
  const _CreateReportRequest({this.reportedUserId, this.reportedActivityId, required this.reason, this.details});
  factory _CreateReportRequest.fromJson(Map<String, dynamic> json) => _$CreateReportRequestFromJson(json);

@override final  String? reportedUserId;
@override final  String? reportedActivityId;
@override final  String reason;
@override final  String? details;

/// Create a copy of CreateReportRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateReportRequestCopyWith<_CreateReportRequest> get copyWith => __$CreateReportRequestCopyWithImpl<_CreateReportRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateReportRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateReportRequest&&(identical(other.reportedUserId, reportedUserId) || other.reportedUserId == reportedUserId)&&(identical(other.reportedActivityId, reportedActivityId) || other.reportedActivityId == reportedActivityId)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.details, details) || other.details == details));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,reportedUserId,reportedActivityId,reason,details);

@override
String toString() {
  return 'CreateReportRequest(reportedUserId: $reportedUserId, reportedActivityId: $reportedActivityId, reason: $reason, details: $details)';
}


}

/// @nodoc
abstract mixin class _$CreateReportRequestCopyWith<$Res> implements $CreateReportRequestCopyWith<$Res> {
  factory _$CreateReportRequestCopyWith(_CreateReportRequest value, $Res Function(_CreateReportRequest) _then) = __$CreateReportRequestCopyWithImpl;
@override @useResult
$Res call({
 String? reportedUserId, String? reportedActivityId, String reason, String? details
});




}
/// @nodoc
class __$CreateReportRequestCopyWithImpl<$Res>
    implements _$CreateReportRequestCopyWith<$Res> {
  __$CreateReportRequestCopyWithImpl(this._self, this._then);

  final _CreateReportRequest _self;
  final $Res Function(_CreateReportRequest) _then;

/// Create a copy of CreateReportRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? reportedUserId = freezed,Object? reportedActivityId = freezed,Object? reason = null,Object? details = freezed,}) {
  return _then(_CreateReportRequest(
reportedUserId: freezed == reportedUserId ? _self.reportedUserId : reportedUserId // ignore: cast_nullable_to_non_nullable
as String?,reportedActivityId: freezed == reportedActivityId ? _self.reportedActivityId : reportedActivityId // ignore: cast_nullable_to_non_nullable
as String?,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,details: freezed == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ReportResponse {

 String get id; String get reporterUserId; String? get reportedUserId; String? get reportedActivityId; String get reason; String? get details;@ReportStatusConverter() ReportStatus get status; DateTime get createdAt; DateTime? get resolvedAt;
/// Create a copy of ReportResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportResponseCopyWith<ReportResponse> get copyWith => _$ReportResponseCopyWithImpl<ReportResponse>(this as ReportResponse, _$identity);

  /// Serializes this ReportResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.reporterUserId, reporterUserId) || other.reporterUserId == reporterUserId)&&(identical(other.reportedUserId, reportedUserId) || other.reportedUserId == reportedUserId)&&(identical(other.reportedActivityId, reportedActivityId) || other.reportedActivityId == reportedActivityId)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.details, details) || other.details == details)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.resolvedAt, resolvedAt) || other.resolvedAt == resolvedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,reporterUserId,reportedUserId,reportedActivityId,reason,details,status,createdAt,resolvedAt);

@override
String toString() {
  return 'ReportResponse(id: $id, reporterUserId: $reporterUserId, reportedUserId: $reportedUserId, reportedActivityId: $reportedActivityId, reason: $reason, details: $details, status: $status, createdAt: $createdAt, resolvedAt: $resolvedAt)';
}


}

/// @nodoc
abstract mixin class $ReportResponseCopyWith<$Res>  {
  factory $ReportResponseCopyWith(ReportResponse value, $Res Function(ReportResponse) _then) = _$ReportResponseCopyWithImpl;
@useResult
$Res call({
 String id, String reporterUserId, String? reportedUserId, String? reportedActivityId, String reason, String? details,@ReportStatusConverter() ReportStatus status, DateTime createdAt, DateTime? resolvedAt
});




}
/// @nodoc
class _$ReportResponseCopyWithImpl<$Res>
    implements $ReportResponseCopyWith<$Res> {
  _$ReportResponseCopyWithImpl(this._self, this._then);

  final ReportResponse _self;
  final $Res Function(ReportResponse) _then;

/// Create a copy of ReportResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? reporterUserId = null,Object? reportedUserId = freezed,Object? reportedActivityId = freezed,Object? reason = null,Object? details = freezed,Object? status = null,Object? createdAt = null,Object? resolvedAt = freezed,}) {
  return _then(ReportResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,reporterUserId: null == reporterUserId ? _self.reporterUserId : reporterUserId // ignore: cast_nullable_to_non_nullable
as String,reportedUserId: freezed == reportedUserId ? _self.reportedUserId : reportedUserId // ignore: cast_nullable_to_non_nullable
as String?,reportedActivityId: freezed == reportedActivityId ? _self.reportedActivityId : reportedActivityId // ignore: cast_nullable_to_non_nullable
as String?,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,details: freezed == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ReportStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,resolvedAt: freezed == resolvedAt ? _self.resolvedAt : resolvedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [ReportResponse].
extension ReportResponsePatterns on ReportResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReportResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReportResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReportResponse value)  $default,){
final _that = this;
switch (_that) {
case _ReportResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReportResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ReportResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String reporterUserId,  String? reportedUserId,  String? reportedActivityId,  String reason,  String? details, @ReportStatusConverter()  ReportStatus status,  DateTime createdAt,  DateTime? resolvedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReportResponse() when $default != null:
return $default(_that.id,_that.reporterUserId,_that.reportedUserId,_that.reportedActivityId,_that.reason,_that.details,_that.status,_that.createdAt,_that.resolvedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String reporterUserId,  String? reportedUserId,  String? reportedActivityId,  String reason,  String? details, @ReportStatusConverter()  ReportStatus status,  DateTime createdAt,  DateTime? resolvedAt)  $default,) {final _that = this;
switch (_that) {
case _ReportResponse():
return $default(_that.id,_that.reporterUserId,_that.reportedUserId,_that.reportedActivityId,_that.reason,_that.details,_that.status,_that.createdAt,_that.resolvedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String reporterUserId,  String? reportedUserId,  String? reportedActivityId,  String reason,  String? details, @ReportStatusConverter()  ReportStatus status,  DateTime createdAt,  DateTime? resolvedAt)?  $default,) {final _that = this;
switch (_that) {
case _ReportResponse() when $default != null:
return $default(_that.id,_that.reporterUserId,_that.reportedUserId,_that.reportedActivityId,_that.reason,_that.details,_that.status,_that.createdAt,_that.resolvedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReportResponse implements ReportResponse {
  const _ReportResponse({required this.id, required this.reporterUserId, this.reportedUserId, this.reportedActivityId, required this.reason, this.details, @ReportStatusConverter() required this.status, required this.createdAt, this.resolvedAt});
  factory _ReportResponse.fromJson(Map<String, dynamic> json) => _$ReportResponseFromJson(json);

@override final  String id;
@override final  String reporterUserId;
@override final  String? reportedUserId;
@override final  String? reportedActivityId;
@override final  String reason;
@override final  String? details;
@override@ReportStatusConverter() final  ReportStatus status;
@override final  DateTime createdAt;
@override final  DateTime? resolvedAt;

/// Create a copy of ReportResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReportResponseCopyWith<_ReportResponse> get copyWith => __$ReportResponseCopyWithImpl<_ReportResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReportResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReportResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.reporterUserId, reporterUserId) || other.reporterUserId == reporterUserId)&&(identical(other.reportedUserId, reportedUserId) || other.reportedUserId == reportedUserId)&&(identical(other.reportedActivityId, reportedActivityId) || other.reportedActivityId == reportedActivityId)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.details, details) || other.details == details)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.resolvedAt, resolvedAt) || other.resolvedAt == resolvedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,reporterUserId,reportedUserId,reportedActivityId,reason,details,status,createdAt,resolvedAt);

@override
String toString() {
  return 'ReportResponse(id: $id, reporterUserId: $reporterUserId, reportedUserId: $reportedUserId, reportedActivityId: $reportedActivityId, reason: $reason, details: $details, status: $status, createdAt: $createdAt, resolvedAt: $resolvedAt)';
}


}

/// @nodoc
abstract mixin class _$ReportResponseCopyWith<$Res> implements $ReportResponseCopyWith<$Res> {
  factory _$ReportResponseCopyWith(_ReportResponse value, $Res Function(_ReportResponse) _then) = __$ReportResponseCopyWithImpl;
@override @useResult
$Res call({
 String id, String reporterUserId, String? reportedUserId, String? reportedActivityId, String reason, String? details,@ReportStatusConverter() ReportStatus status, DateTime createdAt, DateTime? resolvedAt
});




}
/// @nodoc
class __$ReportResponseCopyWithImpl<$Res>
    implements _$ReportResponseCopyWith<$Res> {
  __$ReportResponseCopyWithImpl(this._self, this._then);

  final _ReportResponse _self;
  final $Res Function(_ReportResponse) _then;

/// Create a copy of ReportResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? reporterUserId = null,Object? reportedUserId = freezed,Object? reportedActivityId = freezed,Object? reason = null,Object? details = freezed,Object? status = null,Object? createdAt = null,Object? resolvedAt = freezed,}) {
  return _then(_ReportResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,reporterUserId: null == reporterUserId ? _self.reporterUserId : reporterUserId // ignore: cast_nullable_to_non_nullable
as String,reportedUserId: freezed == reportedUserId ? _self.reportedUserId : reportedUserId // ignore: cast_nullable_to_non_nullable
as String?,reportedActivityId: freezed == reportedActivityId ? _self.reportedActivityId : reportedActivityId // ignore: cast_nullable_to_non_nullable
as String?,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,details: freezed == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ReportStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,resolvedAt: freezed == resolvedAt ? _self.resolvedAt : resolvedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
