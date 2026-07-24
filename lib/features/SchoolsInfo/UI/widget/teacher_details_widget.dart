// lib/features/SchoolsInfo/presentation/widgets/teacher_details_widget.dart

import 'package:flutter/material.dart';
import 'package:school/features/SchoolsInfo/domain/Entities/TeacherInfoEntity.dart';
import 'package:school/generated/l10n.dart';

class TeacherDetailsWidget extends StatelessWidget {
  final TeacherInfoEntity teacher;
  final String schoolName;

  const TeacherDetailsWidget({
    super.key,
    required this.teacher,
    required this.schoolName,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final sections = teacher.sections ?? [];
    final subjects = teacher.subjects ?? [];
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      children: [
        // ====== بطاقة الملف الشخصي ======
        Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // ====== الصورة الرمزية ======
                Container(
                  width: 100,
                  height: 100,
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
                    child: Text(
                      teacher.name?.isNotEmpty == true
                          ? teacher.name![0].toUpperCase()
                          : '?',
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // ====== الاسم ======
                Text(
                  teacher.name ?? 'معلم غير معروف',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),

                // ====== المدرسة ======
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.school,
                        size: 16,
                        color: theme.colorScheme.primary,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        schoolName,
                        style: TextStyle(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // ====== أزرار التواصل ======
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildContactButton(
                      context,
                      icon: Icons.phone_outlined,
                      label: S.of(context).call,
                      onTap: () {},
                    ),
                  ],
                ),

                const SizedBox(height: 16),
                Divider(color: theme.dividerColor),
                const SizedBox(height: 16),

                // ====== معلومات التواصل ======
                Row(
                  children: [
                    Expanded(
                      child: _buildInfoItem(
                        context,
                        label: S.of(context).fullName,
                        value: teacher.name ?? 'غير معروف',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildInfoItem(
                        context,
                        label: S.of(context).phone,
                        value: teacher.phone ?? 'غير متوفر',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 24),

        // ====== الفصول الدراسية ======
        if (sections.isNotEmpty) ...[
          _buildSectionHeader(
            context,
            title: S.of(context).classesTaught,
            icon: Icons.class_outlined,
            color: Colors.green,
          ),
          const SizedBox(height: 12),
          ...sections.map(
            (section) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.grey.shade800.withOpacity(0.3)
                    : Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDark
                      ? Colors.grey.shade700.withOpacity(0.3)
                      : Colors.grey.shade200,
                  width: 0.5,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.class_outlined,
                    size: 20,
                    color: Colors.green.shade600,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '${section.gradeName ?? ''} - ${section.sectionName ?? ''}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],

        // ====== المواد التي يدرسها ======
        if (subjects.isNotEmpty) ...[
          _buildSectionHeader(
            context,
            title: S.of(context).subjectsTaught,
            icon: Icons.book,
            color: Colors.blue,
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,

            children: subjects.map((subject) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      theme.colorScheme.primary.withOpacity(
                        isDark ? 0.3 : 0.12,
                      ),
                      theme.colorScheme.primary.withOpacity(
                        isDark ? 0.15 : 0.05,
                      ),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: theme.colorScheme.primary.withOpacity(
                      isDark ? 0.3 : 0.15,
                    ),
                    width: 0.5,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.menu_book,
                      size: 18,
                      color: isDark
                          ? theme.colorScheme.primary.withOpacity(0.9)
                          : theme.colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      subject.subjectName ?? 'مادة غير معروفة',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: isDark
                            ? theme.colorScheme.primary.withOpacity(0.9)
                            : theme.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ],
    );
  }

  Widget _buildContactButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: theme.colorScheme.primary.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: theme.colorScheme.primary.withOpacity(0.2),
            width: 0.5,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, size: 18, color: theme.colorScheme.primary),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(
    BuildContext context, {
    required String label,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey.shade500,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
  }) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 24,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 12),
        Icon(icon, color: color, size: 22),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
