import 'package:flutter/material.dart';

import 'package:mind_lock_tracker/core/constants/app_colors.dart';

class StreakCounter extends StatelessWidget {
  final int days;

  const StreakCounter({super.key, required this.days});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.surface,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Streak', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.local_fire_department, color: AppColors.warning, size: 28),
                const SizedBox(width: 8),
                Text('$days', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                Text(' days', style: TextStyle(color: AppColors.textSecondary)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
