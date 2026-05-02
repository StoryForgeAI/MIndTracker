import 'package:shared_preferences/shared_preferences.dart';
import '../domain/onboarding_data.dart';
import '../../tracking/domain/app_info.dart';

abstract class OnboardingRepository {
  Future<OnboardingData> getOnboardingData();
  Future<void> saveOnboardingData(OnboardingData data);
  Future<void> completeOnboarding();
}

class OnboardingRepositoryImpl implements OnboardingRepository {
  static const _selectedAppsKey = 'selected_apps';
  static const _blockedAppsKey = 'blocked_apps';
  static const _lockIntervalKey = 'lock_interval';
  static const _goalKey = 'goal';
  static const _completedKey = 'onboarding_completed';

  @override
  Future<OnboardingData> getOnboardingData() async {
    final prefs = await SharedPreferences.getInstance();
    final selectedAppsJson = prefs.getStringList(_selectedAppsKey) ?? [];
    final blockedAppsJson = prefs.getStringList(_blockedAppsKey) ?? [];
    final lockInterval = prefs.getInt(_lockIntervalKey) ?? 30;
    final goal = prefs.getString(_goalKey) ?? '';
    final completed = prefs.getBool(_completedKey) ?? false;

    return OnboardingData(
      selectedApps: selectedAppsJson.map((e) => _appFromJson(e)).toList(),
      blockedApps: blockedAppsJson.map((e) => _appFromJson(e)).toList(),
      lockIntervalMinutes: lockInterval,
      goal: goal,
      isCompleted: completed,
    );
  }

  @override
  Future<void> saveOnboardingData(OnboardingData data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      _selectedAppsKey,
      data.selectedApps.map((e) => _appToJson(e)).toList(),
    );
    await prefs.setStringList(
      _blockedAppsKey,
      data.blockedApps.map((e) => _appToJson(e)).toList(),
    );
    await prefs.setInt(_lockIntervalKey, data.lockIntervalMinutes);
    await prefs.setString(_goalKey, data.goal);
  }

  @override
  Future<void> completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_completedKey, true);
  }

  String _appToJson(AppInfo app) => '${app.packageName}|${app.appName}';

  AppInfo _appFromJson(String json) {
    final parts = json.split('|');
    return AppInfo(packageName: parts[0], appName: parts[1]);
  }
}
