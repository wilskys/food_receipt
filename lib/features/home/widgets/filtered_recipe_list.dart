import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_receipt/features/home/widgets/recipe_card_grid.dart';
import 'package:food_receipt/features/home/widgets/recipe_card_grid_skeleton.dart';
import 'package:go_router/go_router.dart';
import '../../../providers/filtered_meal_provider.dart';

class FilteredRecipeList extends ConsumerWidget {
  const FilteredRecipeList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mealAsync = ref.watch(filteredMealProvider);

    return mealAsync.when(
      loading: () => const RecipeCardGridSkeleton(),
      error: (e, _) => const Text('Failed to load recipes'),
      data: (meals) {
        if (meals.isEmpty) {
          return const SizedBox.shrink();
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: meals.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (_, index) {
            final meal = meals[index];
            return RecipeCardGrid(
              meal: meal,
              onTap: () {
                context.push('/meal/${meal.id}');
              },
            );
          },
        );
      },
    );
  }
}
