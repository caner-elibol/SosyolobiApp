import 'package:dio/dio.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_client.dart';
import '../../../core/network/envelope.dart';
import '../domain/profile.dart';

part 'profile_api.g.dart';

@riverpod
ProfileApi profileApi(Ref ref) => ProfileApi(ref.watch(apiClientProvider));

class ProfileApi {
  ProfileApi(this._dio);

  final Dio _dio;

  Future<UserProfile> getMe() async {
    final response = await guardDio(() => _dio.get<Map<String, dynamic>>('/api/profiles/me'));
    return unwrap(response, (json) => UserProfile.fromJson(json as Map<String, dynamic>));
  }

  Future<UserProfile> update({required String displayName, String? bio}) async {
    final response = await guardDio(() => _dio.put<Map<String, dynamic>>(
          '/api/profiles/me',
          data: {'displayName': displayName, if (bio != null) 'bio': bio},
        ));
    return unwrap(response, (json) => UserProfile.fromJson(json as Map<String, dynamic>));
  }

  Future<UserProfile> uploadAvatar(String filePath) async {
    final formData = FormData.fromMap({
      'File': await MultipartFile.fromFile(filePath),
    });
    final response = await guardDio(() => _dio.post<Map<String, dynamic>>('/api/profiles/me/avatar', data: formData));
    return unwrap(response, (json) => UserProfile.fromJson(json as Map<String, dynamic>));
  }

  Future<PublicProfile> getPublic(String userId) async {
    final response = await guardDio(() => _dio.get<Map<String, dynamic>>('/api/profiles/$userId'));
    return unwrap(response, (json) => PublicProfile.fromJson(json as Map<String, dynamic>));
  }
}
