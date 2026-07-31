// lib/features/Counselor/UI/page/sectionScreen.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/features/Counselor/UI/page/CounselorStudentsScreen.dart';
import 'package:school/features/Counselor/domain/Entities/gradeandSectionEntity/gradeEntity.dart';

class Sectionscreen extends StatelessWidget {
  final Gradeentity grade;

  // ✅ حسابات القيم الثابتة خارج build
  final double listPadding = 16.w;

  final double cardMarginBottom = 16.h;
  final double cardPadding = 16.w;
  final double containerSize = 60.w;
  final double containerRadius = 16.r;
  final double iconSize = 40.w;
  final double titleFontSize = 18.sp;
  final double arrowPadding = 8.w;
  final double arrowSize = 16.w;
  final double arrowRadius = 12.r;
  final double gap = 16.w;
  Sectionscreen({super.key, required this.grade});

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
        padding: EdgeInsets.all(listPadding),
        itemCount: sections?.length ?? 0,
        itemBuilder: (context, index) {
          final section = sections![index];

          return Hero(
            tag: 'section_${section.id}',
            child: Card(
              margin: EdgeInsets.only(bottom: cardMarginBottom),
              child: InkWell(
                borderRadius: BorderRadius.circular(20.r),
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
                  padding: EdgeInsets.all(cardPadding),
                  child: Row(
                    children: [
                      Container(
                        width: containerSize,
                        height: containerSize,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              theme.colorScheme.primary,
                              theme.colorScheme.primary.withOpacity(0.7),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(containerRadius),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.school_rounded,
                            size: iconSize,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                      ),
                      SizedBox(width: gap),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              section.name ?? 'شعبة بدون اسم',
                              style: TextStyle(
                                fontSize: titleFontSize,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4.h),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(arrowPadding),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(arrowRadius),
                        ),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: arrowSize,
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
