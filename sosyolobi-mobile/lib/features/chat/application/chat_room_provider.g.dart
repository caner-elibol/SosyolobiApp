// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_room_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Mirrors `useChatRoom` in `sosyolobi-web-2/src/hooks/useChatRoom.ts`.

@ProviderFor(chatRoom)
final chatRoomProvider = ChatRoomFamily._();

/// Mirrors `useChatRoom` in `sosyolobi-web-2/src/hooks/useChatRoom.ts`.

final class ChatRoomProvider
    extends
        $FunctionalProvider<AsyncValue<ChatRoom>, ChatRoom, FutureOr<ChatRoom>>
    with $FutureModifier<ChatRoom>, $FutureProvider<ChatRoom> {
  /// Mirrors `useChatRoom` in `sosyolobi-web-2/src/hooks/useChatRoom.ts`.
  ChatRoomProvider._({
    required ChatRoomFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'chatRoomProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$chatRoomHash();

  @override
  String toString() {
    return r'chatRoomProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<ChatRoom> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<ChatRoom> create(Ref ref) {
    final argument = this.argument as String;
    return chatRoom(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ChatRoomProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$chatRoomHash() => r'15dc2d8d08988c2ce74faf2b59e6abfe06c7c1a8';

/// Mirrors `useChatRoom` in `sosyolobi-web-2/src/hooks/useChatRoom.ts`.

final class ChatRoomFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<ChatRoom>, String> {
  ChatRoomFamily._()
    : super(
        retry: null,
        name: r'chatRoomProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Mirrors `useChatRoom` in `sosyolobi-web-2/src/hooks/useChatRoom.ts`.

  ChatRoomProvider call(String activityId) =>
      ChatRoomProvider._(argument: activityId, from: this);

  @override
  String toString() => r'chatRoomProvider';
}
