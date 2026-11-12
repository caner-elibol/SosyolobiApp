// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Mirrors `useNotifications` in
/// `sosyolobi-web-2/src/hooks/useNotifications.ts`, including its literal
/// `refetchInterval: 5_000` poll — via the shared [pollTickerProvider]
/// rather than an own `Timer`, see that provider's doc for why.
///
/// Watches [authProvider] (same fix as `MyProfile` in
/// `profile_providers.dart`) so switching users rebuilds immediately instead
/// of showing the previous user's notifications for up to 5s, and so no
/// request fires (and hits a 401) on ticks while logged out.

@ProviderFor(NotificationsController)
final notificationsControllerProvider = NotificationsControllerProvider._();

/// Mirrors `useNotifications` in
/// `sosyolobi-web-2/src/hooks/useNotifications.ts`, including its literal
/// `refetchInterval: 5_000` poll — via the shared [pollTickerProvider]
/// rather than an own `Timer`, see that provider's doc for why.
///
/// Watches [authProvider] (same fix as `MyProfile` in
/// `profile_providers.dart`) so switching users rebuilds immediately instead
/// of showing the previous user's notifications for up to 5s, and so no
/// request fires (and hits a 401) on ticks while logged out.
final class NotificationsControllerProvider
    extends
        $AsyncNotifierProvider<NotificationsController, List<AppNotification>> {
  /// Mirrors `useNotifications` in
  /// `sosyolobi-web-2/src/hooks/useNotifications.ts`, including its literal
  /// `refetchInterval: 5_000` poll — via the shared [pollTickerProvider]
  /// rather than an own `Timer`, see that provider's doc for why.
  ///
  /// Watches [authProvider] (same fix as `MyProfile` in
  /// `profile_providers.dart`) so switching users rebuilds immediately instead
  /// of showing the previous user's notifications for up to 5s, and so no
  /// request fires (and hits a 401) on ticks while logged out.
  NotificationsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationsControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationsControllerHash();

  @$internal
  @override
  NotificationsController create() => NotificationsController();
}

String _$notificationsControllerHash() =>
    r'700941cacb8b5e5c8f5bfed1e2ac494142854339';

/// Mirrors `useNotifications` in
/// `sosyolobi-web-2/src/hooks/useNotifications.ts`, including its literal
/// `refetchInterval: 5_000` poll — via the shared [pollTickerProvider]
/// rather than an own `Timer`, see that provider's doc for why.
///
/// Watches [authProvider] (same fix as `MyProfile` in
/// `profile_providers.dart`) so switching users rebuilds immediately instead
/// of showing the previous user's notifications for up to 5s, and so no
/// request fires (and hits a 401) on ticks while logged out.

abstract class _$NotificationsController
    extends $AsyncNotifier<List<AppNotification>> {
  FutureOr<List<AppNotification>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<AppNotification>>, List<AppNotification>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<AppNotification>>,
                List<AppNotification>
              >,
              AsyncValue<List<AppNotification>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(unreadNotificationsCount)
final unreadNotificationsCountProvider = UnreadNotificationsCountProvider._();

final class UnreadNotificationsCountProvider
    extends $FunctionalProvider<int, int, int>
    with $Provider<int> {
  UnreadNotificationsCountProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'unreadNotificationsCountProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$unreadNotificationsCountHash();

  @$internal
  @override
  $ProviderElement<int> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  int create(Ref ref) {
    return unreadNotificationsCount(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$unreadNotificationsCountHash() =>
    r'68982b9b025e7616a252d8316acd69276a1ec4ac';
