import 'package:flutter/material.dart';
import 'category_chip_skeleton.dart';

class CategorySectionSkeleton extends StatelessWidget {
  const CategorySectionSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// HEADER
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Category',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text('See all', style: TextStyle(color: Colors.orange)),
          ],
        ),

        const SizedBox(height: 12),

        /// CHIP SKELETON
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(4, (_) => const CategoryChipSkeleton()),
        ),
      ],
    );
  }
}
