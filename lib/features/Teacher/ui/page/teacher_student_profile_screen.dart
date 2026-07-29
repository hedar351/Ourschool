import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school/core/injection.dart' as di;
import 'package:school/core/widget/Loadingwidget.dart';
import 'package:school/core/widget/SnackBar/Message.dart';
import 'package:school/features/Teacher/ui/bloc/TeacherStudentProflie/bloc/teacher_student_proflie_bloc.dart';
import 'package:school/features/Teacher/ui/bloc/TeacherStudentProflie/bloc/teacher_student_proflie_event.dart';
import 'package:school/features/Teacher/ui/bloc/TeacherStudentProflie/bloc/teacher_student_proflie_state.dart';
import 'package:school/features/Teacher/ui/widget/teacher_mark_card.dart';
import 'package:school/features/Teacher/ui/widget/teacher_student_info_card.dart';
import 'package:school/generated/l10n.dart';

class TeacherStudentProfileScreen extends StatefulWidget {
  final int localStudentNumber;
  final int schoolId;

  const TeacherStudentProfileScreen({
    super.key,
    required this.localStudentNumber,
    required this.schoolId,
  });

  @override
  State<TeacherStudentProfileScreen> createState() =>
      _TeacherStudentProfileScreenState();
}

class _TeacherStudentProfileScreenState
    extends State<TeacherStudentProfileScreen>
    with AutomaticKeepAliveClientMixin, WidgetsBindingObserver {
  late SnackBarMessage snackBarMessage;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (context) => di.sl<TeacherStudentProfileBloc>()
        ..add(
          GetTeacherStudentProfileEvent(
            localStudentNumber: widget.localStudentNumber,
            schoolId: widget.schoolId,
          ),
        ),
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
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    snackBarMessage = SnackBarMessage();
  }

  Widget _buildEmptyMessage(BuildContext context, String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Text(
          message,
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ملف الطالب'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
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
            const SizedBox(height: 16),
            TextButton.icon(
              onPressed: () {
                context.read<TeacherStudentProfileBloc>().add(
                  RefreshTeacherStudentProfileEvent(
                    localStudentNumber: widget.localStudentNumber,
                    schoolId: widget.schoolId,
                  ),
                );
              },
              icon: const Icon(Icons.refresh),
              label: const Text('إعادة المحاولة'),
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
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: theme.scaffoldBackgroundColor,
        foregroundColor: theme.colorScheme.onSurface,
      ),
      body: Stack(
        children: [
          SafeArea(
            child: RefreshIndicator(
              onRefresh: () => _onRefresh(context),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TeacherStudentInfoCard(profile: profile),
                    const SizedBox(height: 24),

                    _buildSectionHeader(
                      context,
                      title: S.of(context).semester_1,
                      icon: Icons.bookmark,
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(height: 12),
                    if (semester1.isNotEmpty)
                      ...semester1.map((mark) => TeacherMarkCard(mark: mark))
                    else
                      _buildEmptyMessage(context, 'لا توجد علامات للفصل الأول'),

                    const SizedBox(height: 24),

                    _buildSectionHeader(
                      context,
                      title: S.of(context).semester_2,
                      icon: Icons.bookmark,
                      color: theme.colorScheme.secondary,
                    ),
                    const SizedBox(height: 12),
                    if (semester2.isNotEmpty)
                      ...semester2.map((mark) => TeacherMarkCard(mark: mark))
                    else
                      _buildEmptyMessage(
                        context,
                        'لا توجد علامات للفصل الثاني',
                      ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
          if (state.isRevalidating)
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

  Widget _buildSectionHeader(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
  }) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 24,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 12),
        Icon(icon, color: color, size: 22),
        const SizedBox(width: 10),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ],
    );
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
