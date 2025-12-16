import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_receipt/models/meal.dart';
import 'package:food_receipt/providers/category_state_provider.dart';
import '../repositories/meal_repository.dart';

final mealRepositoryProvider = Provider<MealRepository>((ref) {
  return MealRepository();
});

final filteredMealProvider = FutureProvider.autoDispose<List<Meal>>((
  ref,
) async {
  final category = ref.watch(selectedCategoryProvider);

  if (category == null) return [];

  final repo = ref.read(mealRepositoryProvider);
  return repo.fetchByCategory(category);
});
