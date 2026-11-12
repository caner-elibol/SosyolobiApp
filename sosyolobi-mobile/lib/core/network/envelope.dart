import 'package:dio/dio.dart';

import 'api_exception.dart';

T unwrap<T>(Response<dynamic> response, T Function(dynamic json) fromJsonT) {
  final body = response.data;
  if (body is Map<String, dynamic> && body.containsKey('success')) {
    final success = body['success'] as bool? ?? false;
    if (!success) {
      throw _errorFrom(response);
    }
    return fromJsonT(body['data']);
  }
  return fromJsonT(body);
}

List<T> unwrapList<T>(Response<dynamic> response, T Function(dynamic json) fromJsonT) {
  return unwrap<List<dynamic>>(response, (json) => (json as List<dynamic>? ?? const []))
      .map(fromJsonT)
      .toList();
}

class PagedResult<T> {
  const PagedResult({
    required this.items,
    required this.totalCount,
    required this.page,
    required this.pageSize,
    required this.totalPages,
    required this.hasNextPage,
    required this.hasPreviousPage,
  });

  factory PagedResult.fromJson(dynamic json, T Function(dynamic json) fromJsonT) {
    final map = json as Map<String, dynamic>;
    return PagedResult(
      items: (map['items'] as List<dynamic>? ?? const []).map(fromJsonT).toList(),
      totalCount: map['totalCount'] as int? ?? 0,
      page: map['page'] as int? ?? 1,
      pageSize: map['pageSize'] as int? ?? 0,
      totalPages: map['totalPages'] as int? ?? 0,
      hasNextPage: map['hasNextPage'] as bool? ?? false,
      hasPreviousPage: map['hasPreviousPage'] as bool? ?? false,
    );
  }

  final List<T> items;
  final int totalCount;
  final int page;
  final int pageSize;
  final int totalPages;
  final bool hasNextPage;
  final bool hasPreviousPage;
}

PagedResult<T> unwrapPaged<T>(Response<dynamic> response, T Function(dynamic json) fromJsonT) {
  return unwrap<PagedResult<T>>(response, (json) => PagedResult.fromJson(json, fromJsonT));
}

ApiException _errorFrom(Response<dynamic> response) {
  final body = response.data;
  if (body is Map<String, dynamic>) {
    final rawErrors = body['errors'] as Map<String, dynamic>? ?? body['Errors'] as Map<String, dynamic>?;
    final errors = rawErrors?.map((k, v) => MapEntry(k, (v as List<dynamic>).cast<String>()));
    final message = body['message'] as String? ??
        body['Message'] as String? ??
        body['title'] as String? ??
        errors?.values.firstOrNull?.firstOrNull;
    final code = body['code'] as String? ?? body['Code'] as String?;
    return ApiException(
      statusCode: response.statusCode,
      message: message ?? 'Bir hata oluştu. Tekrar deneyin.',
      code: code,
      errors: errors,
    );
  }
  return ApiException(
    statusCode: response.statusCode,
    message: 'Bir hata oluştu. Tekrar deneyin.',
  );
}

ApiException apiExceptionFromDioError(DioException error) {
  final response = error.response;
  if (response != null) return _errorFrom(response);
  if (error.type == DioExceptionType.connectionTimeout || error.type == DioExceptionType.receiveTimeout) {
    return ApiException(message: 'Sunucu yanıt vermiyor. Tekrar deneyin.');
  }
  return ApiException(message: 'Sunucuya ulaşılamadı. Bağlantınızı kontrol edin.');
}

Future<Response<T>> guardDio<T>(Future<Response<T>> Function() request) async {
  try {
    return await request();
  } on DioException catch (e) {
    throw apiExceptionFromDioError(e);
  }
}
