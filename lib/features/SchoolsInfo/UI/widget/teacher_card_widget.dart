import 'package:flutter/material.dart';

import '../../domain/Entities/TeacherInfoEntity.dart';

class TeacherCardWidget extends StatelessWidget {
  final TeacherInfoEntity teacher;
  final VoidCallback? onTap;

  const TeacherCardWidget({super.key, required this.teacher, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // final sections = teacher.sections ?? [];
    final subjects = teacher.subjects ?? [];
    final isDark = theme.brightness == Brightness.dark;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        splashColor: theme.colorScheme.primary.withOpacity(0.1),
        highlightColor: theme.colorScheme.primary.withOpacity(0.05),

        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark
                ? theme.colorScheme.surface.withOpacity(0.3)
                : theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isDark
                  ? theme.colorScheme.outline.withOpacity(0.3)
                  : theme.colorScheme.outline.withOpacity(0.15),
              width: 0.5,
            ),
          ),
          child: Row(
            children: [
              // ====== الصورة الرمزية ======
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      theme.colorScheme.primary,
                      theme.colorScheme.primary.withOpacity(0.6),
                    ],
                  ),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(Icons.person, color: theme.colorScheme.onPrimary),
                ),
              ),
              const SizedBox(width: 16),

              // ====== معلومات المعلم ======
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      teacher.name ?? 'معلم غير معروف',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 6),

                    // ====== المواد ======
                    if (subjects.isNotEmpty) ...[
                      Wrap(
                        spacing: 6,
                        runSpacing: 4,
                        children: subjects.map((subject) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary.withOpacity(
                                isDark ? 0.2 : 0.12,
                              ),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: theme.colorScheme.primary.withOpacity(
                                  isDark ? 0.3 : 0.15,
                                ),
                                width: 0.5,
                              ),
                            ),
                            child: Text(
                              subject.subjectName ?? '',
                              style: TextStyle(
                                fontSize: 11,
                                color: isDark
                                    ? theme.colorScheme.primary.withOpacity(0.9)
                                    : theme.colorScheme.primary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 4),
                    ],

                    // ====== الشعب ======
                  ],
                ),
              ),

              // ====== أيقونة السهم ======
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.08),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.chevron_right,
                  color: theme.colorScheme.primary,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
