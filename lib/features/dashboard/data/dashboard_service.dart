import '../domain/session_stats.dart';
import '../../tracking/domain/usage_log.dart';

abstract class DashboardService {
  Future<SessionStats> getSessionStats(String userId);
  Future<List<UsageLog>> getWeeklyUsage(String userId);
  Future<Map<String, int>> getAppUsageBreakdown(String userId);
  Future<int> getStreakDays(String userId);
  Future<int> getBlockedAttempts(String userId);
}

class DashboardServiceImpl implements DashboardService {
  @override
  Future<SessionStats> getSessionStats(String userId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return SessionStats(
      id: 'stats-1',
      userId: userId,
      date: DateTime.now(),
      totalScreenTimeMinutes: 180,
      focusScore: 75,
      streakDays: 5,
      blockedAttempts: 12,
      appUsageMinutes: {
        'Instagram': 45,
        'TikTok': 30,
        'YouTube': 60,
        'Twitter': 20,
        'Other': 25,
      },
    );
  }

  @override
  Future<List<UsageLog>> getWeeklyUsage(String userId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final now = DateTime.now();
    return List.generate(7, (index) {
      final date = now.subtract(Duration(days: 6 - index));
      return UsageLog(
        id: 'log-$index',
        userId: userId,
        packageName: 'com.example.app',
        appName: 'App $index',
        durationMinutes: 30 + (index * 10),
        timestamp: date,
      );
    });
  }

  @override
  Future<Map<String, int>> getAppUsageBreakdown(String userId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return {
      'Instagram': 45,
      'TikTok': 30,
      'YouTube': 60,
      'Twitter': 20,
      'Other': 25,
    };
  }

  @override
  Future<int> getStreakDays(String userId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return 5;
  }

  @override
  Future<int> getBlockedAttempts(String userId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return 12;
  }
}
