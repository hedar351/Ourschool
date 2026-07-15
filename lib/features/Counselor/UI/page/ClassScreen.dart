import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school/core/injection.dart' as di;
import 'package:school/core/widget/Loadingwidget.dart';
import 'package:school/features/Counselor/UI/bloc/grade_bloc.dart';
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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox_outlined, size: 80, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(
            S.of(context).There_are_no_sections_at_the_moment,
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
              context.read<GradeBloc>().add(RefreshGradeEvent());
            },
            icon: const Icon(Icons.refresh),
            label: const Text('إعادة المحاولة'),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadedState(BuildContext context, GradeLoaded state) {
    return GradesGrid(grade: state.grade, onRefresh: () => _onRefresh(context));
  }

  Future<void> _onRefresh(BuildContext context) async {
    context.read<GradeBloc>().add(RefreshGradeEvent());
  }
}
