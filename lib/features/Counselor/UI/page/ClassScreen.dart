// lib/features/Counselor/UI/page/ClassScreen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/core/injection.dart' as di;
import 'package:school/core/widget/Loadingwidget.dart';
import 'package:school/features/Counselor/UI/bloc/GradeBloc/grade_bloc.dart';
import 'package:school/features/Counselor/UI/widget/GradesGrid.dart';
import 'package:school/generated/l10n.dart';

class ClassScreen extends StatefulWidget {
  const ClassScreen({super.key});

  @override
  State<ClassScreen> createState() => _ClassScreenState();
}

class _ClassScreenState extends State<ClassScreen>
    with AutomaticKeepAliveClientMixin {
  bool _loaded = false;

  // ✅ حسابات القيم الثابتة خارج build
  final double emptyIconSize = 80.w;
  final double emptyGap = 16.h;
  final double errorIconSize = 80.w;
  final double errorGap = 16.h;

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
            print("[bloc]:context.read<GradeBloc>().add(GetGradeEvent())");
          }

          if (state is GradeLoading) {
            return const Loadingwidget();
          }
          if (state is GradeLoaded) {
            if (state.grade.isEmpty) {
              return _buildEmptyState(context);
            }
            return _buildLoadedState(context, state);
          }
          if (state is GradeError) {
            return _buildErrorState(context, state.message);
          }
          return const Loadingwidget();
        },
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
            S.of(context).There_are_no_sections_at_the_moment,
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
              context.read<GradeBloc>().add(RefreshGradeEvent());
            },
            icon: Icon(Icons.refresh, size: 20.w),
            label: Text('إعادة المحاولة', style: TextStyle(fontSize: 14.sp)),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadedState(BuildContext context, GradeLoaded state) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Stack(
          children: [
            GradesGrid(
              grade: state.grade,
              onRefresh: () => _onRefresh(context),
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
      ),
    );
  }

  Future<void> _onRefresh(BuildContext context) async {
    context.read<GradeBloc>().add(RefreshGradeEvent());
  }
}
