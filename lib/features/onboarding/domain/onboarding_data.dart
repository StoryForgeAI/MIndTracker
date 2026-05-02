import '../../tracking/domain/app_info.dart';

class OnboardingData {
  final List<AppInfo> selectedApps;
  final List<AppInfo> blockedApps;
  final int lockIntervalMinutes;
  final String goal;
  final bool isCompleted;

  const OnboardingData({
    this.selectedApps = const [],
    this.blockedApps = const [],
    this.lockIntervalMinutes = 30,
    this.goal = '',
    this.isCompleted = false,
  });

  OnboardingData copyWith({
    List<AppInfo>? selectedApps,
    List<AppInfo>? blockedApps,
    int? lockIntervalMinutes,
    String? goal,
    bool? isCompleted,
  }) {
    return OnboardingData(
      selectedApps: selectedApps ?? this.selectedApps,
      blockedApps: blockedApps ?? this.blockedApps,
      lockIntervalMinutes: lockIntervalMinutes ?? this.lockIntervalMinutes,
      goal: goal ?? this.goal,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  bool get isStep1Complete => selectedApps.isNotEmpty;
  bool get isStep2Complete => true;
  bool get isStep3Complete => lockIntervalMinutes > 0;
  bool get isStep4Complete => goal.isNotEmpty;
  bool get isComplete => isStep1Complete && isStep3Complete && isStep4Complete;
}
