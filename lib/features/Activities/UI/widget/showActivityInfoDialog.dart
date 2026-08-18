import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school/core/injection.dart' as di;
import 'package:school/features/Activities/UI/bloc/activitiesBloc/activities_bloc.dart';
import 'package:school/features/Activities/UI/bloc/activities_registrations_bloc/activities_registrations_bloc.dart';
import 'package:school/features/Activities/UI/widget/ActivityInfoDialogContent.dart';

void showActivityInfoDialog(BuildContext context, int activityId) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: '',
    transitionDuration: const Duration(milliseconds: 400),
    barrierColor: Colors.black54,
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      final curvedAnimation = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutBack,
      );
      return RepaintBoundary(
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.7, end: 1.0).animate(curvedAnimation),
          child: FadeTransition(
            opacity: Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(curvedAnimation),
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.1),
                end: Offset.zero,
              ).animate(curvedAnimation),
              child: child,
            ),
          ),
        ),
      );
    },
    pageBuilder: (context, animation, secondaryAnimation) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => di.sl<ActivitiesRegistrationsBloc>(),
          ),
          BlocProvider(create: (context) => di.sl<ActivitiesBloc>()),
        ],
        child: ActivityInfoDialogContent(activityId: activityId),
      );
    },
  );
}
