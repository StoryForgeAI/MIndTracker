import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mind_lock_tracker/core/constants/app_colors.dart';
import 'package:mind_lock_tracker/core/utils/providers.dart';

class GoalSelectionScreen extends ConsumerWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const GoalSelectionScreen({super.key, required this.onNext, required this.onBack});

  static final _goals = [
    'Improve focus',
    'Increase productivity',
    'Reduce social media',
    'Better sleep habits',
    'Digital detox',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(onboardingDataProvider);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Select your goal',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
          const SizedBox(height: 8),
          Text('What do you want to achieve?',
              style: TextStyle(color: AppColors.textSecondary)),
          const SizedBox(height: 24),
          Expanded(
            child: ListView.builder(
              itemCount: _goals.length,
              itemBuilder: (context, index) {
                final goal = _goals[index];
                final isSelected = data.goal == goal;
                return Card(
                  color: isSelected ? AppColors.primary : AppColors.surface,
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  child: ListTile(
                    title: Text(goal, style: const TextStyle(color: AppColors.textPrimary)),
                    trailing: isSelected
                        ? const Icon(Icons.check, color: AppColors.textPrimary)
                        : null,
                    onTap: () {
                      ref.read(onboardingDataProvider.notifier).state = data.copyWith(goal: goal);
                    },
                  ),
                );
              },
            ),
          ),
          Row(
            children: [
              TextButton(onPressed: onBack, child: const Text('Back')),
              const Spacer(),
              ElevatedButton(
                onPressed: data.goal.isNotEmpty ? onNext : null,
                child: const Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
