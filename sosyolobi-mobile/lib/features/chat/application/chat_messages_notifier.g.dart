// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_messages_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Mirrors `ChatPanel.tsx`'s effect: builds a fresh ChatHub connection when
/// the panel (this provider) is created, joins the room, listens for
/// `ReceiveMessage`/`RoomClosed`, and tears the connection down on dispose —
/// exactly web's per-mount connection lifecycle, not an app-wide singleton.

@ProviderFor(ChatMessagesNotifier)
final chatMessagesProvider = ChatMessagesNotifierFamily._();

/// Mirrors `ChatPanel.tsx`'s effect: builds a fresh ChatHub connection when
/// the panel (this provider) is created, joins the room, listens for
/// `ReceiveMessage`/`RoomClosed`, and tears the connection down on dispose —
/// exactly web's per-mount connection lifecycle, not an app-wide singleton.
final class ChatMessagesNotifierProvider
    extends $AsyncNotifierProvider<ChatMessagesNotifier, ChatRoomState> {
  /// Mirrors `ChatPanel.tsx`'s effect: builds a fresh ChatHub connection when
  /// the panel (this provider) is created, joins the room, listens for
  /// `ReceiveMessage`/`RoomClosed`, and tears the connection down on dispose —
  /// exactly web's per-mount connection lifecycle, not an app-wide singleton.
  ChatMessagesNotifierProvider._({
    required ChatMessagesNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'chatMessagesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$chatMessagesNotifierHash();

  @override
  String toString() {
    return r'chatMessagesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ChatMessagesNotifier create() => ChatMessagesNotifier();

  @override
  bool operator ==(Object other) {
    return other is ChatMessagesNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$chatMessagesNotifierHash() =>
    r'6102bab1229ceb71f7dcbe4bbccd5bb094ef4dbc';

/// Mirrors `ChatPanel.tsx`'s effect: builds a fresh ChatHub connection when
/// the panel (this provider) is created, joins the room, listens for
/// `ReceiveMessage`/`RoomClosed`, and tears the connection down on dispose —
/// exactly web's per-mount connection lifecycle, not an app-wide singleton.

final class ChatMessagesNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          ChatMessagesNotifier,
          AsyncValue<ChatRoomState>,
          ChatRoomState,
          FutureOr<ChatRoomState>,
          String
        > {
  ChatMessagesNotifierFamily._()
    : super(
        retry: null,
        name: r'chatMessagesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Mirrors `ChatPanel.tsx`'s effect: builds a fresh ChatHub connection when
  /// the panel (this provider) is created, joins the room, listens for
  /// `ReceiveMessage`/`RoomClosed`, and tears the connection down on dispose —
  /// exactly web's per-mount connection lifecycle, not an app-wide singleton.

  ChatMessagesNotifierProvider call(String roomId) =>
      ChatMessagesNotifierProvider._(argument: roomId, from: this);

  @override
  String toString() => r'chatMessagesProvider';
}

/// Mirrors `ChatPanel.tsx`'s effect: builds a fresh ChatHub connection when
/// the panel (this provider) is created, joins the room, listens for
/// `ReceiveMessage`/`RoomClosed`, and tears the connection down on dispose —
/// exactly web's per-mount connection lifecycle, not an app-wide singleton.

abstract class _$ChatMessagesNotifier extends $AsyncNotifier<ChatRoomState> {
  late final _$args = ref.$arg as String;
  String get roomId => _$args;

  FutureOr<ChatRoomState> build(String roomId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<ChatRoomState>, ChatRoomState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ChatRoomState>, ChatRoomState>,
              AsyncValue<ChatRoomState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
