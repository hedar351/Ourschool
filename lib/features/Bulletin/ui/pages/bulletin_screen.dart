// lib/features/Bulletin/ui/pages/bulletin_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/core/widget/Loadingwidget.dart';
import 'package:school/core/widget/SnackBar/Message.dart';
import 'package:school/features/Bulletin/ui/bloc/bulletin_bloc.dart';
import 'package:school/features/Bulletin/ui/widget/ScaffoldWidget.dart';
import 'package:school/generated/l10n.dart';

class BulletinScreen extends StatefulWidget {
  const BulletinScreen({super.key});

  @override
  State<BulletinScreen> createState() => _BulletinScreenState();
}

class _BulletinScreenState extends State<BulletinScreen>
    with AutomaticKeepAliveClientMixin, WidgetsBindingObserver {
  late SnackBarMessage snackBarMessage;

  // ✅ حسابات القيم الثابتة خارج build
  final double _iconSize = 80.w;
  final double _iconColor = 0.4;
  final double _gapSmall = 16.h;
  final double _gapMedium = 8.h;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocConsumer<BulletinBloc, BulletinState>(
      listener: (context, state) {
        if (state is BulletinError) {
          snackBarMessage.errorMessage(
            message: state.message,
            context: context,
          );
        }
      },
      builder: (context, state) {
        if (state is BulletinLoading) {
          return const Loadingwidget();
        }
        if (state is BulletinLoaded) {
          if (state.bulletins.isEmpty) {
            return _buildEmptyState(context);
          }
          return _buildLoadedState(context, state);
        }
        if (state is BulletinError) {
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

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox_outlined,
            size: _iconSize,
            color: Colors.grey.shade400,
          ),
          SizedBox(height: _gapSmall),
          Text(
            S.of(context).There_are_no_bulletins_at_the_moment,
            style: theme.textTheme.titleMedium?.copyWith(fontSize: 16.sp),
          ),
          SizedBox(height: _gapMedium),
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
            size: _iconSize,
            color: Colors.red.shade300,
          ),
          SizedBox(height: _gapSmall),
          Text(
            message,
            textAlign: TextAlign.center,
            style: theme.textTheme.titleMedium?.copyWith(fontSize: 16.sp),
          ),
          SizedBox(height: _gapMedium),
          TextButton.icon(
            onPressed: () {
              context.read<BulletinBloc>().add(RefreshBulletinsEvent());
            },
            icon: Icon(Icons.refresh, size: 20.w),
            label: Text('إعادة المحاولة', style: TextStyle(fontSize: 14.sp)),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadedState(BuildContext context, BulletinLoaded state) {
    return Stack(
      children: [
        Scaffoldwidget(
          bulletins: state.bulletins,
          onRefresh: () => _onRefresh(context),
        ),
      ],
    );
  }

  void _loadData() {
    final bloc = context.read<BulletinBloc>();
    final currentState = bloc.state;

    if (currentState is BulletinInitial || currentState is BulletinError) {
      bloc.add(GetBulletinsEvent());
    } else if (currentState is BulletinLoaded && !currentState.isRevalidating) {
      bloc.add(RevalidateBulletinsEvent());
    }
  }

  Future<void> _onRefresh(BuildContext context) async {
    context.read<BulletinBloc>().add(RefreshBulletinsEvent());
  }
}
