// lib/features/Teacher/ui/page/school_subjects_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/features/Teacher/domain/Entities/TeacherProfileEntities/schoolsEntity.dart';
import 'package:school/features/Teacher/ui/page/subject_grades_screen.dart';
import 'package:school/features/Teacher/ui/widget/TeacherSubjectCard%20.dart';

class SchoolSubjectsScreen extends StatelessWidget {
  final Schoolsentity school;
  final String schoolName;

  // ✅ حسابات القيم الثابتة خارج build
  final double listPadding = 16.w;

  SchoolSubjectsScreen({
    super.key,
    required this.school,
    required this.schoolName,
  });

  @override
  Widget build(BuildContext context) {
    final subjects = school.subjects ?? [];
    return Scaffold(
      appBar: AppBar(
        title: Text(schoolName, style: TextStyle(fontSize: 18.sp)),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(listPadding),
        itemCount: subjects.length,
        itemBuilder: (context, index) {
          final subject = subjects[index];
          return TeacherSubjectCard(
            subject: subject,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SubjectGradesScreen(
                    subject: subject,
                    schoolName: schoolName,
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
