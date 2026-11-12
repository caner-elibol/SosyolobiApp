import 'package:dio/dio.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_client.dart';
import '../../../core/network/envelope.dart';
import '../../activities/domain/activity.dart';
import '../domain/friend.dart';

part 'friends_api.g.dart';

@riverpod
FriendsApi friendsApi(Ref ref) => FriendsApi(ref.watch(apiClientProvider));

class FriendsApi {
  FriendsApi(this._dio);

  final Dio _dio;

  Future<List<Friend>> getFriends() async {
    final response = await guardDio(() => _dio.get<Map<String, dynamic>>('/api/friends'));
    return unwrapList(response, (json) => Friend.fromJson(json as Map<String, dynamic>));
  }

  Future<void> removeFriend(String friendUserId) async {
    await guardDio(() => _dio.delete<Map<String, dynamic>>('/api/friends/$friendUserId'));
  }

  Future<List<Activity>> getFriendActivities(String friendUserId) async {
    final response = await guardDio(() => _dio.get<Map<String, dynamic>>('/api/friends/$friendUserId/activities'));
    return unwrapList(response, (json) => Activity.fromJson(json as Map<String, dynamic>));
  }

  Future<FriendRequest> sendRequest(String addresseeUserId) async {
    final response = await guardDio(() => _dio.post<Map<String, dynamic>>(
          '/api/friends/requests',
          data: {'addresseeUserId': addresseeUserId},
        ));
    return unwrap(response, (json) => FriendRequest.fromJson(json as Map<String, dynamic>));
  }

  Future<List<FriendRequest>> getIncomingRequests() async {
    final response = await guardDio(() => _dio.get<Map<String, dynamic>>('/api/friends/requests/incoming'));
    return unwrapList(response, (json) => FriendRequest.fromJson(json as Map<String, dynamic>));
  }

  Future<List<FriendRequest>> getSentRequests() async {
    final response = await guardDio(() => _dio.get<Map<String, dynamic>>('/api/friends/requests/sent'));
    return unwrapList(response, (json) => FriendRequest.fromJson(json as Map<String, dynamic>));
  }

  Future<void> accept(String requestId) async {
    await guardDio(() => _dio.post<Map<String, dynamic>>('/api/friends/requests/$requestId/accept'));
  }

  Future<void> reject(String requestId) async {
    await guardDio(() => _dio.post<Map<String, dynamic>>('/api/friends/requests/$requestId/reject'));
  }

  Future<void> cancel(String requestId) async {
    await guardDio(() => _dio.delete<Map<String, dynamic>>('/api/friends/requests/$requestId'));
  }
}
