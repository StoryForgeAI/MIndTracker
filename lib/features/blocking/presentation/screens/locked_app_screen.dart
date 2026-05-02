import 'dart:async';
import 'package:flutter/material.dart';

import 'package:mind_lock_tracker/core/constants/app_colors.dart';

class LockedAppScreen extends StatefulWidget {
  final String packageName;

  const LockedAppScreen({super.key, required this.packageName});

  @override
  State<LockedAppScreen> createState() => _LockedAppScreenState();
}

class _LockedAppScreenState extends State<LockedAppScreen> {
  int _remainingSeconds = 30 * 60;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          _timer?.cancel();
          Navigator.of(context).pop();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get _formattedTime {
    final minutes = _remainingSeconds ~/ 60;
    final seconds = _remainingSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.lock, size: 80, color: AppColors.primary),
            const SizedBox(height: 24),
            Text('App Locked',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
            const SizedBox(height: 8),
            Text(widget.packageName.split('.').last,
                style: TextStyle(fontSize: 18, color: AppColors.textSecondary)),
            const SizedBox(height: 32),
            Text(_formattedTime,
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: AppColors.primary)),
            const SizedBox(height: 8),
            Text('until unlock', style: TextStyle(color: AppColors.textSecondary)),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
