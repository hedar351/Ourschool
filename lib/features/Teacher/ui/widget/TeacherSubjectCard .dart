import 'package:flutter/material.dart';
import 'package:school/features/Teacher/domain/Entities/TeacherProfileEntities/SubjectEntity.dart';
import 'package:school/generated/l10n.dart';

class TeacherSubjectCard extends StatelessWidget {
  final Subjectentity? subject;
  final VoidCallback onTap;

  const TeacherSubjectCard({
    super.key,
    required this.subject,
    required this.onTap,
  });

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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        theme.colorScheme.secondary,
                        theme.colorScheme.secondary.withOpacity(0.6),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      firstLetter,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        subject?.subjectName ?? S.of(context).subject,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${subject?.grades.length ?? 0} ${S.of(context).classes}',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: theme.colorScheme.secondary),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
