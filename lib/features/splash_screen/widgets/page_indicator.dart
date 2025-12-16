import 'package:flutter/material.dart';
import '../../../config/app_colors.dart';

class PageIndicator extends StatelessWidget {
  final int currentIndex;
  final int total;

  const PageIndicator({
    super.key,
    required this.currentIndex,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: List.generate(
          total,
          (index) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: index == currentIndex ? 18 : 6,
            height: 6,
            decoration: BoxDecoration(
              color: index == currentIndex
                  ? AppColors.primary
                  : AppColors.primary.withOpacity(0.4),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }
}
