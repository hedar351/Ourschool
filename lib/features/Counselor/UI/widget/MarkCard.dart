import 'package:flutter/material.dart';
import 'package:school/features/Counselor/domain/Entities/StudentsProfileEntity/Counselor_MarkEntity.dart';
import 'package:school/generated/l10n.dart';

class MarkCard extends StatelessWidget {
  final CounselorMarkentity mark;

  const MarkCard({super.key, required this.mark});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final total = mark.total ?? 0;
    final color = total >= 90
        ? Colors.green
        : total >= 70
        ? Colors.orange
        : Colors.red;

    // ترجمة الفصل الدراسي
    final semesterText = switch (mark.semester) {
      1 => S.of(context).semester_1,
      2 => S.of(context).semester_2,
      // 3 => S.of(context).semester_3,
      _ => '${S.of(context).semester} ${mark.semester ?? '?'}',
    };

    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  mark.subjectName ?? S.of(context).subject,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: theme.colorScheme.primary.withOpacity(0.2),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.bookmark,
                        size: 14,
                        color: theme.colorScheme.primary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        semesterText,
                        style: TextStyle(
                          fontSize: 12,
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                _buildGradeChip(S.of(context).oral, mark.quiz1),
                _buildGradeChip(S.of(context).oral_2, mark.quiz2),
                _buildGradeChip(S.of(context).homework, mark.homework),
                _buildGradeChip(S.of(context).final_exam, mark.finalExam),
              ],
            ),
            const SizedBox(height: 12),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: color.withOpacity(0.3), width: 1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).final_grade,
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    '$total%',
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300, width: 0.5),
      ),
      child: Text(
        '$label: $val',
        style: const TextStyle(fontSize: 12, color: Colors.black87),
      ),
    );
  }
}
