import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school/core/widget/Loadingwidget.dart';
import 'package:school/features/Bulletin/ui/bloc/bulletin_bloc.dart';
import 'package:school/features/Bulletin/ui/widget/ScaffoldWidget.dart';

class BulletinScreen extends StatefulWidget {
  const BulletinScreen({super.key});

  @override
  State<BulletinScreen> createState() => _BulletinScreenState();
}

class _BulletinScreenState extends State<BulletinScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<BulletinBloc, BulletinState>(
      builder: (context, state) {
        if (state is BulletinLoading) {
          return const Loadingwidget();
        }
        if (state is BulletinLoaded) {
          return Stack(
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                switchInCurve: Curves.easeInOut,
                switchOutCurve: Curves.easeInOut,
                child: RefreshIndicator(
                  key: ValueKey(state.bulletins.length),
                  onRefresh: () => _onRefresh(context),
                  child: Scaffoldwidget(bulletins: state.bulletins),
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
          );
        }
        if (state is BulletinError) {
          return Center(child: Text(state.message));
        }
        return const Loadingwidget();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<BulletinBloc>().add(GetBulletinsEvent());
    context.read<BulletinBloc>().add(WatchCachedBulletinsEvent());
  }

  Future<void> _onRefresh(BuildContext context) async {
    BlocProvider.of<BulletinBloc>(context).add(RefreshBulletinsEvent());
  }
}
