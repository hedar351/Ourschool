// lib/features/Student/presentation/widgets/quick_stats_row.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/features/Student/domain/entity/Student-FullProfile/StatisticsEntity.dart';
import 'package:school/features/Student/ui/ProfileScreen/widget/pulsing_icon.dart';
import 'package:school/generated/l10n.dart';

class QuickStatsRow extends StatelessWidget {
  final StatisticsEntity statistics;
  final int warningsCount;
  final int summonsCount;
  final VoidCallback onAttendanceTap;
  final VoidCallback onWarningsTap;
  final VoidCallback onSummonsTap;

  const QuickStatsRow({
    super.key,
    required this.statistics,
    required this.warningsCount,
    required this.summonsCount,
    required this.onAttendanceTap,
    required this.onWarningsTap,
    required this.onSummonsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            context,
            title: S.of(context).Attendance,
            value: '${statistics.totalAttendance ?? 0}',
            icon: Icons.calendar_today,
            color: Colors.red,
            onTap: onAttendanceTap,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _buildStatCard(
            context,
            title: S.of(context).warnings_title,
            value: '$warningsCount',
            icon: Icons.warning_amber_rounded,
            color: Colors.orange,
            onTap: onWarningsTap,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _buildStatCard(
            context,
            title: S.of(context).summons,
            value: '$summonsCount',
            icon: Icons.gavel,
            color: Colors.purple,
            onTap: onSummonsTap,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w),
          child: Column(
            children: [
              PulsingIcon(icon: icon, color: color),
              SizedBox(height: 8.h),
              Text(
                value,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color,
                  fontSize: 20.sp,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(fontSize: 12.sp),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
