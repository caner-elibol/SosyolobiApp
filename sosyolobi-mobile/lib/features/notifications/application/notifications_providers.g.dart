// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Combined notifications-unread + chat-unread badge count, mirrors
/// `AppTopbar.tsx`'s `badgeCount = unreadCount + totalUnreadRooms`.

@ProviderFor(unreadBadgeCount)
final unreadBadgeCountProvider = UnreadBadgeCountProvider._();

/// Combined notifications-unread + chat-unread badge count, mirrors
/// `AppTopbar.tsx`'s `badgeCount = unreadCount + totalUnreadRooms`.

final class UnreadBadgeCountProvider extends $FunctionalProvider<int, int, int>
    with $Provider<int> {
  /// Combined notifications-unread + chat-unread badge count, mirrors
  /// `AppTopbar.tsx`'s `badgeCount = unreadCount + totalUnreadRooms`.
  UnreadBadgeCountProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'unreadBadgeCountProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$unreadBadgeCountHash();

  @$internal
  @override
  $ProviderElement<int> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  int create(Ref ref) {
    return unreadBadgeCount(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$unreadBadgeCountHash() => r'b83b56485bf4cd738b1398cdc6030caf56ae7e5b';
