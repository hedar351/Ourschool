
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PulsingIcon extends StatelessWidget {
  final IconData icon;
  final Color color;

  const PulsingIcon({super.key, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Icon(icon, color: color, size: 32.w);
  }
}
