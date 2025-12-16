import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_receipt/providers/category_state_provider.dart';
import '../../../providers/category_provider.dart';
import 'category_chip.dart';

class CategoryBottomSheet extends ConsumerWidget {
  const CategoryBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryAsync = ref.watch(categoryListProvider);
    final selected = ref.watch(selectedCategoryProvider);

    return Container(
      decoration: BoxDecoration(color: Colors.transparent),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.4,
      ),
      child: categoryAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => const Center(child: Text('Failed to load categories')),
        data: (categories) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// DRAG HANDLE
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),

              /// TITLE
              const Text(
                'All Categories',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 16),

              /// CATEGORY LIST
              Flexible(
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: categories.map((c) {
                      return CategoryChip(
                        label: c.name,
                        isActive: selected == c.name,
                        onTap: () {
                          ref.read(selectedCategoryProvider.notifier).state =
                              c.name;

                          Navigator.pop(context);
                        },
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
