import 'package:dio/dio.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_client.dart';
import '../../../core/network/envelope.dart';
import '../domain/auth_response.dart';

part 'auth_api.g.dart';

@riverpod
AuthApi authApi(Ref ref) => AuthApi(ref.watch(apiClientProvider));

class AuthApi {
  AuthApi(this._dio);

  final Dio _dio;

  Future<void> sendOtp(String phoneNumber) async {
    await guardDio(() => _dio.post<Map<String, dynamic>>(
          '/api/auth/send-otp',
          data: {'phoneNumber': phoneNumber},
        ));
  }

  Future<AuthResponse> verifyOtp({required String phoneNumber, required String code}) async {
    final response = await guardDio(() => _dio.post<Map<String, dynamic>>(
          '/api/auth/verify-otp',
          data: {'phoneNumber': phoneNumber, 'code': code},
        ));
    return unwrap(response, (json) => AuthResponse.fromJson(json as Map<String, dynamic>));
  }

  Future<void> logout(String refreshToken) async {
    await guardDio(() => _dio.post<Map<String, dynamic>>(
          '/api/auth/logout',
          data: {'refreshToken': refreshToken},
        ));
  }
}
