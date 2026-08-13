import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/features/FirstStep/SchoolsInfo/domain/Entities/SchoolInfoEntity.dart';

import '../page/school_teachers_screen.dart';

class SchoolCardWidget extends StatelessWidget {
  final SchoolInfoEntity school;
  final double cardMarginBottom = 16.h;

  final double cardPadding = 16.w;
  final double cardRadius = 20.r;
  final double sideBorderWidth = 0.5.w;
  final double containerSize = 50.w;
  final double containerRadius = 14.r;
  final double iconSize = 26.w;
  final double gapSmall = 14.w;
  final double titleFontSize = 18.sp;
  final double typeFontSize = 12.sp;
  final double typeIconSize = 14.w;
  final double infoFontSize = 13.sp;
  final double infoIconSize = 16.w;
  final double infoGap = 8.w;
  final double infoVerticalPadding = 6.h;
  SchoolCardWidget({super.key, required this.school});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Card(
      margin: EdgeInsets.only(bottom: cardMarginBottom),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(cardRadius),
        side: BorderSide(
          color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
          width: sideBorderWidth,
        ),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SchoolTeachersScreen(school: school),
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.all(cardPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: containerSize,
                    height: containerSize,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          theme.colorScheme.primary,
                          theme.colorScheme.primary.withOpacity(0.7),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(containerRadius),
                    ),
                    child: Icon(
                      Icons.school,
                      color: theme.colorScheme.onPrimary,
                      size: iconSize,
                    ),
                  ),
                  SizedBox(width: gapSmall),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          school.name ?? 'مدرسة غير معروفة',
                          style: TextStyle(
                            fontSize: titleFontSize,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 2.h),
                        Row(
                          children: [
                            Icon(
                              Icons.verified,
                              size: typeIconSize,
                              color: theme.colorScheme.primary,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              school.typename ?? 'مدرسة',
                              style: TextStyle(
                                fontSize: typeFontSize,
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 14.h),

              if (school.address != null && school.address!.isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(bottom: infoVerticalPadding),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: infoIconSize,
                        color: Colors.grey.shade500,
                      ),
                      SizedBox(width: infoGap),
                      Expanded(
                        child: Text(
                          school.address!,
                          style: TextStyle(
                            fontSize: infoFontSize,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              if (school.phone != null && school.phone!.isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(bottom: infoVerticalPadding),
                  child: Row(
                    children: [
                      Icon(
                        Icons.phone_outlined,
                        size: infoIconSize,
                        color: Colors.grey.shade500,
                      ),
                      SizedBox(width: infoGap),
                      Text(
                        school.phone!,
                        style: TextStyle(
                          fontSize: infoFontSize,
                          color: Colors.grey.shade600,
                        ),
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
}
