import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   if (state == AppLifecycleState.resumed) {
  //     _loadData();
  //   }
  // }
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadData();
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox_outlined, size: 80, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(
            S.of(context).There_are_no_bulletins_at_the_moment,
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
              context.read<BulletinBloc>().add(RefreshBulletinsEvent());
            },
            icon: const Icon(Icons.refresh),
            label: const Text('إعادة المحاولة'),
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
