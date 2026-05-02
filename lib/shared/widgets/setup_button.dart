import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:mind_lock_tracker/core/constants/app_colors.dart';

class SetupButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const SetupButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.background,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(77),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed ?? () => context.go('/onboarding'),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.warning,
          foregroundColor: AppColors.background,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: const Text('Setup incomplete → Fix', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}
