// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_location_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Mirrors `sosyolobi-web-2/src/hooks/useCurrentLocation.ts`: serve a cached
/// location instantly if it's fresh (avoids a "konum alınıyor" wait on every
/// screen open), then resolve permission + a real fix in the background;
/// fall back to Istanbul if denied/unavailable.

@ProviderFor(CurrentLocationNotifier)
final currentLocationProvider = CurrentLocationNotifierProvider._();

/// Mirrors `sosyolobi-web-2/src/hooks/useCurrentLocation.ts`: serve a cached
/// location instantly if it's fresh (avoids a "konum alınıyor" wait on every
/// screen open), then resolve permission + a real fix in the background;
/// fall back to Istanbul if denied/unavailable.
final class CurrentLocationNotifierProvider
    extends $AsyncNotifierProvider<CurrentLocationNotifier, CurrentLocation> {
  /// Mirrors `sosyolobi-web-2/src/hooks/useCurrentLocation.ts`: serve a cached
  /// location instantly if it's fresh (avoids a "konum alınıyor" wait on every
  /// screen open), then resolve permission + a real fix in the background;
  /// fall back to Istanbul if denied/unavailable.
  CurrentLocationNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentLocationProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentLocationNotifierHash();

  @$internal
  @override
  CurrentLocationNotifier create() => CurrentLocationNotifier();
}

String _$currentLocationNotifierHash() =>
    r'056c3212cc3ced08ea9633def16ad697d57780a8';

/// Mirrors `sosyolobi-web-2/src/hooks/useCurrentLocation.ts`: serve a cached
/// location instantly if it's fresh (avoids a "konum alınıyor" wait on every
/// screen open), then resolve permission + a real fix in the background;
/// fall back to Istanbul if denied/unavailable.

abstract class _$CurrentLocationNotifier
    extends $AsyncNotifier<CurrentLocation> {
  FutureOr<CurrentLocation> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<CurrentLocation>, CurrentLocation>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<CurrentLocation>, CurrentLocation>,
              AsyncValue<CurrentLocation>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
