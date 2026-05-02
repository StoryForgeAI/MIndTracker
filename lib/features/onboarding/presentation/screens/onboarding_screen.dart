import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:mind_lock_tracker/core/constants/app_colors.dart';
import 'package:mind_lock_tracker/core/utils/providers.dart';
import 'package:mind_lock_tracker/shared/widgets/setup_button.dart';
import 'app_selection_screen.dart';
import 'blocking_setup_screen.dart';
import 'lock_interval_screen.dart';
import 'goal_selection_screen.dart';
import 'finish_screen.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  int _currentStep = 0;
  final _steps = ['Apps', 'Blocking', 'Timer', 'Goal', 'Finish'];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final repo = ref.read(onboardingRepositoryProvider);
    final data = await repo.getOnboardingData();
    ref.read(onboardingDataProvider.notifier).state = data;
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(onboardingDataProvider);
    final isComplete = data.isComplete;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Setup'),
        backgroundColor: AppColors.background,
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: (_currentStep +1) / _steps.length,
            backgroundColor: AppColors.surface,
            valueColor: const AlwaysStoppedAnimation(AppColors.primary),
          ),
          Expanded(
            child: _buildCurrentStep(),
          ),
          if (!isComplete)
            SetupButton(
              onPressed: () {
                context.go('/dashboard');
              },
            ),
        ],
      ),
    );
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 0:
        return AppSelectionScreen(
          onNext: () => setState(() => _currentStep = 1),
        );
      case 1:
        return BlockingSetupScreen(
          onNext: () => setState(() => _currentStep = 2),
          onBack: () => setState(() => _currentStep = 0),
        );
      case 2:
        return LockIntervalScreen(
          onNext: () => setState(() => _currentStep = 3),
          onBack: () => setState(() => _currentStep = 1),
        );
      case 3:
        return GoalSelectionScreen(
          onNext: () => setState(() => _currentStep = 4),
          onBack: () => setState(() => _currentStep = 2),
        );
      case 4:
        return FinishScreen(
          onFinish: _completeOnboarding,
          onBack: () => setState(() => _currentStep = 3),
        );
      default:
        return const SizedBox();
    }
  }

  Future<void> _completeOnboarding() async {
    final repo = ref.read(onboardingRepositoryProvider);
    final data = ref.read(onboardingDataProvider).copyWith(isCompleted: true);
    await repo.saveOnboardingData(data);
    await repo.completeOnboarding();
    if (mounted) context.go('/dashboard');
  }
}
