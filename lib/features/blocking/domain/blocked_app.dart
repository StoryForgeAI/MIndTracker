class BlockedApp {
  final String id;
  final String userId;
  final String packageName;
  final String appName;
  final int lockDurationMinutes;
  final DateTime? unlockTime;
  final bool isActive;

  const BlockedApp({
    required this.id,
    required this.userId,
    required this.packageName,
    required this.appName,
    required this.lockDurationMinutes,
    this.unlockTime,
    this.isActive = true,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'package_name': packageName,
        'app_name': appName,
        'lock_duration_minutes': lockDurationMinutes,
        'unlock_time': unlockTime?.toIso8601String(),
        'is_active': isActive,
      };
}
