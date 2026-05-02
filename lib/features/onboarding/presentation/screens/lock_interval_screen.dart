import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mind_lock_tracker/core/constants/app_colors.dart';
import 'package:mind_lock_tracker/core/utils/providers.dart';

class LockIntervalScreen extends ConsumerWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const LockIntervalScreen({super.key, required this.onNext, required this.onBack});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(onboardingDataProvider);
    final presets = [15, 30, 60];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Lock interval',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
          const SizedBox(height: 8),
          Text('Set how long apps should be blocked',
              style: TextStyle(color: AppColors.textSecondary)),
          const SizedBox(height: 24),
          ...presets.map((minutes) => _PresetButton(
                label: _formatDuration(minutes),
                isSelected: data.lockIntervalMinutes == minutes,
                onTap: () => _selectInterval(minutes, ref),
              )),
          const SizedBox(height: 16),
          _CustomIntervalField(
            onSelected: (minutes) => _selectInterval(minutes, ref),
          ),
          const Spacer(),
          Row(
            children: [
              TextButton(onPressed: onBack, child: const Text('Back')),
              const Spacer(),
              ElevatedButton(onPressed: onNext, child: const Text('Next')),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDuration(int minutes) {
    if (minutes < 60) return '${minutes}m';
    return '${minutes ~/ 60}h';
  }

  void _selectInterval(int minutes, WidgetRef ref) {
    final data = ref.read(onboardingDataProvider);
    ref.read(onboardingDataProvider.notifier).state = data.copyWith(lockIntervalMinutes: minutes);
  }
}

class _PresetButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _PresetButton({required this.label, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isSelected ? AppColors.primary : AppColors.surface,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        title: Text(label, style: TextStyle(color: isSelected ? AppColors.textPrimary : AppColors.textPrimary)),
        trailing: isSelected ? const Icon(Icons.check, color: AppColors.textPrimary) : null,
        onTap: onTap,
      ),
    );
  }
}

class _CustomIntervalField extends StatefulWidget {
  final Function(int) onSelected;

  const _CustomIntervalField({required this.onSelected});

  @override
  State<_CustomIntervalField> createState() => _CustomIntervalFieldState();
}

class _CustomIntervalFieldState extends State<_CustomIntervalField> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            style: const TextStyle(color: AppColors.textPrimary),
            decoration: InputDecoration(
              hintText: 'Custom (minutes)',
              hintStyle: TextStyle(color: AppColors.textSecondary),
              filled: true,
              fillColor: AppColors.surface,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            ),
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: () {
            final minutes = int.tryParse(_controller.text);
            if (minutes != null && minutes > 0) {
              widget.onSelected(minutes);
            }
          },
          child: const Text('Set'),
        ),
      ],
    );
  }
}
