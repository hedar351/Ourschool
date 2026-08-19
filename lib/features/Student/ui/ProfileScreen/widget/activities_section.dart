// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:school/features/Student/domain/entity/Student-FullProfile/ActivitiesEntity.dart';
// import 'package:school/generated/l10n.dart';

// class ActivitiesSection extends StatelessWidget {
//   final List<ActivitiesEntity> activities;

//   const ActivitiesSection({super.key, required this.activities});

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     if (activities.isEmpty) {
//       return Container(
//         padding: EdgeInsets.symmetric(vertical: 20.h),
//         child: Center(
//           child: Column(
//             children: [
//               Icon(
//                 Icons.emoji_events_outlined,
//                 size: 48.w,
//                 color: Colors.grey.shade400,
//               ),
//               SizedBox(height: 8.h),
//               Text(
//                 'لا توجد أنشطة مسجلة',
//                 style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade600),
//               ),
//             ],
//           ),
//         ),
//       );
//     }

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             Container(
//               width: 4.w,
//               height: 20.h,
//               decoration: BoxDecoration(
//                 color: Colors.amber.shade700,
//                 borderRadius: BorderRadius.circular(4.r),
//               ),
//             ),
//             SizedBox(width: 10.w),
//             Text(
//               'الأنشطة',
//               style: TextStyle(
//                 fontSize: 16.sp,
//                 fontWeight: FontWeight.bold,
//                 color: theme.colorScheme.onSurface,
//               ),
//             ),
//             const Spacer(),
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
//               decoration: BoxDecoration(
//                 color: Colors.amber.shade700.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(12.r),
//               ),
//               child: Text(
//                 '${activities.length}',
//                 style: TextStyle(
//                   fontSize: 12.sp,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.amber.shade700,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: 12.h),
//         ...activities.map((activity) => _buildActivityCard(context, activity)),
//       ],
//     );
//   }

//   Widget _buildActivityCard(BuildContext context, ActivitiesEntity activity) {
//     final theme = Theme.of(context);
//     final statusColor = _getStatusColor(activity.status);

//     return Container(
//       margin: EdgeInsets.only(bottom: 10.h),
//       padding: EdgeInsets.all(14.w),
//       decoration: BoxDecoration(
//         color: theme.cardColor,
//         borderRadius: BorderRadius.circular(16.r),
//         border: Border.all(color: statusColor.withOpacity(0.2), width: 1.5.w),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.04),
//             blurRadius: 8.w,
//             offset: Offset(0, 2.h),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           // أيقونة
//           Container(
//             padding: EdgeInsets.all(8.w),
//             decoration: BoxDecoration(
//               color: statusColor.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(12.r),
//             ),
//             child: Icon(
//               _getActivityIcon(activity.activityName),
//               color: statusColor,
//               size: 20.w,
//             ),
//           ),
//           SizedBox(width: 12.w),

//           // التفاصيل
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   activity.activityName ?? 'نشاط',
//                   style: TextStyle(
//                     fontSize: 14.sp,
//                     fontWeight: FontWeight.w600,
//                     color: theme.colorScheme.onSurface,
//                   ),
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 SizedBox(height: 4.h),
//                 Row(
//                   children: [
//                     Icon(
//                       Icons.calendar_today_outlined,
//                       size: 12.w,
//                       color: Colors.grey.shade500,
//                     ),
//                     SizedBox(width: 4.w),
//                     Text(
//                       _formatDate(activity.date),
//                       style: TextStyle(
//                         fontSize: 11.sp,
//                         color: Colors.grey.shade600,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),

//           // الحالة
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
//             decoration: BoxDecoration(
//               color: statusColor.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(10.r),
//             ),
//             child: Text(
//               _getStatusLabel(activity.status, context),
//               style: TextStyle(
//                 fontSize: 10.sp,
//                 fontWeight: FontWeight.w600,
//                 color: statusColor,
//               ),
//             ),
//           ),
//           if (activity.status == "Pending")
//             IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
//         ],
//       ),
//     );
//   }

//   String _formatDate(String? dateStr) {
//     if (dateStr == null) return 'غير محدد';
//     try {
//       final date = DateTime.parse(dateStr);
//       const months = [
//         'يناير',
//         'فبراير',
//         'مارس',
//         'أبريل',
//         'مايو',
//         'يونيو',
//         'يوليو',
//         'أغسطس',
//         'سبتمبر',
//         'أكتوبر',
//         'نوفمبر',
//         'ديسمبر',
//       ];
//       return '${date.day} ${months[date.month - 1]} ${date.year}';
//     } catch (_) {
//       return dateStr;
//     }
//   }

//   IconData _getActivityIcon(String? activityName) {
//     final name = activityName?.toLowerCase() ?? '';
//     if (name.contains('رحلة')) return Icons.flight_takeoff_rounded;
//     if (name.contains('علوم')) return Icons.science_rounded;
//     if (name.contains('رياضة')) return Icons.sports_soccer_rounded;
//     if (name.contains('مسابقة')) return Icons.emoji_events_rounded;
//     if (name.contains('فنية') || name.contains('رسم')) {
//       return Icons.palette_rounded;
//     }
//     return Icons.emoji_events_outlined;
//   }

//   Color _getStatusColor(String? status) {
//     switch (status) {
//       case 'Approved':
//         return Colors.green.shade600;
//       case 'Pending':
//         return Colors.amber.shade700;
//       case 'Rejected':
//         return Colors.red.shade600;
//       default:
//         return Colors.grey.shade600;
//     }
//   }

//   String _getStatusLabel(String? status, BuildContext context) {
//     switch (status) {
//       case 'Approved':
//         return S.of(context).approved;
//       case 'Pending':
//         return S.of(context).pending;
//       case 'Rejected':
//         return S.of(context).rejected;
//       default:
//         return status ?? 'غير محدد';
//     }
//   }
// }
// lib/features/Student/ui/ProfileScreen/widget/activities_section.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/features/Student/domain/entity/Student-FullProfile/ActivitiesEntity.dart';
import 'package:school/features/Student/ui/bloc/ActivityRegistrationBloc/activity_registration_bloc.dart';
import 'package:school/features/Student/ui/bloc/ProfileBloc/student_bloc.dart';
import 'package:school/generated/l10n.dart';

class ActivitiesSection extends StatelessWidget {
  final List<ActivitiesEntity> activities;

  const ActivitiesSection({super.key, required this.activities});

  @override
  Widget build(BuildContext context) {
    if (activities.isEmpty) {
      return _buildEmptyState(context);
    }

    return BlocListener<ActivityRegistrationBloc, ActivityRegistrationState>(
      listener: (context, state) {
        if (state is ActivityRegistrationSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 2),
            ),
          );
          context.read<StudentBloc>().add(RefreshStudentProfileEvent());
        }
        if (state is ActivityRegistrationError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 3),
            ),
          );
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          SizedBox(height: 12.h),
          ...activities.map(
            (activity) => _buildActivityCard(context, activity),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityCard(BuildContext context, ActivitiesEntity activity) {
    final theme = Theme.of(context);
    final statusColor = _getStatusColor(activity.status);

    return BlocBuilder<ActivityRegistrationBloc, ActivityRegistrationState>(
      builder: (context, state) {
        final isDeleting = state is ActivityRegistrationLoading;

        return Container(
          margin: EdgeInsets.only(bottom: 10.h),
          padding: EdgeInsets.all(14.w),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: statusColor.withOpacity(0.2),
              width: 1.5.w,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 8.w,
                offset: Offset(0, 2.h),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  _getActivityIcon(activity.activityName),
                  color: statusColor,
                  size: 20.w,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      activity.activityName ?? 'نشاط',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onSurface,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          size: 12.w,
                          color: Colors.grey.shade500,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          _formatDate(activity.date),
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Text(
                  _getStatusLabel(activity.status, context),
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
              if (activity.status == "Pending")
                IconButton(
                  onPressed: isDeleting
                      ? null
                      : () {
                          final activityId = activity.localActivityId;
                          if (activityId != null) {
                            context.read<ActivityRegistrationBloc>().add(
                              DeleteRegisterActivityEvent(
                                activityId: activityId,
                              ),
                            );
                          }
                        },
                  icon: isDeleting
                      ? SizedBox(
                          width: 18.w,
                          height: 18.w,
                          child: CircularProgressIndicator(
                            color: Colors.red.shade600,
                            strokeWidth: 2.w,
                          ),
                        )
                      : Icon(
                          Icons.delete,
                          color: Colors.red.shade600,
                          size: 20.w,
                        ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: Center(
        child: Column(
          children: [
            Icon(
              Icons.emoji_events_outlined,
              size: 48.w,
              color: Colors.grey.shade400,
            ),
            SizedBox(height: 8.h),
            Text(
              'لا توجد أنشطة مسجلة',
              style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Container(
          width: 4.w,
          height: 20.h,
          decoration: BoxDecoration(
            color: Colors.amber.shade700,
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
        SizedBox(width: 10.w),
        Text(
          'الأنشطة',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const Spacer(),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
          decoration: BoxDecoration(
            color: Colors.amber.shade700.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Text(
            '${activities.length}',
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: Colors.amber.shade700,
            ),
          ),
        ),
      ],
    );
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null) return 'غير محدد';
    try {
      final date = DateTime.parse(dateStr);
      const months = [
        'يناير',
        'فبراير',
        'مارس',
        'أبريل',
        'مايو',
        'يونيو',
        'يوليو',
        'أغسطس',
        'سبتمبر',
        'أكتوبر',
        'نوفمبر',
        'ديسمبر',
      ];
      return '${date.day} ${months[date.month - 1]} ${date.year}';
    } catch (_) {
      return dateStr;
    }
  }

  IconData _getActivityIcon(String? activityName) {
    final name = activityName?.toLowerCase() ?? '';
    if (name.contains('رحلة')) return Icons.flight_takeoff_rounded;
    if (name.contains('علوم')) return Icons.science_rounded;
    if (name.contains('رياضة')) return Icons.sports_soccer_rounded;
    if (name.contains('مسابقة')) return Icons.emoji_events_rounded;
    if (name.contains('فنية') || name.contains('رسم')) {
      return Icons.palette_rounded;
    }
    return Icons.emoji_events_outlined;
  }

  Color _getStatusColor(String? status) {
    switch (status) {
      case 'Approved':
        return Colors.green.shade600;
      case 'Pending':
        return Colors.amber.shade700;
      case 'Rejected':
        return Colors.red.shade600;
      default:
        return Colors.grey.shade600;
    }
  }

  String _getStatusLabel(String? status, BuildContext context) {
    switch (status) {
      case 'Approved':
        return S.of(context).approved;
      case 'Pending':
        return S.of(context).pending;
      case 'Rejected':
        return S.of(context).rejected;
      default:
        return status ?? 'غير محدد';
    }
  }
}
