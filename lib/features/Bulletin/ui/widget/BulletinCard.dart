// lib/features/Bulletin/ui/widget/BulletinCard.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/features/Bulletin/domain/Entities/AnnouncementActivityEntity.dart';

class Bulletincard extends StatelessWidget {
  final Announcementactivityentity entity;
  final Color color;

  final double _cardWidth = 280.w;

  final double _marginRight = 16.w;
  final double _borderRadius = 28.r;
  final double _headerPaddingHorizontal = 16.w;
  final double _headerPaddingVertical = 14.h;
  final double _iconSize = 24.w;
  final double _iconGap = 12.w;
  final double _contentPadding = 18.w;
  final double _titleFontSize = 18.sp;
  final double _descFontSize = 14.sp;
  final double _dateFontSize = 13.sp;
  final double _gap = 10.h;
  final double _blurRadius = 12.w;
  Bulletincard({super.key, required this.entity, required this.color});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconData = _getIcon(entity.title);

    return RepaintBoundary(
      child: Container(
        width: _cardWidth,
        margin: EdgeInsets.only(right: _marginRight),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(_borderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: _blurRadius,
              offset: Offset(0, 4.h),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(_borderRadius),
          child: InkWell(
            borderRadius: BorderRadius.circular(_borderRadius),
            onTap: () {},
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // ---- رأس البطاقة ----
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: _headerPaddingHorizontal,
                    vertical: _headerPaddingVertical,
                  ),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.12),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(_borderRadius),
                      topRight: Radius.circular(_borderRadius),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(iconData, color: color, size: _iconSize),
                      SizedBox(width: _iconGap),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _formatDate(entity.date),
                              style: TextStyle(
                                color: color,
                                fontWeight: FontWeight.w600,
                                fontSize: _dateFontSize,
                                letterSpacing: 0.3,
                              ),
                            ),
                            Text(
                              entity.schoolName,
                              style: TextStyle(
                                color: color,
                                fontWeight: FontWeight.w600,
                                fontSize: _dateFontSize,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // ---- محتوى البطاقة ----
                Padding(
                  padding: EdgeInsets.all(_contentPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entity.title,
                        style: TextStyle(
                          fontSize: _titleFontSize,
                          fontWeight: FontWeight.bold,
                          height: 1.3,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: _gap),
                      Text(
                        entity.description,
                        style: TextStyle(
                          fontSize: _descFontSize,
                          color: theme.textTheme.bodyMedium?.color,
                          height: 1.4,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ---- التواريخ بالعربية ----
  String _formatDate(DateTime date) {
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
  }

  // ---- الأيقونات الذكية ----
  IconData _getIcon(String title) {
    final lowerTitle = title.toLowerCase();
    if (lowerTitle.contains('رحلة')) return Icons.tour;
    if (lowerTitle.contains('علوم')) return Icons.science;
    if (lowerTitle.contains('فنية') || lowerTitle.contains('رسم')) {
      return Icons.palette;
    }
    if (lowerTitle.contains('رياضة')) return Icons.sports_soccer;
    if (lowerTitle.contains('هام') || lowerTitle.contains('تحذير')) {
      return Icons.warning_amber_rounded;
    }
    if (lowerTitle.contains('اجتماع') || lowerTitle.contains('أولياء')) {
      return Icons.people;
    }
    if (lowerTitle.contains('تسجيل') || lowerTitle.contains('موعد')) {
      return Icons.edit_calendar;
    }
    return Icons.event;
  }
}
