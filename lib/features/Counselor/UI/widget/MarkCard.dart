import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/features/Counselor/domain/Entities/StudentsProfileEntity/Counselor_MarkEntity.dart';
import 'package:school/generated/l10n.dart';

class MarkCard extends StatelessWidget {
  final CounselorMarkentity mark;

  final double _cardMarginBottom = 12.h;

  final double _cardPadding = 16.w;
  final double _chipPaddingHorizontal = 10.w;
  final double _chipPaddingVertical = 4.h;
  final double _semesterPaddingHorizontal = 12.w;
  final double _semesterPaddingVertical = 6.h;
  final double _totalPaddingHorizontal = 12.w;
  final double _totalPaddingVertical = 8.h;
  final double _subjectFontSize = 16.sp;
  final double _semesterFontSize = 12.sp;
  final double _chipFontSize = 12.sp;
  final double _totalFontSize = 14.sp;
  final double _totalValueFontSize = 16.sp;
  final double _iconSize = 14.w;
  final double _cardRadius = 20.r;
  final double _semesterRadius = 20.r;
  final double _chipRadius = 12.r;
  final double _totalRadius = 16.r;
  final double _elevation = 4;
  MarkCard({super.key, required this.mark});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final total = mark.total ?? 0;
    final color = total >= 90
        ? Colors.green
        : total >= 70
        ? Colors.orange
        : Colors.red;

    final semesterText = switch (mark.semester) {
      1 => S.of(context).semester_1,
      2 => S.of(context).semester_2,
      _ => '${S.of(context).semester} ${mark.semester ?? '?'}',
    };

    return Card(
      elevation: _elevation,
      margin: EdgeInsets.only(bottom: _cardMarginBottom),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_cardRadius),
      ),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: EdgeInsets.all(_cardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  mark.subjectName ?? S.of(context).subject,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: _subjectFontSize,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: _semesterPaddingHorizontal,
                    vertical: _semesterPaddingVertical,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(_semesterRadius),
                    border: Border.all(
                      color: theme.colorScheme.primary.withOpacity(0.2),
                      width: 0.5.w,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.bookmark,
                        size: _iconSize,
                        color: theme.colorScheme.primary,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        semesterText,
                        style: TextStyle(
                          fontSize: _semesterFontSize,
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Wrap(
              spacing: 6.w,
              runSpacing: 6.h,
              children: [
                _buildGradeChip(S.of(context).oral, mark.quiz1),
                _buildGradeChip(S.of(context).oral_2, mark.quiz2),
                _buildGradeChip(S.of(context).homework, mark.homework),
                _buildGradeChip(S.of(context).final_exam, mark.finalExam),
              ],
            ),
            SizedBox(height: 12.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: _totalPaddingHorizontal,
                vertical: _totalPaddingVertical,
              ),
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(_totalRadius),
                border: Border.all(color: color.withOpacity(0.3), width: 1.w),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).final_grade,
                    style: TextStyle(fontSize: _totalFontSize),
                  ),
                  Text(
                    '$total%',
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.bold,
                      fontSize: _totalValueFontSize,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGradeChip(String label, int? value) {
    final val = value ?? 0;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: _chipPaddingHorizontal,
        vertical: _chipPaddingVertical,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(_chipRadius),
        border: Border.all(color: Colors.grey.shade300, width: 0.5.w),
      ),
      child: Text(
        '$label: $val',
        style: TextStyle(fontSize: _chipFontSize, color: Colors.black87),
      ),
    );
  }
}
