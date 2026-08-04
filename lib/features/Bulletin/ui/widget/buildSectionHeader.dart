// // lib/features/Bulletin/ui/widget/buildSectionHeader.dart

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class Buildsectionheader extends StatelessWidget {
//   final String title;
//   final Color color;
//   final VoidCallback? onPressed;

//   // ✅ حسابات القيم الثابتة خارج build
//   final double _containerWidth = 5.w;

//   final double _containerHeight = 26.h;
//   final double _gap = 12.w;
//   final double _fontSize = 22.sp;
//   Buildsectionheader({
//     super.key,
//     required this.title,
//     required this.color,
//     this.onPressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Container(
//           width: _containerWidth,
//           height: _containerHeight,
//           decoration: BoxDecoration(
//             color: color,
//             borderRadius: BorderRadius.circular(12.r),
//           ),
//         ),
//         SizedBox(width: _gap),
//         Expanded(
//           child: Text(
//             title,
//             style: TextStyle(
//               fontSize: _fontSize,
//               fontWeight: FontWeight.bold,
//               color: color,
//               letterSpacing: 0.2,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildSectionHeader extends StatelessWidget {
  final String title;
  final Color color;
  final VoidCallback? onPressed;

  const BuildSectionHeader({
    super.key,
    required this.title,
    required this.color,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: color.withOpacity(0.1), width: 1.w),
      ),
      child: Row(
        children: [
          Container(
            width: 6.w,
            height: 24.h,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w800,
                color: color,
                letterSpacing: 0.2,
              ),
            ),
          ),
          if (onPressed != null)
            InkWell(
              onTap: onPressed,
              borderRadius: BorderRadius.circular(20.r),
              child: Padding(
                padding: EdgeInsets.all(8.w),
                child: Icon(Icons.arrow_forward_ios, size: 16.w, color: color),
              ),
            ),
        ],
      ),
    );
  }
}
