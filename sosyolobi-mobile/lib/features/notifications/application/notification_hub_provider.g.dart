// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_hub_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// App-wide NotificationHub connection (unlike [ChatMessagesNotifier]'s
/// per-panel connection — the notification badge is visible everywhere via
/// [AppShell], so this one lives for the whole authenticated session).
/// `NotificationHub` has no client-invokable methods; it auto-joins group
/// `user_{userId}` on connect and pushes `ReceiveNotification`. On receipt
/// we simply refetch (`invalidate`) the notifications list rather than
/// hand-merge the pushed payload — one source of truth, no dedup logic to
/// get wrong. The 5s poll in [NotificationsController] remains as a
/// reconnect-gap backstop, matching plan's "prefer push, keep a backstop".

@ProviderFor(NotificationHub)
final notificationHubProvider = NotificationHubProvider._();

/// App-wide NotificationHub connection (unlike [ChatMessagesNotifier]'s
/// per-panel connection — the notification badge is visible everywhere via
/// [AppShell], so this one lives for the whole authenticated session).
/// `NotificationHub` has no client-invokable methods; it auto-joins group
/// `user_{userId}` on connect and pushes `ReceiveNotification`. On receipt
/// we simply refetch (`invalidate`) the notifications list rather than
/// hand-merge the pushed payload — one source of truth, no dedup logic to
/// get wrong. The 5s poll in [NotificationsController] remains as a
/// reconnect-gap backstop, matching plan's "prefer push, keep a backstop".
final class NotificationHubProvider
    extends $AsyncNotifierProvider<NotificationHub, void> {
  /// App-wide NotificationHub connection (unlike [ChatMessagesNotifier]'s
  /// per-panel connection — the notification badge is visible everywhere via
  /// [AppShell], so this one lives for the whole authenticated session).
  /// `NotificationHub` has no client-invokable methods; it auto-joins group
  /// `user_{userId}` on connect and pushes `ReceiveNotification`. On receipt
  /// we simply refetch (`invalidate`) the notifications list rather than
  /// hand-merge the pushed payload — one source of truth, no dedup logic to
  /// get wrong. The 5s poll in [NotificationsController] remains as a
  /// reconnect-gap backstop, matching plan's "prefer push, keep a backstop".
  NotificationHubProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationHubProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationHubHash();

  @$internal
  @override
  NotificationHub create() => NotificationHub();
}

String _$notificationHubHash() => r'9a7b04c8e47951e9c08e12f4633ac2ac01e2d68a';

/// App-wide NotificationHub connection (unlike [ChatMessagesNotifier]'s
/// per-panel connection — the notification badge is visible everywhere via
/// [AppShell], so this one lives for the whole authenticated session).
/// `NotificationHub` has no client-invokable methods; it auto-joins group
/// `user_{userId}` on connect and pushes `ReceiveNotification`. On receipt
/// we simply refetch (`invalidate`) the notifications list rather than
/// hand-merge the pushed payload — one source of truth, no dedup logic to
/// get wrong. The 5s poll in [NotificationsController] remains as a
/// reconnect-gap backstop, matching plan's "prefer push, keep a backstop".

abstract class _$NotificationHub extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
