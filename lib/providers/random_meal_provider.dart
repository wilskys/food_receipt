import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_receipt/repositories/meal_repository.dart';

import '../models/meal.dart';

final mealRepositoryProvider = Provider<MealRepository>((ref) {
  return MealRepository();
});

final randomMealProvider = FutureProvider<Meal>((ref) async {
  final repo = ref.read(mealRepositoryProvider);
  return repo.getRandomMeal();
});
