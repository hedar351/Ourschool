// lib/features/Teacher/ui/page/teacher_student_profile_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/core/injection.dart' as di;
import 'package:school/core/widget/Loadingwidget.dart';
import 'package:school/core/widget/SnackBar/Message.dart';
import 'package:school/features/Teacher/domain/Entities/TeacherStudentProfile/SemesterMarks.dart';
import 'package:school/features/Teacher/ui/bloc/MarkBloc/mark_bloc.dart';
import 'package:school/features/Teacher/ui/bloc/TeacherStudentProflie/bloc/teacher_student_proflie_bloc.dart';
import 'package:school/features/Teacher/ui/bloc/TeacherStudentProflie/bloc/teacher_student_proflie_event.dart';
import 'package:school/features/Teacher/ui/bloc/TeacherStudentProflie/bloc/teacher_student_proflie_state.dart';
import 'package:school/features/Teacher/ui/widget/teacher_mark_card.dart';
import 'package:school/features/Teacher/ui/widget/teacher_student_info_card.dart';
import 'package:school/generated/l10n.dart';

enum QuizType {
  quiz1(id: 1, labelKey: 'quiz_type_1'),
  quiz2(id: 2, labelKey: 'quiz_type_2'),
  homework(id: 3, labelKey: 'quiz_type_3'),
  oral(id: 4, labelKey: 'quiz_type_5'),

  finalExam(id: 5, labelKey: 'quiz_type_5');

  final int id;
  final String labelKey;
  const QuizType({required this.id, required this.labelKey});

  static QuizType fromId(int id) {
    return QuizType.values.firstWhere((e) => e.id == id);
  }

  static String getLabel(int id, BuildContext context) {
    try {
      final type = fromId(id);
      switch (type) {
        case QuizType.quiz1:
          return S.of(context).quiz_type_1;
        case QuizType.quiz2:
          return S.of(context).quiz_type_2;
        case QuizType.homework:
          return S.of(context).quiz_type_3;
        case QuizType.oral:
          return S.of(context).oral;
        case QuizType.finalExam:
          return S.of(context).quiz_type_5;
      }
    } catch (_) {
      return S.of(context).unknown_name;
    }
  }
}

class TeacherStudentProfileScreen extends StatefulWidget {
  final int localStudentNumber;
  final int schoolId;
  final int subjectId;
  const TeacherStudentProfileScreen({
    super.key,
    required this.localStudentNumber,
    required this.schoolId,
    required this.subjectId,
  });

  @override
  State<TeacherStudentProfileScreen> createState() =>
      _TeacherStudentProfileScreenState();
}

class _TeacherStudentProfileScreenState
    extends State<TeacherStudentProfileScreen>
    with AutomaticKeepAliveClientMixin, WidgetsBindingObserver {
  late SnackBarMessage snackBarMessage;

  final double contentPadding = 16.w;
  final double gapLarge = 24.h;
  final double gapMedium = 12.h;
  final double gapSmall = 8.h;
  final double sectionHeaderHeight = 24.h;
  final double sectionHeaderGap = 12.w;
  final double sectionHeaderIconSize = 22.w;
  final double sectionHeaderFontSize = 18.sp;
  final double emptyMessageFontSize = 14.sp;
  final double errorIconSize = 80.w;
  final double actionButtonIconSize = 20.w;
  final double actionButtonFontSize = 14.sp;
  final double dialogTitleFontSize = 18.sp;
  final double dialogButtonFontSize = 14.sp;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.sl<TeacherStudentProfileBloc>()
            ..add(
              GetTeacherStudentProfileEvent(
                localStudentNumber: widget.localStudentNumber,
                schoolId: widget.schoolId,
              ),
            ),
        ),
        BlocProvider(create: (context) => di.sl<MarkBloc>()),
      ],
      child: BlocListener<MarkBloc, MarkState>(
        listener: (context, state) {
          if (state is SuccessMarkState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
            context.read<TeacherStudentProfileBloc>().add(
              RefreshTeacherStudentProfileEvent(
                localStudentNumber: widget.localStudentNumber,
                schoolId: widget.schoolId,
              ),
            );
          }
          if (state is ErrorMarkState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child:
            BlocConsumer<TeacherStudentProfileBloc, TeacherStudentProfileState>(
              listener: (context, state) {
                if (state is TeacherStudentProfileError) {
                  snackBarMessage.errorMessage(
                    message: state.message,
                    context: context,
                  );
                }
              },
              builder: (context, state) {
                if (state is TeacherStudentProfileLoading) {
                  return const Loadingwidget();
                }
                if (state is TeacherStudentProfileLoaded) {
                  return _buildProfileContent(context, state);
                }
                if (state is TeacherStudentProfileError) {
                  return _buildErrorState(context, state.message);
                }
                return const Loadingwidget();
              },
            ),
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) _loadData();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    snackBarMessage = SnackBarMessage();
  }

  Future<void> showAddEditMarkDialog(
    BuildContext context, {
    required bool isEdit,
    SemesterMarks? existingMark,
    int? semester,
  }) async {
    final markBloc = context.read<MarkBloc>();

    final formKey = GlobalKey<FormState>();
    int? selectedSemester = semester;
    QuizType? selectedQuizType;
    final scoreController = TextEditingController();
    final maxScoreController = TextEditingController();

    if (isEdit && existingMark != null) {
      selectedSemester = semester ?? 1;
      selectedQuizType = QuizType.quiz1;
      scoreController.text = existingMark.quiz1?.toString() ?? '0';
      maxScoreController.text = '100';
    }

    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) {
        return BlocProvider.value(
          value: markBloc,
          child: StatefulBuilder(
            builder: (context, setState) {
              void updateScoreField(QuizType? newType) {
                if (isEdit && existingMark != null && newType != null) {
                  double? value;
                  switch (newType) {
                    case QuizType.quiz1:
                      value = existingMark.quiz1;
                      break;
                    case QuizType.quiz2:
                      value = existingMark.quiz2;
                      break;
                    case QuizType.homework:
                      value = existingMark.homework;
                      break;
                    case QuizType.finalExam:
                      value = existingMark.finalExam;
                      break;
                    case QuizType.oral:
                      value = existingMark.oral;
                      break;
                  }
                  scoreController.text = value?.toString() ?? '0';
                }
              }

              return AlertDialog(
                title: Text(
                  isEdit ? S.of(context).edit_mark : S.of(context).add_mark,
                  style: TextStyle(
                    fontSize: dialogTitleFontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                content: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        DropdownButtonFormField<int>(
                          decoration: InputDecoration(
                            labelText: S.of(context).semester,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          initialValue: selectedSemester,
                          items: const [
                            DropdownMenuItem(
                              value: 1,
                              child: Text('الفصل الأول'),
                            ),
                            DropdownMenuItem(
                              value: 2,
                              child: Text('الفصل الثاني'),
                            ),
                          ],
                          onChanged: (value) => setState(() {
                            selectedSemester = value;
                          }),
                          validator: (value) => value == null
                              ? S.of(context).please_select_semester
                              : null,
                        ),
                        SizedBox(height: gapMedium),

                        DropdownButtonFormField<QuizType>(
                          decoration: InputDecoration(
                            labelText: S.of(context).quiz_type,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          initialValue: selectedQuizType,
                          items: QuizType.values.map((type) {
                            return DropdownMenuItem(
                              value: type,
                              child: Text(_getQuizTypeLabel(type, context)),
                            );
                          }).toList(),
                          onChanged: (value) => setState(() {
                            selectedQuizType = value;
                            updateScoreField(value);
                          }),
                          validator: (value) => value == null
                              ? S.of(context).please_select_quiz_type
                              : null,
                        ),
                        SizedBox(height: gapMedium),

                        // ====== حقل العلامة ======
                        TextFormField(
                          controller: scoreController,
                          decoration: InputDecoration(
                            labelText: S.of(context).score,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            suffixText: S.of(context).out_of,
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return S.of(context).please_enter_score;
                            }
                            if (double.tryParse(value) == null) {
                              return S.of(context).please_enter_valid_number;
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: gapMedium),

                        // ====== حقل العلامة الكاملة ======
                        TextFormField(
                          controller: maxScoreController,
                          decoration: InputDecoration(
                            labelText: S.of(context).max_score,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return S.of(context).please_enter_max_score;
                            }
                            if (double.tryParse(value) == null) {
                              return S.of(context).please_enter_valid_number;
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(dialogContext),
                    child: Text(
                      S.of(context).cancel,
                      style: TextStyle(fontSize: dialogButtonFontSize),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        Navigator.pop(dialogContext);
                        final score = double.parse(scoreController.text);
                        final maxScore = double.parse(maxScoreController.text);

                        if (isEdit && existingMark != null) {
                          context.read<MarkBloc>().add(
                            EditEvent(
                              schoolId: widget.schoolId,
                              localStudentNumber: widget.localStudentNumber,
                              localSubjectId: existingMark.localSubjectId!,
                              semester: selectedSemester!,
                              quizTypeId: selectedQuizType!.id,
                              score: score,
                              maxScore: maxScore,
                            ),
                          );
                        } else {
                          context.read<MarkBloc>().add(
                            AddMarkEvent(
                              schoolId: widget.schoolId,
                              localStudentNumber: widget.localStudentNumber,
                              localSubjectId: widget.subjectId,
                              semester: selectedSemester!,
                              quizTypeId: selectedQuizType!.id,
                              score: score,
                              maxScore: maxScore,
                            ),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    child: Text(
                      isEdit ? S.of(context).edit : S.of(context).add,
                      style: TextStyle(
                        fontSize: dialogButtonFontSize,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Future<void> showDeleteMarkDialog(BuildContext context) async {
    final markBloc = context.read<MarkBloc>();

    int? selectedSemester;
    QuizType? selectedQuizType;

    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) {
        return BlocProvider.value(
          value: markBloc,
          child: StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Text(
                  S.of(context).delete,
                  style: TextStyle(
                    fontSize: dialogTitleFontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButtonFormField<int>(
                      decoration: InputDecoration(
                        labelText: S.of(context).semester,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      initialValue: selectedSemester,
                      items: const [
                        DropdownMenuItem(value: 1, child: Text('الفصل الأول')),
                        DropdownMenuItem(value: 2, child: Text('الفصل الثاني')),
                      ],
                      onChanged: (value) =>
                          setState(() => selectedSemester = value),
                      validator: (value) => value == null
                          ? S.of(context).please_select_semester
                          : null,
                    ),
                    SizedBox(height: gapMedium),

                    DropdownButtonFormField<QuizType>(
                      decoration: InputDecoration(
                        labelText: S.of(context).quiz_type,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      initialValue: selectedQuizType,
                      items: QuizType.values.map((type) {
                        return DropdownMenuItem(
                          value: type,
                          child: Text(_getQuizTypeLabel(type, context)),
                        );
                      }).toList(),
                      onChanged: (value) =>
                          setState(() => selectedQuizType = value),
                      validator: (value) => value == null
                          ? S.of(context).please_select_quiz_type
                          : null,
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(dialogContext),
                    child: Text(
                      S.of(context).cancel,
                      style: TextStyle(fontSize: dialogButtonFontSize),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (selectedSemester != null &&
                          selectedQuizType != null) {
                        Navigator.pop(dialogContext);
                        context.read<MarkBloc>().add(
                          DeleteEvent(
                            schoolId: widget.schoolId,
                            localStudentNumber: widget.localStudentNumber,
                            localSubjectId: widget.subjectId,
                            semester: selectedSemester!,
                            quizTypeId: selectedQuizType!.id,
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: Text(
                      S.of(context).delete,
                      style: TextStyle(
                        fontSize: dialogButtonFontSize,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        child: Row(
          children: [
            Icon(icon, color: color, size: actionButtonIconSize),
            SizedBox(width: 4.w),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: actionButtonFontSize,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: theme.dividerColor.withOpacity(0.5),
          width: 4.w,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildActionButton(
            context,
            icon: Icons.add_circle_outline,
            label: S.of(context).add_mark,
            color: Colors.green,
            onPressed: () => showAddEditMarkDialog(context, isEdit: false),
          ),
          Container(
            width: 1.w,
            height: 30.h,
            color: theme.dividerColor.withOpacity(0.5),
          ),
          _buildActionButton(
            context,
            icon: Icons.edit_outlined,
            label: S.of(context).edit_mark,
            color: Colors.blue,
            onPressed: () => showAddEditMarkDialog(context, isEdit: true),
          ),
          Container(
            width: 1.w,
            height: 30.h,
            color: theme.dividerColor.withOpacity(0.5),
          ),
          _buildActionButton(
            context,
            icon: Icons.delete_outline,
            label: S.of(context).delete,
            color: Colors.red,
            onPressed: () => showDeleteMarkDialog(context),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      title: Text(
        S.of(context).student_profile,
        style: TextStyle(fontSize: 18.sp, color: theme.colorScheme.onSurface),
      ),
      centerTitle: true,
      elevation: 0,
      // backgroundColor: theme.scaffoldBackgroundColor,
      // foregroundColor: theme.colorScheme.onSurface,
    );
  }

  Widget _buildEmptyMessage(BuildContext context, String message) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: Text(
          message,
          style: TextStyle(
            fontSize: emptyMessageFontSize,
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: errorIconSize,
              color: theme.colorScheme.error,
            ),
            SizedBox(height: 16.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.error,
                fontSize: 16.sp,
              ),
            ),
            SizedBox(height: 16.h),
            TextButton.icon(
              onPressed: () {
                context.read<TeacherStudentProfileBloc>().add(
                  RefreshTeacherStudentProfileEvent(
                    localStudentNumber: widget.localStudentNumber,
                    schoolId: widget.schoolId,
                  ),
                );
              },
              icon: Icon(
                Icons.refresh,
                color: theme.colorScheme.primary,
                size: 20.w,
              ),
              label: Text(
                S.of(context).retry,
                style: TextStyle(
                  color: theme.colorScheme.primary,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileContent(
    BuildContext context,
    TeacherStudentProfileLoaded state,
  ) {
    final profile = state.profile;
    final semester1 = profile.semester1Marks ?? [];
    final semester2 = profile.semester2Marks ?? [];
    final theme = Theme.of(context);

    return Scaffold(
      appBar: _buildAppBar(context),
      body: Stack(
        children: [
          SafeArea(
            child: RefreshIndicator(
              onRefresh: () => _onRefresh(context),
              color: Colors.transparent,
              backgroundColor: Colors.transparent,
              strokeWidth: 0,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.all(contentPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TeacherStudentInfoCard(profile: profile),
                    SizedBox(height: gapLarge),

                    _buildActionButtons(context),
                    SizedBox(height: gapMedium),

                    // ====== الفصل الأول ======
                    _buildSectionHeader(
                      context,
                      title: S.of(context).semester_1,
                      icon: Icons.bookmark,
                      color: theme.colorScheme.primary,
                    ),
                    SizedBox(height: gapMedium),
                    if (semester1.isNotEmpty)
                      ...semester1.map((mark) => TeacherMarkCard(mark: mark))
                    else
                      _buildEmptyMessage(
                        context,
                        S.of(context).no_marks_semester_1,
                      ),

                    SizedBox(height: gapLarge),

                    // ====== الفصل الثاني ======
                    _buildSectionHeader(
                      context,
                      title: S.of(context).semester_2,
                      icon: Icons.bookmark,
                      color: theme.colorScheme.secondary,
                    ),
                    SizedBox(height: gapMedium),
                    if (semester2.isNotEmpty)
                      ...semester2.map((mark) => TeacherMarkCard(mark: mark))
                    else
                      _buildEmptyMessage(
                        context,
                        S.of(context).no_marks_semester_2,
                      ),

                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ),
          ),
          if (state.isRevalidating)
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

  Widget _buildSectionHeader(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
  }) {
    return Row(
      children: [
        Container(
          width: 4.w,
          height: sectionHeaderHeight,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
        SizedBox(width: sectionHeaderGap),
        Icon(icon, color: color, size: sectionHeaderIconSize),
        SizedBox(width: 10.w),
        Text(
          title,
          style: TextStyle(
            fontSize: sectionHeaderFontSize,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ],
    );
  }

  String _getQuizTypeLabel(QuizType type, BuildContext context) {
    switch (type) {
      case QuizType.quiz1:
        return S.of(context).quiz_type_1;
      case QuizType.quiz2:
        return S.of(context).quiz_type_2;
      case QuizType.homework:
        return S.of(context).quiz_type_3;
      case QuizType.oral:
        return S.of(context).oral;
      case QuizType.finalExam:
        return S.of(context).quiz_type_5;
    }
  }

  void _loadData() {
    final bloc = context.read<TeacherStudentProfileBloc>();
    final currentState = bloc.state;
    if (currentState is TeacherStudentProfileInitial ||
        currentState is TeacherStudentProfileError) {
      bloc.add(
        GetTeacherStudentProfileEvent(
          localStudentNumber: widget.localStudentNumber,
          schoolId: widget.schoolId,
        ),
      );
    } else if (currentState is TeacherStudentProfileLoaded &&
        !currentState.isRevalidating) {
      bloc.add(
        RevalidateTeacherStudentProfileEvent(
          localStudentNumber: widget.localStudentNumber,
          schoolId: widget.schoolId,
        ),
      );
    }
  }

  Future<void> _onRefresh(BuildContext context) async {
    context.read<TeacherStudentProfileBloc>().add(
      RefreshTeacherStudentProfileEvent(
        localStudentNumber: widget.localStudentNumber,
        schoolId: widget.schoolId,
      ),
    );
  }
}
