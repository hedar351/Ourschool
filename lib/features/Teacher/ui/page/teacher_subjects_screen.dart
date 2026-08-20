import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    return BlocBuilder<TeacherBloc, TeacherState>(
      builder: (context, state) {
        if (state is TeacherLoading) {
          return const Loadingwidget();
        }

        if (state is TeacherLoaded) {
          final profile = state.profile;
          final teacher = profile.teacherInfo;
          final schools = profile.school ?? [];

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
              color: Theme.of(context).colorScheme.primary,
              child: subjectsWithSchool.isEmpty
                  ? _buildEmptyState(context)
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
          return _buildErrorState(context, state.message);
        }

        return const Loadingwidget();
      },
    );
  }

  // ============================================================
  // ====== حالة عدم وجود بيانات ======
  // ============================================================

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.school_outlined,
                size: 64.w,
                color: theme.colorScheme.primary.withOpacity(0.6),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              S.of(context).no_subjects_available,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              S.of(context).no_subjects_description,
              style: TextStyle(fontSize: 14.sp, color: theme.hintColor),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),
            OutlinedButton.icon(
              onPressed: () {
                context.read<TeacherBloc>().add(RefreshTeacherEvent());
              },
              icon: Icon(Icons.refresh_rounded, size: 18.w),
              label: Text(S.of(context).retry),
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // ====== حالة الخطأ ======
  // ============================================================

  Widget _buildErrorState(BuildContext context, String message) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.wifi_off_rounded,
              size: 64.w,
              color: theme.colorScheme.error.withOpacity(0.6),
            ),
            SizedBox(height: 16.h),
            Text(
              message,
              style: TextStyle(
                fontSize: 16.sp,
                color: theme.colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),
            ElevatedButton.icon(
              onPressed: () {
                context.read<TeacherBloc>().add(RefreshTeacherEvent());
              },
              icon: Icon(Icons.refresh_rounded, size: 18.w),
              label: Text(S.of(context).retry),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // ====== بطاقة المادة ======
  // ============================================================

  Widget _buildSubjectCard(BuildContext context, _SubjectWithSchool item) {
    final theme = Theme.of(context);
    final subject = item.subject;
    final school = item.school;

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
