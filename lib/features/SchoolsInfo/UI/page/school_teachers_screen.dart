import 'package:flutter/material.dart';
import 'package:school/features/SchoolsInfo/UI/page/teacher_details_screen.dart';
import 'package:school/features/SchoolsInfo/UI/widget/teacher_card_widget.dart';
import 'package:school/generated/l10n.dart';

import '../../domain/Entities/SchoolInfoEntity.dart';
import '../../domain/Entities/TeacherInfoEntity.dart';

class SchoolTeachersScreen extends StatelessWidget {
  final SchoolInfoEntity school;

  const SchoolTeachersScreen({super.key, required this.school});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final teachers = school.teacherInfo ?? [];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          school.name ?? '',
          style: TextStyle(color: theme.colorScheme.onSurface),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: theme.scaffoldBackgroundColor,
        foregroundColor: theme.colorScheme.onSurface,
        iconTheme: IconThemeData(color: theme.colorScheme.onSurface),
      ),
      body: teachers.isEmpty
          ? _buildEmptyState(context)
          : _buildTeachersList(context, teachers),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.person_off_outlined,
            size: 80,
            color: theme.colorScheme.outline,
          ),
          const SizedBox(height: 16),
          Text(
            S.of(context).noTeachers,
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeachersList(
    BuildContext context,
    List<TeacherInfoEntity> teachers,
  ) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: teachers.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final teacher = teachers[index];
              return TeacherCardWidget(
                teacher: teacher,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TeacherDetailsScreen(
                        teacher: teacher,
                        schoolName: school.name ?? '',
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
