import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/core/widget/Loadingwidget.dart';
import 'package:school/core/widget/SnackBar/Message.dart';
import 'package:school/features/Counselor/domain/Entities/StudentsProfileEntity/Counselor_WarningsEntity.dart';
import 'package:school/features/Counselor/domain/Entities/attendanceEntity/attendanceEntity.dart';
import 'package:school/features/Student/domain/entity/Student-FullProfile/StudentFullProfileEntity.dart';
import 'package:school/features/Student/domain/entity/Student-FullProfile/SummonsEntity.dart';
import 'package:school/features/Student/ui/ProfileScreen/dialogs/animated_dialog.dart';
import 'package:school/features/Student/ui/ProfileScreen/dialogs/attendance_dialog.dart';
import 'package:school/features/Student/ui/ProfileScreen/dialogs/summons_dialog.dart';
import 'package:school/features/Student/ui/ProfileScreen/dialogs/warnings_dialog.dart';
import 'package:school/features/Student/ui/ProfileScreen/widget/academic_info_card.dart';
import 'package:school/features/Student/ui/ProfileScreen/widget/activities_section.dart';
import 'package:school/features/Student/ui/ProfileScreen/widget/animated_section.dart';
import 'package:school/features/Student/ui/ProfileScreen/widget/exam_marks_card.dart';
import 'package:school/features/Student/ui/ProfileScreen/widget/loans_section.dart';
import 'package:school/features/Student/ui/ProfileScreen/widget/quick_stats_row.dart';
import 'package:school/features/Student/ui/ProfileScreen/widget/schedule_image_card.dart';
import 'package:school/features/Student/ui/ProfileScreen/widget/statistics_summary_card.dart';
import 'package:school/features/Student/ui/bloc/ProfileBloc/student_bloc.dart';
import 'package:school/generated/l10n.dart';

class AcademicRecordScreen extends StatefulWidget {
  const AcademicRecordScreen({super.key});

  @override
  State<AcademicRecordScreen> createState() => _AcademicRecordScreenState();
}

class _AcademicRecordScreenState extends State<AcademicRecordScreen>
    with
        WidgetsBindingObserver,
        TickerProviderStateMixin,
        AutomaticKeepAliveClientMixin
// AutoRefreshMixin<AcademicRecordScreen>
{
  late SnackBarMessage snackBarMessage;

  late AnimationController _mainAnimController;
  late List<Animation<double>> _fadeAnimations;
  late List<Animation<Offset>> _slideAnimations;
  late List<Animation<double>> _scaleAnimations;

  final int _totalSections = 8;
  final double _iconSize = 80.w;
  final double _gapSmall = 16.h;
  final double _gapMedium = 8.h;

  // @override
  // int get refreshInterval => 400;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: BlocConsumer<StudentBloc, StudentState>(
        listener: (context, state) {
          if (state is StudentError) {
            snackBarMessage.errorMessage(
              message: state.message,
              context: context,
            );
          }
        },
        builder: (context, state) {
          if (state is StudentLoading) {
            return const Loadingwidget();
          }
          if (state is StudentLoaded) {
            if (state.profile.isEmpty) {
              return _buildEmptyState(context);
            }
            return _buildLoadedState(context, state);
          }
          if (state is StudentError) {
            return _buildErrorState(context, state.message);
          }
          return const Loadingwidget();
        },
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _loadData();
    }
  }

  @override
  void dispose() {
    _mainAnimController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    snackBarMessage = SnackBarMessage();
    _initAnimations();
    _loadData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // restartAutoRefresh();
    });
  }

  // @override
  // Future<void> onAutoRefresh() async {
  //   print('🔄 [AutoRefresh] تحديث ملف الطالب تلقائياً...');
  //   if (mounted) {
  //     context.read<StudentBloc>().add(RefreshStudentProfileEvent());
  //   }
  // }

  Widget _buildContent(BuildContext context, Studentfullprofileentity profile) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final studentInfo = profile.studentInfo!;
    final statistics = profile.statistics;
    final marksStatistics = profile.marksstatistics;
    final semesterMarks1 = profile.semesterMarks1 ?? [];
    final semesterMarks2 = profile.semesterMark2 ?? [];
    final attendances = profile.attendance ?? [];
    final warnings = profile.warnings ?? [];
    final summons = profile.summons ?? [];
    final scheduleImage = profile.scheduleImage;
    final loans = profile.loans ?? [];
    final activities = profile.activities ?? [];

    return CustomScrollView(
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
                  colors: [colorScheme.primary, colorScheme.primaryContainer],
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

                    // SizedBox(height: 4.h),
                    // Text(
                    //   'رقم الطالب: ${studentInfo.localStudentNumber ?? 'غير محدد'}',
                    //   style: theme.textTheme.bodySmall?.copyWith(
                    //     color: colorScheme.onPrimary.withOpacity(0.7),
                    //     fontSize: 12.sp,
                    //   ),
                    // ),
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
              // 1. المعلومات الأساسية
              AnimatedSection(
                fadeAnim: _fadeAnimations[0],
                slideAnim: _slideAnimations[0],
                scaleAnim: _scaleAnimations[0],
                child: AcademicInfoCard(studentInfo: studentInfo),
              ),
              SizedBox(height: 16.h),

              AnimatedSection(
                fadeAnim: _fadeAnimations[1],
                slideAnim: _slideAnimations[1],
                scaleAnim: _scaleAnimations[1],
                child: QuickStatsRow(
                  statistics: statistics,
                  warningsCount: warnings.length,
                  summonsCount: summons.length,
                  onAttendanceTap: () =>
                      _showAttendanceDetails(context, attendances),
                  onWarningsTap: () => _showWarningsDetails(context, warnings),
                  onSummonsTap: () => _showSummonsDetails(context, summons),
                ),
              ),
              SizedBox(height: 16.h),

              // 3. إحصائيات العلامات
              AnimatedSection(
                fadeAnim: _fadeAnimations[2],
                slideAnim: _slideAnimations[2],
                scaleAnim: _scaleAnimations[2],
                child: StatisticsSummaryCard(
                  marksStatistics: marksStatistics,
                  statistics: statistics,
                  semester1Average: profile.semester1Average ?? 0,
                  semester2Average: profile.semester2Average ?? 0,
                  finalAverage: profile.finalAverage ?? 0,
                ),
              ),
              SizedBox(height: 16.h),

              // 4. علامات الفصول
              AnimatedSection(
                fadeAnim: _fadeAnimations[3],
                slideAnim: _slideAnimations[3],
                scaleAnim: _scaleAnimations[3],
                child: ExamMarksCard(
                  semesterMarks1: semesterMarks1,
                  semesterMarks2: semesterMarks2,
                ),
              ),
              SizedBox(height: 16.h),

              // 5. الجدول الدراسي
              if (scheduleImage != null && scheduleImage.isNotEmpty)
                AnimatedSection(
                  fadeAnim: _fadeAnimations[4],
                  slideAnim: _slideAnimations[4],
                  scaleAnim: _scaleAnimations[4],
                  child: ScheduleImageCard(imageUrl: scheduleImage),
                ),
              SizedBox(height: 16.h),

              // 6. الاستعارات
              AnimatedSection(
                fadeAnim: _fadeAnimations[5],
                slideAnim: _slideAnimations[5],
                scaleAnim: _scaleAnimations[5],
                child: LoansSection(loans: loans),
              ),
              SizedBox(height: 16.h),

              // 7. الأنشطة
              AnimatedSection(
                fadeAnim: _fadeAnimations[6],
                slideAnim: _slideAnimations[6],
                scaleAnim: _scaleAnimations[6],
                child: ActivitiesSection(activities: activities),
              ),
              SizedBox(height: 16.h),

              // 8. مساحة فارغة للأسفل
              SizedBox(height: 80.h),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person_off, size: _iconSize, color: Colors.grey.shade400),
          SizedBox(height: _gapSmall),
          Text(
            S.of(context).There_are_no_bulletins_at_the_moment,
            style: theme.textTheme.titleMedium?.copyWith(fontSize: 16.sp),
          ),
          SizedBox(height: _gapMedium),
          Text(
            S.of(context).Pull_down_to_refresh,
            style: theme.textTheme.bodySmall?.copyWith(fontSize: 12.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.wifi_off_rounded,
            size: _iconSize,
            color: Colors.red.shade300,
          ),
          SizedBox(height: _gapSmall),
          Text(
            message,
            textAlign: TextAlign.center,
            style: theme.textTheme.titleMedium?.copyWith(fontSize: 16.sp),
          ),
          SizedBox(height: _gapMedium),
          TextButton.icon(
            onPressed: () {
              context.read<StudentBloc>().add(RefreshStudentProfileEvent());
            },
            icon: Icon(Icons.refresh, size: 20.w),
            label: Text(S.of(context).retry, style: TextStyle(fontSize: 14.sp)),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadedState(BuildContext context, StudentLoaded state) {
    return RefreshIndicator(
      onRefresh: () => _onRefresh(context),
      child: _buildContent(context, state.profile.first),
    );
  }

  void _initAnimations() {
    _mainAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeAnimations = List.generate(_totalSections, (index) {
      final start = index / _totalSections;
      final end = (index + 1) / _totalSections + 0.1;
      final clampedEnd = end.clamp(0.0, 1.0);
      final clampedStart = start.clamp(0.0, clampedEnd);

      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _mainAnimController,
          curve: Interval(clampedStart, clampedEnd, curve: Curves.easeOut),
        ),
      );
    });

    _slideAnimations = List.generate(_totalSections, (index) {
      final start = index / _totalSections;
      final end = (index + 1) / _totalSections + 0.1;
      final clampedEnd = end.clamp(0.0, 1.0);
      final clampedStart = start.clamp(0.0, clampedEnd);

      return Tween<Offset>(
        begin: const Offset(0, 0.5),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _mainAnimController,
          curve: Interval(clampedStart, clampedEnd, curve: Curves.easeOut),
        ),
      );
    });

    _scaleAnimations = List.generate(_totalSections, (index) {
      final start = index / _totalSections;
      final end = (index + 1) / _totalSections + 0.1;
      final clampedEnd = end.clamp(0.0, 1.0);
      final clampedStart = start.clamp(0.0, clampedEnd);

      return Tween<double>(begin: 0.8, end: 1.0).animate(
        CurvedAnimation(
          parent: _mainAnimController,
          curve: Interval(clampedStart, clampedEnd, curve: Curves.easeOut),
        ),
      );
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _mainAnimController.forward();
      }
    });
  }

  void _loadData() {
    final bloc = context.read<StudentBloc>();
    final currentState = bloc.state;

    if (currentState is StudentInitial || currentState is StudentError) {
      bloc.add(GetStudentProfileEvent());
    } else if (currentState is StudentLoaded && !currentState.isRevalidating) {
      bloc.add(RevalidateStudentProfileEvent());
    }
  }

  Future<void> _onRefresh(BuildContext context) async {
    context.read<StudentBloc>().add(RefreshStudentProfileEvent());
  }

  void _showAttendanceDetails(
    BuildContext context,
    List<AttendanceEntity> attendances,
  ) {
    showAnimatedDialog(
      context: context,
      child: AttendanceDialog(attendances: attendances),
    );
  }

  void _showSummonsDetails(BuildContext context, List<SummonsEntity> summons) {
    showAnimatedDialog(
      context: context,
      child: SummonsDialog(summons: summons),
    );
  }

  void _showWarningsDetails(
    BuildContext context,
    List<CounselorWarningsentity> warnings,
  ) {
    showAnimatedDialog(
      context: context,
      child: WarningsDialog(warnings: warnings),
    );
  }
}
