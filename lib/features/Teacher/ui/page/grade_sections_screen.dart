// lib/features/Teacher/ui/page/grade_sections_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

  // ✅ حسابات القيم الثابتة خارج build
  final double listPadding = 16.w;

  GradeSectionsScreen({
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
        title: Text(
          '$schoolName - ${grade.name}',
          style: TextStyle(fontSize: 18.sp),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(listPadding),
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
