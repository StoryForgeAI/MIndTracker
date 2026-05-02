import 'dart:async';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import '../domain/app_info.dart';

abstract class AndroidTrackingService {
  Future<List<AppInfo>> getInstalledApps();
  Future<bool> hasUsagePermission();
  Future<void> requestUsagePermission();
}

class AndroidTrackingServiceImpl implements AndroidTrackingService {
  static const platform = MethodChannel('com.mindlock.mind_lock_tracker/tracking');

  @override
  Future<List<AppInfo>> getInstalledApps() async {
    try {
      final status = await Permission.notification.status;
      if (!status.isGranted) {
        await Permission.notification.request();
      }

      final result = await platform.invokeMethod<List>('getInstalledApps');
      if (result != null) {
        return result.map((item) {
          final map = item as Map;
          return AppInfo(
            packageName: map['packageName'] ?? '',
            appName: map['appName'] ?? '',
            isSystemApp: map['isSystemApp'] ?? false,
          );
        }).toList();
      }
    } catch (e) {
      // Handle error silently
    }
    return _getMockApps();
  }

  @override
  Future<bool> hasUsagePermission() async {
    try {
      final result = await platform.invokeMethod<bool>('hasUsagePermission');
      return result ?? false;
    } catch (e) {
      // Handle error silently
      return false;
    }
  }

  @override
  Future<void> requestUsagePermission() async {
    try {
      await platform.invokeMethod('requestUsagePermission');
    } catch (e) {
      // Handle error silently
    }
  }

  List<AppInfo> _getMockApps() {
    return [
      AppInfo.mock('Instagram'),
      AppInfo.mock('TikTok'),
      AppInfo.mock('YouTube'),
      AppInfo.mock('Twitter'),
      AppInfo.mock('Facebook'),
      AppInfo.mock('WhatsApp'),
      AppInfo.mock('Snapchat'),
      AppInfo.mock('LinkedIn'),
    ];
  }
}
