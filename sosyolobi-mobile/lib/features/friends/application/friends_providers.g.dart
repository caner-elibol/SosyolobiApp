// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friends_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Mirrors `useFriends` in `sosyolobi-web-2/src/hooks/useFriends.ts`.

@ProviderFor(friends)
final friendsProvider = FriendsProvider._();

/// Mirrors `useFriends` in `sosyolobi-web-2/src/hooks/useFriends.ts`.

final class FriendsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Friend>>,
          List<Friend>,
          FutureOr<List<Friend>>
        >
    with $FutureModifier<List<Friend>>, $FutureProvider<List<Friend>> {
  /// Mirrors `useFriends` in `sosyolobi-web-2/src/hooks/useFriends.ts`.
  FriendsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'friendsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$friendsHash();

  @$internal
  @override
  $FutureProviderElement<List<Friend>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Friend>> create(Ref ref) {
    return friends(ref);
  }
}

String _$friendsHash() => r'd1d960a683d10e729007ca09853b8a6f30828153';

/// Mirrors `useIncomingFriendRequests`.

@ProviderFor(incomingFriendRequests)
final incomingFriendRequestsProvider = IncomingFriendRequestsProvider._();

/// Mirrors `useIncomingFriendRequests`.

final class IncomingFriendRequestsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<FriendRequest>>,
          List<FriendRequest>,
          FutureOr<List<FriendRequest>>
        >
    with
        $FutureModifier<List<FriendRequest>>,
        $FutureProvider<List<FriendRequest>> {
  /// Mirrors `useIncomingFriendRequests`.
  IncomingFriendRequestsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'incomingFriendRequestsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$incomingFriendRequestsHash();

  @$internal
  @override
  $FutureProviderElement<List<FriendRequest>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<FriendRequest>> create(Ref ref) {
    return incomingFriendRequests(ref);
  }
}

String _$incomingFriendRequestsHash() =>
    r'eb65354707b70d57c4c5770192fe9391b9221dba';

/// Mirrors `useSentFriendRequests`.

@ProviderFor(sentFriendRequests)
final sentFriendRequestsProvider = SentFriendRequestsProvider._();

/// Mirrors `useSentFriendRequests`.

final class SentFriendRequestsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<FriendRequest>>,
          List<FriendRequest>,
          FutureOr<List<FriendRequest>>
        >
    with
        $FutureModifier<List<FriendRequest>>,
        $FutureProvider<List<FriendRequest>> {
  /// Mirrors `useSentFriendRequests`.
  SentFriendRequestsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sentFriendRequestsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sentFriendRequestsHash();

  @$internal
  @override
  $FutureProviderElement<List<FriendRequest>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<FriendRequest>> create(Ref ref) {
    return sentFriendRequests(ref);
  }
}

String _$sentFriendRequestsHash() =>
    r'00f01c4b790ac1c33286c4e34821512f87616a51';

/// Mirrors `useFriendActivities` — 200 only when the caller is friends with
/// `userId` (or it's their own id); the API returns 401 otherwise, which
/// surfaces as an `AsyncError` here for the caller to treat as "locked".

@ProviderFor(friendActivities)
final friendActivitiesProvider = FriendActivitiesFamily._();

/// Mirrors `useFriendActivities` — 200 only when the caller is friends with
/// `userId` (or it's their own id); the API returns 401 otherwise, which
/// surfaces as an `AsyncError` here for the caller to treat as "locked".

final class FriendActivitiesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Activity>>,
          List<Activity>,
          FutureOr<List<Activity>>
        >
    with $FutureModifier<List<Activity>>, $FutureProvider<List<Activity>> {
  /// Mirrors `useFriendActivities` — 200 only when the caller is friends with
  /// `userId` (or it's their own id); the API returns 401 otherwise, which
  /// surfaces as an `AsyncError` here for the caller to treat as "locked".
  FriendActivitiesProvider._({
    required FriendActivitiesFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'friendActivitiesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$friendActivitiesHash();

  @override
  String toString() {
    return r'friendActivitiesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Activity>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Activity>> create(Ref ref) {
    final argument = this.argument as String;
    return friendActivities(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is FriendActivitiesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$friendActivitiesHash() => r'14cbdea260bf23ed2aed511c81b74a6fdcce7175';

/// Mirrors `useFriendActivities` — 200 only when the caller is friends with
/// `userId` (or it's their own id); the API returns 401 otherwise, which
/// surfaces as an `AsyncError` here for the caller to treat as "locked".

final class FriendActivitiesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Activity>>, String> {
  FriendActivitiesFamily._()
    : super(
        retry: null,
        name: r'friendActivitiesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Mirrors `useFriendActivities` — 200 only when the caller is friends with
  /// `userId` (or it's their own id); the API returns 401 otherwise, which
  /// surfaces as an `AsyncError` here for the caller to treat as "locked".

  FriendActivitiesProvider call(String userId) =>
      FriendActivitiesProvider._(argument: userId, from: this);

  @override
  String toString() => r'friendActivitiesProvider';
}

/// Mirrors `useFriendStatus` — no single backend endpoint reports friendship
/// status between two users, so it's derived client-side by scanning the
/// friends list + both pending-request lists for `userId`.

@ProviderFor(friendStatus)
final friendStatusProvider = FriendStatusFamily._();

/// Mirrors `useFriendStatus` — no single backend endpoint reports friendship
/// status between two users, so it's derived client-side by scanning the
/// friends list + both pending-request lists for `userId`.

final class FriendStatusProvider
    extends
        $FunctionalProvider<
          FriendStatusInfo,
          FriendStatusInfo,
          FriendStatusInfo
        >
    with $Provider<FriendStatusInfo> {
  /// Mirrors `useFriendStatus` — no single backend endpoint reports friendship
  /// status between two users, so it's derived client-side by scanning the
  /// friends list + both pending-request lists for `userId`.
  FriendStatusProvider._({
    required FriendStatusFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'friendStatusProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$friendStatusHash();

  @override
  String toString() {
    return r'friendStatusProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<FriendStatusInfo> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FriendStatusInfo create(Ref ref) {
    final argument = this.argument as String;
    return friendStatus(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FriendStatusInfo value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FriendStatusInfo>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is FriendStatusProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$friendStatusHash() => r'f8f57bef82f9e91c4dbc5b5277317df2eb00bd4d';

/// Mirrors `useFriendStatus` — no single backend endpoint reports friendship
/// status between two users, so it's derived client-side by scanning the
/// friends list + both pending-request lists for `userId`.

final class FriendStatusFamily extends $Family
    with $FunctionalFamilyOverride<FriendStatusInfo, String> {
  FriendStatusFamily._()
    : super(
        retry: null,
        name: r'friendStatusProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Mirrors `useFriendStatus` — no single backend endpoint reports friendship
  /// status between two users, so it's derived client-side by scanning the
  /// friends list + both pending-request lists for `userId`.

  FriendStatusProvider call(String userId) =>
      FriendStatusProvider._(argument: userId, from: this);

  @override
  String toString() => r'friendStatusProvider';
}

/// Mirrors the mutations in `useFriends.ts` — grouped into one action
/// controller (like `RequestActionsController`) since they all invalidate
/// the same friend-list/request-list caches.

@ProviderFor(FriendActionsController)
final friendActionsControllerProvider = FriendActionsControllerProvider._();

/// Mirrors the mutations in `useFriends.ts` — grouped into one action
/// controller (like `RequestActionsController`) since they all invalidate
/// the same friend-list/request-list caches.
final class FriendActionsControllerProvider
    extends $AsyncNotifierProvider<FriendActionsController, void> {
  /// Mirrors the mutations in `useFriends.ts` — grouped into one action
  /// controller (like `RequestActionsController`) since they all invalidate
  /// the same friend-list/request-list caches.
  FriendActionsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'friendActionsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$friendActionsControllerHash();

  @$internal
  @override
  FriendActionsController create() => FriendActionsController();
}

String _$friendActionsControllerHash() =>
    r'67becad488c814d6ad49604d073b36c7efa601ca';

/// Mirrors the mutations in `useFriends.ts` — grouped into one action
/// controller (like `RequestActionsController`) since they all invalidate
/// the same friend-list/request-list caches.

abstract class _$FriendActionsController extends $AsyncNotifier<void> {
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
