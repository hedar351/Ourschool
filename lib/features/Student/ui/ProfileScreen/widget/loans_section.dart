// lib/features/Student/ui/ProfileScreen/widget/loans_section.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/features/Student/domain/entity/Student-FullProfile/LoansEntity.dart';
import 'package:school/features/Student/ui/ProfileScreen/widget/loan_card.dart';

class LoansSection extends StatelessWidget {
  final List<Loansentity> loans;

  const LoansSection({super.key, required this.loans});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (loans.isEmpty) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: Center(
          child: Column(
            children: [
              Icon(
                Icons.library_books_outlined,
                size: 48.w,
                color: Colors.grey.shade400,
              ),
              SizedBox(height: 8.h),
              Text(
                'لا توجد استعارات حالياً',
                style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 4.w,
              height: 20.h,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
            SizedBox(width: 10.w),
            Text(
              ' استعاراتي',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
            const Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                '${loans.length}',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        ...loans.map(
          (loan) => LoanCard(loan: loan, index: loans.indexOf(loan)),
        ),
      ],
    );
  }
}
