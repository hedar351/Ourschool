// lib/features/Teacher/ui/widgets/teacher_mark_card.dart

import 'package:flutter/material.dart';
import 'package:school/features/Teacher/domain/Entities/TeacherStudentProfile/SemesterMarks.dart';
import 'package:school/generated/l10n.dart';

class TeacherMarkCard extends StatelessWidget {
  final SemesterMarks mark;

  const TeacherMarkCard({super.key, required this.mark});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 0,
      color: isDark
          ? Colors.grey.shade800.withOpacity(0.3)
          : Colors.grey.shade50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(
          color: isDark
              ? Colors.grey.shade700.withOpacity(0.3)
              : Colors.grey.shade200,
          width: 0.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ====== اسم المادة ======
            Row(
              children: [
                Container(
                  width: 4,
                  height: 20,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  mark.subjectName ?? 'مادة غير معروفة',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const Spacer(),
                // ====== المجموع ======
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'AVG: ${mark.totle?.toStringAsFixed(0) ?? '0'}',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // ====== تفاصيل العلامات ======
            Row(
              children: [
                _buildMarkChip(
                  context,
                  label: S.of(context).oral,
                  value: mark.quiz1,
                ),
                const SizedBox(width: 8),
                _buildMarkChip(
                  context,
                  label: S.of(context).oral_2,
                  value: mark.quiz2,
                ),
                const SizedBox(width: 8),
                _buildMarkChip(
                  context,
                  label: S.of(context).homework,
                  value: mark.homework,
                ),
                const SizedBox(width: 8),
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
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withOpacity(0.06),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: theme.colorScheme.primary.withOpacity(0.1),
          width: 0.3,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$label: ',
            style: TextStyle(fontSize: 11, color: theme.colorScheme.outline),
          ),
          Text(
            value?.toStringAsFixed(0) ?? '0',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
