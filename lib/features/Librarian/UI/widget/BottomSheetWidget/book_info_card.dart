import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/generated/l10n.dart';

class BookInfoCard extends StatelessWidget {
  final String title;
  final String author;
  final int availableCopies;
  final int reservedCopies;
  final int availableForLoan;

  const BookInfoCard({
    super.key,
    required this.title,
    required this.author,
    required this.availableCopies,
    required this.reservedCopies,
    required this.availableForLoan,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (title.isEmpty && author.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: theme.dividerColor.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.isNotEmpty ? title : S.of(context).unknownTitle,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
          if (author.isNotEmpty) ...[
            SizedBox(height: 4.h),
            Text(
              '${S.of(context).authorLabel}: $author',
              style: TextStyle(fontSize: 13.sp, color: theme.hintColor),
            ),
          ],
          SizedBox(height: 8.h),
          Row(
            children: [
              _buildInfoChip(
                context,
                label: S.of(context).bookDetailsAvailableCopies,
                value: '$availableCopies',
                color: Colors.green.shade600,
              ),
              SizedBox(width: 8.w),
              _buildInfoChip(
                context,
                label: S.of(context).bookDetailsAvailableForLoan,
                value: '$availableForLoan',
                color: Colors.blue.shade600,
              ),

              // SizedBox(width: 2.w),
            ],
          ),
          SizedBox(height: 8.h),

          _buildInfoChip(
            context,
            label: S.of(context).bookDetailsReservedCopies,
            value: '$reservedCopies',
            color: Colors.orange.shade600,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(
    BuildContext context, {
    required String label,
    required String value,
    required Color color,
  }) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 10.sp, color: theme.hintColor),
          ),
          SizedBox(width: 4.w),
          Text(
            value,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
