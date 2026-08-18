// lib/features/Student/ui/ProfileScreen/widget/activities_section.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/features/Student/domain/entity/Student-FullProfile/ActivitiesEntity.dart';

class ActivitiesSection extends StatelessWidget {
  final List<ActivitiesEntity> activities;

  const ActivitiesSection({super.key, required this.activities});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (activities.isEmpty) {
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
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
        ),
        SizedBox(height: 12.h),
        ...activities.map((activity) => _buildActivityCard(context, activity)),
      ],
    );
  }

  Widget _buildActivityCard(BuildContext context, ActivitiesEntity activity) {
    final theme = Theme.of(context);
    final statusColor = _getStatusColor(activity.status);

    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: statusColor.withOpacity(0.2), width: 1.5.w),
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
          // أيقونة
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

          // التفاصيل
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

          // الحالة
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Text(
              _getStatusLabel(activity.status),
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

  String _getStatusLabel(String? status) {
    switch (status) {
      case 'Approved':
        return 'مقبول';
      case 'Pending':
        return 'قيد الانتظار';
      case 'Rejected':
        return 'مرفوض';
      default:
        return status ?? 'غير محدد';
    }
  }
}
