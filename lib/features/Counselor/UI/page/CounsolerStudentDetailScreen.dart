import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school/core/injection.dart' as di;
import 'package:school/core/widget/Loadingwidget.dart';
import 'package:school/features/Counselor/UI/bloc/PostWarnings/post_warnings_bloc.dart';
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
import 'package:school/features/Counselor/domain/Repo/CounselorRepo.dart';
import 'package:school/generated/l10n.dart';

import '../../domain/UseCases/Postwarningsusecase.dart';

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

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<StudentProfileBloc>()),
        BlocProvider(
          create: (_) {
            final repo = di.sl<CounselorRepo>();
            final useCase = Postwarningsusecase(repository: repo);
            return PostWarningBloc(
              postWarningsUseCase: useCase,
              counselorRepo: repo,
            );
          },
        ),
        BlocProvider(create: (_) => di.sl<AttendanceBloc>()),
      ],
      child: BlocListener<AttendanceBloc, AttendanceState>(
        listener: (context, state) {
          if (state is AttendanceSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
            context.read<StudentProfileBloc>().add(
              RefreshStudentProfileEvent(
                localStudentNumber: widget.localStudentNumber,
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
          Icon(Icons.error_outline, size: 80, color: Colors.red.shade300),
          const SizedBox(height: 16),
          Text(
            message,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          TextButton.icon(
            onPressed: () {
              context.read<StudentProfileBloc>().add(
                RefreshStudentProfileEvent(
                  localStudentNumber: widget.localStudentNumber,
                ),
              );
            },
            icon: const Icon(Icons.refresh),
            label: const Text('إعادة المحاولة'),
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

    // بناء واجهة العلامات المباشرة (كما كانت سابقاً)
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
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: Row(
              children: [
                Icon(Icons.bookmark, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  semesterTitle,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        );
        marksWidgets.addAll(semesterMarks.map((m) => MarkCard(mark: m)));
        marksWidgets.add(const SizedBox(height: 8));
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
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ====== بطاقة معلومات الطالب ======
                    StudentInfoCard(student: student),
                    const SizedBox(height: 24),

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
                          icon: const Icon(Icons.add_circle, color: Colors.red),
                          onPressed: () => showAddAttendanceDialog(
                            context,
                            student?.localStudentNumber,
                          ),
                          tooltip: 'إضافة غياب',
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // ====== بطاقة المواد ======
                    SectionCard(
                      icon: Icons.book,
                      title: S.of(context).subjects_title.trim(),
                      count: subjects.length,
                      onTap: () => showSubjectsDialog(context, subjects),
                    ),
                    const SizedBox(height: 16),

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
                          icon: const Icon(Icons.add_circle, color: Colors.red),
                          onPressed: () =>
                              showAddWarningDialog(context, student),
                          tooltip: 'إضافة إنذار',
                        ),
                      ],
                    ),

                    // ====== العلامات (عرض مباشر) ======
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Icon(Icons.bar_chart, color: theme.colorScheme.primary),
                        const SizedBox(width: 8),
                        Text(
                          S.of(context).marks_title,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),
                    if (marks != null && marks.isNotEmpty)
                      ...marksWidgets
                    else
                      Text(
                        S.of(context).There_are_no_Marks_at_the_moment,
                        style: theme.textTheme.bodySmall,
                      ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
          if (isRevalidating)
            const Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: LinearProgressIndicator(
                backgroundColor: Colors.transparent,
                color: Colors.blue,
                minHeight: 3,
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
