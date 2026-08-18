import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/features/Cross-role/Bulletin/domain/Entities/AnnouncementActivityEntity.dart';
import 'package:school/features/Cross-role/Bulletin/ui/widget/bulletin_details_sheet.dart';
import 'package:school/features/Librarian/UI/widget/helpingWidget/helpers.dart';

class BulletinCard extends StatelessWidget {
  final Announcementactivityentity entity;
  final Color color;
  final bool isStudent;
  final bool isActivitySupervisor;

  const BulletinCard({
    super.key,
    required this.entity,
    required this.color,
    required this.isStudent,
    required this.isActivitySupervisor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final iconData = _getIcon(entity.title);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _showBottomSheet(context),
        borderRadius: BorderRadius.circular(20.r),
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(20.r),

            border: isDark
                ? Border.all(
                    color: theme.dividerColor.withOpacity(0.4),
                    width: 1.w,
                  )
                : null,
            boxShadow: isDark
                ? null
                : [
                    BoxShadow(
                      color: color.withOpacity(0.08),
                      blurRadius: 16.r,
                      offset: Offset(0, 8.h),
                    ),
                  ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Icon(iconData, color: color, size: 24.w),
              ),
              SizedBox(width: 16.w),

              // المحتوى
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            entity.title,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                              height: 1.3,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      entity.description,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.7),
                        height: 1.5,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time_rounded,
                          size: 14.w,
                          color: theme.colorScheme.onSurface.withOpacity(0.5),
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          formatDate(entity.date),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurface.withOpacity(0.5),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Container(
                          width: 1.w,
                          height: 12.h,
                          color: theme.dividerColor,
                        ),
                        SizedBox(width: 12.w),
                        Icon(
                          Icons.school_rounded,
                          size: 14.w,
                          color: theme.colorScheme.onSurface.withOpacity(0.5),
                        ),
                        SizedBox(width: 6.w),
                        Expanded(
                          child: Text(
                            entity.schoolName,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurface.withOpacity(
                                0.5,
                              ),
                              fontWeight: FontWeight.w500,
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
            ],
          ),
        ),
      ),
    );
  }

  IconData _getIcon(String title) {
    final lowerTitle = title.toLowerCase();
    if (lowerTitle.contains('رحلة')) return Icons.flight_takeoff_rounded;
    if (lowerTitle.contains('علوم')) return Icons.science_rounded;
    if (lowerTitle.contains('فنية') || lowerTitle.contains('رسم')) {
      return Icons.palette_rounded;
    }
    if (lowerTitle.contains('رياضة')) return Icons.sports_soccer_rounded;
    if (lowerTitle.contains('هام') || lowerTitle.contains('تحذير')) {
      return Icons.warning_amber_rounded;
    }
    if (lowerTitle.contains('اجتماع') || lowerTitle.contains('أولياء')) {
      return Icons.people_alt_rounded;
    }
    if (lowerTitle.contains('تسجيل') || lowerTitle.contains('موعد')) {
      return Icons.edit_calendar_rounded;
    }
    return Icons.campaign_rounded;
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BulletinDetailsSheet(
        entity: entity,
        color: color,
        isStudent: isStudent,
        isActivitySupervisor: isActivitySupervisor,
      ),
    );
  }
}
