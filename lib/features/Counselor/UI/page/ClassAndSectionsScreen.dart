import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/core/injection.dart' as di;
import 'package:school/core/widget/Loadingwidget.dart';
import 'package:school/features/Counselor/UI/bloc/GradeBloc/grade_bloc.dart';
import 'package:school/features/Counselor/UI/page/CounselorStudentsScreen.dart';
import 'package:school/features/Counselor/domain/Entities/gradeandSectionEntity/SectionEntity.dart';
import 'package:school/features/Counselor/domain/Entities/gradeandSectionEntity/gradeEntity.dart';
import 'package:school/generated/l10n.dart';

class ClassAndSectionsScreen extends StatefulWidget {
  const ClassAndSectionsScreen({super.key});

  @override
  State<ClassAndSectionsScreen> createState() => _ClassAndSectionsScreenState();
}

class _ClassAndSectionsScreenState extends State<ClassAndSectionsScreen>
    with AutomaticKeepAliveClientMixin {
  bool _loaded = false;

  final Set<int> _expandedGradeIds = {};

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocProvider(
      create: (context) => di.sl<GradeBloc>(),
      child: BlocBuilder<GradeBloc, GradeState>(
        builder: (context, state) {
          if (!_loaded && state is GradeInitial) {
            _loaded = true;
            context.read<GradeBloc>().add(GetGradeEvent());
          }

          if (state is GradeLoading) {
            return const Loadingwidget();
          }

          if (state is GradeLoaded) {
            if (state.grade.isEmpty) {
              return _buildEmptyState(context);
            }
            return _buildContent(context, state);
          }

          if (state is GradeError) {
            return _buildErrorState(context, state.message);
          }

          return const Loadingwidget();
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, GradeLoaded state) {
    final theme = Theme.of(context);
    final grades = state.grade;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          S.of(context).classes,
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Stack(
        children: [
          RefreshIndicator(
            onRefresh: () => _onRefresh(context),
            child: ListView(
              padding: EdgeInsets.all(16.w),
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                ...grades.map((grade) => _buildGradeCard(context, grade)),
              ],
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

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          S.of(context).classes,
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inbox_outlined, size: 80.w, color: Colors.grey.shade400),
            SizedBox(height: 16.h),
            Text(
              S.of(context).There_are_no_sections_at_the_moment,
              style: theme.textTheme.titleMedium?.copyWith(fontSize: 16.sp),
            ),
            SizedBox(height: 8.h),
            OutlinedButton.icon(
              onPressed: () => _onRefresh(context),
              icon: const Icon(Icons.refresh_rounded),
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
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          S.of(context).classes,
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 80.w, color: Colors.red.shade300),
            SizedBox(height: 16.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium?.copyWith(fontSize: 16.sp),
            ),
            SizedBox(height: 8.h),
            TextButton.icon(
              onPressed: () {
                context.read<GradeBloc>().add(RefreshGradeEvent());
              },
              icon: Icon(Icons.refresh, size: 20.w),
              label: Text('إعادة المحاولة', style: TextStyle(fontSize: 14.sp)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGradeCard(BuildContext context, Gradeentity grade) {
    final theme = Theme.of(context);
    final sections = grade.sections ?? [];
    final isExpanded = _expandedGradeIds.contains(grade.id);

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10.w,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => _toggleGrade(grade.id!),
            child: Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    theme.colorScheme.primary,
                    theme.colorScheme.primary.withOpacity(0.7),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r),
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.school_rounded, color: Colors.white, size: 24.w),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      grade.name ?? 'صف بدون اسم',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '${sections.length} ${S.of(context).Sections}',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      AnimatedRotation(
                        turns: isExpanded ? 0.5 : 0.0,
                        duration: const Duration(milliseconds: 300),
                        child: Icon(
                          Icons.arrow_drop_down_rounded,
                          color: Colors.white,
                          size: 28.w,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          AnimatedCrossFade(
            duration: const Duration(milliseconds: 300),
            firstChild: const SizedBox.shrink(),
            secondChild: Column(
              children: sections
                  .map((section) => _buildSectionItem(context, section, grade))
                  .toList(),
            ),
            crossFadeState: isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionItem(
    BuildContext context,
    Sectionentity section,
    Gradeentity grade,
  ) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CounselorStudentsScreen(
              sectionName: section.name ?? "شعبة بدون اسم",
              localGradeNumber: grade.localGradeNumber ?? 0,
              localSectionNumber: section.localSectionNumber ?? 0,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: theme.dividerColor.withOpacity(0.08),
              width: 0.5.w,
            ),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(
                child: Icon(
                  Icons.class_rounded,
                  color: theme.colorScheme.primary,
                  size: 20.w,
                ),
              ),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    section.name ?? 'شعبة بدون اسم',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'اضغط لعرض الطلاب',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16.w,
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onRefresh(BuildContext context) async {
    context.read<GradeBloc>().add(RefreshGradeEvent());
  }

  void _toggleGrade(int gradeId) {
    setState(() {
      if (_expandedGradeIds.contains(gradeId)) {
        _expandedGradeIds.remove(gradeId);
      } else {
        _expandedGradeIds.add(gradeId);
      }
    });
  }
}
