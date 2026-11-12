// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_unread_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Mirrors `useChatUnread` in `sosyolobi-web-2/src/hooks/useChatUnread.ts` —
/// including its literal `refetchInterval: 5_000` poll (there is no
/// app-wide SignalR connection to push this reactively in this client's
/// design, see [ChatMessagesNotifier]'s per-panel connection lifecycle;
/// web polls for exactly the same reason its own hub connection is
/// per-`ChatPanel`-mount, not app-wide) — via the shared [pollTickerProvider]
/// rather than an own `Timer`, see that provider's doc for why.
///
/// Watches [authProvider] (same fix as `MyProfile` in
/// `profile_providers.dart`) so switching users rebuilds immediately instead
/// of showing the previous user's unread counts for up to 5s until the next
/// tick, and so no request fires (and hits a 401) on ticks while logged out.

@ProviderFor(ChatUnread)
final chatUnreadProvider = ChatUnreadProvider._();

/// Mirrors `useChatUnread` in `sosyolobi-web-2/src/hooks/useChatUnread.ts` —
/// including its literal `refetchInterval: 5_000` poll (there is no
/// app-wide SignalR connection to push this reactively in this client's
/// design, see [ChatMessagesNotifier]'s per-panel connection lifecycle;
/// web polls for exactly the same reason its own hub connection is
/// per-`ChatPanel`-mount, not app-wide) — via the shared [pollTickerProvider]
/// rather than an own `Timer`, see that provider's doc for why.
///
/// Watches [authProvider] (same fix as `MyProfile` in
/// `profile_providers.dart`) so switching users rebuilds immediately instead
/// of showing the previous user's unread counts for up to 5s until the next
/// tick, and so no request fires (and hits a 401) on ticks while logged out.
final class ChatUnreadProvider
    extends $AsyncNotifierProvider<ChatUnread, List<ChatUnreadSummary>> {
  /// Mirrors `useChatUnread` in `sosyolobi-web-2/src/hooks/useChatUnread.ts` —
  /// including its literal `refetchInterval: 5_000` poll (there is no
  /// app-wide SignalR connection to push this reactively in this client's
  /// design, see [ChatMessagesNotifier]'s per-panel connection lifecycle;
  /// web polls for exactly the same reason its own hub connection is
  /// per-`ChatPanel`-mount, not app-wide) — via the shared [pollTickerProvider]
  /// rather than an own `Timer`, see that provider's doc for why.
  ///
  /// Watches [authProvider] (same fix as `MyProfile` in
  /// `profile_providers.dart`) so switching users rebuilds immediately instead
  /// of showing the previous user's unread counts for up to 5s until the next
  /// tick, and so no request fires (and hits a 401) on ticks while logged out.
  ChatUnreadProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'chatUnreadProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$chatUnreadHash();

  @$internal
  @override
  ChatUnread create() => ChatUnread();
}

String _$chatUnreadHash() => r'b6124c545d4ad9aec139cf42e0948a0e2c7d5825';

/// Mirrors `useChatUnread` in `sosyolobi-web-2/src/hooks/useChatUnread.ts` —
/// including its literal `refetchInterval: 5_000` poll (there is no
/// app-wide SignalR connection to push this reactively in this client's
/// design, see [ChatMessagesNotifier]'s per-panel connection lifecycle;
/// web polls for exactly the same reason its own hub connection is
/// per-`ChatPanel`-mount, not app-wide) — via the shared [pollTickerProvider]
/// rather than an own `Timer`, see that provider's doc for why.
///
/// Watches [authProvider] (same fix as `MyProfile` in
/// `profile_providers.dart`) so switching users rebuilds immediately instead
/// of showing the previous user's unread counts for up to 5s until the next
/// tick, and so no request fires (and hits a 401) on ticks while logged out.

abstract class _$ChatUnread extends $AsyncNotifier<List<ChatUnreadSummary>> {
  FutureOr<List<ChatUnreadSummary>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<ChatUnreadSummary>>,
              List<ChatUnreadSummary>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<ChatUnreadSummary>>,
                List<ChatUnreadSummary>
              >,
              AsyncValue<List<ChatUnreadSummary>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Total unread chat rooms — feeds into the combined notification badge
/// (`AppTopbar.tsx`'s `badgeCount = unreadCount + totalUnreadRooms`).

@ProviderFor(totalUnreadChatRooms)
final totalUnreadChatRoomsProvider = TotalUnreadChatRoomsProvider._();

/// Total unread chat rooms — feeds into the combined notification badge
/// (`AppTopbar.tsx`'s `badgeCount = unreadCount + totalUnreadRooms`).

final class TotalUnreadChatRoomsProvider
    extends $FunctionalProvider<int, int, int>
    with $Provider<int> {
  /// Total unread chat rooms — feeds into the combined notification badge
  /// (`AppTopbar.tsx`'s `badgeCount = unreadCount + totalUnreadRooms`).
  TotalUnreadChatRoomsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'totalUnreadChatRoomsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$totalUnreadChatRoomsHash();

  @$internal
  @override
  $ProviderElement<int> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  int create(Ref ref) {
    return totalUnreadChatRooms(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$totalUnreadChatRoomsHash() =>
    r'0aa513f55dae3c5aaa07496804ce3a14530aba0e';
