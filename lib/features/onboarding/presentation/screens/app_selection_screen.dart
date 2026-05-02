import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mind_lock_tracker/core/constants/app_colors.dart';
import 'package:mind_lock_tracker/core/utils/providers.dart';
import 'package:mind_lock_tracker/features/tracking/domain/app_info.dart';

class AppSelectionScreen extends ConsumerStatefulWidget {
  final VoidCallback onNext;

  const AppSelectionScreen({super.key, required this.onNext});

  @override
  ConsumerState<AppSelectionScreen> createState() => _AppSelectionScreenState();
}

class _AppSelectionScreenState extends ConsumerState<AppSelectionScreen> {
  List<AppInfo> _apps = [];
  bool _showAll = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadApps();
  }

  Future<void> _loadApps() async {
    try {
      final service = ref.read(androidTrackingServiceProvider);
      final apps = await service.getInstalledApps();
      setState(() {
        _apps = apps;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _apps = _getMockApps();
        _isLoading = false;
      });
    }
  }

  List<AppInfo> _getMockApps() => [
        AppInfo.mock('Instagram'),
        AppInfo.mock('TikTok'),
        AppInfo.mock('YouTube'),
        AppInfo.mock('Twitter'),
        AppInfo.mock('Facebook'),
        AppInfo.mock('WhatsApp'),
        AppInfo.mock('Snapchat'),
        AppInfo.mock('LinkedIn'),
      ];

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(onboardingDataProvider);
    final displayedApps = _showAll ? _apps : _apps.take(5).toList();

    if (_isLoading) {
      return const Center(child: CircularProgressIndicator(color: AppColors.primary));
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Select apps to track',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
          const SizedBox(height: 8),
          Text('Choose the apps you want to monitor',
              style: TextStyle(color: AppColors.textSecondary)),
          const SizedBox(height: 24),
          Expanded(
            child: ListView.builder(
              itemCount: displayedApps.length + 1,
              itemBuilder: (context, index) {
                if (index == displayedApps.length) {
                  return TextButton(
                    onPressed: () => setState(() => _showAll = !_showAll),
                    child: Text(_showAll ? 'Show less' : 'Show more apps'),
                  );
                }
                final app = displayedApps[index];
                final isSelected = data.selectedApps.any((a) => a.packageName == app.packageName);
                return _AppListItem(
                  app: app,
                  isSelected: isSelected,
                  onToggle: () => _toggleApp(app),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: data.selectedApps.isNotEmpty ? widget.onNext : null,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
            ),
            child: const Text('Next'),
          ),
        ],
      ),
    );
  }

  void _toggleApp(AppInfo app) {
    final data = ref.read(onboardingDataProvider);
    final updated = [...data.selectedApps];
    if (updated.any((a) => a.packageName == app.packageName)) {
      updated.removeWhere((a) => a.packageName == app.packageName);
    } else {
      updated.add(app);
    }
    ref.read(onboardingDataProvider.notifier).state = data.copyWith(selectedApps: updated);
  }
}

class _AppListItem extends StatelessWidget {
  final AppInfo app;
  final bool isSelected;
  final VoidCallback onToggle;

  const _AppListItem({required this.app, required this.isSelected, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.surface,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.primary,
          child: Text(app.appName.substring(0, 1), style: const TextStyle(color: AppColors.textPrimary)),
        ),
        title: Text(app.appName, style: const TextStyle(color: AppColors.textPrimary)),
        trailing: Checkbox(
          value: isSelected,
          onChanged: (_) => onToggle(),
          activeColor: AppColors.primary,
        ),
      ),
    );
  }
}
