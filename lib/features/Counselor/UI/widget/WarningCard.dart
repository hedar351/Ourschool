// lib/features/Counselor/UI/widget/WarningCard.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/features/Counselor/domain/Entities/StudentsProfileEntity/Counselor_WarningsEntity.dart';
import 'package:school/generated/l10n.dart';

class WarningCard extends StatelessWidget {
  static const Color backgroundColor = Color(0xFF4A1A1D);

  static const Color iconColor = Colors.red;

  final CounselorWarningsentity warning;
  // ✅ حسابات القيم الثابتة خارج build
  final double _cardMarginBottom = 12.h;
  final double _cardPadding = 12.w;
  final double _iconContainerPadding = 8.w;
  final double _iconSize = 28.w;
  final double _reasonFontSize = 16.sp;
  final double _detailFontSize = 13.sp;
  final double _cardRadius = 16.r;

  final double _elevation = 2;
  WarningCard({super.key, required this.warning});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      margin: EdgeInsets.only(bottom: _cardMarginBottom),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_cardRadius),
      ),
      elevation: _elevation,
      child: InkWell(
        borderRadius: BorderRadius.circular(_cardRadius),
        onTap: () => _showWarningDialog(context),
        child: Padding(
          padding: EdgeInsets.all(_cardPadding),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(_iconContainerPadding),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.warning, color: iconColor, size: _iconSize),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      warning.reason ?? S.of(context).warning,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: _reasonFontSize,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(Icons.flag, size: 14.w, color: Colors.white70),
                        SizedBox(width: 4.w),
                        Text(
                          warning.type ?? S.of(context).type_general,
                          style: TextStyle(
                            fontSize: _detailFontSize,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 14.w,
                          color: Colors.white70,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          _formatDate(warning.createdAt, context),
                          style: TextStyle(
                            fontSize: _detailFontSize,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: Colors.white.withOpacity(0.5),
                size: 20.w,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label: ',
          style: TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(color: Colors.white, fontSize: 14.sp),
          ),
        ),
      ],
    );
  }

  String _formatDate(String? dateString, BuildContext context) {
    if (dateString == null || dateString.isEmpty) {
      return S.of(context).date_unknown;
    }
    try {
      final date = DateTime.parse(dateString);
      return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    } catch (e) {
      return dateString;
    }
  }

  void _showWarningDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          title: Row(
            children: [
              Icon(Icons.warning, color: Colors.red, size: 28.w),
              SizedBox(width: 12.w),
              Text(
                S.of(context).warning_details,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailRow(
                S.of(context).reason,
                warning.reason ?? S.of(context).not_specified,
              ),
              SizedBox(height: 8.h),
              _buildDetailRow(
                S.of(context).type,
                warning.type ?? S.of(context).type_general,
              ),
              SizedBox(height: 8.h),
              _buildDetailRow(
                S.of(context).date,
                _formatDate(warning.createdAt, context),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              style: TextButton.styleFrom(foregroundColor: Colors.white),
              child: Text(S.of(context).close),
            ),
          ],
        );
      },
    );
  }
}
