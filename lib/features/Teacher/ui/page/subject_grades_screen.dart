// lib/features/Teacher/ui/page/subject_grades_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/features/Teacher/domain/Entities/TeacherProfileEntities/SubjectEntity.dart';
import 'package:school/features/Teacher/domain/Entities/TeacherProfileEntities/schoolsEntity.dart';
import 'package:school/features/Teacher/ui/page/grade_sections_screen.dart';
import 'package:school/features/Teacher/ui/widget/GradeCard%20.dart';

class SubjectGradesScreen extends StatelessWidget {
  final Subjectentity subject;
  final String schoolName;
  final Schoolsentity school;

  // ✅ حسابات القيم الثابتة خارج build
  final double listPadding = 16.w;

  SubjectGradesScreen({
    super.key,
    required this.subject,
    required this.schoolName,
    required this.school,
  });

  @override
  Widget build(BuildContext context) {
    final grades = subject.grades;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '$schoolName - ${subject.subjectName}',
          style: TextStyle(fontSize: 18.sp),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(listPadding),
        itemCount: grades.length,
        itemBuilder: (context, index) {
          final grade = grades[index];
          return GradeCard(
            grade: grade,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => GradeSectionsScreen(
                    grade: grade,
                    schoolName: schoolName,
                    subjectName: subject.subjectName ?? '',
                    subjectEntity: subject,
                    school: school,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
