import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_receipt/providers/filtered_meal_provider.dart';
import '../models/meal.dart';

final mealDetailProvider = FutureProvider.family<Meal, String>((
  ref,
  mealId,
) async {
  final repo = ref.read(mealRepositoryProvider);
  return repo.getMealDetail(mealId);
});
