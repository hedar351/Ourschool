import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/core/widget/Loadingwidget.dart';
import 'package:school/core/widget/SnackBar/Message.dart';
import 'package:school/features/Counselor/domain/Entities/StudentsProfileEntity/Counselor_WarningsEntity.dart';
import 'package:school/features/Counselor/domain/Entities/attendanceEntity/attendanceEntity.dart';
import 'package:school/features/Student/domain/entity/Student-FullProfile/StudentFullProfileEntity.dart';
import 'package:school/features/Student/domain/entity/Student-FullProfile/SummonsEntity.dart';
import 'package:school/features/Student/ui/bloc/student_bloc.dart';
import 'package:school/features/Student/ui/dialogs/attendance_dialog.dart';
import 'package:school/features/Student/ui/dialogs/summons_dialog.dart';
import 'package:school/features/Student/ui/dialogs/warnings_dialog.dart';
import 'package:school/features/Student/ui/widget/academic_info_card.dart';
import 'package:school/features/Student/ui/widget/empty_error_widgets.dart';
import 'package:school/features/Student/ui/widget/exam_marks_card.dart';
import 'package:school/features/Student/ui/widget/quick_stats_row.dart';
import 'package:school/features/Student/ui/widget/schedule_image_card.dart';
import 'package:school/generated/l10n.dart';

class AcademicRecordScreen extends StatefulWidget {
  const AcademicRecordScreen({super.key});

  @override
  State<AcademicRecordScreen> createState() => _AcademicRecordScreenState();
}

class _AcademicRecordScreenState extends State<AcademicRecordScreen> {
  @override
  Widget build(BuildContext context) {
    return
    // Scaffold(
    //   backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    //   body:
    BlocConsumer<StudentBloc, StudentState>(
      listener: (context, state) {
        if (state is StudentError) {
          SnackBarMessage().errorMessage(
            message: state.message,
            context: context,
          );
        }
      },
      builder: (context, state) {
        if (state is StudentLoading) return const Loadingwidget();
        if (state is StudentLoaded) {
          if (state.profile.isEmpty) {
            return buildEmptyState(context);
          }
          return _buildContent(context, state.profile.first);
        }
        if (state is StudentError) {
          return buildErrorState(context, state.message);
        }
        return const Loadingwidget();
      },
      // ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<StudentBloc>().add(GetStudentProfileEvent());
    });
  }

  Widget _buildContent(BuildContext context, Studentfullprofileentity profile) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final studentInfo = profile.studentInfo!;
    final statistics = profile.statistics!;
    final semesterMarks1 = profile.semesterMarks1 ?? [];
    final semesterMarks2 = profile.semesterMark2 ?? [];
    final attendances = profile.attendance ?? [];
    final warnings = profile.warnings ?? [];
    final summons = profile.summons ?? [];
    final scheduleImage = profile.scheduleImage;

    return RefreshIndicator(
      onRefresh: () async {
        context.read<StudentBloc>().add(RefreshStudentProfileEvent());
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            // AppBar
            SliverAppBar(
              automaticallyImplyLeading: false,
              expandedHeight: 200.h,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        colorScheme.primary,
                        colorScheme.primaryContainer,
                      ],
                    ),
                  ),
                  child: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 12.h),
                        Text(
                          studentInfo.name ?? S.of(context).unknown_name,
                          style: theme.textTheme.headlineMedium?.copyWith(
                            color: colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 22.sp,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          '${studentInfo.gradeName ?? ''} - ${studentInfo.sectionName ?? ''}',
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: colorScheme.onPrimary.withOpacity(0.9),
                            fontSize: 16.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Content
            SliverPadding(
              padding: EdgeInsets.all(16.w),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  AcademicInfoCard(studentInfo: studentInfo),
                  SizedBox(height: 16.h),

                  QuickStatsRow(
                    statistics: statistics,
                    warningsCount: warnings.length,
                    summonsCount: summons.length,
                    onAttendanceTap: () =>
                        _showAttendanceDetails(context, attendances),
                    onWarningsTap: () =>
                        _showWarningsDetails(context, warnings),
                    onSummonsTap: () => _showSummonsDetails(context, summons),
                  ),
                  SizedBox(height: 16.h),

                  ExamMarksCard(
                    semesterMarks1: semesterMarks1,
                    semesterMarks2: semesterMarks2,
                  ),
                  SizedBox(height: 16.h),

                  if (scheduleImage != null && scheduleImage.isNotEmpty)
                    ScheduleImageCard(imageUrl: scheduleImage),

                  SizedBox(height: 80.h),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---- Dialogs ----
  void _showAttendanceDetails(
    BuildContext context,
    List<AttendanceEntity> attendances,
  ) {
    showDialog(
      context: context,
      builder: (ctx) => AttendanceDialog(attendances: attendances),
    );
  }

  void _showSummonsDetails(BuildContext context, List<SummonsEntity> summons) {
    showDialog(
      context: context,
      builder: (ctx) => SummonsDialog(summons: summons),
    );
  }

  void _showWarningsDetails(
    BuildContext context,
    List<CounselorWarningsentity> warnings,
  ) {
    showDialog(
      context: context,
      builder: (ctx) => WarningsDialog(warnings: warnings),
    );
  }
}
