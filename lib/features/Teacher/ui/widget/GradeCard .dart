import 'package:flutter/material.dart';
import 'package:school/features/Counselor/domain/Entities/gradeandSectionEntity/gradeEntity.dart';
import 'package:school/generated/l10n.dart';

class GradeCard extends StatelessWidget {
  final Gradeentity grade;
  final VoidCallback onTap;

  const GradeCard({super.key, required this.grade, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Hero(
      tag: 'grade_${grade.id}',
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
                    color:
                        theme.colorScheme.tertiary.withOpacity(0.1) ??
                        Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      (grade.name?.isNotEmpty == true) ? grade.name![0] : 'ص',
                      style: TextStyle(
                        color: theme.colorScheme.tertiary ?? Colors.blue,
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
                        grade.name ?? S.of(context).class_name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${grade.sections?.length ?? 0} ${S.of(context).Sections}',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: theme.colorScheme.tertiary ?? Colors.blue,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
