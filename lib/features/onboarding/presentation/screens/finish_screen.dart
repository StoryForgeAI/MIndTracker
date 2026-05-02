import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:mind_lock_tracker/core/constants/app_colors.dart';
import 'package:mind_lock_tracker/core/utils/providers.dart';
import 'package:mind_lock_tracker/features/onboarding/domain/onboarding_data.dart';

class FinishScreen extends ConsumerWidget {
  final VoidCallback onFinish;
  final VoidCallback onBack;

  const FinishScreen({super.key, required this.onFinish, required this.onBack});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(onboardingDataProvider);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Setup complete!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
          const SizedBox(height: 24),
          _SummaryCard(data: data),
          const Spacer(),
          Row(
            children: [
              TextButton(onPressed: onBack, child: const Text('Back')),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  onFinish();
                  context.go('/dashboard');
                },
                child: const Text('Start Tracking'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final OnboardingData data;

  const _SummaryCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.surface,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Apps tracked: ${data.selectedApps.length}',
                style: const TextStyle(color: AppColors.textPrimary, fontSize: 16)),
            const SizedBox(height: 8),
            Text('Blocked apps: ${data.blockedApps.length}',
                style: const TextStyle(color: AppColors.textPrimary, fontSize: 16)),
            const SizedBox(height: 8),
            Text('Lock interval: ${data.lockIntervalMinutes} min',
                style: const TextStyle(color: AppColors.textPrimary, fontSize: 16)),
            const SizedBox(height: 8),
            Text('Goal: ${data.goal}',
                style: const TextStyle(color: AppColors.textPrimary, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
