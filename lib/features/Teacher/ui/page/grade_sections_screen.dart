import 'package:flutter/material.dart';
import 'package:school/features/Counselor/domain/Entities/gradeandSectionEntity/gradeEntity.dart';
import 'package:school/features/Teacher/domain/Entities/TeacherProfileEntities/SubjectEntity.dart';
import 'package:school/features/Teacher/domain/Entities/TeacherProfileEntities/schoolsEntity.dart';
import 'package:school/features/Teacher/ui/widget/buildSectionCard.dart';

class GradeSectionsScreen extends StatelessWidget {
  final Gradeentity grade;
  final String schoolName;
  final String subjectName;
  final Subjectentity subjectEntity;
  final Schoolsentity school;
  const GradeSectionsScreen({
    super.key,
    required this.grade,
    required this.schoolName,
    required this.subjectName,
    required this.subjectEntity,
    required this.school,
  });

  @override
  Widget build(BuildContext context) {
    final sections = grade.sections ?? [];
    return Scaffold(
      appBar: AppBar(
        title: Text('$schoolName - ${grade.name}'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: sections.length,
        itemBuilder: (context, index) {
          final section = sections[index];
          return buildSectionCard(
            context: context,
            section: section,
            grade: grade,
            localSubjectId: subjectEntity.localSubjectId ?? 0,
            subjectName: subjectEntity.subjectName ?? '',
            school: school,
          );
        },
      ),
    );
  }
}
