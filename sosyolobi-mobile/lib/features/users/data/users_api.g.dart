// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(usersApi)
final usersApiProvider = UsersApiProvider._();

final class UsersApiProvider
    extends $FunctionalProvider<UsersApi, UsersApi, UsersApi>
    with $Provider<UsersApi> {
  UsersApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'usersApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$usersApiHash();

  @$internal
  @override
  $ProviderElement<UsersApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  UsersApi create(Ref ref) {
    return usersApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UsersApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UsersApi>(value),
    );
  }
}

String _$usersApiHash() => r'254ba2d5b0accbf7555073e0663daacc78535512';
