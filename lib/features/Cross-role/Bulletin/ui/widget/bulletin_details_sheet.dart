import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/core/injection.dart' as di;
import 'package:school/core/widget/getIcon.dart';
import 'package:school/features/Activities/UI/bloc/activitiesBloc/activities_bloc.dart';
import 'package:school/features/Activities/UI/widget/showActivityInfoDialog.dart';
import 'package:school/features/Activities/UI/widget/showDeleteConfirmation.dart';
import 'package:school/features/Activities/UI/widget/showEditActivityDialog.dart';
import 'package:school/features/Cross-role/Bulletin/domain/Entities/AnnouncementActivityEntity.dart';
import 'package:school/features/Librarian/UI/widget/helpingWidget/helpers.dart';
import 'package:school/features/Student/ui/bloc/ActivityRegistrationBloc/activity_registration_bloc.dart';
import 'package:school/generated/l10n.dart';

class BulletinDetailsSheet extends StatelessWidget {
  final Announcementactivityentity entity;
  final Color color;
  final bool isStudent;
  final bool isActivitySupervisor;

  const BulletinDetailsSheet({
    super.key,
    required this.entity,
    required this.color,
    required this.isStudent,
    required this.isActivitySupervisor,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.sl<ActivitiesBloc>()),
        BlocProvider(create: (context) => di.sl<ActivityRegistrationBloc>()),
      ],
      child: _BulletinDetailsSheetContent(
        entity: entity,
        color: color,
        isStudent: isStudent,
        isActivitySupervisor: isActivitySupervisor,
      ),
    );
  }
}

class _BulletinDetailsSheetContent extends StatelessWidget {
  final Announcementactivityentity entity;
  final Color color;
  final bool isStudent;
  final bool isActivitySupervisor;

  const _BulletinDetailsSheetContent({
    required this.entity,
    required this.color,
    required this.isStudent,
    required this.isActivitySupervisor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return BlocConsumer<ActivityRegistrationBloc, ActivityRegistrationState>(
      listener: (context, state) {
        if (state is ActivityRegistrationSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 2),
            ),
          );
          Navigator.pop(context);
        }
        if (state is ActivityRegistrationError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 3),
            ),
          );
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        final isRegistering = state is ActivityRegistrationLoading;

        return Container(
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
            border: isDark
                ? Border(
                    top: BorderSide(color: theme.dividerColor, width: 1.w),
                  )
                : null,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(isDark ? 0.5 : 0.1),
                blurRadius: 30.r,
                offset: const Offset(0, -10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 12.h),
              Container(
                width: 48.w,
                height: 5.h,
                decoration: BoxDecoration(
                  color: theme.colorScheme.onSurface.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              SizedBox(height: 24.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.15),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        getIcon(entity.title),
                        color: color,
                        size: 32.w,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            entity.title,
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w800,
                              height: 1.3,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today_rounded,
                                size: 16.w,
                                color: theme.colorScheme.onSurface.withOpacity(
                                  0.6,
                                ),
                              ),
                              SizedBox(width: 6.w),
                              Text(
                                formatDate(entity.date),
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.onSurface
                                      .withOpacity(0.6),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (isActivitySupervisor && entity.type == 'activity')
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              showEditActivityDialog(context, entity);
                            },
                            icon: Icon(
                              Icons.edit_rounded,
                              color: Colors.blue.shade600,
                              size: 22.w,
                            ),
                            tooltip: 'تعديل',
                          ),
                          IconButton(
                            onPressed: () =>
                                showDeleteConfirmationActivity(context, entity),
                            icon: Icon(
                              Icons.delete_rounded,
                              color: Colors.red.shade600,
                              size: 22.w,
                            ),
                            tooltip: 'حذف',
                          ),
                        ],
                      ),
                  ],
                ),
              ),

              SizedBox(height: 24.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'التفاصيل',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: color,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      entity.description,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        height: 1.7,
                        color: theme.colorScheme.onSurface.withOpacity(0.8),
                      ),
                    ),
                    SizedBox(height: 24.h),

                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerHighest
                            .withOpacity(0.5),
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: theme.dividerColor.withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.school_rounded, color: color, size: 20.w),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'المدرسة',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.onSurface
                                        .withOpacity(0.6),
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  entity.schoolName,
                                  style: theme.textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 32.h),

              Padding(
                padding: EdgeInsets.fromLTRB(
                  24.w,
                  0,
                  15.w,
                  24.h + MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: color,
                            foregroundColor: theme.colorScheme.onPrimary,
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            S.of(context).close,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    if (entity.type == 'activity' && isActivitySupervisor)
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () =>
                              showActivityInfoDialog(context, entity.id),
                          icon: Icon(
                            Icons.info_outline_rounded,
                            size: 18.w,
                            color: Colors.white,
                          ),
                          label: Text(
                            S.of(context).Information,
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade700,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            elevation: 0,
                          ),
                        ),
                      ),
                    if (entity.type == 'activity' && isStudent)
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: isRegistering
                              ? null
                              : () {
                                  final activityId = entity.id;
                                  context.read<ActivityRegistrationBloc>().add(
                                    RegisterActivityEvent(
                                      activityId: activityId,
                                    ),
                                  );
                                },
                          icon: isRegistering
                              ? SizedBox(
                                  width: 18.w,
                                  height: 18.w,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2.w,
                                  ),
                                )
                              : Icon(
                                  Icons.check_circle_rounded,
                                  size: 18.w,
                                  color: Colors.white,
                                ),
                          label: Text(
                            isRegistering
                                ? S.of(context).reserving
                                : S.of(context).register,
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade700,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            elevation: 0,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
