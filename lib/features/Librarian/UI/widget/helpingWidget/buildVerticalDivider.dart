import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildVerticalDivider(BuildContext context) {
  return Container(
    height: 20.h,
    width: 1.w,
    color: Theme.of(context).dividerColor.withOpacity(0.15),
  );
}
