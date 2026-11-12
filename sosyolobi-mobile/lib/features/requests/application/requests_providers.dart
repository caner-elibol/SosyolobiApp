import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../activities/application/activities_providers.dart';
import '../data/requests_api.dart';
import '../domain/activity_join_request.dart';

part 'requests_providers.g.dart';

@riverpod
Future<List<ActivityJoinRequest>> sentRequests(Ref ref) => ref.watch(requestsApiProvider).sent();

@riverpod
Future<List<ActivityJoinRequest>> activityRequests(Ref ref, String activityId) =>
    ref.watch(requestsApiProvider).forActivity(activityId);

@riverpod
class RequestActionsController extends _$RequestActionsController {
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

  Future<void> join(String activityId, {String? message}) => _run(() async {
        await ref.read(requestsApiProvider).join(activityId, message: message);
        ref.invalidate(activityDetailProvider(activityId));
      });

  Future<void> cancel(String requestId, {String? activityId}) => _run(() async {
        await ref.read(requestsApiProvider).cancel(requestId);
        ref.invalidate(sentRequestsProvider);
        if (activityId != null) ref.invalidate(activityDetailProvider(activityId));
      });

  Future<void> approve(String requestId, {String? activityId}) => _run(() async {
        await ref.read(requestsApiProvider).approve(requestId);
        if (activityId != null) {
          ref.invalidate(activityDetailProvider(activityId));
          ref.invalidate(activityRequestsProvider(activityId));
        }
      });

  Future<void> reject(String requestId, {String? activityId}) => _run(() async {
        await ref.read(requestsApiProvider).reject(requestId);
        if (activityId != null) ref.invalidate(activityRequestsProvider(activityId));
      });
}
