import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/features/Activities/UI/bloc/activitiesBloc/activities_bloc.dart';
import 'package:school/features/Activities/UI/bloc/activities_registrations_bloc/activities_registrations_bloc.dart';
import 'package:school/features/Activities/domain/entity/registrations_info_entity.dart';
import 'package:school/generated/l10n.dart';

class ActivityInfoDialogContent extends StatefulWidget {
  final int activityId;

  const ActivityInfoDialogContent({super.key, required this.activityId});

  @override
  State<ActivityInfoDialogContent> createState() =>
      ActivityInfoDialogContentState();
}

class ActivityInfoDialogContentState extends State<ActivityInfoDialogContent> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return MultiBlocListener(
      listeners: [
        BlocListener<ActivitiesRegistrationsBloc, ActivitiesRegistrationsState>(
          listener: (context, state) {
            if (state is ActivitiesRegistrationsError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                  duration: const Duration(seconds: 3),
                ),
              );
            }
          },
        ),
        BlocListener<ActivitiesBloc, ActivitiesState>(
          listener: (context, state) {
            if (state is ActivitiesSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.green,
                  duration: const Duration(seconds: 2),
                ),
              );
              context.read<ActivitiesRegistrationsBloc>().add(
                RefreshActivitiesRegistrationsEvent(
                  activityId: widget.activityId,
                ),
              );
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
        ),
      ],
      child: AlertDialog(
        backgroundColor: theme.scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
        ),
        title: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: colorScheme.primary.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.info_outline_rounded,
                color: colorScheme.primary,
                size: 24.w,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                S.of(context).Information,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(50.r),
                onTap: () => context.read<ActivitiesRegistrationsBloc>().add(
                  RefreshActivitiesRegistrationsEvent(
                    activityId: widget.activityId,
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.all(6.w),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: theme.dividerColor.withOpacity(0.05),
                  ),
                  child: Icon(
                    Icons.refresh,
                    size: 20.w,
                    color: theme.hintColor,
                  ),
                ),
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(50.r),
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: EdgeInsets.all(6.w),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: theme.dividerColor.withOpacity(0.05),
                  ),
                  child: Icon(
                    Icons.close_rounded,
                    size: 20.w,
                    color: theme.hintColor,
                  ),
                ),
              ),
            ),
          ],
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 16.h),

                _buildRegistrationsStats(context),
                SizedBox(height: 16.h),

                _buildRegistrationsList(context),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              S.of(context).close,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ActivitiesRegistrationsBloc>().add(
        GetActivitiesRegistrationsEvent(activityId: widget.activityId),
      );
    });
  }

  Widget _buildRegistrationCard(
    BuildContext context,
    RegistrationsInfoEntity reg,
  ) {
    final theme = Theme.of(context);
    final statusColor = _getStatusColor(reg.status);

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: theme.dividerColor.withOpacity(0.08),
          width: 1.w,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 36.w,
            height: 36.w,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.08),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Center(child: Icon(Icons.person)),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reg.studentName ?? 'غير معروف',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: 2.h),
                Row(
                  children: [
                    Icon(
                      Icons.school_outlined,
                      size: 12.w,
                      color: theme.hintColor,
                    ),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: Text(
                        '${reg.gradeName ?? ''} - ${reg.sectionName ?? ''}',
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: theme.hintColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (reg.status == 'Pending')
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    context.read<ActivitiesBloc>().add(
                      ApproveRegistrationEvent(
                        activityId: widget.activityId,
                        studentLocalNumber: reg.studentLocalNumber ?? 0,
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.check_circle_rounded,
                    size: 20.w,
                    color: Colors.green.shade600,
                  ),
                  tooltip: 'قبول',
                ),
                IconButton(
                  onPressed: () {
                    context.read<ActivitiesBloc>().add(
                      RejectRegistrationEvent(
                        activityId: widget.activityId,
                        studentLocalNumber: reg.studentLocalNumber ?? 0,
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.cancel_rounded,
                    size: 20.w,
                    color: Colors.red.shade600,
                  ),
                  tooltip: 'رفض',
                ),
              ],
            )
          else
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                _getStatusLabel(reg.status),
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                  color: statusColor,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildRegistrationsList(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<
      ActivitiesRegistrationsBloc,
      ActivitiesRegistrationsState
    >(
      builder: (context, state) {
        if (state is ActivitiesRegistrationsLoading) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          );
        }

        if (state is ActivitiesRegistrationsError) {
          return const SizedBox.shrink();
        }

        if (state is! ActivitiesRegistrationsLoaded) {
          return const SizedBox.shrink();
        }

        final registrations = state.registrations.registrationsInfoEntity;

        if (registrations.isEmpty) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            alignment: Alignment.center,
            child: Column(
              children: [
                Icon(
                  Icons.people_outline,
                  size: 40.w,
                  color: Colors.grey.shade400,
                ),
                SizedBox(height: 8.h),
                Text(
                  'لا توجد تسجيلات',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).registrants_list,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 10.h),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: registrations.length,
              separatorBuilder: (_, _) => SizedBox(height: 8.h),
              itemBuilder: (context, index) {
                final reg = registrations[index];
                return _buildRegistrationCard(context, reg);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildRegistrationsStats(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<
      ActivitiesRegistrationsBloc,
      ActivitiesRegistrationsState
    >(
      builder: (context, state) {
        if (state is ActivitiesRegistrationsLoading) {
          return Center(
            child: SizedBox(
              height: 40.h,
              width: 40.w,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          );
        }

        if (state is ActivitiesRegistrationsError) {
          return Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.error_outline,
                  color: Colors.red.shade600,
                  size: 20.w,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    'فشل تحميل التسجيلات',
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.red.shade700,
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        if (state is! ActivitiesRegistrationsLoaded) {
          return const SizedBox.shrink();
        }

        final stats = state.registrations.activitiesStatisticsEntity;

        return Row(
          children: [
            _buildStatChip(
              context,
              label: S.of(context).total,
              value: '${stats.total ?? 0}',
              color: Colors.blueGrey,
            ),
            SizedBox(width: 8.w),
            _buildStatChip(
              context,
              label: S.of(context).pending,
              value: '${stats.pending ?? 0}',
              color: Colors.amber.shade700,
            ),
            SizedBox(width: 8.w),
            _buildStatChip(
              context,
              label: S.of(context).approved,
              value: '${stats.approved ?? 0}',
              color: Colors.green.shade600,
            ),
            SizedBox(width: 8.w),
            _buildStatChip(
              context,
              label: S.of(context).rejected,
              value: '${stats.rejected ?? 0}',
              color: Colors.red.shade600,
            ),
          ],
        );
      },
    );
  }

  Widget _buildStatChip(
    BuildContext context, {
    required String label,
    required String value,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 4.w),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: color.withOpacity(0.15), width: 0.5.w),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              label,
              style: TextStyle(
                fontSize: 9.sp,
                color: Theme.of(context).hintColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status) {
      case 'Pending':
        return Colors.amber.shade700;
      case 'Approved':
        return Colors.green.shade600;
      case 'Rejected':
        return Colors.red.shade600;
      default:
        return Colors.grey.shade600;
    }
  }

  String _getStatusLabel(String? status) {
    switch (status) {
      case 'Pending':
        return S.of(context).pending;
      case 'Approved':
        return S.of(context).approved;
      case 'Rejected':
        return S.of(context).rejected;
      default:
        return status ?? 'غير محدد';
    }
  }
}
