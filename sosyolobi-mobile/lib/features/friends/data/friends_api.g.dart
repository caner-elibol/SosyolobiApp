// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friends_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(friendsApi)
final friendsApiProvider = FriendsApiProvider._();

final class FriendsApiProvider
    extends $FunctionalProvider<FriendsApi, FriendsApi, FriendsApi>
    with $Provider<FriendsApi> {
  FriendsApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'friendsApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$friendsApiHash();

  @$internal
  @override
  $ProviderElement<FriendsApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FriendsApi create(Ref ref) {
    return friendsApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FriendsApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FriendsApi>(value),
    );
  }
}

String _$friendsApiHash() => r'3341ff82b37791a0d67c3877e4293b9137ce1abe';
