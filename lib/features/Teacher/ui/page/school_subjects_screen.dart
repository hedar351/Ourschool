import 'package:flutter/material.dart';
import 'package:school/features/Teacher/domain/Entities/TeacherProfileEntities/schoolsEntity.dart';
import 'package:school/features/Teacher/ui/page/subject_grades_screen.dart';
import 'package:school/features/Teacher/ui/widget/TeacherSubjectCard%20.dart';

class SchoolSubjectsScreen extends StatelessWidget {
  final Schoolsentity school;
  final String schoolName;

  const SchoolSubjectsScreen({
    super.key,
    required this.school,
    required this.schoolName,
  });

  @override
  Widget build(BuildContext context) {
    final subjects = school.subjects ?? [];
    return Scaffold(
      appBar: AppBar(title: Text(schoolName), centerTitle: true),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
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
