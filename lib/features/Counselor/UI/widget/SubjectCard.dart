import 'package:flutter/material.dart';
import 'package:school/features/Counselor/domain/Entities/StudentsProfileEntity/Counselor_SubjectsEntity.dart';
import 'package:school/generated/l10n.dart';

class SubjectCard extends StatelessWidget {
  final CounselorSubjectsentity subject;

  const SubjectCard({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Container(
            //   width: 56,
            //   height: 56,
            //   decoration: BoxDecoration(
            //     gradient: LinearGradient(
            //       colors: [
            //         theme.colorScheme.primary,
            //         theme.colorScheme.primary.withOpacity(0.6),
            //       ],
            //       begin: Alignment.topLeft,
            //       end: Alignment.bottomRight,
            //     ),
            //     shape: BoxShape.circle,
            //   ),
            //   child: Center(
            //     child: Text(
            //       subject.subjectName?.isNotEmpty == true
            //           ? subject.subjectName![0].toUpperCase()
            //           : 'م',
            //       style: const TextStyle(
            //         color: Colors.white,
            //         fontWeight: FontWeight.bold,
            //         fontSize: 22,
            //       ),
            //     ),
            //   ),
            // ),
            // const SizedBox(width: 16),

            // معلومات المادة
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subject.subjectName ?? S.of(context).subject,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      // color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(
                        Icons.person_outline,
                        size: 16,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${S.of(context).teacher_prefix} ${subject.teacherName ?? S.of(context).not_specified}',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
