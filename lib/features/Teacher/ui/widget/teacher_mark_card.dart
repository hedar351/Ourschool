// lib/features/Teacher/ui/widget/teacher_mark_card.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/features/Teacher/domain/Entities/TeacherStudentProfile/SemesterMarks.dart';
import 'package:school/generated/l10n.dart';

class TeacherMarkCard extends StatelessWidget {
  final SemesterMarks mark;

  // ✅ حسابات القيم الثابتة خارج build
  final double cardPadding = 14.w;

  final double chipPaddingHorizontal = 8.w;
  final double chipPaddingVertical = 4.h;
  final double titleFontSize = 16.sp;
  final double avgFontSize = 13.sp;
  final double chipLabelFontSize = 11.sp;
  final double chipValueFontSize = 12.sp;
  final double gapSmall = 8.w;
  final double gapMedium = 10.h;
  final double borderWidth = 0.5.w;
  // late final double avg = mark.totle!/4;
  TeacherMarkCard({super.key, required this.mark});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Card(
      margin: EdgeInsets.only(bottom: 8.h),
      elevation: 0,
      color: isDark
          ? Colors.grey.shade800.withOpacity(0.3)
          : Colors.grey.shade50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14.r),
        side: BorderSide(
          color: isDark
              ? Colors.grey.shade700.withOpacity(0.3)
              : Colors.grey.shade200,
          width: borderWidth,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(cardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 4.w,
                  height: 20.h,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
                SizedBox(width: gapSmall),
                Text(
                  mark.subjectName ?? 'مادة غير معروفة',
                  style: TextStyle(
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    'total: ${mark.total ?? 0}',
                    style: TextStyle(
                      fontSize: avgFontSize,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: gapMedium),
            Row(
              children: [
                _buildMarkChip(
                  context,
                  label: S.of(context).oral,
                  value: mark.quiz1,
                ),
                SizedBox(width: gapSmall),
                _buildMarkChip(
                  context,
                  label: S.of(context).oral_2,
                  value: mark.quiz2,
                ),
                SizedBox(width: gapSmall),
                _buildMarkChip(
                  context,
                  label: S.of(context).homework,
                  value: mark.homework,
                ),
                SizedBox(width: gapSmall),
                _buildMarkChip(
                  context,
                  label: S.of(context).final_exam,
                  value: mark.finalExam,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMarkChip(
    BuildContext context, {
    required String label,
    required double? value,
  }) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: chipPaddingHorizontal,
        vertical: chipPaddingVertical,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withOpacity(0.06),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: theme.colorScheme.primary.withOpacity(0.1),
          width: 0.3.w,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              fontSize: chipLabelFontSize,
              color: theme.colorScheme.outline,
            ),
          ),
          Text(
            value?.toStringAsFixed(0) ?? '0',
            style: TextStyle(
              fontSize: chipValueFontSize,
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
