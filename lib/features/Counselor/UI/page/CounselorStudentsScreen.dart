import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

  final double emptyIconSize = 80.w;
  final double emptyGap = 16.h;
  final double errorIconSize = 80.w;
  final double errorGap = 16.h;
  final double listPadding = 16.w;
  final double listGap = 12.h;
  final double cardPadding = 12.w;
  final double avatarSize = 50.w;
  final double avatarRadius = 16.r;
  final double avatarFontSize = 24.sp;
  final double nameFontSize = 18.sp;
  final double infoFontSize = 12.sp;
  final double iconSize = 14.w;
  final double chevronSize = 24.w;
  final double cardElevation = 4;

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
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("لا توجد صورة جدول لهذه الشعبة")),
            );
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
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox_outlined,
            size: emptyIconSize,
            color: Colors.grey.shade400,
          ),
          SizedBox(height: emptyGap),
          Text(
            'لا يوجد طلاب في هذه الشعبة',
            style: theme.textTheme.titleMedium?.copyWith(fontSize: 16.sp),
          ),
          SizedBox(height: 8.h),
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
            size: errorIconSize,
            color: Colors.red.shade300,
          ),
          SizedBox(height: errorGap),
          Text(
            message,
            textAlign: TextAlign.center,
            style: theme.textTheme.titleMedium?.copyWith(fontSize: 16.sp),
          ),
          SizedBox(height: 8.h),
          TextButton.icon(
            onPressed: () {
              context.read<StudentsBloc>().add(
                RefreshStudentsEvent(
                  localGradeNumber: widget.localGradeNumber,
                  localSectionNumber: widget.localSectionNumber,
                ),
              );
            },
            icon: Icon(Icons.refresh, size: 20.w),
            label: Text('إعادة المحاولة', style: TextStyle(fontSize: 14.sp)),
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
      child: Icon(Icons.image, size: 24.w),
    );
  }

  Widget _buildLoadedState(
    BuildContext context,
    StudentsLoaded state,
    List<Studententity> students,
  ) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.sectionName),
        centerTitle: true,
        elevation: 0,
        // backgroundColor: theme.scaffoldBackgroundColor,
        // foregroundColor: theme.colorScheme.onSurface,
      ),
      backgroundColor: theme.scaffoldBackgroundColor,
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
            color: Colors.transparent,
            backgroundColor: Colors.transparent,
            strokeWidth: 0,
            child: ListView.separated(
              padding: EdgeInsets.all(listPadding),
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: students.length,
              separatorBuilder: (_, _) => SizedBox(height: listGap),
              itemBuilder: (context, index) {
                final student = students[index];
                return _buildStudentCard(context, student);
              },
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
        elevation: cardElevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(cardPadding),
          child: Row(
            children: [
              Container(
                width: avatarSize,
                height: avatarSize,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      theme.colorScheme.primary,
                      theme.colorScheme.primaryContainer,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(avatarRadius),
                ),
                child: Center(child: Icon(Icons.person)),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      student.name ?? 'طالب بدون اسم',
                      style: TextStyle(
                        fontSize: nameFontSize,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(
                          Icons.person,
                          size: iconSize,
                          color: theme.colorScheme.outline,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          "${S.of(context).guardianName}  ${student.guardianName ?? 'غير محدد'}",
                          style: TextStyle(
                            fontSize: infoFontSize,
                            color: theme.colorScheme.outline,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      children: [
                        Icon(
                          Icons.phone,
                          size: iconSize,
                          color: theme.colorScheme.outline,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          student.guardianPhone ?? 'غير محدد',
                          style: TextStyle(
                            fontSize: infoFontSize,
                            color: theme.colorScheme.outline,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: theme.colorScheme.primary,
                size: chevronSize,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
