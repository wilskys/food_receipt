import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../providers/search_provider.dart';
import 'recipe_card_grid.dart';
import 'recipe_card_grid_skeleton.dart';

class SearchResultGrid extends ConsumerWidget {
  const SearchResultGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.watch(searchQueryProvider);

    if (query.isEmpty) {
      return const SizedBox.shrink();
    }

    final resultAsync = ref.watch(searchResultProvider);

    return resultAsync.when(
      loading: () => GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 4,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.75,
        ),
        itemBuilder: (_, __) => const RecipeCardGridSkeleton(),
      ),
      error: (e, _) => const Text('Failed to search recipes'),
      data: (meals) {
        if (meals.isEmpty) {
          return const Padding(
            padding: EdgeInsets.all(24),
            child: Text('No recipes found'),
          );
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
          itemBuilder: (_, i) {
            final meal = meals[i];
            return RecipeCardGrid(
              meal: meal,
              onTap: () => context.push('/meal/${meal.id}'),
            );
          },
        );
      },
    );
  }
}
