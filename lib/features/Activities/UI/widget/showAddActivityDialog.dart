import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school/core/injection.dart' as di;
import 'package:school/features/Activities/UI/bloc/activitiesBloc/activities_bloc.dart';
import 'package:school/features/Activities/UI/widget/AddActivityDialog.dart';

void showAddActivityDialog(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierDismissible: false,
    barrierLabel: '',
    transitionDuration: const Duration(milliseconds: 500),
    barrierColor: Colors.black54,
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return RepaintBoundary(
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.5, end: 1.0).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
          ),
          child: FadeTransition(
            opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOut),
            ),
            child: SlideTransition(
              position:
                  Tween<Offset>(
                    begin: const Offset(0, 0.3),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOutCubic,
                    ),
                  ),
              child: child,
            ),
          ),
        ),
      );
    },
    pageBuilder: (context, animation, secondaryAnimation) {
      return BlocProvider(
        create: (context) => di.sl<ActivitiesBloc>(),
        child: const AddActivityDialog(),
      );
    },
  );
}
