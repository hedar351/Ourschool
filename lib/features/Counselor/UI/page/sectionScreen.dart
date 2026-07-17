import 'package:flutter/material.dart';
import 'package:school/features/Counselor/UI/page/CounselorStudentsScreen.dart';
import 'package:school/features/Counselor/domain/Entities/gradeandSectionEntity/gradeEntity.dart';

// import 'package:school/features/Counselor/UI/page/StudentsListScreen.dart';

class Sectionscreen extends StatelessWidget {
  final Gradeentity grade;

  const Sectionscreen({super.key, required this.grade});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final sections = grade.sections;
    return Scaffold(
      appBar: AppBar(
        title: Text("${grade.name}"),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: sections?.length ?? 0,
        itemBuilder: (context, index) {
          final section = sections![index];

          return Hero(
            tag: 'section_${section.id}',
            child: Card(
              margin: const EdgeInsets.only(bottom: 16),
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  print("localGradeNumber: ${grade.localGradeNumber}");
                  print("localSectionNumber: ${section.localSectionNumber}");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CounselorStudentsScreen(
                        sectionName: section.name ?? "",
                        localGradeNumber: grade.localGradeNumber ?? 0,
                        localSectionNumber: section.localSectionNumber ?? 0,
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              theme.colorScheme.primary,
                              theme.colorScheme.primary.withOpacity(0.7),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.school_rounded,
                            size: 40,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              section.name ?? 'شعبة بدون اسم',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
