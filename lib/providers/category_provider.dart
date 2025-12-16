import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/category_repository.dart';
import '../models/category.dart';

final categoryRepositoryProvider = Provider<CategoryRepository>((ref) {
  return CategoryRepository();
});

final categoryListProvider = FutureProvider<List<MealCategory>>((ref) async {
  final repo = ref.read(categoryRepositoryProvider);
  return repo.fetchCategories();
});
