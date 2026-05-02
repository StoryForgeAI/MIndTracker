import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mind_lock_tracker/core/constants/app_colors.dart';
import 'package:mind_lock_tracker/core/utils/providers.dart';
import 'package:mind_lock_tracker/features/tracking/domain/app_info.dart';

class BlockingSetupScreen extends ConsumerWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const BlockingSetupScreen({super.key, required this.onNext, required this.onBack});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(onboardingDataProvider);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Block apps',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
          const SizedBox(height: 8),
          Text('Toggle apps you want to block during focus sessions',
              style: TextStyle(color: AppColors.textSecondary)),
          const SizedBox(height: 24),
          Expanded(
            child: data.selectedApps.isEmpty
                ? const Center(child: Text('No apps selected', style: TextStyle(color: AppColors.textSecondary)))
                : ListView.builder(
                    itemCount: data.selectedApps.length,
                    itemBuilder: (context, index) {
                      final app = data.selectedApps[index];
                      final isBlocked = data.blockedApps.any((a) => a.packageName == app.packageName);
                      return Card(
                        color: AppColors.surface,
                        child: SwitchListTile(
                          title: Text(app.appName, style: const TextStyle(color: AppColors.textPrimary)),
                          value: isBlocked,
                          onChanged: (_) => _toggleBlocked(app, ref),
                          activeColor: AppColors.primary,
                        ),
                      );
                    },
                  ),
          ),
          Row(
            children: [
              TextButton(onPressed: onBack, child: const Text('Back')),
              const Spacer(),
              TextButton(onPressed: onNext, child: const Text('Skip for now')),
              const SizedBox(width: 8),
              ElevatedButton(onPressed: onNext, child: const Text('Next')),
            ],
          ),
        ],
      ),
    );
  }

  void _toggleBlocked(AppInfo app, WidgetRef ref) {
    final data = ref.read(onboardingDataProvider);
    final updated = [...data.blockedApps];
    if (updated.any((a) => a.packageName == app.packageName)) {
      updated.removeWhere((a) => a.packageName == app.packageName);
    } else {
      updated.add(app);
    }
    ref.read(onboardingDataProvider.notifier).state = data.copyWith(blockedApps: updated);
  }
}
