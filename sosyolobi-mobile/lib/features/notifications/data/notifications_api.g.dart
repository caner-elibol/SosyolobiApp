// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(notificationsApi)
final notificationsApiProvider = NotificationsApiProvider._();

final class NotificationsApiProvider
    extends
        $FunctionalProvider<
          NotificationsApi,
          NotificationsApi,
          NotificationsApi
        >
    with $Provider<NotificationsApi> {
  NotificationsApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationsApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationsApiHash();

  @$internal
  @override
  $ProviderElement<NotificationsApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  NotificationsApi create(Ref ref) {
    return notificationsApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationsApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotificationsApi>(value),
    );
  }
}

String _$notificationsApiHash() => r'afb0f41247d8901a48bf0495c73e20d00fe57f41';
