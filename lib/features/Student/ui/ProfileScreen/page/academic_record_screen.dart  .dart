// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:school/core/widget/Loadingwidget.dart';
// import 'package:school/core/widget/SnackBar/Message.dart';
// import 'package:school/features/Counselor/domain/Entities/StudentsProfileEntity/Counselor_WarningsEntity.dart';
// import 'package:school/features/Counselor/domain/Entities/attendanceEntity/attendanceEntity.dart';
// import 'package:school/features/Student/domain/entity/Student-FullProfile/StudentFullProfileEntity.dart';
// import 'package:school/features/Student/domain/entity/Student-FullProfile/SummonsEntity.dart';
// import 'package:school/features/Student/ui/bloc/student_bloc.dart';
// import 'package:school/features/Student/ui/dialogs/attendance_dialog.dart';
// import 'package:school/features/Student/ui/dialogs/summons_dialog.dart';
// import 'package:school/features/Student/ui/dialogs/warnings_dialog.dart';
// import 'package:school/features/Student/ui/widget/academic_info_card.dart';
// import 'package:school/features/Student/ui/widget/exam_marks_card.dart';
// import 'package:school/features/Student/ui/widget/quick_stats_row.dart';
// import 'package:school/features/Student/ui/widget/schedule_image_card.dart';
// import 'package:school/generated/l10n.dart';

// class AcademicRecordScreen extends StatefulWidget {
//   const AcademicRecordScreen({super.key});

//   @override
//   State<AcademicRecordScreen> createState() => _AcademicRecordScreenState();
// }

// class _AcademicRecordScreenState extends State<AcademicRecordScreen>
//     with WidgetsBindingObserver {
//   late SnackBarMessage snackBarMessage;

//   // ✅ حسابات القيم الثابتة خارج build (مثل BulletinScreen)
//   final double _iconSize = 80.w;
//   final double _gapSmall = 16.h;
//   final double _gapMedium = 8.h;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       body: BlocConsumer<StudentBloc, StudentState>(
//         listener: (context, state) {
//           if (state is StudentError) {
//             snackBarMessage.errorMessage(
//               message: state.message,
//               context: context,
//             );
//           }
//         },
//         builder: (context, state) {
//           if (state is StudentLoading) {
//             return const Loadingwidget();
//           }
//           if (state is StudentLoaded) {
//             if (state.profile.isEmpty) {
//               return _buildEmptyState(context);
//             }
//             return _buildLoadedState(context, state);
//           }
//           if (state is StudentError) {
//             return _buildErrorState(context, state.message);
//           }
//           return const Loadingwidget();
//         },
//       ),
//     );
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.resumed) {
//       _loadData();
//     }
//   }

//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//     snackBarMessage = SnackBarMessage();
//     _loadData();
//   }

//   Widget _buildContent(BuildContext context, Studentfullprofileentity profile) {
//     final theme = Theme.of(context);
//     final colorScheme = theme.colorScheme;
//     final studentInfo = profile.studentInfo!;
//     final statistics = profile.statistics!;
//     final semesterMarks1 = profile.semesterMarks1 ?? [];
//     final semesterMarks2 = profile.semesterMark2 ?? [];
//     final attendances = profile.attendance ?? [];
//     final warnings = profile.warnings ?? [];
//     final summons = profile.summons ?? [];
//     final scheduleImage = profile.scheduleImage;

//     return CustomScrollView(
//       slivers: [
//         // AppBar
//         SliverAppBar(
//           automaticallyImplyLeading: false,
//           expandedHeight: 200.h,
//           pinned: true,
//           flexibleSpace: FlexibleSpaceBar(
//             background: Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topRight,
//                   end: Alignment.bottomLeft,
//                   colors: [colorScheme.primary, colorScheme.primaryContainer],
//                 ),
//               ),
//               child: SafeArea(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     SizedBox(height: 12.h),
//                     Text(
//                       studentInfo.name ?? S.of(context).unknown_name,
//                       style: theme.textTheme.headlineMedium?.copyWith(
//                         color: colorScheme.onPrimary,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 22.sp,
//                       ),
//                     ),
//                     SizedBox(height: 4.h),
//                     Text(
//                       '${studentInfo.gradeName ?? ''} - ${studentInfo.sectionName ?? ''}',
//                       style: theme.textTheme.bodyLarge?.copyWith(
//                         color: colorScheme.onPrimary.withOpacity(0.9),
//                         fontSize: 16.sp,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),

//         // Content
//         SliverPadding(
//           padding: EdgeInsets.all(16.w),
//           sliver: SliverList(
//             delegate: SliverChildListDelegate([
//               AcademicInfoCard(studentInfo: studentInfo),
//               SizedBox(height: 16.h),

//               QuickStatsRow(
//                 statistics: statistics,
//                 warningsCount: warnings.length,
//                 summonsCount: summons.length,
//                 onAttendanceTap: () =>
//                     _showAttendanceDetails(context, attendances),
//                 onWarningsTap: () => _showWarningsDetails(context, warnings),
//                 onSummonsTap: () => _showSummonsDetails(context, summons),
//               ),
//               SizedBox(height: 16.h),

//               ExamMarksCard(
//                 semesterMarks1: semesterMarks1,
//                 semesterMarks2: semesterMarks2,
//               ),
//               SizedBox(height: 16.h),

//               if (scheduleImage != null && scheduleImage.isNotEmpty)
//                 ScheduleImageCard(imageUrl: scheduleImage),

//               SizedBox(height: 80.h),
//             ]),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildEmptyState(BuildContext context) {
//     final theme = Theme.of(context);

//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.person_off, size: _iconSize, color: Colors.grey.shade400),
//           SizedBox(height: _gapSmall),
//           Text(
//             S.of(context).There_are_no_bulletins_at_the_moment,
//             style: theme.textTheme.titleMedium?.copyWith(fontSize: 16.sp),
//           ),
//           SizedBox(height: _gapMedium),
//           Text(
//             S.of(context).Pull_down_to_refresh,
//             style: theme.textTheme.bodySmall?.copyWith(fontSize: 12.sp),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildErrorState(BuildContext context, String message) {
//     final theme = Theme.of(context);

//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.error_outline,
//             size: _iconSize,
//             color: Colors.red.shade300,
//           ),
//           SizedBox(height: _gapSmall),
//           Text(
//             message,
//             textAlign: TextAlign.center,
//             style: theme.textTheme.titleMedium?.copyWith(fontSize: 16.sp),
//           ),
//           SizedBox(height: _gapMedium),
//           TextButton.icon(
//             onPressed: () {
//               context.read<StudentBloc>().add(RefreshStudentProfileEvent());
//             },
//             icon: Icon(Icons.refresh, size: 20.w),
//             label: Text(S.of(context).retry, style: TextStyle(fontSize: 14.sp)),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildLoadedState(BuildContext context, StudentLoaded state) {
//     return RefreshIndicator(
//       onRefresh: () => _onRefresh(context),
//       child: _buildContent(context, state.profile.first),
//     );
//   }

//   void _loadData() {
//     final bloc = context.read<StudentBloc>();
//     final currentState = bloc.state;

//     if (currentState is StudentInitial || currentState is StudentError) {
//       bloc.add(GetStudentProfileEvent());
//     } else if (currentState is StudentLoaded && !currentState.isRevalidating) {
//       bloc.add(RevalidateStudentProfileEvent());
//     }
//   }

//   Future<void> _onRefresh(BuildContext context) async {
//     context.read<StudentBloc>().add(RefreshStudentProfileEvent());
//   }

//   // ---- Dialogs ----
//   void _showAttendanceDetails(
//     BuildContext context,
//     List<AttendanceEntity> attendances,
//   ) {
//     showDialog(
//       context: context,
//       builder: (ctx) => AttendanceDialog(attendances: attendances),
//     );
//   }

//   void _showSummonsDetails(BuildContext context, List<SummonsEntity> summons) {
//     showDialog(
//       context: context,
//       builder: (ctx) => SummonsDialog(summons: summons),
//     );
//   }

//   void _showWarningsDetails(
//     BuildContext context,
//     List<CounselorWarningsentity> warnings,
//   ) {
//     showDialog(
//       context: context,
//       builder: (ctx) => WarningsDialog(warnings: warnings),
//     );
//   }
// }
// lib/features/Student/ui/pages/academic_record_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/core/widget/Loadingwidget.dart';
import 'package:school/core/widget/SnackBar/Message.dart';
import 'package:school/features/Counselor/domain/Entities/StudentsProfileEntity/Counselor_WarningsEntity.dart';
import 'package:school/features/Counselor/domain/Entities/attendanceEntity/attendanceEntity.dart';
import 'package:school/features/Student/domain/entity/Student-FullProfile/StudentFullProfileEntity.dart';
import 'package:school/features/Student/domain/entity/Student-FullProfile/SummonsEntity.dart';
import 'package:school/features/Student/ui/ProfileScreen/dialogs/attendance_dialog.dart';
import 'package:school/features/Student/ui/ProfileScreen/dialogs/summons_dialog.dart';
import 'package:school/features/Student/ui/ProfileScreen/dialogs/warnings_dialog.dart';
import 'package:school/features/Student/ui/ProfileScreen/widget/academic_info_card.dart';
import 'package:school/features/Student/ui/ProfileScreen/widget/animated_section.dart';
import 'package:school/features/Student/ui/ProfileScreen/widget/exam_marks_card.dart';
import 'package:school/features/Student/ui/ProfileScreen/widget/quick_stats_row.dart';
import 'package:school/features/Student/ui/ProfileScreen/widget/schedule_image_card.dart';
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
        AutomaticKeepAliveClientMixin {
  late SnackBarMessage snackBarMessage;

  late AnimationController _mainAnimController;
  late List<Animation<double>> _fadeAnimations;
  late List<Animation<Offset>> _slideAnimations;
  late List<Animation<double>> _scaleAnimations;

  final int _totalSections = 5;

  // ✅ حسابات القيم الثابتة خارج build (مثل BulletinScreen)
  final double _iconSize = 80.w;
  final double _gapSmall = 16.h;
  final double _gapMedium = 8.h;

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
              // ✅ القسم 1: معلومات الطالب
              AnimatedSection(
                fadeAnim: _fadeAnimations[0],
                slideAnim: _slideAnimations[0],
                scaleAnim: _scaleAnimations[0],
                child: AcademicInfoCard(studentInfo: studentInfo),
              ),
              SizedBox(height: 16.h),

              // ✅ القسم 2: الإحصائيات
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

              // ✅ القسم 3: العلامات
              AnimatedSection(
                fadeAnim: _fadeAnimations[2],
                slideAnim: _slideAnimations[2],
                scaleAnim: _scaleAnimations[2],
                child: ExamMarksCard(
                  semesterMarks1: semesterMarks1,
                  semesterMarks2: semesterMarks2,
                ),
              ),
              SizedBox(height: 16.h),

              // ✅ القسم 4: صورة الجدول (إن وجدت)
              if (scheduleImage != null && scheduleImage.isNotEmpty)
                AnimatedSection(
                  fadeAnim: _fadeAnimations[3],
                  slideAnim: _slideAnimations[3],
                  scaleAnim: _scaleAnimations[3],
                  child: ScheduleImageCard(imageUrl: scheduleImage),
                ),

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
            Icons.error_outline,
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

  // ---- Animations ----
  void _initAnimations() {
    _mainAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeAnimations = List.generate(_totalSections, (index) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _mainAnimController,
          curve: Interval(
            index * 0.2,
            1.0 - (_totalSections - index - 1) * 0.15,
            curve: Curves.easeOut,
          ),
        ),
      );
    });

    _slideAnimations = List.generate(_totalSections, (index) {
      return Tween<Offset>(
        begin: const Offset(0, 0.5),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _mainAnimController,
          curve: Interval(
            index * 0.2,
            1.0 - (_totalSections - index - 1) * 0.15,
            curve: Curves.easeOut,
          ),
        ),
      );
    });

    _scaleAnimations = List.generate(_totalSections, (index) {
      return Tween<double>(begin: 0.8, end: 1.0).animate(
        CurvedAnimation(
          parent: _mainAnimController,
          curve: Interval(
            index * 0.2,
            1.0 - (_totalSections - index - 1) * 0.15,
            curve: Curves.easeOut,
          ),
        ),
      );
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _mainAnimController.forward();
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
