import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_receipt/core/widgets/app_cached_image.dart';
import 'package:food_receipt/models/favorite_meal.dart';
import 'package:food_receipt/providers/favorite_provider.dart';
import '../../providers/meal_detail_provider.dart';

class MealDetailPage extends ConsumerStatefulWidget {
  final String mealId;
  const MealDetailPage({super.key, required this.mealId});

  @override
  ConsumerState<MealDetailPage> createState() => _MealDetailPageState();
}

class _MealDetailPageState extends ConsumerState<MealDetailPage> {
  bool showIngredients = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mealAsync = ref.watch(mealDetailProvider(widget.mealId));

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        title: const Text('Recipe Detail'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Consumer(
            builder: (context, ref, _) {
              final mealState = ref.watch(mealDetailProvider(widget.mealId));
              final favorites = ref.watch(favoriteListProvider);
              final isFav = favorites.any((f) => f.id == widget.mealId);

              return mealState.maybeWhen(
                data: (meal) {
                  return IconButton(
                    icon: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      color: isFav ? Colors.red : Colors.grey.shade800,
                    ),
                    onPressed: () {
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
                  );
                },
                orElse: () => const SizedBox.shrink(),
              );
            },
          ),
        ],
      ),
      body: mealAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => const Center(child: Text('Failed to load recipe')),
        data: (meal) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// IMAGE
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: AppCachedImage(
                          imageUrl: meal.thumbnail,
                          width: double.infinity,
                          height: 220,
                          fit: BoxFit.cover,
                        ),
                      ),

                      const SizedBox(height: 24),

                      /// TAB SWITCHER
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            _TabButton(
                              label: 'Ingredients List',
                              active: showIngredients,
                              onTap: () =>
                                  setState(() => showIngredients = true),
                            ),
                            _TabButton(
                              label: 'Cooking Instructions',
                              active: !showIngredients,
                              onTap: () =>
                                  setState(() => showIngredients = false),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      /// CONTENT
                      if (showIngredients)
                        Column(
                          children: meal.ingredients.map((i) {
                            final iconName = i.name.toLowerCase().replaceAll(
                              ' ',
                              '_',
                            );

                            return Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                children: [
                                  /// INGREDIENT ICON
                                  Image.network(
                                    'https://www.themealdb.com/images/ingredients/${i.name}.png',
                                    width: 40,
                                    height: 40,
                                    errorBuilder: (_, __, ___) =>
                                        const Icon(Icons.restaurant),
                                  ),
                                  const SizedBox(width: 12),

                                  /// TEXT
                                  Expanded(
                                    child: Text(
                                      i.name,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    i.measure,
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        )
                      else
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            meal.instructions ?? '',
                            style: const TextStyle(height: 1.6, fontSize: 15),
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              /// BOTTOM ACTIONS
            ],
          );
        },
      ),
    );
  }
}

/// TAB BUTTON
class _TabButton extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _TabButton({
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: active
                ? Theme.of(context).primaryColor.withOpacity(0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: active ? Theme.of(context).primaryColor : Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
