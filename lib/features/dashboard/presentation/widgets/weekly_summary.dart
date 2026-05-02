import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:mind_lock_tracker/core/constants/app_colors.dart';
import 'package:mind_lock_tracker/features/dashboard/domain/session_stats.dart';

class WeeklySummary extends StatelessWidget {
  final SessionStats stats;

  const WeeklySummary({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    final entries = stats.appUsageMinutes.entries.toList();

    return Card(
      color: AppColors.surface,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Weekly Summary',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: entries.asMap().map((i, e) {
                    final colors = [AppColors.chart1, AppColors.chart2, AppColors.chart3, AppColors.chart4, AppColors.chart5];
                    return MapEntry(
                      i,
                      PieChartSectionData(
                        value: e.value.toDouble(),
                        title: '${e.key}\n${e.value}m',
                        color: colors[i % colors.length],
                        radius: 80,
                        titleStyle: const TextStyle(fontSize: 10, color: AppColors.textPrimary, fontWeight: FontWeight.bold),
                      ),
                    );
                  }).values.toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
