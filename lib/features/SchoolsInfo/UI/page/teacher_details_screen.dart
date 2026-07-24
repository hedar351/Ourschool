import 'package:flutter/material.dart';
import 'package:school/features/SchoolsInfo/UI/widget/teacher_details_widget.dart';
import 'package:school/features/SchoolsInfo/domain/Entities/TeacherInfoEntity.dart';
import 'package:school/generated/l10n.dart';

class TeacherDetailsScreen extends StatelessWidget {
  final TeacherInfoEntity teacher;
  final String schoolName;

  const TeacherDetailsScreen({
    super.key,
    required this.teacher,
    required this.schoolName,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).teacherDetails,
          style: TextStyle(color: theme.colorScheme.onSurface),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: theme.scaffoldBackgroundColor,
        foregroundColor: theme.colorScheme.onSurface,
        iconTheme: IconThemeData(color: theme.colorScheme.onSurface),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: TeacherDetailsWidget(teacher: teacher, schoolName: schoolName),
      ),
    );
  }
}
