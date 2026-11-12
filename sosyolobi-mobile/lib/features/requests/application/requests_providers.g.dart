// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'requests_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Mirrors `useSentRequests` in `sosyolobi-web-2/src/hooks/useJoinRequest.ts`.

@ProviderFor(sentRequests)
final sentRequestsProvider = SentRequestsProvider._();

/// Mirrors `useSentRequests` in `sosyolobi-web-2/src/hooks/useJoinRequest.ts`.

final class SentRequestsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ActivityJoinRequest>>,
          List<ActivityJoinRequest>,
          FutureOr<List<ActivityJoinRequest>>
        >
    with
        $FutureModifier<List<ActivityJoinRequest>>,
        $FutureProvider<List<ActivityJoinRequest>> {
  /// Mirrors `useSentRequests` in `sosyolobi-web-2/src/hooks/useJoinRequest.ts`.
  SentRequestsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sentRequestsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sentRequestsHash();

  @$internal
  @override
  $FutureProviderElement<List<ActivityJoinRequest>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ActivityJoinRequest>> create(Ref ref) {
    return sentRequests(ref);
  }
}

String _$sentRequestsHash() => r'86d1166b51a987df3c461502f0254203164d323e';

/// Requests (any status) for a single activity — owner-only on the backend.
/// Backs the "Katılım İstekleri" button/modal on the activity detail screen.

@ProviderFor(activityRequests)
final activityRequestsProvider = ActivityRequestsFamily._();

/// Requests (any status) for a single activity — owner-only on the backend.
/// Backs the "Katılım İstekleri" button/modal on the activity detail screen.

final class ActivityRequestsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ActivityJoinRequest>>,
          List<ActivityJoinRequest>,
          FutureOr<List<ActivityJoinRequest>>
        >
    with
        $FutureModifier<List<ActivityJoinRequest>>,
        $FutureProvider<List<ActivityJoinRequest>> {
  /// Requests (any status) for a single activity — owner-only on the backend.
  /// Backs the "Katılım İstekleri" button/modal on the activity detail screen.
  ActivityRequestsProvider._({
    required ActivityRequestsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'activityRequestsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$activityRequestsHash();

  @override
  String toString() {
    return r'activityRequestsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<ActivityJoinRequest>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ActivityJoinRequest>> create(Ref ref) {
    final argument = this.argument as String;
    return activityRequests(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ActivityRequestsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$activityRequestsHash() => r'1189cd62c20cd3bbb089f7064e0666836e24e704';

/// Requests (any status) for a single activity — owner-only on the backend.
/// Backs the "Katılım İstekleri" button/modal on the activity detail screen.

final class ActivityRequestsFamily extends $Family
    with
        $FunctionalFamilyOverride<FutureOr<List<ActivityJoinRequest>>, String> {
  ActivityRequestsFamily._()
    : super(
        retry: null,
        name: r'activityRequestsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Requests (any status) for a single activity — owner-only on the backend.
  /// Backs the "Katılım İstekleri" button/modal on the activity detail screen.

  ActivityRequestsProvider call(String activityId) =>
      ActivityRequestsProvider._(argument: activityId, from: this);

  @override
  String toString() => r'activityRequestsProvider';
}

/// Mirrors `useJoinRequest`'s `join`/`cancel` mutations plus
/// `useIncomingRequests`'s `approve`/`reject` — grouped into one action
/// controller since they all invalidate the same request-list caches.

@ProviderFor(RequestActionsController)
final requestActionsControllerProvider = RequestActionsControllerProvider._();

/// Mirrors `useJoinRequest`'s `join`/`cancel` mutations plus
/// `useIncomingRequests`'s `approve`/`reject` — grouped into one action
/// controller since they all invalidate the same request-list caches.
final class RequestActionsControllerProvider
    extends $AsyncNotifierProvider<RequestActionsController, void> {
  /// Mirrors `useJoinRequest`'s `join`/`cancel` mutations plus
  /// `useIncomingRequests`'s `approve`/`reject` — grouped into one action
  /// controller since they all invalidate the same request-list caches.
  RequestActionsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'requestActionsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$requestActionsControllerHash();

  @$internal
  @override
  RequestActionsController create() => RequestActionsController();
}

String _$requestActionsControllerHash() =>
    r'8e30efe29c4fef32a4d5e6dc8e338bd17b7e2ae8';

/// Mirrors `useJoinRequest`'s `join`/`cancel` mutations plus
/// `useIncomingRequests`'s `approve`/`reject` — grouped into one action
/// controller since they all invalidate the same request-list caches.

abstract class _$RequestActionsController extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
