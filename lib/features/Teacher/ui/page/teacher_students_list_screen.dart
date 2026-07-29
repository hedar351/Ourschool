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
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // ====== قائمة الطلاب المفلترة ======
  List<Studententity> get _filteredStudents {
    if (_searchQuery.isEmpty) {
      return _students;
    }
    return _students.where((student) {
      final name = student.name?.toLowerCase() ?? '';
      return name.contains(_searchQuery.toLowerCase());
    }).toList();
  }

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

            return _buildLoadedState(context, state);
          }

          return const Loadingwidget();
        },
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // ====================================================================
  // ====== AppBar ======
  // ====================================================================

  AppBar _buildAppBar(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      title: Text('${widget.gradeName} - ${widget.sectionName}'),
      centerTitle: true,
      elevation: 0,
      backgroundColor: theme.scaffoldBackgroundColor,
      foregroundColor: theme.colorScheme.onSurface,
    );
  }

  // ====================================================================
  // ====== حالة فارغة ======
  // ====================================================================

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inbox_outlined,
              size: 80,
              color: theme.colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(
              'لا يوجد طلاب في هذه الشعبة',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              S.of(context).Pull_down_to_refresh,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.outline,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ====================================================================
  // ====== حالة الخطأ ======
  // ====================================================================

  Widget _buildErrorState(BuildContext context, String message) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 80, color: theme.colorScheme.error),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.error,
              ),
            ),
            const SizedBox(height: 16),
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
              icon: Icon(Icons.refresh, color: theme.colorScheme.primary),
              label: Text(
                'إعادة المحاولة',
                style: TextStyle(color: theme.colorScheme.primary),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ====================================================================
  // ====== الحالة المحملة (مع البحث) ======
  // ====================================================================

  Widget _buildLoadedState(
    BuildContext context,
    TeacherStudentListLoaded state,
  ) {
    final theme = Theme.of(context);
    final filtered = _filteredStudents;

    return Scaffold(
      appBar: _buildAppBar(context),
      body: Stack(
        children: [
          SafeArea(
            child: RefreshIndicator(
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
              color: Colors.transparent,
              backgroundColor: Colors.transparent,
              strokeWidth: 0,
              child: Column(
                children: [
                  // ====== شريط البحث ======
                  _buildSearchBar(context),
                  const SizedBox(height: 8),

                  // ====== قائمة الطلاب ======
                  Expanded(
                    child: filtered.isEmpty
                        ? _buildNoSearchResult(context)
                        : ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            itemCount: filtered.length,
                            itemBuilder: (context, index) {
                              final student = filtered[index];
                              return _buildStudentCard(context, student);
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
          // ====== شريط التحميل العلوي ======
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

  // ====================================================================
  // ====== رسالة عدم وجود نتائج بحث ======
  // ====================================================================

  Widget _buildNoSearchResult(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 64, color: theme.colorScheme.outline),
          const SizedBox(height: 12),
          Text(
            'لا يوجد طلاب تطابق البحث',
            style: TextStyle(fontSize: 16, color: theme.colorScheme.outline),
          ),
        ],
      ),
    );
  }

  // ====================================================================
  // ====== شريط البحث ======
  // ====================================================================

  Widget _buildSearchBar(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: theme.brightness == Brightness.dark
              ? Colors.grey.shade800.withOpacity(0.6)
              : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: theme.colorScheme.outline.withOpacity(0.2),
            width: 0.5,
          ),
        ),
        child: TextField(
          controller: _searchController,
          onChanged: (value) {
            setState(() {
              _searchQuery = value;
            });
          },
          decoration: InputDecoration(
            hintText: 'ابحث عن طالب بالاسم...',
            hintStyle: TextStyle(
              color: theme.colorScheme.outline,
              fontSize: 14,
            ),
            prefixIcon: Icon(
              Icons.search,
              color: theme.colorScheme.outline,
              size: 22,
            ),
            suffixIcon: _searchQuery.isNotEmpty
                ? IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: theme.colorScheme.outline,
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        _searchQuery = '';
                        _searchController.clear();
                      });
                    },
                  )
                : null,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
          textAlign: TextAlign.right,
        ),
      ),
    );
  }

  // ====================================================================
  // ====== بطاقة الطالب ======
  // ====================================================================

  Widget _buildStudentCard(BuildContext context, Studententity student) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: theme.brightness == Brightness.dark
              ? Colors.grey.shade700.withOpacity(0.3)
              : Colors.grey.shade200,
          width: 0.5,
        ),
      ),
      color: theme.cardColor,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: theme.colorScheme.primary,
          child: Text(
            student.name?.isNotEmpty == true ? student.name![0] : '?',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          student.name ?? S.of(context).unknown_name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (student.guardianName != null)
              Text(
                '${S.of(context).guardianName}: ${student.guardianName}',
                style: TextStyle(color: theme.colorScheme.outline),
              ),
            if (student.guardianPhone != null)
              Text(
                '${S.of(context).phone}: ${student.guardianPhone}',
                style: TextStyle(color: theme.colorScheme.outline),
              ),
          ],
        ),
        trailing: Icon(Icons.chevron_right, color: theme.colorScheme.outline),
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
