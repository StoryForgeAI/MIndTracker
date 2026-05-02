class UsageLog {
  final String id;
  final String userId;
  final String packageName;
  final String appName;
  final int durationMinutes;
  final DateTime timestamp;
  final bool wasBlocked;

  const UsageLog({
    required this.id,
    required this.userId,
    required this.packageName,
    required this.appName,
    required this.durationMinutes,
    required this.timestamp,
    this.wasBlocked = false,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'package_name': packageName,
        'app_name': appName,
        'duration_minutes': durationMinutes,
        'timestamp': timestamp.toIso8601String(),
        'was_blocked': wasBlocked,
      };

  factory UsageLog.fromJson(Map<String, dynamic> json) => UsageLog(
        id: json['id'] ?? '',
        userId: json['user_id'] ?? '',
        packageName: json['package_name'] ?? '',
        appName: json['app_name'] ?? '',
        durationMinutes: json['duration_minutes'] ?? 0,
        timestamp: DateTime.parse(json['timestamp']),
        wasBlocked: json['was_blocked'] ?? false,
      );
}
