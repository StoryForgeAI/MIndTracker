class SessionStats {
  final String id;
  final String userId;
  final DateTime date;
  final int totalScreenTimeMinutes;
  final int focusScore;
  final int streakDays;
  final int blockedAttempts;
  final Map<String, int> appUsageMinutes;

  const SessionStats({
    required this.id,
    required this.userId,
    required this.date,
    required this.totalScreenTimeMinutes,
    required this.focusScore,
    required this.streakDays,
    required this.blockedAttempts,
    required this.appUsageMinutes,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'date': date.toIso8601String(),
        'total_screen_time_minutes': totalScreenTimeMinutes,
        'focus_score': focusScore,
        'streak_days': streakDays,
        'blocked_attempts': blockedAttempts,
        'app_usage_minutes': appUsageMinutes,
      };

  factory SessionStats.fromJson(Map<String, dynamic> json) => SessionStats(
        id: json['id'] ?? '',
        userId: json['user_id'] ?? '',
        date: DateTime.parse(json['date']),
        totalScreenTimeMinutes: json['total_screen_time_minutes'] ?? 0,
        focusScore: json['focus_score'] ?? 0,
        streakDays: json['streak_days'] ?? 0,
        blockedAttempts: json['blocked_attempts'] ?? 0,
        appUsageMinutes: Map<String, int>.from(json['app_usage_minutes'] ?? {}),
      );
}
