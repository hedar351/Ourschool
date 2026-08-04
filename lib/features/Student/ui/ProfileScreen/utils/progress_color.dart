// lib/features/Student/presentation/utils/progress_color.dart

import 'package:flutter/material.dart';

Color getProgressColor(double percent) {
  if (percent >= 0.9) return Colors.green;
  if (percent >= 0.8) return Colors.blue;
  if (percent >= 0.7) return Colors.orange;
  return Colors.red;
}
