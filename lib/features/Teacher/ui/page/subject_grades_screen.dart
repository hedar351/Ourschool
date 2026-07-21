import 'package:flutter/material.dart';
import 'package:school/features/Teacher/domain/Entities/TeacherProfileEntities/SubjectEntity.dart';
import 'package:school/features/Teacher/ui/page/grade_sections_screen.dart';
import 'package:school/features/Teacher/ui/widget/GradeCard%20.dart';

class SubjectGradesScreen extends StatelessWidget {
  final Subjectentity subject;
  final String schoolName;

  const SubjectGradesScreen({
    super.key,
    required this.subject,
    required this.schoolName,
  });

  @override
  Widget build(BuildContext context) {
    final grades = subject.grades;
    return Scaffold(
      appBar: AppBar(
        title: Text('$schoolName - ${subject.subjectName}'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
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
