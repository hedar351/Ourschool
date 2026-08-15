import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/features/Student/domain/entity/Student-FullProfile/LoansEntity.dart';

class LoanCard extends StatelessWidget {
  final Loansentity loan;
  final int index;

  const LoanCard({super.key, required this.loan, required this.index});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isOverdue = false;

    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.green.shade200, width: 1.5.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8.w,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Row(
        children: [
          // ---- معلومات الاستعارة ----
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  loan.bookTitle ?? 'كتاب',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 12.w,
                      color: Colors.grey.shade500,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      'استعارة: ${_formatDate(loan.loanDate)}',
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.event_note_outlined,
                      size: 12.w,
                      color: Colors.grey.shade500,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      'إعادة: ${_formatDate(loan.dueDate)}',
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: Colors.green.shade700,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ---- حالة الاستعارة ----
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Text(
              isOverdue ? 'متأخر' : 'نشط',
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w600,
                color: Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null) return 'غير محدد';
    try {
      final date = DateTime.parse(dateStr);
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
    } catch (_) {
      return dateStr;
    }
  }
}
