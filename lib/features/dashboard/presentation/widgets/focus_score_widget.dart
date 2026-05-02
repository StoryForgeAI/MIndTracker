import 'package:flutter/material.dart';

import 'package:mind_lock_tracker/core/constants/app_colors.dart';

class FocusScoreWidget extends StatelessWidget {
  final int score;

  const FocusScoreWidget({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.surface,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Focus Score',
                      style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
                  const SizedBox(height: 8),
                  Text('$score',
                      style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: score >= 70 ? AppColors.success : AppColors.warning)),
                ],
              ),
            ),
            SizedBox(
              width: 80,
              height: 80,
              child: Stack(
                children: [
                  CircularProgressIndicator(
                    value: score / 100,
                    strokeWidth: 8,
                    backgroundColor: AppColors.surfaceVariant,
                    valueColor: AlwaysStoppedAnimation(
                      score >= 70 ? AppColors.success : AppColors.warning,
                    ),
                  ),
                  Center(
                    child: Text('$score%',
                        style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
