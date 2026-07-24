// // lib/features/SchoolsInfo/presentation/pages/schools_screen.dart

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:school/core/injection.dart' as di;
// import 'package:school/core/widget/Loadingwidget.dart';
// import 'package:school/core/widget/SnackBar/Message.dart';

// import '../bloc/school_info_bloc.dart';
// import '../widget/school_card_widget.dart';

// class SchoolsScreen extends StatelessWidget {
//   const SchoolsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => di.sl<SchoolInfoBloc>()..add(GetSchoolsEvent()),
//       child: const SchoolsScreenView(),
//     );
//   }
// }

// class SchoolsScreenView extends StatefulWidget {
//   const SchoolsScreenView({super.key});

//   @override
//   State<SchoolsScreenView> createState() => _SchoolsScreenViewState();
// }

// class _SchoolsScreenViewState extends State<SchoolsScreenView>
//     with AutomaticKeepAliveClientMixin, WidgetsBindingObserver {
//   late SnackBarMessage snackBarMessage;

//   @override
//   bool get wantKeepAlive => true;

//   @override
//   Widget build(BuildContext context) {
//     super.build(context);

//     return BlocConsumer<SchoolInfoBloc, SchoolInfoState>(
//       listener: (context, state) {
//         if (state is SchoolInfoError) {
//           snackBarMessage.errorMessage(
//             message: state.message,
//             context: context,
//           );
//         }
//       },
//       builder: (context, state) {
//         if (state is SchoolInfoLoading) {
//           return const Loadingwidget();
//         }

//         if (state is SchoolInfoLoaded) {
//           final schools = state.schools.schoolInfo ?? [];
//           if (schools.isEmpty) {
//             return _buildEmptyState(context);
//           }
//           return _buildLoadedState(context, state);
//         }

//         if (state is SchoolInfoError) {
//           return _buildErrorState(context, state.message);
//         }

//         return const Loadingwidget();
//       },
//     );
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.resumed) {
//       _loadData();
//     }
//   }

//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//     snackBarMessage = SnackBarMessage();
//     _loadData();
//   }

//   AppBar _buildAppBar(BuildContext context) {
//     return AppBar(
//       title: const Text('المدارس'),
//       centerTitle: true,
//       elevation: 0,
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       foregroundColor: Theme.of(context).colorScheme.onSurface,
//     );
//   }

//   Widget _buildEmptyState(BuildContext context) {
//     return Scaffold(
//       appBar: _buildAppBar(context),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.school_outlined, size: 80, color: Colors.grey.shade400),
//             const SizedBox(height: 16),
//             Text(
//               'لا توجد مدارس متاحة حالياً',
//               style: Theme.of(context).textTheme.titleMedium,
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'اسحب للأسفل للتحديث',
//               style: Theme.of(context).textTheme.bodySmall,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildErrorState(BuildContext context, String message) {
//     return Scaffold(
//       appBar: _buildAppBar(context),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.error_outline, size: 80, color: Colors.red.shade300),
//             const SizedBox(height: 16),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 32),
//               child: Text(
//                 message,
//                 textAlign: TextAlign.center,
//                 style: Theme.of(context).textTheme.titleMedium,
//               ),
//             ),
//             const SizedBox(height: 16),
//             TextButton.icon(
//               onPressed: () {
//                 context.read<SchoolInfoBloc>().add(RefreshSchoolsEvent());
//               },
//               icon: const Icon(Icons.refresh),
//               label: const Text('إعادة المحاولة'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildLoadedState(BuildContext context, SchoolInfoLoaded state) {
//     final schools = state.schools.schoolInfo ?? [];

//     return Scaffold(
//       appBar: _buildAppBar(context),
//       body: RefreshIndicator(
//         onRefresh: () => _onRefresh(context),
//         child: CustomScrollView(
//           slivers: [
//             SliverPadding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               sliver: SliverList(
//                 delegate: SliverChildBuilderDelegate((context, index) {
//                   final school = schools[index];
//                   return SchoolCardWidget(school: school);
//                 }, childCount: schools.length),
//               ),
//             ),
//             const SliverToBoxAdapter(child: SizedBox(height: 80)),
//           ],
//         ),
//       ),
//     );
//   }

//   void _loadData() {
//     final bloc = context.read<SchoolInfoBloc>();
//     final currentState = bloc.state;

//     if (currentState is SchoolInfoInitial || currentState is SchoolInfoError) {
//       bloc.add(GetSchoolsEvent());
//     } else if (currentState is SchoolInfoLoaded &&
//         !currentState.isRevalidating) {
//       bloc.add(RevalidateSchoolsEvent());
//     }
//   }

//   Future<void> _onRefresh(BuildContext context) async {
//     context.read<SchoolInfoBloc>().add(RefreshSchoolsEvent());
//   }
// }
// lib/features/SchoolsInfo/presentation/pages/schools_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
              size: 80,
              color: theme.colorScheme.primary.withOpacity(0.3),
            ),
            const SizedBox(height: 16),
            Text(
              S.of(context).noSchools,
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              S.of(context).pullToRefresh,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.outline,
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
            Icon(Icons.error_outline, size: 80, color: theme.colorScheme.error),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.error,
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextButton.icon(
              onPressed: () {
                context.read<SchoolInfoBloc>().add(RefreshSchoolsEvent());
              },
              icon: Icon(Icons.refresh, color: theme.colorScheme.primary),
              label: Text(
                S.of(context).retry,
                style: TextStyle(color: theme.colorScheme.primary),
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
            // SliverToBoxAdapter(
            //   child: Padding(
            //     padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Text(
            //           S.of(context).affiliatedSchools,
            //           style: theme.textTheme.headlineMedium?.copyWith(
            //             fontWeight: FontWeight.bold,
            //             color: theme.colorScheme.onSurface,
            //           ),
            //         ),

            //         const SizedBox(height: 4),
            //         Text(
            //           '${schools.length} ${S.of(context).schools}',
            //           style: theme.textTheme.bodyMedium?.copyWith(
            //             color: theme.colorScheme.outline,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final school = schools[index];
                  return SchoolCardWidget(school: school);
                }, childCount: schools.length),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 80)),
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
