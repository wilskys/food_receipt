import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_receipt/features/favorite/widgets/favorite_grid_skeleton.dart';
import 'package:food_receipt/features/home/widgets/recipe_card_grid.dart';
import 'package:food_receipt/models/meal.dart';
import 'package:food_receipt/models/favorite_meal.dart';
import 'package:food_receipt/providers/favorite_provider.dart';
import 'package:food_receipt/providers/favorite_ui_provider.dart';
import 'package:go_router/go_router.dart';

class FavoritePage extends ConsumerWidget {
  const FavoritePage({super.key});

  @override
  @override
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoriteListProvider);
    final isLoading = ref.watch(favoriteLoadingProvider);
    final isEditMode = ref.watch(favoriteEditModeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditMode ? 'Edit Favorites' : 'Your Favorites'),
        actions: [
          if (favorites.isNotEmpty)
            TextButton(
              onPressed: () {
                ref.read(favoriteEditModeProvider.notifier).state = !isEditMode;
              },
              child: Text(isEditMode ? 'Done' : 'Edit'),
            ),
        ],
      ),

      body: isLoading
          ? const FavoriteGridSkeleton() // ⏳ LOADING
          : favorites.isEmpty
          ? const _FavoriteEmptyState() // 📭 EMPTY
          : Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                itemCount: favorites.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (_, i) {
                  final fav = favorites[i];
                  final isEditMode = ref.watch(favoriteEditModeProvider);

                  return Stack(
                    children: [
                      RecipeCardGrid(
                        meal: Meal(
                          id: fav.id,
                          name: fav.name,
                          thumbnail: fav.thumbnail,
                        ),
                        onTap: isEditMode
                            ? null
                            : () => context.push('/meal/${fav.id}'),
                        showFavoriteIcon: false,
                      ),
                      if (isEditMode)
                        Positioned(
                          top: 6,
                          right: 6,
                          child: GestureDetector(
                            onTap: () {
                              _showRemoveDialog(context, ref, fav);
                            },
                            child: Container(
                              width: 28,
                              height: 28,
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
    );
  }

  /// 🔥 CONFIRMATION DIALOG
  void _showRemoveDialog(
    BuildContext context,
    WidgetRef ref,
    FavoriteMeal meal,
  ) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text('Remove from favorites?'),
          content: Text(
            '"${meal.name}" will be removed from your favorites.',
            style: const TextStyle(height: 1.4),
          ),
          actionsPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                ref.read(favoriteListProvider.notifier).toggleFavorite(meal);

                Navigator.pop(context);

                /// OPTIONAL FEEDBACK
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Removed from favorites'),
                    behavior: SnackBarBehavior.floating,
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              child: const Text(
                'Remove',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _FavoriteEmptyState extends StatelessWidget {
  const _FavoriteEmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.favorite_border, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No favorites yet',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Save your favorite recipes and\nfind them here later.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
