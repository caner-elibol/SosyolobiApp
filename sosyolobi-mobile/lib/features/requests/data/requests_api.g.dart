// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'requests_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(requestsApi)
final requestsApiProvider = RequestsApiProvider._();

final class RequestsApiProvider
    extends $FunctionalProvider<RequestsApi, RequestsApi, RequestsApi>
    with $Provider<RequestsApi> {
  RequestsApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'requestsApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$requestsApiHash();

  @$internal
  @override
  $ProviderElement<RequestsApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  RequestsApi create(Ref ref) {
    return requestsApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RequestsApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RequestsApi>(value),
    );
  }
}

String _$requestsApiHash() => r'e75c4144d937961207c1a3112298faa1757898d2';
