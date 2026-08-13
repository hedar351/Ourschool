import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/features/FirstStep/SchoolsInfo/UI/page/teacher_details_screen.dart';
import 'package:school/features/FirstStep/SchoolsInfo/UI/widget/teacher_card_widget.dart';
import 'package:school/generated/l10n.dart';

import '../../domain/Entities/SchoolInfoEntity.dart';
import '../../domain/Entities/TeacherInfoEntity.dart';

class SchoolTeachersScreen extends StatelessWidget {
  final SchoolInfoEntity school;

  final double emptyIconSize = 80.w;

  final double emptyGap = 16.h;
  final double listPadding = 16.w;
  final double listItemGap = 12.h;
  SchoolTeachersScreen({super.key, required this.school});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final teachers = school.teacherInfo ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          school.name ?? '',
          style: TextStyle(color: theme.colorScheme.onSurface, fontSize: 18.sp),
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
            size: emptyIconSize,
            color: theme.colorScheme.outline,
          ),
          SizedBox(height: emptyGap),
          Text(
            S.of(context).noTeachers,
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onSurface,
              fontSize: 16.sp,
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
            padding: EdgeInsets.all(listPadding),
            itemCount: teachers.length,
            separatorBuilder: (_, _) => SizedBox(height: listItemGap),
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
