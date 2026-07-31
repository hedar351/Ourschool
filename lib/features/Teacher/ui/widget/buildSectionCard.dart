// lib/features/Teacher/ui/widget/buildSectionCard.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/features/Counselor/domain/Entities/gradeandSectionEntity/SectionEntity.dart';
import 'package:school/features/Counselor/domain/Entities/gradeandSectionEntity/gradeEntity.dart';
import 'package:school/features/Teacher/domain/Entities/TeacherProfileEntities/schoolsEntity.dart';
import 'package:school/features/Teacher/ui/page/teacher_students_list_screen.dart';
import 'package:school/generated/l10n.dart';

Widget buildSectionCard({
  required BuildContext context,
  required Sectionentity section,
  required Gradeentity grade,
  required int localSubjectId,
  required String subjectName,
  required Schoolsentity school,
}) {
  final theme = Theme.of(context);

  // ✅ حسابات القيم الثابتة
  final double cardMarginBottom = 12.h;
  final double cardPadding = 16.w;
  final double containerSize = 56.w;
  final double containerRadius = 16.r;
  final double iconSize = 28.w;
  final double titleFontSize = 17.sp;
  final double subtitleFontSize = 13.sp;
  final double gap = 16.w;

  return Card(
    elevation: 4,
    margin: EdgeInsets.only(bottom: cardMarginBottom),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
    clipBehavior: Clip.antiAlias,
    child: InkWell(
      borderRadius: BorderRadius.circular(20.r),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => TeacherStudentsListScreen(
              localGradeNumber: grade.localGradeNumber ?? 0,
              localSectionNumber: section.localSectionNumber ?? 0,
              localSubjectId: localSubjectId,
              gradeName: grade.name ?? '',
              sectionName: section.name ?? '',
              subjectName: subjectName,
              school: school,
            ),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.all(cardPadding),
        child: Row(
          children: [
            Container(
              width: containerSize,
              height: containerSize,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(containerRadius),
              ),
              child: Icon(
                Icons.group_outlined,
                size: iconSize,
                color: theme.colorScheme.primary,
              ),
            ),
            SizedBox(width: gap),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    section.name ?? S.of(context).Sections,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: titleFontSize,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    grade.name ?? '',
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
              color: theme.colorScheme.primary.withOpacity(0.6),
              size: 20.w,
            ),
          ],
        ),
      ),
    ),
  );
}
