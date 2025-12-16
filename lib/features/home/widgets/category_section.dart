import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_receipt/features/home/widgets/category_bottom_sheet.dart';
import 'package:food_receipt/features/home/widgets/category_section_skeleton.dart';
import 'package:food_receipt/models/category.dart';
import '../../../providers/category_provider.dart';
import '../../../providers/category_state_provider.dart';
import 'category_chip.dart';

class CategorySection extends ConsumerWidget {
  const CategorySection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryAsync = ref.watch(categoryListProvider);
    final selected = ref.watch(selectedCategoryProvider);

    return categoryAsync.when(
      loading: () => const CategorySectionSkeleton(),
      error: (e, _) => const Text('Failed to load categories'),
      data: (categories) {
        if (ref.read(selectedCategoryProvider) == null &&
            categories.isNotEmpty) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ref.read(selectedCategoryProvider.notifier).state =
                categories.first.name;
          });
        }

        final selected = ref.watch(selectedCategoryProvider);

        final reordered = reorderCategories(categories, selected);

        final preview = reordered.take(4).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// HEADER + SEE ALL
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Category',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(24),
                        ),
                      ),
                      builder: (_) => const CategoryBottomSheet(),
                    );
                  },
                  child: const Text(
                    'See all',
                    style: TextStyle(color: Colors.orange),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            /// PREVIEW CHIP (ACTIVE DI DEPAN)
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: preview.map((c) {
                return CategoryChip(
                  label: c.name,
                  isActive: selected == c.name,
                  onTap: () {
                    ref.read(selectedCategoryProvider.notifier).state = c.name;
                  },
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }

  List<MealCategory> reorderCategories(
    List<MealCategory> categories,
    String? selected,
  ) {
    if (selected == null) return categories;

    final selectedIndex = categories.indexWhere((c) => c.name == selected);

    if (selectedIndex <= 0) return categories;

    final selectedItem = categories[selectedIndex];

    return [selectedItem, ...categories.where((c) => c.name != selected)];
  }
}
