import 'package:flutter/material.dart';
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

  return Card(
    elevation: 4,
    margin: const EdgeInsets.only(bottom: 12),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    clipBehavior: Clip.antiAlias,
    child: InkWell(
      borderRadius: BorderRadius.circular(20),
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
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                Icons.group_outlined,
                size: 28,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    section.name ?? S.of(context).Sections,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    grade.name ?? '', // عرض اسم الصف كتفصيل إضافي
                    style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: theme.colorScheme.primary.withOpacity(0.6),
            ),
          ],
        ),
      ),
    ),
  );
}
