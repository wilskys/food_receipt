import 'package:flutter/material.dart';
import 'package:food_receipt/features/home/widgets/recipe_card_grid_skeleton.dart';

class FavoriteGridSkeleton extends StatelessWidget {
  const FavoriteGridSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        itemCount: 6,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.75,
        ),
        itemBuilder: (_, __) => const RecipeCardGridSkeleton(),
      ),
    );
  }
}
