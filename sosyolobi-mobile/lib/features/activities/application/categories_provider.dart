import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/domain/category.dart';
import '../data/categories_api.dart';

part 'categories_provider.g.dart';

@Riverpod(keepAlive: true)
Future<List<Category>> categories(Ref ref) => ref.watch(categoriesApiProvider).getAll();
