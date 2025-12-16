import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_receipt/core/widgets/app_cached_image.dart';
import 'package:food_receipt/models/favorite_meal.dart';
import 'package:food_receipt/models/meal.dart';
import 'package:food_receipt/providers/favorite_provider.dart';

class RecipeCardGrid extends ConsumerWidget {
  final Meal meal;
  final bool showFavoriteIcon;
  final VoidCallback? onTap;

  const RecipeCardGrid({
    super.key,
    required this.meal,
    this.onTap,
    this.showFavoriteIcon = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoriteListProvider);
    final isFav = favorites.any((f) => f.id == meal.id);
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// IMAGE + FAVORITE
            AspectRatio(
              aspectRatio: 1, // square image
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    child: AppCachedImage(
                      imageUrl: meal.thumbnail,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),

                  Visibility(
                    visible: showFavoriteIcon,
                    child: Positioned(
                      top: 8,
                      right: 8,
                      child: GestureDetector(
                        onTap: () {
                          ref
                              .read(favoriteListProvider.notifier)
                              .toggleFavorite(
                                FavoriteMeal(
                                  id: meal.id,
                                  name: meal.name,
                                  thumbnail: meal.thumbnail,
                                ),
                              );
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              SnackBar(
                                content: Text(
                                  isFav
                                      ? 'Removed from favorites'
                                      : 'Added to favorites',
                                ),
                                duration: const Duration(seconds: 1),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isFav
                                ? Icons.favorite_outlined
                                : Icons.favorite_border,
                            color: isFav ? Colors.red : Colors.red,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// TEXT
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                meal.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  height: 1.3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
