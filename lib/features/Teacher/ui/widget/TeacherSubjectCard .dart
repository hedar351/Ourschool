// lib/features/Teacher/ui/widget/TeacherSubjectCard .dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/features/Teacher/domain/Entities/TeacherProfileEntities/SubjectEntity.dart';
import 'package:school/generated/l10n.dart';

class TeacherSubjectCard extends StatelessWidget {
  final Subjectentity? subject;
  final VoidCallback onTap;

  // ✅ حسابات القيم الثابتة خارج build
  final double cardPadding = 16.w;

  final double containerSize = 56.w;
  final double containerRadius = 16.r;
  final double letterFontSize = 24.sp;
  final double titleFontSize = 18.sp;
  final double subtitleFontSize = 14.sp;
  final double gap = 16.w;
  TeacherSubjectCard({super.key, required this.subject, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final firstLetter = (subject?.subjectName?.isNotEmpty == true)
        ? subject!.subjectName![0]
        : 'م';

    return Hero(
      tag: 'subject_${subject?.subjectId}',
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
                    gradient: LinearGradient(
                      colors: [
                        theme.colorScheme.secondary,
                        theme.colorScheme.secondary.withOpacity(0.6),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(containerRadius),
                  ),
                  child: Center(
                    child: Text(
                      firstLetter,
                      style: TextStyle(
                        color: Colors.white,
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
                        subject?.subjectName ?? S.of(context).subject,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: titleFontSize,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        '${subject?.grades.length ?? 0} ${S.of(context).classes}',
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
                  color: theme.colorScheme.secondary,
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
