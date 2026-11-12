// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_activities_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(mapActivitiesApi)
final mapActivitiesApiProvider = MapActivitiesApiProvider._();

final class MapActivitiesApiProvider
    extends
        $FunctionalProvider<
          MapActivitiesApi,
          MapActivitiesApi,
          MapActivitiesApi
        >
    with $Provider<MapActivitiesApi> {
  MapActivitiesApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mapActivitiesApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mapActivitiesApiHash();

  @$internal
  @override
  $ProviderElement<MapActivitiesApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  MapActivitiesApi create(Ref ref) {
    return mapActivitiesApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MapActivitiesApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MapActivitiesApi>(value),
    );
  }
}

String _$mapActivitiesApiHash() => r'8ef7ca53a78d2e637daa0d345f91c5c41a0c3c5b';
