// lib/features/Teacher/ui/widget/GradeCard .dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/features/Counselor/domain/Entities/gradeandSectionEntity/gradeEntity.dart';
import 'package:school/generated/l10n.dart';

class GradeCard extends StatelessWidget {
  final Gradeentity grade;
  final VoidCallback onTap;

  // ✅ حسابات القيم الثابتة خارج build
  final double cardPadding = 16.w;

  final double containerSize = 56.w;
  final double containerRadius = 16.r;
  final double titleFontSize = 18.sp;
  final double subtitleFontSize = 14.sp;
  final double letterFontSize = 24.sp;
  final double gap = 16.w;
  GradeCard({super.key, required this.grade, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Hero(
      tag: 'grade_${grade.id}',
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(cardPadding),
            child: Row(
              children: [
                Container(
                  width: containerSize,
                  height: containerSize,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.tertiary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(containerRadius),
                  ),
                  child: Center(
                    child: Text(
                      (grade.name?.isNotEmpty == true) ? grade.name![0] : ' ',
                      style: TextStyle(
                        color: theme.colorScheme.tertiary,
                        fontWeight: FontWeight.bold,
                        fontSize: letterFontSize,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: gap),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        grade.name ?? S.of(context).class_name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: titleFontSize,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        '${grade.sections?.length ?? 0} ${S.of(context).Sections}',
                        style: TextStyle(
                          fontSize: subtitleFontSize,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: theme.colorScheme.tertiary,
                  size: 20.w,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
