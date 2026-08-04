import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/core/injection.dart' as di;
import 'package:school/core/widget/Loadingwidget.dart';
import 'package:school/features/Teacher/domain/Entities/TeacherProfileEntities/SubjectEntity.dart';
import 'package:school/features/Teacher/domain/Entities/TeacherProfileEntities/schoolsEntity.dart';
import 'package:school/features/Teacher/ui/bloc/TeacherBloc/teacher_bloc.dart';
import 'package:school/features/Teacher/ui/page/teacher_sections_screen.dart';
import 'package:school/generated/l10n.dart';

class TeacherSubjectsScreen extends StatefulWidget {
  const TeacherSubjectsScreen({super.key});

  @override
  State<TeacherSubjectsScreen> createState() => _TeacherSubjectsScreenState();
}

class _SubjectWithSchool {
  final Subjectentity subject;
  final Schoolsentity school;
  _SubjectWithSchool({required this.subject, required this.school});
}

class _TeacherSubjectsScreenState extends State<TeacherSubjectsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.sl<TeacherBloc>()..add(GetTeacherEvent()),
      child: BlocBuilder<TeacherBloc, TeacherState>(
        builder: (context, state) {
          if (state is TeacherLoading) {
            return const Loadingwidget();
          }
          if (state is TeacherLoaded) {
            final profile = state.profile;
            final teacher = profile.teacherInfo;
            final schools = profile.school ?? [];

            // استخلاص جميع المواد مع معلومات المدرسة
            List<_SubjectWithSchool> subjectsWithSchool = [];
            for (var school in schools) {
              for (var subject in school.subjects ?? []) {
                subjectsWithSchool.add(
                  _SubjectWithSchool(subject: subject, school: school),
                );
              }
            }

            return Scaffold(
              appBar: AppBar(
                title: Text(
                  teacher?.name ?? S.of(context).teacher_profile,
                  style: TextStyle(fontSize: 18.sp),
                ),
                centerTitle: true,
                automaticallyImplyLeading: false,
                elevation: 0,
              ),
              body: RefreshIndicator(
                onRefresh: () async {
                  context.read<TeacherBloc>().add(RefreshTeacherEvent());
                },
                color: Colors.transparent,
                backgroundColor: Colors.transparent,
                strokeWidth: 0,
                child: subjectsWithSchool.isEmpty
                    ? Center(
                        child: Text(
                          "S.of(context).no_subjects",
                          style: TextStyle(fontSize: 16.sp),
                        ),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.all(16.w),
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: subjectsWithSchool.length,
                        itemBuilder: (context, index) {
                          final item = subjectsWithSchool[index];
                          return _buildSubjectCard(context, item);
                        },
                      ),
              ),
            );
          }
          if (state is TeacherError) {
            return Center(
              child: Text(state.message, style: TextStyle(fontSize: 16.sp)),
            );
          }
          return const Loadingwidget();
        },
      ),
    );
  }

  Widget _buildSubjectCard(BuildContext context, _SubjectWithSchool item) {
    final theme = Theme.of(context);
    final subject = item.subject;
    final school = item.school;

    // ignore: unused_local_variable
    for (var grade in subject.grades) {}

    return Card(
      margin: EdgeInsets.only(bottom: 12.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  TeacherSectionsScreen(subject: subject, school: school),
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Row(
            children: [
              Container(
                width: 50.w,
                height: 50.w,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Center(
                  child: Text(
                    subject.subjectName?.isNotEmpty == true
                        ? subject.subjectName![0]
                        : 'م',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subject.subjectName ?? S.of(context).subject,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      school.schoolName ?? '',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: theme.colorScheme.primary),
            ],
          ),
        ),
      ),
    );
  }
}
