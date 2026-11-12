// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activities_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(activitiesApi)
final activitiesApiProvider = ActivitiesApiProvider._();

final class ActivitiesApiProvider
    extends $FunctionalProvider<ActivitiesApi, ActivitiesApi, ActivitiesApi>
    with $Provider<ActivitiesApi> {
  ActivitiesApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activitiesApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activitiesApiHash();

  @$internal
  @override
  $ProviderElement<ActivitiesApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ActivitiesApi create(Ref ref) {
    return activitiesApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ActivitiesApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ActivitiesApi>(value),
    );
  }
}

String _$activitiesApiHash() => r'58776b16f8ca551ce2f7f9e3643d097325b0cf7a';
