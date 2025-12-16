import 'package:flutter/material.dart';
import '../../../config/app_colors.dart';

enum ArrowDirection { next, back }

class ArrowButton extends StatelessWidget {
  final VoidCallback? onTap;
  final ArrowDirection direction;
  final bool enabled;

  const ArrowButton({
    super.key,
    required this.onTap,
    required this.direction,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1 : 0, // invisible but keep space
      child: GestureDetector(
        onTap: enabled ? onTap : null,
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.primary.withOpacity(0.4),
              width: 2,
            ),
          ),
          child: Container(
            width: 52,
            height: 52,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary,
            ),
            child: Icon(
              direction == ArrowDirection.next
                  ? Icons.arrow_forward_ios
                  : Icons.arrow_back_ios_new,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}
