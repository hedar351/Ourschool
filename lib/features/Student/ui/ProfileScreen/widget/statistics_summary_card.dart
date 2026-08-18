// lib/features/Student/ui/ProfileScreen/widget/statistics_summary_card.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/features/Student/domain/entity/Student-FullProfile/MarksStatisticsEntity.dart';
import 'package:school/features/Student/domain/entity/Student-FullProfile/StatisticsEntity.dart';

class StatisticsSummaryCard extends StatelessWidget {
  final MarksStatisticsEntity? marksStatistics;
  final StatisticsEntity? statistics;
  final double semester1Average;
  final double semester2Average;
  final double finalAverage;

  const StatisticsSummaryCard({
    super.key,
    required this.marksStatistics,
    required this.statistics,
    required this.semester1Average,
    required this.semester2Average,
    required this.finalAverage,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    Icons.analytics_rounded,
                    color: colorScheme.primary,
                    size: 22.w,
                  ),
                ),
                SizedBox(width: 10.w),
                Text(
                  'إحصائيات العلامات',
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),

            // المعدلات
            Row(
              children: [
                _buildAverageChip(
                  context,
                  label: 'الفصل الأول',
                  value: semester1Average,
                  color: Colors.blue.shade600,
                ),
                SizedBox(width: 8.w),
                _buildAverageChip(
                  context,
                  label: 'الفصل الثاني',
                  value: semester2Average,
                  color: Colors.green.shade600,
                ),
                SizedBox(width: 8.w),
                _buildAverageChip(
                  context,
                  label: 'النهائي',
                  value: finalAverage,
                  color: colorScheme.primary,
                  isHighlight: true,
                ),
              ],
            ),
            SizedBox(height: 12.h),

            // إحصائيات إضافية
            if (marksStatistics != null) ...[
              Divider(height: 1.h, color: theme.dividerColor.withOpacity(0.3)),
              SizedBox(height: 12.h),
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: [
                  _buildStatChip(
                    context,
                    label: 'مجموع العلامات',
                    value: '${marksStatistics!.totalMarks ?? 0}',
                  ),
                  _buildStatChip(
                    context,
                    label: 'ناجح',
                    value: '${marksStatistics!.passedSubjects ?? 0}',
                    color: Colors.green.shade600,
                  ),
                  _buildStatChip(
                    context,
                    label: 'راسب',
                    value: '${marksStatistics!.failedSubjects ?? 0}',
                    color: Colors.red.shade600,
                  ),
                  _buildStatChip(
                    context,
                    label: 'نسبة النجاح',
                    value: '${marksStatistics!.successRate ?? 0}%',
                    color: Colors.orange.shade600,
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildAverageChip(
    BuildContext context, {
    required String label,
    required double value,
    required Color color,
    bool isHighlight = false,
  }) {
    final theme = Theme.of(context);
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(10.r),
          border: isHighlight
              ? Border.all(color: color, width: 1.5.w)
              : Border.all(color: color.withOpacity(0.2), width: 1.w),
        ),
        child: Column(
          children: [
            Text(
              value.toStringAsFixed(1),
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              label,
              style: TextStyle(fontSize: 10.sp, color: theme.hintColor),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatChip(
    BuildContext context, {
    required String label,
    required String value,
    Color? color,
    IconData? icon,
  }) {
    final theme = Theme.of(context);
    final defaultColor = theme.hintColor;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: (color ?? defaultColor).withOpacity(0.08),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: (color ?? defaultColor).withOpacity(0.15),
          width: 1.w,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14.w, color: color ?? defaultColor),
            SizedBox(width: 4.w),
          ],
          Text(
            '$label: ',
            style: TextStyle(fontSize: 11.sp, color: theme.hintColor),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
              color: color ?? defaultColor,
            ),
          ),
        ],
      ),
    );
  }
}
