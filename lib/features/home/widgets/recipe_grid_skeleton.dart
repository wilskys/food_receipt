import 'package:flutter/material.dart';
import 'recipe_card_grid_skeleton.dart';

class RecipeGridSkeleton extends StatelessWidget {
  const RecipeGridSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 6,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (_, __) => const RecipeCardGridSkeleton(),
    );
  }
}
