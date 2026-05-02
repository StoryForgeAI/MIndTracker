import 'package:flutter/material.dart';

import 'package:mind_lock_tracker/core/constants/app_colors.dart';

class BlockedAttempts extends StatelessWidget {
  final int count;

  const BlockedAttempts({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.surface,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Blocked', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.block, color: AppColors.error, size: 28),
                const SizedBox(width: 8),
                Text('$count', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                Text(' times', style: TextStyle(color: AppColors.textSecondary)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
