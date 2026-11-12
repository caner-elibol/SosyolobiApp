import 'package:dio/dio.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_client.dart';
import '../../../core/network/envelope.dart';
import '../domain/report.dart';

part 'users_api.g.dart';

@riverpod
UsersApi usersApi(Ref ref) => UsersApi(ref.watch(apiClientProvider));

class UsersApi {
  UsersApi(this._dio);

  final Dio _dio;

  Future<void> block(String userId) async {
    await guardDio(() => _dio.post<Map<String, dynamic>>('/api/users/$userId/block'));
  }

  Future<void> unblock(String userId) async {
    await guardDio(() => _dio.delete<Map<String, dynamic>>('/api/users/$userId/block'));
  }

  Future<void> report(CreateReportRequest request) async {
    await guardDio(() => _dio.post<Map<String, dynamic>>('/api/reports', data: request.toJson()));
  }

  Future<PagedResult<ReportResponse>> getMyReports({int page = 1, int pageSize = 50}) async {
    final response = await guardDio(() => _dio.get<Map<String, dynamic>>(
          '/api/reports/mine',
          queryParameters: {'page': page, 'pageSize': pageSize},
        ));
    return unwrapPaged(response, (json) => ReportResponse.fromJson(json as Map<String, dynamic>));
  }
}
