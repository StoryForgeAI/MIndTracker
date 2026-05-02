import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:mind_lock_tracker/core/constants/app_colors.dart';
import 'package:mind_lock_tracker/core/utils/providers.dart';
import 'package:mind_lock_tracker/shared/widgets/setup_button.dart';
import 'package:mind_lock_tracker/features/dashboard/domain/session_stats.dart';
import 'package:mind_lock_tracker/features/dashboard/presentation/widgets/screen_time_chart.dart';
import 'package:mind_lock_tracker/features/dashboard/presentation/widgets/focus_score_widget.dart';
import 'package:mind_lock_tracker/features/dashboard/presentation/widgets/streak_counter.dart';
import 'package:mind_lock_tracker/features/dashboard/presentation/widgets/blocked_attempts.dart';
import 'package:mind_lock_tracker/features/dashboard/presentation/widgets/weekly_summary.dart';

final dashboardStatsProvider = FutureProvider<SessionStats>((ref) async {
  final service = ref.read(dashboardServiceProvider);
  return service.getSessionStats('user-1');
});

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(dashboardStatsProvider);
    final onboardingData = ref.watch(onboardingDataProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Mind Lock Tracker'),
        backgroundColor: AppColors.background,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.go('/onboarding'),
          ),
        ],
      ),
      body: !onboardingData.isComplete
          ? const Center(
              child: SetupButton(),
            )
          : RefreshIndicator(
              onRefresh: () async {
                ref.invalidate(dashboardStatsProvider);
              },
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  statsAsync.when(
                    data: (stats) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Today\'s Overview',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                        const SizedBox(height: 16),
                        FocusScoreWidget(score: stats.focusScore),
                        const SizedBox(height: 16),
                        ScreenTimeChart(totalMinutes: stats.totalScreenTimeMinutes),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(child: StreakCounter(days: stats.streakDays)),
                            const SizedBox(width: 16),
                            Expanded(child: BlockedAttempts(count: stats.blockedAttempts)),
                          ],
                        ),
                        const SizedBox(height: 24),
                        WeeklySummary(stats: stats),
                      ],
                    ),
                    loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
                    error: (_, __) => const Center(child: Text('Error loading data', style: TextStyle(color: AppColors.textPrimary))),
                  ),
                ],
              ),
            ),
    );
  }
}
