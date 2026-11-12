// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_session.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Core-level "is there currently a valid session" flag.
///
/// This exists purely so [AuthInterceptor] (infrastructure, in `core/`) can
/// signal a forced logout (refresh-token failure on a 401) without depending
/// on the richer `features/auth` `AuthNotifier` — that would invert the
/// dependency direction (`core` must not depend on `features`). The feature
/// layer's `AuthNotifier` listens to this flag and reconciles its own
/// (decoded-JWT) state from it; `go_router`'s redirect watches the feature
/// notifier, not this raw flag, directly.

@ProviderFor(AuthSession)
final authSessionProvider = AuthSessionProvider._();

/// Core-level "is there currently a valid session" flag.
///
/// This exists purely so [AuthInterceptor] (infrastructure, in `core/`) can
/// signal a forced logout (refresh-token failure on a 401) without depending
/// on the richer `features/auth` `AuthNotifier` — that would invert the
/// dependency direction (`core` must not depend on `features`). The feature
/// layer's `AuthNotifier` listens to this flag and reconciles its own
/// (decoded-JWT) state from it; `go_router`'s redirect watches the feature
/// notifier, not this raw flag, directly.
final class AuthSessionProvider extends $NotifierProvider<AuthSession, bool> {
  /// Core-level "is there currently a valid session" flag.
  ///
  /// This exists purely so [AuthInterceptor] (infrastructure, in `core/`) can
  /// signal a forced logout (refresh-token failure on a 401) without depending
  /// on the richer `features/auth` `AuthNotifier` — that would invert the
  /// dependency direction (`core` must not depend on `features`). The feature
  /// layer's `AuthNotifier` listens to this flag and reconciles its own
  /// (decoded-JWT) state from it; `go_router`'s redirect watches the feature
  /// notifier, not this raw flag, directly.
  AuthSessionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authSessionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authSessionHash();

  @$internal
  @override
  AuthSession create() => AuthSession();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$authSessionHash() => r'7ed5f99dbedb79eee1f8965d5ecd834b9ac82592';

/// Core-level "is there currently a valid session" flag.
///
/// This exists purely so [AuthInterceptor] (infrastructure, in `core/`) can
/// signal a forced logout (refresh-token failure on a 401) without depending
/// on the richer `features/auth` `AuthNotifier` — that would invert the
/// dependency direction (`core` must not depend on `features`). The feature
/// layer's `AuthNotifier` listens to this flag and reconciles its own
/// (decoded-JWT) state from it; `go_router`'s redirect watches the feature
/// notifier, not this raw flag, directly.

abstract class _$AuthSession extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
