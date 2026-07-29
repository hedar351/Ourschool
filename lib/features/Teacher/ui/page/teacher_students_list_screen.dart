import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school/core/injection.dart' as di;
import 'package:school/core/widget/Loadingwidget.dart';
import 'package:school/features/Counselor/domain/Entities/StudentsBySectionEntity/studentEntity.dart';
import 'package:school/features/Teacher/domain/Entities/TeacherProfileEntities/schoolsEntity.dart';
import 'package:school/features/Teacher/ui/bloc/StudentListBloc/teacher_student_list_bloc.dart';
import 'package:school/features/Teacher/ui/page/teacher_student_profile_screen.dart';
import 'package:school/generated/l10n.dart';

class TeacherStudentsListScreen extends StatefulWidget {
  final int localGradeNumber;
  final int localSectionNumber;
  final int localSubjectId;
  final String gradeName;
  final String sectionName;
  final String subjectName;
  final Schoolsentity school;
  const TeacherStudentsListScreen({
    super.key,
    required this.localGradeNumber,
    required this.localSectionNumber,
    required this.localSubjectId,
    required this.gradeName,
    required this.sectionName,
    required this.subjectName,
    required this.school,
  });

  @override
  State<TeacherStudentsListScreen> createState() =>
      _TeacherStudentsListScreenState();
}

class _TeacherStudentsListScreenState extends State<TeacherStudentsListScreen> {
  List<Studententity> _students = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.sl<TeacherStudentListBloc>(),
      child: BlocConsumer<TeacherStudentListBloc, TeacherStudentListState>(
        listener: (context, state) {
          if (state is TeacherStudentListLoaded) {
            setState(() {
              _students = state.students.students ?? [];
            });
          }
        },
        builder: (context, state) {
          if (state is TeacherStudentListInitial) {
            context.read<TeacherStudentListBloc>().add(
              GetTeacherStudentsEvent(
                localGradeNumber: widget.localGradeNumber,
                localSectionNumber: widget.localSectionNumber,
                localSubjectId: widget.localSubjectId,
                schoolId: widget.school.schoolId!,
              ),
            );
            context.read<TeacherStudentListBloc>().add(
              WatchCachedTeacherStudentsEvent(
                localGradeNumber: widget.localGradeNumber,
                localSectionNumber: widget.localSectionNumber,
                localSubjectId: widget.localSubjectId,
                schoolId: widget.school.schoolId!,
              ),
            );
          }

          if (state is TeacherStudentListLoading) {
            return const Loadingwidget();
          }

          if (state is TeacherStudentListError) {
            return _buildErrorState(context, state.message);
          }

          if (state is TeacherStudentListLoaded) {
            if (_students.isEmpty) {
              return _buildEmptyState(context);
            }

            return Scaffold(
              appBar: AppBar(
                title: Text('${widget.gradeName} - ${widget.sectionName}'),
                centerTitle: true,
              ),
              body: Stack(
                children: [
                  RefreshIndicator(
                    onRefresh: () async {
                      context.read<TeacherStudentListBloc>().add(
                        RefreshTeacherStudentsEvent(
                          localGradeNumber: widget.localGradeNumber,
                          localSectionNumber: widget.localSectionNumber,
                          localSubjectId: widget.localSubjectId,
                          schoolId: widget.school.schoolId!,
                        ),
                      );
                    },
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      itemCount: _students.length,
                      itemBuilder: (context, index) {
                        final student = _students[index];
                        return _buildStudentCard(context, student);
                      },
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

          return const Loadingwidget();
        },
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox_outlined, size: 80, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(
            'لا يوجد طلاب في هذه الشعبة',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            S.of(context).Pull_down_to_refresh,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
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
              context.read<TeacherStudentListBloc>().add(
                RefreshTeacherStudentsEvent(
                  localGradeNumber: widget.localGradeNumber,
                  localSectionNumber: widget.localSectionNumber,
                  localSubjectId: widget.localSubjectId,
                  schoolId: widget.school.schoolId!,
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

  Widget _buildStudentCard(BuildContext context, Studententity student) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: theme.colorScheme.primary,
          child: Text(
            student.name?.isNotEmpty == true ? student.name![0] : '?',
            style: const TextStyle(color: Colors.white),
          ),
        ),
        title: Text(
          student.name ?? S.of(context).unknown_name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (student.guardianName != null)
              Text('${S.of(context).guardianName}: ${student.guardianName}'),
            if (student.guardianPhone != null)
              Text('${S.of(context).phone}: ${student.guardianPhone}'),
          ],
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => TeacherStudentProfileScreen(
                localStudentNumber: student.localStudentNumber!,
                schoolId: widget.school.schoolId!,
              ),
            ),
          );
        },
      ),
    );
  }
}
