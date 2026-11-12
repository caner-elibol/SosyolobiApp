import 'package:dio/dio.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/domain/category.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/envelope.dart';

part 'categories_api.g.dart';

@riverpod
CategoriesApi categoriesApi(Ref ref) => CategoriesApi(ref.watch(apiClientProvider));

class CategoriesApi {
  CategoriesApi(this._dio);

  final Dio _dio;

  Future<List<Category>> getAll() async {
    final response = await guardDio(() => _dio.get<Map<String, dynamic>>('/api/categories'));
    return unwrapList(response, (json) => Category.fromJson(json as Map<String, dynamic>));
  }
}
