// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChatRoom {

 String get id; String get activityId;@ChatRoomStatusConverter() ChatRoomStatus get status; DateTime get createdAt; DateTime? get closedAt;
/// Create a copy of ChatRoom
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatRoomCopyWith<ChatRoom> get copyWith => _$ChatRoomCopyWithImpl<ChatRoom>(this as ChatRoom, _$identity);

  /// Serializes this ChatRoom to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatRoom&&(identical(other.id, id) || other.id == id)&&(identical(other.activityId, activityId) || other.activityId == activityId)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.closedAt, closedAt) || other.closedAt == closedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,activityId,status,createdAt,closedAt);

@override
String toString() {
  return 'ChatRoom(id: $id, activityId: $activityId, status: $status, createdAt: $createdAt, closedAt: $closedAt)';
}


}

/// @nodoc
abstract mixin class $ChatRoomCopyWith<$Res>  {
  factory $ChatRoomCopyWith(ChatRoom value, $Res Function(ChatRoom) _then) = _$ChatRoomCopyWithImpl;
@useResult
$Res call({
 String id, String activityId,@ChatRoomStatusConverter() ChatRoomStatus status, DateTime createdAt, DateTime? closedAt
});




}
/// @nodoc
class _$ChatRoomCopyWithImpl<$Res>
    implements $ChatRoomCopyWith<$Res> {
  _$ChatRoomCopyWithImpl(this._self, this._then);

  final ChatRoom _self;
  final $Res Function(ChatRoom) _then;

/// Create a copy of ChatRoom
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? activityId = null,Object? status = null,Object? createdAt = null,Object? closedAt = freezed,}) {
  return _then(ChatRoom(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,activityId: null == activityId ? _self.activityId : activityId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ChatRoomStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,closedAt: freezed == closedAt ? _self.closedAt : closedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatRoom].
extension ChatRoomPatterns on ChatRoom {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatRoom value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatRoom() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatRoom value)  $default,){
final _that = this;
switch (_that) {
case _ChatRoom():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatRoom value)?  $default,){
final _that = this;
switch (_that) {
case _ChatRoom() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String activityId, @ChatRoomStatusConverter()  ChatRoomStatus status,  DateTime createdAt,  DateTime? closedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatRoom() when $default != null:
return $default(_that.id,_that.activityId,_that.status,_that.createdAt,_that.closedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String activityId, @ChatRoomStatusConverter()  ChatRoomStatus status,  DateTime createdAt,  DateTime? closedAt)  $default,) {final _that = this;
switch (_that) {
case _ChatRoom():
return $default(_that.id,_that.activityId,_that.status,_that.createdAt,_that.closedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String activityId, @ChatRoomStatusConverter()  ChatRoomStatus status,  DateTime createdAt,  DateTime? closedAt)?  $default,) {final _that = this;
switch (_that) {
case _ChatRoom() when $default != null:
return $default(_that.id,_that.activityId,_that.status,_that.createdAt,_that.closedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatRoom implements ChatRoom {
  const _ChatRoom({required this.id, required this.activityId, @ChatRoomStatusConverter() required this.status, required this.createdAt, this.closedAt});
  factory _ChatRoom.fromJson(Map<String, dynamic> json) => _$ChatRoomFromJson(json);

@override final  String id;
@override final  String activityId;
@override@ChatRoomStatusConverter() final  ChatRoomStatus status;
@override final  DateTime createdAt;
@override final  DateTime? closedAt;

/// Create a copy of ChatRoom
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatRoomCopyWith<_ChatRoom> get copyWith => __$ChatRoomCopyWithImpl<_ChatRoom>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatRoomToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatRoom&&(identical(other.id, id) || other.id == id)&&(identical(other.activityId, activityId) || other.activityId == activityId)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.closedAt, closedAt) || other.closedAt == closedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,activityId,status,createdAt,closedAt);

@override
String toString() {
  return 'ChatRoom(id: $id, activityId: $activityId, status: $status, createdAt: $createdAt, closedAt: $closedAt)';
}


}

/// @nodoc
abstract mixin class _$ChatRoomCopyWith<$Res> implements $ChatRoomCopyWith<$Res> {
  factory _$ChatRoomCopyWith(_ChatRoom value, $Res Function(_ChatRoom) _then) = __$ChatRoomCopyWithImpl;
@override @useResult
$Res call({
 String id, String activityId,@ChatRoomStatusConverter() ChatRoomStatus status, DateTime createdAt, DateTime? closedAt
});




}
/// @nodoc
class __$ChatRoomCopyWithImpl<$Res>
    implements _$ChatRoomCopyWith<$Res> {
  __$ChatRoomCopyWithImpl(this._self, this._then);

  final _ChatRoom _self;
  final $Res Function(_ChatRoom) _then;

/// Create a copy of ChatRoom
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? activityId = null,Object? status = null,Object? createdAt = null,Object? closedAt = freezed,}) {
  return _then(_ChatRoom(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,activityId: null == activityId ? _self.activityId : activityId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ChatRoomStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,closedAt: freezed == closedAt ? _self.closedAt : closedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$ChatMessageReplyPreview {

 String get id; String get senderDisplayName; String get content;
/// Create a copy of ChatMessageReplyPreview
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatMessageReplyPreviewCopyWith<ChatMessageReplyPreview> get copyWith => _$ChatMessageReplyPreviewCopyWithImpl<ChatMessageReplyPreview>(this as ChatMessageReplyPreview, _$identity);

  /// Serializes this ChatMessageReplyPreview to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatMessageReplyPreview&&(identical(other.id, id) || other.id == id)&&(identical(other.senderDisplayName, senderDisplayName) || other.senderDisplayName == senderDisplayName)&&(identical(other.content, content) || other.content == content));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,senderDisplayName,content);

@override
String toString() {
  return 'ChatMessageReplyPreview(id: $id, senderDisplayName: $senderDisplayName, content: $content)';
}


}

/// @nodoc
abstract mixin class $ChatMessageReplyPreviewCopyWith<$Res>  {
  factory $ChatMessageReplyPreviewCopyWith(ChatMessageReplyPreview value, $Res Function(ChatMessageReplyPreview) _then) = _$ChatMessageReplyPreviewCopyWithImpl;
@useResult
$Res call({
 String id, String senderDisplayName, String content
});




}
/// @nodoc
class _$ChatMessageReplyPreviewCopyWithImpl<$Res>
    implements $ChatMessageReplyPreviewCopyWith<$Res> {
  _$ChatMessageReplyPreviewCopyWithImpl(this._self, this._then);

  final ChatMessageReplyPreview _self;
  final $Res Function(ChatMessageReplyPreview) _then;

/// Create a copy of ChatMessageReplyPreview
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? senderDisplayName = null,Object? content = null,}) {
  return _then(ChatMessageReplyPreview(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,senderDisplayName: null == senderDisplayName ? _self.senderDisplayName : senderDisplayName // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatMessageReplyPreview].
extension ChatMessageReplyPreviewPatterns on ChatMessageReplyPreview {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatMessageReplyPreview value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatMessageReplyPreview() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatMessageReplyPreview value)  $default,){
final _that = this;
switch (_that) {
case _ChatMessageReplyPreview():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatMessageReplyPreview value)?  $default,){
final _that = this;
switch (_that) {
case _ChatMessageReplyPreview() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String senderDisplayName,  String content)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatMessageReplyPreview() when $default != null:
return $default(_that.id,_that.senderDisplayName,_that.content);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String senderDisplayName,  String content)  $default,) {final _that = this;
switch (_that) {
case _ChatMessageReplyPreview():
return $default(_that.id,_that.senderDisplayName,_that.content);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String senderDisplayName,  String content)?  $default,) {final _that = this;
switch (_that) {
case _ChatMessageReplyPreview() when $default != null:
return $default(_that.id,_that.senderDisplayName,_that.content);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatMessageReplyPreview implements ChatMessageReplyPreview {
  const _ChatMessageReplyPreview({required this.id, required this.senderDisplayName, required this.content});
  factory _ChatMessageReplyPreview.fromJson(Map<String, dynamic> json) => _$ChatMessageReplyPreviewFromJson(json);

@override final  String id;
@override final  String senderDisplayName;
@override final  String content;

/// Create a copy of ChatMessageReplyPreview
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatMessageReplyPreviewCopyWith<_ChatMessageReplyPreview> get copyWith => __$ChatMessageReplyPreviewCopyWithImpl<_ChatMessageReplyPreview>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatMessageReplyPreviewToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatMessageReplyPreview&&(identical(other.id, id) || other.id == id)&&(identical(other.senderDisplayName, senderDisplayName) || other.senderDisplayName == senderDisplayName)&&(identical(other.content, content) || other.content == content));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,senderDisplayName,content);

@override
String toString() {
  return 'ChatMessageReplyPreview(id: $id, senderDisplayName: $senderDisplayName, content: $content)';
}


}

/// @nodoc
abstract mixin class _$ChatMessageReplyPreviewCopyWith<$Res> implements $ChatMessageReplyPreviewCopyWith<$Res> {
  factory _$ChatMessageReplyPreviewCopyWith(_ChatMessageReplyPreview value, $Res Function(_ChatMessageReplyPreview) _then) = __$ChatMessageReplyPreviewCopyWithImpl;
@override @useResult
$Res call({
 String id, String senderDisplayName, String content
});




}
/// @nodoc
class __$ChatMessageReplyPreviewCopyWithImpl<$Res>
    implements _$ChatMessageReplyPreviewCopyWith<$Res> {
  __$ChatMessageReplyPreviewCopyWithImpl(this._self, this._then);

  final _ChatMessageReplyPreview _self;
  final $Res Function(_ChatMessageReplyPreview) _then;

/// Create a copy of ChatMessageReplyPreview
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? senderDisplayName = null,Object? content = null,}) {
  return _then(_ChatMessageReplyPreview(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,senderDisplayName: null == senderDisplayName ? _self.senderDisplayName : senderDisplayName // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ChatMessage {

 String get id; String get chatRoomId; String get senderUserId; String get senderDisplayName; String? get senderAvatarUrl; String get content; ChatMessageReplyPreview? get replyTo; DateTime get createdAt;
/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatMessageCopyWith<ChatMessage> get copyWith => _$ChatMessageCopyWithImpl<ChatMessage>(this as ChatMessage, _$identity);

  /// Serializes this ChatMessage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.chatRoomId, chatRoomId) || other.chatRoomId == chatRoomId)&&(identical(other.senderUserId, senderUserId) || other.senderUserId == senderUserId)&&(identical(other.senderDisplayName, senderDisplayName) || other.senderDisplayName == senderDisplayName)&&(identical(other.senderAvatarUrl, senderAvatarUrl) || other.senderAvatarUrl == senderAvatarUrl)&&(identical(other.content, content) || other.content == content)&&(identical(other.replyTo, replyTo) || other.replyTo == replyTo)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,chatRoomId,senderUserId,senderDisplayName,senderAvatarUrl,content,replyTo,createdAt);

@override
String toString() {
  return 'ChatMessage(id: $id, chatRoomId: $chatRoomId, senderUserId: $senderUserId, senderDisplayName: $senderDisplayName, senderAvatarUrl: $senderAvatarUrl, content: $content, replyTo: $replyTo, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $ChatMessageCopyWith<$Res>  {
  factory $ChatMessageCopyWith(ChatMessage value, $Res Function(ChatMessage) _then) = _$ChatMessageCopyWithImpl;
@useResult
$Res call({
 String id, String chatRoomId, String senderUserId, String senderDisplayName, String? senderAvatarUrl, String content, ChatMessageReplyPreview? replyTo, DateTime createdAt
});


$ChatMessageReplyPreviewCopyWith<$Res>? get replyTo;

}
/// @nodoc
class _$ChatMessageCopyWithImpl<$Res>
    implements $ChatMessageCopyWith<$Res> {
  _$ChatMessageCopyWithImpl(this._self, this._then);

  final ChatMessage _self;
  final $Res Function(ChatMessage) _then;

/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? chatRoomId = null,Object? senderUserId = null,Object? senderDisplayName = null,Object? senderAvatarUrl = freezed,Object? content = null,Object? replyTo = freezed,Object? createdAt = null,}) {
  return _then(ChatMessage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,chatRoomId: null == chatRoomId ? _self.chatRoomId : chatRoomId // ignore: cast_nullable_to_non_nullable
as String,senderUserId: null == senderUserId ? _self.senderUserId : senderUserId // ignore: cast_nullable_to_non_nullable
as String,senderDisplayName: null == senderDisplayName ? _self.senderDisplayName : senderDisplayName // ignore: cast_nullable_to_non_nullable
as String,senderAvatarUrl: freezed == senderAvatarUrl ? _self.senderAvatarUrl : senderAvatarUrl // ignore: cast_nullable_to_non_nullable
as String?,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,replyTo: freezed == replyTo ? _self.replyTo : replyTo // ignore: cast_nullable_to_non_nullable
as ChatMessageReplyPreview?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChatMessageReplyPreviewCopyWith<$Res>? get replyTo {
    if (_self.replyTo == null) {
    return null;
  }

  return $ChatMessageReplyPreviewCopyWith<$Res>(_self.replyTo!, (value) {
    return _then(_self.copyWith(replyTo: value));
  });
}
}


/// Adds pattern-matching-related methods to [ChatMessage].
extension ChatMessagePatterns on ChatMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatMessage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatMessage value)  $default,){
final _that = this;
switch (_that) {
case _ChatMessage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatMessage value)?  $default,){
final _that = this;
switch (_that) {
case _ChatMessage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String chatRoomId,  String senderUserId,  String senderDisplayName,  String? senderAvatarUrl,  String content,  ChatMessageReplyPreview? replyTo,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatMessage() when $default != null:
return $default(_that.id,_that.chatRoomId,_that.senderUserId,_that.senderDisplayName,_that.senderAvatarUrl,_that.content,_that.replyTo,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String chatRoomId,  String senderUserId,  String senderDisplayName,  String? senderAvatarUrl,  String content,  ChatMessageReplyPreview? replyTo,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _ChatMessage():
return $default(_that.id,_that.chatRoomId,_that.senderUserId,_that.senderDisplayName,_that.senderAvatarUrl,_that.content,_that.replyTo,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String chatRoomId,  String senderUserId,  String senderDisplayName,  String? senderAvatarUrl,  String content,  ChatMessageReplyPreview? replyTo,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _ChatMessage() when $default != null:
return $default(_that.id,_that.chatRoomId,_that.senderUserId,_that.senderDisplayName,_that.senderAvatarUrl,_that.content,_that.replyTo,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatMessage implements ChatMessage {
  const _ChatMessage({required this.id, required this.chatRoomId, required this.senderUserId, required this.senderDisplayName, this.senderAvatarUrl, required this.content, this.replyTo, required this.createdAt});
  factory _ChatMessage.fromJson(Map<String, dynamic> json) => _$ChatMessageFromJson(json);

@override final  String id;
@override final  String chatRoomId;
@override final  String senderUserId;
@override final  String senderDisplayName;
@override final  String? senderAvatarUrl;
@override final  String content;
@override final  ChatMessageReplyPreview? replyTo;
@override final  DateTime createdAt;

/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatMessageCopyWith<_ChatMessage> get copyWith => __$ChatMessageCopyWithImpl<_ChatMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatMessageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.chatRoomId, chatRoomId) || other.chatRoomId == chatRoomId)&&(identical(other.senderUserId, senderUserId) || other.senderUserId == senderUserId)&&(identical(other.senderDisplayName, senderDisplayName) || other.senderDisplayName == senderDisplayName)&&(identical(other.senderAvatarUrl, senderAvatarUrl) || other.senderAvatarUrl == senderAvatarUrl)&&(identical(other.content, content) || other.content == content)&&(identical(other.replyTo, replyTo) || other.replyTo == replyTo)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,chatRoomId,senderUserId,senderDisplayName,senderAvatarUrl,content,replyTo,createdAt);

@override
String toString() {
  return 'ChatMessage(id: $id, chatRoomId: $chatRoomId, senderUserId: $senderUserId, senderDisplayName: $senderDisplayName, senderAvatarUrl: $senderAvatarUrl, content: $content, replyTo: $replyTo, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$ChatMessageCopyWith<$Res> implements $ChatMessageCopyWith<$Res> {
  factory _$ChatMessageCopyWith(_ChatMessage value, $Res Function(_ChatMessage) _then) = __$ChatMessageCopyWithImpl;
@override @useResult
$Res call({
 String id, String chatRoomId, String senderUserId, String senderDisplayName, String? senderAvatarUrl, String content, ChatMessageReplyPreview? replyTo, DateTime createdAt
});


@override $ChatMessageReplyPreviewCopyWith<$Res>? get replyTo;

}
/// @nodoc
class __$ChatMessageCopyWithImpl<$Res>
    implements _$ChatMessageCopyWith<$Res> {
  __$ChatMessageCopyWithImpl(this._self, this._then);

  final _ChatMessage _self;
  final $Res Function(_ChatMessage) _then;

/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? chatRoomId = null,Object? senderUserId = null,Object? senderDisplayName = null,Object? senderAvatarUrl = freezed,Object? content = null,Object? replyTo = freezed,Object? createdAt = null,}) {
  return _then(_ChatMessage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,chatRoomId: null == chatRoomId ? _self.chatRoomId : chatRoomId // ignore: cast_nullable_to_non_nullable
as String,senderUserId: null == senderUserId ? _self.senderUserId : senderUserId // ignore: cast_nullable_to_non_nullable
as String,senderDisplayName: null == senderDisplayName ? _self.senderDisplayName : senderDisplayName // ignore: cast_nullable_to_non_nullable
as String,senderAvatarUrl: freezed == senderAvatarUrl ? _self.senderAvatarUrl : senderAvatarUrl // ignore: cast_nullable_to_non_nullable
as String?,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,replyTo: freezed == replyTo ? _self.replyTo : replyTo // ignore: cast_nullable_to_non_nullable
as ChatMessageReplyPreview?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChatMessageReplyPreviewCopyWith<$Res>? get replyTo {
    if (_self.replyTo == null) {
    return null;
  }

  return $ChatMessageReplyPreviewCopyWith<$Res>(_self.replyTo!, (value) {
    return _then(_self.copyWith(replyTo: value));
  });
}
}


/// @nodoc
mixin _$ChatUnreadSummary {

 String get activityId; String get activityTitle; String get chatRoomId; int get unreadCount;
/// Create a copy of ChatUnreadSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatUnreadSummaryCopyWith<ChatUnreadSummary> get copyWith => _$ChatUnreadSummaryCopyWithImpl<ChatUnreadSummary>(this as ChatUnreadSummary, _$identity);

  /// Serializes this ChatUnreadSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatUnreadSummary&&(identical(other.activityId, activityId) || other.activityId == activityId)&&(identical(other.activityTitle, activityTitle) || other.activityTitle == activityTitle)&&(identical(other.chatRoomId, chatRoomId) || other.chatRoomId == chatRoomId)&&(identical(other.unreadCount, unreadCount) || other.unreadCount == unreadCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,activityId,activityTitle,chatRoomId,unreadCount);

@override
String toString() {
  return 'ChatUnreadSummary(activityId: $activityId, activityTitle: $activityTitle, chatRoomId: $chatRoomId, unreadCount: $unreadCount)';
}


}

/// @nodoc
abstract mixin class $ChatUnreadSummaryCopyWith<$Res>  {
  factory $ChatUnreadSummaryCopyWith(ChatUnreadSummary value, $Res Function(ChatUnreadSummary) _then) = _$ChatUnreadSummaryCopyWithImpl;
@useResult
$Res call({
 String activityId, String activityTitle, String chatRoomId, int unreadCount
});




}
/// @nodoc
class _$ChatUnreadSummaryCopyWithImpl<$Res>
    implements $ChatUnreadSummaryCopyWith<$Res> {
  _$ChatUnreadSummaryCopyWithImpl(this._self, this._then);

  final ChatUnreadSummary _self;
  final $Res Function(ChatUnreadSummary) _then;

/// Create a copy of ChatUnreadSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? activityId = null,Object? activityTitle = null,Object? chatRoomId = null,Object? unreadCount = null,}) {
  return _then(ChatUnreadSummary(
activityId: null == activityId ? _self.activityId : activityId // ignore: cast_nullable_to_non_nullable
as String,activityTitle: null == activityTitle ? _self.activityTitle : activityTitle // ignore: cast_nullable_to_non_nullable
as String,chatRoomId: null == chatRoomId ? _self.chatRoomId : chatRoomId // ignore: cast_nullable_to_non_nullable
as String,unreadCount: null == unreadCount ? _self.unreadCount : unreadCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatUnreadSummary].
extension ChatUnreadSummaryPatterns on ChatUnreadSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatUnreadSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatUnreadSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatUnreadSummary value)  $default,){
final _that = this;
switch (_that) {
case _ChatUnreadSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatUnreadSummary value)?  $default,){
final _that = this;
switch (_that) {
case _ChatUnreadSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String activityId,  String activityTitle,  String chatRoomId,  int unreadCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatUnreadSummary() when $default != null:
return $default(_that.activityId,_that.activityTitle,_that.chatRoomId,_that.unreadCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String activityId,  String activityTitle,  String chatRoomId,  int unreadCount)  $default,) {final _that = this;
switch (_that) {
case _ChatUnreadSummary():
return $default(_that.activityId,_that.activityTitle,_that.chatRoomId,_that.unreadCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String activityId,  String activityTitle,  String chatRoomId,  int unreadCount)?  $default,) {final _that = this;
switch (_that) {
case _ChatUnreadSummary() when $default != null:
return $default(_that.activityId,_that.activityTitle,_that.chatRoomId,_that.unreadCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatUnreadSummary implements ChatUnreadSummary {
  const _ChatUnreadSummary({required this.activityId, required this.activityTitle, required this.chatRoomId, required this.unreadCount});
  factory _ChatUnreadSummary.fromJson(Map<String, dynamic> json) => _$ChatUnreadSummaryFromJson(json);

@override final  String activityId;
@override final  String activityTitle;
@override final  String chatRoomId;
@override final  int unreadCount;

/// Create a copy of ChatUnreadSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatUnreadSummaryCopyWith<_ChatUnreadSummary> get copyWith => __$ChatUnreadSummaryCopyWithImpl<_ChatUnreadSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatUnreadSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatUnreadSummary&&(identical(other.activityId, activityId) || other.activityId == activityId)&&(identical(other.activityTitle, activityTitle) || other.activityTitle == activityTitle)&&(identical(other.chatRoomId, chatRoomId) || other.chatRoomId == chatRoomId)&&(identical(other.unreadCount, unreadCount) || other.unreadCount == unreadCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,activityId,activityTitle,chatRoomId,unreadCount);

@override
String toString() {
  return 'ChatUnreadSummary(activityId: $activityId, activityTitle: $activityTitle, chatRoomId: $chatRoomId, unreadCount: $unreadCount)';
}


}

/// @nodoc
abstract mixin class _$ChatUnreadSummaryCopyWith<$Res> implements $ChatUnreadSummaryCopyWith<$Res> {
  factory _$ChatUnreadSummaryCopyWith(_ChatUnreadSummary value, $Res Function(_ChatUnreadSummary) _then) = __$ChatUnreadSummaryCopyWithImpl;
@override @useResult
$Res call({
 String activityId, String activityTitle, String chatRoomId, int unreadCount
});




}
/// @nodoc
class __$ChatUnreadSummaryCopyWithImpl<$Res>
    implements _$ChatUnreadSummaryCopyWith<$Res> {
  __$ChatUnreadSummaryCopyWithImpl(this._self, this._then);

  final _ChatUnreadSummary _self;
  final $Res Function(_ChatUnreadSummary) _then;

/// Create a copy of ChatUnreadSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? activityId = null,Object? activityTitle = null,Object? chatRoomId = null,Object? unreadCount = null,}) {
  return _then(_ChatUnreadSummary(
activityId: null == activityId ? _self.activityId : activityId // ignore: cast_nullable_to_non_nullable
as String,activityTitle: null == activityTitle ? _self.activityTitle : activityTitle // ignore: cast_nullable_to_non_nullable
as String,chatRoomId: null == chatRoomId ? _self.chatRoomId : chatRoomId // ignore: cast_nullable_to_non_nullable
as String,unreadCount: null == unreadCount ? _self.unreadCount : unreadCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
