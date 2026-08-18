import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/core/injection.dart' as di;
import 'package:school/features/Activities/UI/bloc/activitiesBloc/activities_bloc.dart';
import 'package:school/features/Cross-role/Bulletin/domain/Entities/AnnouncementActivityEntity.dart';
import 'package:school/features/Cross-role/Bulletin/ui/bloc/bulletin_bloc.dart';
import 'package:school/generated/l10n.dart';

void showDeleteConfirmationActivity(
  BuildContext bottomSheetContext,
  Announcementactivityentity entity,
) {
  showGeneralDialog(
    context: bottomSheetContext,
    barrierDismissible: false,
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
      return BlocProvider(
        create: (context) => di.sl<ActivitiesBloc>(),
        child: AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.r),
          ),
          title: Row(
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: Colors.red.shade600,
                size: 28.w,
              ),
              SizedBox(width: 10.w),
              Text(
                S.of(context).delete_confirmation_title,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ],
          ),
          content: Text(
            S.of(context).delete_confirmation_content,
            style: TextStyle(
              fontSize: 14.sp,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                S.of(context).cancel,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
            BlocConsumer<ActivitiesBloc, ActivitiesState>(
              listener: (context, state) {
                if (state is ActivitiesSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.green,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                  Navigator.pop(context);
                  Navigator.pop(bottomSheetContext);
                  context.read<BulletinBloc>().add(RefreshBulletinsEvent());
                }
                if (state is ActivitiesError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                      duration: const Duration(seconds: 3),
                    ),
                  );
                }
              },
              builder: (context, state) {
                final isLoading = state is ActivitiesLoading;
                return ElevatedButton.icon(
                  onPressed: isLoading
                      ? null
                      : () {
                          context.read<ActivitiesBloc>().add(
                            DeleteActivityEvent(localActivityId: entity.id),
                          );
                        },
                  icon: isLoading
                      ? SizedBox(
                          width: 20.w,
                          height: 20.w,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.w,
                          ),
                        )
                      : Icon(Icons.delete_rounded, size: 20.w),
                  label: Text(
                    isLoading ? S.of(context).deleting : S.of(context).delete,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade600,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 12.h,
                    ),
                    disabledBackgroundColor: Colors.grey.shade300,
                  ),
                );
              },
            ),
          ],
        ),
      );
    },
  );
}
