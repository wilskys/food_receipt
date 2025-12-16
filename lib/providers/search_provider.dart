import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:food_receipt/providers/filtered_meal_provider.dart';
import '../models/meal.dart';
import '../repositories/meal_repository.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchResultProvider = FutureProvider<List<Meal>>((ref) async {
  final query = ref.watch(searchQueryProvider);
  final repo = ref.read(mealRepositoryProvider);

  if (query.isEmpty) return [];

  return repo.searchMeals(query);
});
