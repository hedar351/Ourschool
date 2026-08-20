// lib/features/Teacher/ui/page/teacher_students_list_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

  final double emptyIconSize = 80.w;
  final double emptyGap = 16.h;
  final double searchBarHorizontalPadding = 16.w;
  final double searchBarVerticalPadding = 8.h;
  final double searchBarRadius = 14.r;
  final double searchIconSize = 22.w;
  final double clearIconSize = 20.w;
  final double searchContentPaddingHorizontal = 16.w;
  final double searchContentPaddingVertical = 12.h;
  final double listHorizontalPadding = 16.w;
  final double listVerticalPadding = 8.h;
  final double cardMarginBottom = 12.h;
  final double noResultIconSize = 64.w;
  final double noResultFontSize = 16.sp;
  final double errorIconSize = 80.w;

  List<Studententity> get _filteredStudents {
    if (_searchQuery.isEmpty) return _students;
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
            setState(() => _students = state.students.students ?? []);
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

          if (state is TeacherStudentListLoading) return const Loadingwidget();
          if (state is TeacherStudentListError) {
            return _buildErrorState(context, state.message);
          }
          if (state is TeacherStudentListLoaded) {
            if (_students.isEmpty) return _buildEmptyState(context);
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

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        '${widget.gradeName} - ${widget.sectionName}',
        style: TextStyle(fontSize: 18.sp),
      ),
      centerTitle: true,
      elevation: 0,
    );
  }

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
              size: emptyIconSize,
              color: theme.colorScheme.outline,
            ),
            SizedBox(height: emptyGap),
            Text(
              'لا يوجد طلاب في هذه الشعبة',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurface,
                fontSize: 16.sp,
              ),
            ),
            SizedBox(height: 8.h),
            OutlinedButton.icon(
              onPressed: () async {
                context.read<TeacherStudentListBloc>().add(
                  RefreshTeacherStudentsEvent(
                    localGradeNumber: widget.localGradeNumber,
                    localSectionNumber: widget.localSectionNumber,
                    localSubjectId: widget.localSubjectId,
                    schoolId: widget.school.schoolId!,
                  ),
                );
              },
              icon: Icon(Icons.refresh_rounded, size: 18.w),
              label: Text(S.of(context).retry),
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ],
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
                context.read<TeacherStudentListBloc>().add(
                  RefreshTeacherStudentsEvent(
                    localGradeNumber: widget.localGradeNumber,
                    localSectionNumber: widget.localSectionNumber,
                    localSubjectId: widget.localSubjectId,
                    schoolId: widget.school.schoolId!,
                  ),
                );
              },
              icon: Icon(
                Icons.refresh,
                color: theme.colorScheme.primary,
                size: 20.w,
              ),
              label: Text(
                'إعادة المحاولة',
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

  Widget _buildLoadedState(
    BuildContext context,
    TeacherStudentListLoaded state,
  ) {
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
                  _buildSearchBar(context),
                  SizedBox(height: 8.h),
                  Expanded(
                    child: filtered.isEmpty
                        ? _buildNoSearchResult(context)
                        : ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            padding: EdgeInsets.symmetric(
                              horizontal: listHorizontalPadding,
                              vertical: listVerticalPadding,
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

  Widget _buildNoSearchResult(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: noResultIconSize,
            color: theme.colorScheme.outline,
          ),
          SizedBox(height: 12.h),
          Text(
            'لا يوجد طلاب تطابق البحث',
            style: TextStyle(
              fontSize: noResultFontSize,
              color: theme.colorScheme.outline,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: searchBarHorizontalPadding,
        vertical: searchBarVerticalPadding,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: theme.brightness == Brightness.dark
              ? Colors.grey.shade800.withOpacity(0.6)
              : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(searchBarRadius),
          border: Border.all(
            color: theme.colorScheme.outline.withOpacity(0.2),
            width: 0.5.w,
          ),
        ),
        child: TextField(
          controller: _searchController,
          onChanged: (value) => setState(() => _searchQuery = value),
          decoration: InputDecoration(
            hintText: 'ابحث عن طالب بالاسم...',
            hintStyle: TextStyle(
              color: theme.colorScheme.outline,
              fontSize: 14.sp,
            ),
            prefixIcon: Icon(
              Icons.search,
              color: theme.colorScheme.outline,
              size: searchIconSize,
            ),
            suffixIcon: _searchQuery.isNotEmpty
                ? IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: theme.colorScheme.outline,
                      size: clearIconSize,
                    ),
                    onPressed: () => setState(() {
                      _searchQuery = '';
                      _searchController.clear();
                    }),
                  )
                : null,
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(
              horizontal: searchContentPaddingHorizontal,
              vertical: searchContentPaddingVertical,
            ),
          ),
          textAlign: TextAlign.right,
        ),
      ),
    );
  }

  Widget _buildStudentCard(BuildContext context, Studententity student) {
    final theme = Theme.of(context);
    return Card(
      margin: EdgeInsets.only(bottom: cardMarginBottom),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
        side: BorderSide(
          color: theme.brightness == Brightness.dark
              ? Colors.grey.shade700.withOpacity(0.3)
              : Colors.grey.shade200,
          width: 0.5.w,
        ),
      ),
      color: theme.cardColor,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: theme.colorScheme.primary,
          child: Text(
            student.name?.isNotEmpty == true ? student.name![0] : '?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          student.name ?? S.of(context).unknown_name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
            color: theme.colorScheme.onSurface,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (student.guardianName != null)
              Text(
                '${S.of(context).guardianName}: ${student.guardianName}',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: theme.colorScheme.outline,
                ),
              ),
            if (student.guardianPhone != null)
              Text(
                '${S.of(context).phone}: ${student.guardianPhone}',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: theme.colorScheme.outline,
                ),
              ),
          ],
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: theme.colorScheme.outline,
          size: 20.w,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => TeacherStudentProfileScreen(
                localStudentNumber: student.localStudentNumber!,
                schoolId: widget.school.schoolId!,
                subjectId: widget.localSubjectId,
              ),
            ),
          );
        },
      ),
    );
  }
}
