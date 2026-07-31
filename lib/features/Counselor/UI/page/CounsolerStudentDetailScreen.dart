// lib/features/Counselor/UI/page/CounsolerStudentDetailScreen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/core/injection.dart' as di;
import 'package:school/core/widget/Loadingwidget.dart';
import 'package:school/features/Counselor/UI/bloc/PostWarnings/post_warnings_bloc.dart';
import 'package:school/features/Counselor/UI/bloc/PostWarnings/post_warnings_state.dart';
import 'package:school/features/Counselor/UI/bloc/Studentprofile/student_profile_bloc.dart';
import 'package:school/features/Counselor/UI/bloc/attendance/attendance_bloc.dart';
import 'package:school/features/Counselor/UI/widget/MarkCard.dart';
import 'package:school/features/Counselor/UI/widget/ShowDialog/ShowAttendanceDialog.dart';
import 'package:school/features/Counselor/UI/widget/ShowDialog/showAddAttendanceDialog.dart';
import 'package:school/features/Counselor/UI/widget/ShowDialog/showAddWarningDialog.dart';
import 'package:school/features/Counselor/UI/widget/ShowDialog/show_subjects_dialog.dart';
import 'package:school/features/Counselor/UI/widget/ShowDialog/show_warnings_dialog.dart';
import 'package:school/features/Counselor/UI/widget/StudentInfoCard.dart';
import 'package:school/features/Counselor/UI/widget/section_card_widget.dart';
import 'package:school/features/Counselor/domain/Entities/StudentsProfileEntity/Counselor_MarkEntity.dart';
import 'package:school/features/Counselor/domain/Entities/StudentsProfileEntity/Counselor_studentFullProfile.dart';
import 'package:school/generated/l10n.dart';

class CounsolerStudentDetailScreen extends StatefulWidget {
  final int localStudentNumber;

  const CounsolerStudentDetailScreen({
    super.key,
    required this.localStudentNumber,
  });

  @override
  State<CounsolerStudentDetailScreen> createState() =>
      _CounsolerStudentDetailScreenState();
}

class _CounsolerStudentDetailScreenState
    extends State<CounsolerStudentDetailScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _loaded = false;

  // ✅ حسابات القيم الثابتة خارج build
  final double _contentPadding = 16.w;
  final double _gapLarge = 24.h;
  final double _gapMedium = 16.h;
  final double _gapSmall = 12.h;
  final double _elevation = 6;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<StudentProfileBloc>()),
        BlocProvider(create: (_) => di.sl<PostWarningBloc>()),
        BlocProvider(create: (_) => di.sl<AttendanceBloc>()),
      ],
      child: BlocListener<PostWarningBloc, PostWarningState>(
        listener: (context, state) {
          if (state is PostWarningSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.warning.reason!),
                backgroundColor: Colors.green,
              ),
            );
          }
          if (state is PostWarningError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocListener<AttendanceBloc, AttendanceState>(
          listener: (context, state) {
            if (state is AttendanceSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.green,
                ),
              );
            }
            if (state is AttendanceError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: BlocConsumer<StudentProfileBloc, StudentProfileState>(
            listener: (context, state) {
              if (state is StudentProfileLoaded) {
                _controller.forward();
              }
            },
            builder: (context, state) {
              if (!_loaded && state is StudentProfileInitial) {
                _loaded = true;
                context.read<StudentProfileBloc>().add(
                  GetStudentProfileEvent(
                    localStudentNumber: widget.localStudentNumber,
                  ),
                );
              }

              if (state is StudentProfileLoading) {
                return const Loadingwidget();
              }

              if (state is StudentProfileLoaded) {
                return _buildProfileContent(
                  context,
                  state.profile,
                  state.isRevalidating,
                );
              }

              if (state is StudentProfileError) {
                return _buildErrorState(context, state.message);
              }

              return const Loadingwidget();
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 80.w, color: Colors.red.shade300),
          SizedBox(height: 16.h),
          Text(
            message,
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontSize: 16.sp),
          ),
          SizedBox(height: 8.h),
          TextButton.icon(
            onPressed: () {
              context.read<StudentProfileBloc>().add(
                RefreshStudentProfileEvent(
                  localStudentNumber: widget.localStudentNumber,
                ),
              );
            },
            icon: Icon(Icons.refresh, size: 20.w),
            label: Text('إعادة المحاولة', style: TextStyle(fontSize: 14.sp)),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileContent(
    BuildContext context,
    CounselorStudentfullprofile profile,
    bool isRevalidating,
  ) {
    final theme = Theme.of(context);
    final student = profile.studententity;
    final subjects = profile.subjectsentity ?? [];
    final marks = profile.makrentity;
    final warnings = profile.warningsentity ?? [];
    final attendance = profile.attendance ?? [];

    List<Widget> marksWidgets = [];
    if (marks != null && marks.isNotEmpty) {
      final marksBySemester = <int, List<CounselorMarkentity>>{};
      for (var mark in marks) {
        final semester = mark.semester ?? 0;
        marksBySemester.putIfAbsent(semester, () => []).add(mark);
      }

      for (final entry in marksBySemester.entries) {
        final semester = entry.key;
        final semesterMarks = entry.value;

        final semesterTitle = switch (semester) {
          1 => S.of(context).semester_1,
          2 => S.of(context).semester_2,
          _ => '${S.of(context).semester} $semester',
        };

        marksWidgets.add(
          Padding(
            padding: EdgeInsets.only(top: 8.h, bottom: 8.h),
            child: Row(
              children: [
                Icon(
                  Icons.bookmark,
                  color: theme.colorScheme.primary,
                  size: 22.w,
                ),
                SizedBox(width: 8.w),
                Text(
                  semesterTitle,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                    fontSize: 16.sp,
                  ),
                ),
              ],
            ),
          ),
        );
        marksWidgets.addAll(semesterMarks.map((m) => MarkCard(mark: m)));
        marksWidgets.add(SizedBox(height: 8.h));
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(student?.name ?? S.of(context).unknown_name),
        centerTitle: true,
        elevation: 0,
      ),
      body: Stack(
        children: [
          SafeArea(
            child: RefreshIndicator(
              onRefresh: () async => _onRefresh(context),
              child: SingleChildScrollView(
                padding: EdgeInsets.all(_contentPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StudentInfoCard(student: student),
                    SizedBox(height: _gapLarge),

                    // ====== بطاقة الغيابات ======
                    Row(
                      children: [
                        Expanded(
                          child: SectionCard(
                            icon: Icons.event_available,
                            title: S.of(context).Attendance,
                            count: attendance.length,
                            onTap: () => showAttendanceDialog(
                              context,
                              attendance,
                              student,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.add_circle,
                            color: Colors.red,
                            size: 24.w,
                          ),
                          onPressed: () => showAddAttendanceDialog(
                            context,
                            student?.localStudentNumber,
                          ),
                          tooltip: 'إضافة غياب',
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(
                            minWidth: 36.w,
                            minHeight: 36.h,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: _gapMedium),

                    // ====== بطاقة المواد ======
                    SectionCard(
                      icon: Icons.book,
                      title: S.of(context).subjects_title.trim(),
                      count: subjects.length,
                      onTap: () => showSubjectsDialog(context, subjects),
                    ),
                    SizedBox(height: _gapMedium),

                    // ====== بطاقة الإنذارات ======
                    Row(
                      children: [
                        Expanded(
                          child: SectionCard(
                            icon: Icons.warning_amber,
                            title: S.of(context).warnings_title.trim(),
                            count: warnings.length,
                            onTap: () => showWarningsDialog(context, warnings),
                            iconBackgroundColor: Colors.red,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.add_circle,
                            color: Colors.red,
                            size: 24.w,
                          ),
                          onPressed: () =>
                              showAddWarningDialog(context, student),
                          tooltip: 'إضافة إنذار',
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(
                            minWidth: 36.w,
                            minHeight: 36.h,
                          ),
                        ),
                      ],
                    ),

                    // ====== العلامات ======
                    SizedBox(height: _gapMedium),
                    Row(
                      children: [
                        Icon(
                          Icons.bar_chart,
                          color: theme.colorScheme.primary,
                          size: 22.w,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          S.of(context).marks_title,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                            fontSize: 16.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: _gapSmall),
                    if (marks != null && marks.isNotEmpty)
                      ...marksWidgets
                    else
                      Text(
                        S.of(context).There_are_no_Marks_at_the_moment,
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontSize: 14.sp,
                        ),
                      ),
                    SizedBox(height: _gapLarge),
                  ],
                ),
              ),
            ),
          ),
          if (isRevalidating)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: LinearProgressIndicator(
                backgroundColor: Colors.transparent,
                color: Colors.blue,
                minHeight: 3.h,
              ),
            ),
        ],
      ),
    );
  }

  void _onRefresh(BuildContext context) {
    context.read<StudentProfileBloc>().add(
      RefreshStudentProfileEvent(localStudentNumber: widget.localStudentNumber),
    );
  }
}
