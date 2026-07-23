import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school/core/widget/showImageViewer.dart';
import 'package:school/features/Counselor/UI/bloc/StudentListBLoc/student_list_bloc.dart';

import '../../../../core/injection.dart' as di;
import '../../../../core/widget/Loadingwidget.dart';
import '../../../../generated/l10n.dart';
import '../../domain/Entities/StudentsBySectionEntity/studentEntity.dart';
import '../bloc/StudentListBLoc/student_list_event.dart';
import '../bloc/StudentListBLoc/student_list_state.dart';
import '../bloc/schedule-imagesBloc/schedule_images_bloc.dart';
import 'CounsolerStudentDetailScreen.dart';

class CounselorStudentsScreen extends StatefulWidget {
  final int localGradeNumber;
  final int localSectionNumber;
  final String sectionName;

  const CounselorStudentsScreen({
    super.key,
    required this.sectionName,
    required this.localGradeNumber,
    required this.localSectionNumber,
  });

  @override
  State<CounselorStudentsScreen> createState() =>
      _CounselorStudentsScreenState();
}

class _CounselorStudentsScreenState extends State<CounselorStudentsScreen>
    with AutomaticKeepAliveClientMixin {
  bool _loaded = false;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.sl<StudentsBloc>()),
        BlocProvider(create: (context) => di.sl<ScheduleImagesBloc>()),
      ],
      child: BlocListener<ScheduleImagesBloc, ScheduleImagesState>(
        listener: (context, state) {
          if (state is ScheduleImagesLoaded) {
            setState(() {});
            showImageViewer(context, state.scheduleImage.imageUrl);
          } else if (state is ScheduleImagesError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: BlocBuilder<StudentsBloc, StudentsState>(
          builder: (context, state) {
            if (!_loaded && state is StudentsInitial) {
              _loaded = true;
              context.read<StudentsBloc>().add(
                GetStudentsEvent(
                  localGradeNumber: widget.localGradeNumber,
                  localSectionNumber: widget.localSectionNumber,
                ),
              );
              print(
                "[bloc]: context.read<StudentsBloc>().add(GetStudentsEvent())",
              );
            }

            if (state is StudentsLoading) {
              return const Loadingwidget();
            }

            if (state is StudentsLoaded) {
              final students = state.students.students ?? [];
              if (students.isEmpty) {
                return _buildEmptyState(context);
              }
              return _buildLoadedState(context, state, students);
            }

            if (state is StudentsError) {
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
    super.dispose();
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
              context.read<StudentsBloc>().add(
                RefreshStudentsEvent(
                  localGradeNumber: widget.localGradeNumber,
                  localSectionNumber: widget.localSectionNumber,
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

  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        context.read<ScheduleImagesBloc>().add(
          GetScheduleImageEvent(
            localGradeNumber: widget.localGradeNumber,
            localSectionNumber: widget.localSectionNumber,
          ),
        );
      },
      backgroundColor: Colors.green,
      child: const Icon(Icons.image),
    );
  }

  Widget _buildLoadedState(
    BuildContext context,
    StudentsLoaded state,
    List<Studententity> students,
  ) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.sectionName)),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      floatingActionButton: _buildFloatingActionButton(context),
      body: Stack(
        children: [
          RefreshIndicator(
            onRefresh: () async {
              context.read<StudentsBloc>().add(
                RefreshStudentsEvent(
                  localGradeNumber: widget.localGradeNumber,
                  localSectionNumber: widget.localSectionNumber,
                ),
              );
            },
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: students.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final student = students[index];
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

  Widget _buildStudentCard(BuildContext context, Studententity student) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () {
        print(student.localStudentNumber);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CounsolerStudentDetailScreen(
              localStudentNumber: student.localStudentNumber ?? 0,
            ),
          ),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      theme.colorScheme.primary,
                      theme.colorScheme.primaryContainer,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    student.name?.isNotEmpty == true ? student.name![0] : '?',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      student.name ?? 'طالب بدون اسم',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.person, size: 14, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text(
                          "${S.of(context).guardianName}  ${student.guardianName ?? 'غير محدد'}",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Icon(Icons.phone, size: 14, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text(
                          student.guardianPhone ?? 'غير محدد',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
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
