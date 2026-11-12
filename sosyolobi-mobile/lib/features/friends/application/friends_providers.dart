import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../activities/domain/activity.dart';
import '../data/friends_api.dart';
import '../domain/friend.dart';

part 'friends_providers.g.dart';

@riverpod
Future<List<Friend>> friends(Ref ref) => ref.watch(friendsApiProvider).getFriends();

@riverpod
Future<List<FriendRequest>> incomingFriendRequests(Ref ref) => ref.watch(friendsApiProvider).getIncomingRequests();

@riverpod
Future<List<FriendRequest>> sentFriendRequests(Ref ref) => ref.watch(friendsApiProvider).getSentRequests();

@riverpod
Future<List<Activity>> friendActivities(Ref ref, String userId) => ref.watch(friendsApiProvider).getFriendActivities(userId);

enum FriendStatus { none, pendingSent, pendingIncoming, friends }

class FriendStatusInfo {
  const FriendStatusInfo({required this.status, this.request, this.isLoading = false});

  final FriendStatus status;
  final FriendRequest? request;
  final bool isLoading;
}

@riverpod
FriendStatusInfo friendStatus(Ref ref, String userId) {
  final friendsAsync = ref.watch(friendsProvider);
  final sentAsync = ref.watch(sentFriendRequestsProvider);
  final incomingAsync = ref.watch(incomingFriendRequestsProvider);

  final friendsList = friendsAsync.value ?? const <Friend>[];
  final matchedFriend = friendsList.where((f) => f.user.userId == userId).firstOrNull;
  if (matchedFriend != null) {
    return const FriendStatusInfo(status: FriendStatus.friends);
  }

  final sentList = sentAsync.value ?? const <FriendRequest>[];
  final sentRequest = sentList.where((r) => r.user.userId == userId).firstOrNull;
  if (sentRequest != null) {
    return FriendStatusInfo(status: FriendStatus.pendingSent, request: sentRequest);
  }

  final incomingList = incomingAsync.value ?? const <FriendRequest>[];
  final incomingRequest = incomingList.where((r) => r.user.userId == userId).firstOrNull;
  if (incomingRequest != null) {
    return FriendStatusInfo(status: FriendStatus.pendingIncoming, request: incomingRequest);
  }

  final isLoading = friendsAsync.isLoading || sentAsync.isLoading || incomingAsync.isLoading;
  return FriendStatusInfo(status: FriendStatus.none, isLoading: isLoading);
}

@riverpod
class FriendActionsController extends _$FriendActionsController {
  @override
  FutureOr<void> build() {}

  Future<void> _run(Future<void> Function() action) async {
    final keepAliveLink = ref.keepAlive();
    state = const AsyncLoading();
    try {
      state = await AsyncValue.guard(action);
    } finally {
      keepAliveLink.close();
    }
  }

  Future<void> sendRequest(String addresseeUserId) => _run(() async {
        await ref.read(friendsApiProvider).sendRequest(addresseeUserId);
        ref.invalidate(sentFriendRequestsProvider);
        ref.invalidate(friendStatusProvider(addresseeUserId));
      });

  Future<void> accept(String requestId, {String? userId}) => _run(() async {
        await ref.read(friendsApiProvider).accept(requestId);
        ref.invalidate(incomingFriendRequestsProvider);
        ref.invalidate(friendsProvider);
        if (userId != null) ref.invalidate(friendStatusProvider(userId));
      });

  Future<void> reject(String requestId, {String? userId}) => _run(() async {
        await ref.read(friendsApiProvider).reject(requestId);
        ref.invalidate(incomingFriendRequestsProvider);
        if (userId != null) ref.invalidate(friendStatusProvider(userId));
      });

  Future<void> cancel(String requestId, {String? userId}) => _run(() async {
        await ref.read(friendsApiProvider).cancel(requestId);
        ref.invalidate(sentFriendRequestsProvider);
        if (userId != null) ref.invalidate(friendStatusProvider(userId));
      });

  Future<void> removeFriend(String friendUserId) => _run(() async {
        await ref.read(friendsApiProvider).removeFriend(friendUserId);
        ref.invalidate(friendsProvider);
        ref.invalidate(friendStatusProvider(friendUserId));
      });
}
