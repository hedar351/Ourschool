import 'package:flutter/material.dart';

IconData getIcon(String title) {
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
