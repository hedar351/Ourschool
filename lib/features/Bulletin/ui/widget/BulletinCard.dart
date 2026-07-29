import 'package:flutter/material.dart';
import 'package:school/features/Bulletin/domain/Entities/AnnouncementActivityEntity.dart';

class Bulletincard extends StatelessWidget {
  final Announcementactivityentity entity;
  final Color color;

  const Bulletincard({super.key, required this.entity, required this.color});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconData = _getIcon(entity.title);

    return RepaintBoundary(
      child: Container(
        width: 280,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(28),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(28),
          child: InkWell(
            borderRadius: BorderRadius.circular(28),
            onTap: () {
              // Navigator.push(context, ...);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // ---- رأس البطاقة ----
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.12),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(28),
                      topRight: Radius.circular(28),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(iconData, color: color, size: 24),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _formatDate(entity.date),
                              style: TextStyle(
                                color: color,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                letterSpacing: 0.3,
                              ),
                            ),
                            Text(
                              entity.schoolName,
                              style: TextStyle(
                                color: color,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
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
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entity.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          height: 1.3,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        entity.description,
                        style: TextStyle(
                          fontSize: 14,
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
