// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Mirrors `useProfile` in `sosyolobi-web-2/src/hooks/useProfile.ts`.
///
/// `keepAlive: true` means this never auto-disposes, so without watching
/// [authProvider] it would keep serving the FIRST user's profile
/// forever — logging out and back in as a different user (without fully
/// restarting the app) showed the previous account's name/avatar on the
/// Profile screen, since nothing ever re-triggered `getMe()`. Watching auth
/// state here mirrors [NotificationHub]'s already-correct pattern, so this
/// rebuilds (and refetches) on every login/logout, not just the first one.

@ProviderFor(MyProfile)
final myProfileProvider = MyProfileProvider._();

/// Mirrors `useProfile` in `sosyolobi-web-2/src/hooks/useProfile.ts`.
///
/// `keepAlive: true` means this never auto-disposes, so without watching
/// [authProvider] it would keep serving the FIRST user's profile
/// forever — logging out and back in as a different user (without fully
/// restarting the app) showed the previous account's name/avatar on the
/// Profile screen, since nothing ever re-triggered `getMe()`. Watching auth
/// state here mirrors [NotificationHub]'s already-correct pattern, so this
/// rebuilds (and refetches) on every login/logout, not just the first one.
final class MyProfileProvider
    extends $AsyncNotifierProvider<MyProfile, UserProfile> {
  /// Mirrors `useProfile` in `sosyolobi-web-2/src/hooks/useProfile.ts`.
  ///
  /// `keepAlive: true` means this never auto-disposes, so without watching
  /// [authProvider] it would keep serving the FIRST user's profile
  /// forever — logging out and back in as a different user (without fully
  /// restarting the app) showed the previous account's name/avatar on the
  /// Profile screen, since nothing ever re-triggered `getMe()`. Watching auth
  /// state here mirrors [NotificationHub]'s already-correct pattern, so this
  /// rebuilds (and refetches) on every login/logout, not just the first one.
  MyProfileProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'myProfileProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myProfileHash();

  @$internal
  @override
  MyProfile create() => MyProfile();
}

String _$myProfileHash() => r'ea80c7c20caf2bf8c195e4404897377815665cc1';

/// Mirrors `useProfile` in `sosyolobi-web-2/src/hooks/useProfile.ts`.
///
/// `keepAlive: true` means this never auto-disposes, so without watching
/// [authProvider] it would keep serving the FIRST user's profile
/// forever — logging out and back in as a different user (without fully
/// restarting the app) showed the previous account's name/avatar on the
/// Profile screen, since nothing ever re-triggered `getMe()`. Watching auth
/// state here mirrors [NotificationHub]'s already-correct pattern, so this
/// rebuilds (and refetches) on every login/logout, not just the first one.

abstract class _$MyProfile extends $AsyncNotifier<UserProfile> {
  FutureOr<UserProfile> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<UserProfile>, UserProfile>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<UserProfile>, UserProfile>,
              AsyncValue<UserProfile>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Mirrors `usePublicProfile`.

@ProviderFor(publicProfile)
final publicProfileProvider = PublicProfileFamily._();

/// Mirrors `usePublicProfile`.

final class PublicProfileProvider
    extends
        $FunctionalProvider<
          AsyncValue<PublicProfile>,
          PublicProfile,
          FutureOr<PublicProfile>
        >
    with $FutureModifier<PublicProfile>, $FutureProvider<PublicProfile> {
  /// Mirrors `usePublicProfile`.
  PublicProfileProvider._({
    required PublicProfileFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'publicProfileProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$publicProfileHash();

  @override
  String toString() {
    return r'publicProfileProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<PublicProfile> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PublicProfile> create(Ref ref) {
    final argument = this.argument as String;
    return publicProfile(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PublicProfileProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$publicProfileHash() => r'f5519aaf8ffbf16e3a6a7ed96c688554a8d4cd1e';

/// Mirrors `usePublicProfile`.

final class PublicProfileFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<PublicProfile>, String> {
  PublicProfileFamily._()
    : super(
        retry: null,
        name: r'publicProfileProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Mirrors `usePublicProfile`.

  PublicProfileProvider call(String userId) =>
      PublicProfileProvider._(argument: userId, from: this);

  @override
  String toString() => r'publicProfileProvider';
}
