
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/core/injection.dart' as di;
import 'package:school/core/widget/Loadingwidget.dart';
import 'package:school/core/widget/SnackBar/Message.dart';
import 'package:school/generated/l10n.dart';

import '../bloc/school_info_bloc.dart';
import '../widget/school_card_widget.dart';

class SchoolsScreen extends StatelessWidget {
  const SchoolsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<SchoolInfoBloc>()..add(GetSchoolsEvent()),
      child: const SchoolsScreenView(),
    );
  }
}

class SchoolsScreenView extends StatefulWidget {
  const SchoolsScreenView({super.key});

  @override
  State<SchoolsScreenView> createState() => _SchoolsScreenViewState();
}

class _SchoolsScreenViewState extends State<SchoolsScreenView>
    with AutomaticKeepAliveClientMixin, WidgetsBindingObserver {
  late SnackBarMessage snackBarMessage;

  final double emptyIconSize = 80.w;
  final double emptyGap = 16.h;
  final double emptyGapSmall = 8.h;
  final double errorIconSize = 80.w;
  final double errorGap = 16.h;
  final double errorPaddingHorizontal = 32.w;
  final double listPaddingHorizontal = 16.w;
  final double bottomSpacing = 80.h;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocConsumer<SchoolInfoBloc, SchoolInfoState>(
      listener: (context, state) {
        if (state is SchoolInfoError) {
          snackBarMessage.errorMessage(
            message: state.message,
            context: context,
          );
        }
      },
      builder: (context, state) {
        if (state is SchoolInfoLoading) {
          return const Loadingwidget();
        }

        if (state is SchoolInfoLoaded) {
          final schools = state.schools.schoolInfo ?? [];
          if (schools.isEmpty) {
            return _buildEmptyState(context);
          }
          return _buildLoadedState(context, state);
        }

        if (state is SchoolInfoError) {
          return _buildErrorState(context, state.message);
        }

        return const Loadingwidget();
      },
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
    _loadData();
  }

  AppBar _buildAppBar(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      title: Text(
        S.of(context).affiliatedSchools,
        style: theme.textTheme.headlineMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.onSurface,
          fontSize: 20.sp,
        ),
      ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: theme.scaffoldBackgroundColor,
      foregroundColor: theme.colorScheme.onSurface,
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
              Icons.school_outlined,
              size: emptyIconSize,
              color: theme.colorScheme.primary.withOpacity(0.3),
            ),
            SizedBox(height: emptyGap),
            Text(
              S.of(context).noSchools,
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurface,
                fontSize: 16.sp,
              ),
            ),
            SizedBox(height: emptyGapSmall),
            Text(
              S.of(context).pullToRefresh,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.outline,
                fontSize: 12.sp,
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
            SizedBox(height: errorGap),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: errorPaddingHorizontal),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.error,
                  fontSize: 16.sp,
                ),
              ),
            ),
            SizedBox(height: errorGap),
            TextButton.icon(
              onPressed: () {
                context.read<SchoolInfoBloc>().add(RefreshSchoolsEvent());
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

  Widget _buildLoadedState(BuildContext context, SchoolInfoLoaded state) {
    final schools = state.schools.schoolInfo ?? [];
    final theme = Theme.of(context);

    return Scaffold(
      appBar: _buildAppBar(context),
      body: RefreshIndicator(
        onRefresh: () => _onRefresh(context),
        color: theme.colorScheme.primary,
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: listPaddingHorizontal),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final school = schools[index];
                  return SchoolCardWidget(school: school);
                }, childCount: schools.length),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: bottomSpacing)),
          ],
        ),
      ),
    );
  }

  void _loadData() {
    final bloc = context.read<SchoolInfoBloc>();
    final currentState = bloc.state;

    if (currentState is SchoolInfoInitial || currentState is SchoolInfoError) {
      bloc.add(GetSchoolsEvent());
    } else if (currentState is SchoolInfoLoaded &&
        !currentState.isRevalidating) {
      bloc.add(RevalidateSchoolsEvent());
    }
  }

  Future<void> _onRefresh(BuildContext context) async {
    context.read<SchoolInfoBloc>().add(RefreshSchoolsEvent());
  }
}
