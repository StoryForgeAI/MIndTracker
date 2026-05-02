class AppInfo {
  final String packageName;
  final String appName;
  final String? icon;
  final bool isSystemApp;

  const AppInfo({
    required this.packageName,
    required this.appName,
    this.icon,
    this.isSystemApp = false,
  });

  factory AppInfo.mock(String name) {
    return AppInfo(
      packageName: 'com.example.$name',
      appName: name,
      isSystemApp: false,
    );
  }
}
