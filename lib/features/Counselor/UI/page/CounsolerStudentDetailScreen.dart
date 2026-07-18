import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school/core/injection.dart' as di;
import 'package:school/core/widget/Loadingwidget.dart';
import 'package:school/features/Counselor/UI/bloc/PostWarnings/post_warnings_bloc.dart';
import 'package:school/features/Counselor/UI/bloc/PostWarnings/post_warnings_event.dart';
import 'package:school/features/Counselor/UI/bloc/PostWarnings/post_warnings_state.dart';
import 'package:school/features/Counselor/UI/bloc/Studentprofile/student_profile_bloc.dart';
import 'package:school/features/Counselor/UI/widget/MarkCard.dart';
import 'package:school/features/Counselor/UI/widget/SectionHeader.dart';
import 'package:school/features/Counselor/UI/widget/StudentInfoCard.dart';
import 'package:school/features/Counselor/UI/widget/SubjectCard.dart';
import 'package:school/features/Counselor/UI/widget/WarningCard.dart';
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
            print("🟡 [DetailScreen] Creating PostWarningBloc manually");
            final repo = di.sl<CounselorRepo>();
            print("🟡 [DetailScreen] CounselorRepo resolved: $repo");
            final useCase = Postwarningsusecase(repository: repo);
            print("🟡 [DetailScreen] Postwarningsusecase created: $useCase");
            final bloc = PostWarningBloc(
              postWarningsUseCase: useCase,
              counselorRepo: repo,
            );
            print("🟡 [DetailScreen] PostWarningBloc created: $bloc");
            return bloc;
          },
        ),
      ],
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

    // تجميع العلامات حسب الفصل
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(student?.name ?? S.of(context).unknown_name),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.8),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${warnings.length} ⚠️',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
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
                    StudentInfoCard(student: student),
                    const SizedBox(height: 24),

                    // المواد الدراسية
                    SectionHeader(
                      title: S.of(context).subjects_title,
                      icon: Icons.book,
                    ),
                    const SizedBox(height: 12),
                    if (subjects.isNotEmpty)
                      ...subjects.map((s) => SubjectCard(subject: s))
                    else
                      Text(
                        S.of(context).There_are_no_bulletins_at_the_moment,
                        style: theme.textTheme.bodySmall,
                      ),
                    const SizedBox(height: 24),

                    // العلامات (مجمعة حسب الفصل)
                    SectionHeader(
                      title: S.of(context).marks_title,
                      icon: Icons.bar_chart,
                    ),
                    const SizedBox(height: 12),
                    if (marks != null && marks.isNotEmpty)
                      ...marksWidgets
                    else
                      Text(
                        S.of(context).There_are_no_bulletins_at_the_moment,
                        style: theme.textTheme.bodySmall,
                      ),
                    const SizedBox(height: 24),

                    // الإنذارات
                    Row(
                      children: [
                        Expanded(
                          child: SectionHeader(
                            title: S.of(context).warnings_title,
                            icon: Icons.warning_amber,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add_circle, color: Colors.red),
                          onPressed: () => _showAddWarningDialog(context),
                          tooltip: 'إضافة إنذار',
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    if (warnings.isNotEmpty)
                      ...warnings.map((w) => WarningCard(warning: w))
                    else
                      Text(
                        S.of(context).There_are_no_bulletins_at_the_moment,
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

  void _showAddWarningDialog(BuildContext context) {
    final reasonController = TextEditingController();
    String? selectedType;
    final bloc = context.read<PostWarningBloc>();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return BlocProvider.value(
          value: bloc,
          child: BlocConsumer<PostWarningBloc, PostWarningState>(
            listener: (context, state) {
              if (state is PostWarningSuccess) {
                // لا داعي لـ Navigator.pop هنا لأننا سنغلق في builder
                context.read<StudentProfileBloc>().add(
                  RefreshStudentProfileEvent(
                    localStudentNumber: widget.localStudentNumber,
                  ),
                );
              }
              if (state is PostWarningError) {
                Navigator.pop(context);
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            builder: (context, state) {
              return AlertDialog(
                title: Text(S.of(context).add_warning_title),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              selectedType == null
                                  ? S.of(context).select_warning_type
                                  : selectedType == 'Behavior'
                                  ? S.of(context).type_behavior
                                  : S.of(context).type_dismissal_warning,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                          PopupMenuButton<String>(
                            icon: const Icon(Icons.arrow_drop_down),
                            onSelected: (value) {
                              selectedType = value;
                            },
                            itemBuilder: (BuildContext context) => [
                              PopupMenuItem(
                                value: 'Behavior',
                                child: Text(S.of(context).type_behavior),
                              ),
                              PopupMenuItem(
                                value: 'DismissalWarning',
                                child: Text(
                                  S.of(context).type_dismissal_warning,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: reasonController,
                      decoration: InputDecoration(
                        labelText: S.of(context).reason,
                        border: const OutlineInputBorder(),
                      ),
                      maxLines: 3,
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(dialogContext),
                    child: Text(S.of(context).cancel),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final type = selectedType;
                      final reason = reasonController.text.trim();
                      if (type != null && reason.isNotEmpty) {
                        context.read<PostWarningBloc>().add(
                          AddPostWarningEvent(
                            localStudentNumber: widget.localStudentNumber,
                            type: type,
                            reason: reason,
                          ),
                        );
                        Navigator.pop(dialogContext);
                      } else {
                        ScaffoldMessenger.of(dialogContext).showSnackBar(
                          SnackBar(
                            content: Text(
                              S.of(context).please_select_type_and_reason,
                            ),
                          ),
                        );
                      }
                    },
                    child: Text(S.of(context).add),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
