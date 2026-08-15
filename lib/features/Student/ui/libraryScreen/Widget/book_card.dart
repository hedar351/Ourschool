import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/features/Librarian/UI/Bloc/BookReservationsLoansBloc/book_reservations_loans_bloc.dart';
import 'package:school/features/Librarian/UI/widget/BottomSheetWidget/BookReservationsBottomSheet.dart';
import 'package:school/features/Student/domain/entity/Library/BookEntity.dart';
import 'package:school/features/Student/ui/bloc/libraryBloc/library_bloc.dart';
import 'package:school/features/Student/ui/libraryScreen/Widget/BookDetailsSheet.dart';
import 'package:school/generated/l10n.dart';

class BookCard extends StatelessWidget {
  final BookEntity book;
  final int index;
  final bool isStudent;
  const BookCard({
    super.key,
    required this.book,
    required this.index,
    required this.isStudent,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isAvailable = book.isAvailable;
    final statusColor = isAvailable
        ? const Color(0xFF10B981)
        : const Color(0xFFEF4444);
    final int delay = (index * 50).clamp(0, 500);

    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 400 + delay),
      curve: Curves.easeOutQuart,
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, (1 - value) * 20.h),
          child: Opacity(opacity: value, child: child),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 14.h),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: theme.dividerColor.withOpacity(0.08),
            width: 1.5.r,
          ),
          boxShadow: [
            BoxShadow(
              color: statusColor.withOpacity(0.05),
              blurRadius: 15.w,
              offset: Offset(0, 8.h),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20.r),
          child: InkWell(
            borderRadius: BorderRadius.circular(20.r),
            onTap: () => isStudent
                ? _showBookDetails(context, book)
                : _showBookReservations(context, book.localBookNumber),

            splashColor: theme.colorScheme.primary.withOpacity(0.1),
            highlightColor: theme.colorScheme.primary.withOpacity(0.05),
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // ---- 1. شارة الرقم ----
                  Container(
                    width: 56.w,
                    height: 56.w,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          theme.colorScheme.primary,
                          theme.colorScheme.primary.withOpacity(0.7),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          color: theme.colorScheme.primary.withOpacity(0.3),
                          blurRadius: 8.w,
                          offset: Offset(0, 4.h),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Icon(
                        Icons.menu_book_rounded,
                        color: Colors.white,
                        size: 28.w,
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),

                  // ---- 2. معلومات الكتاب ----
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          book.title,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.onSurface,
                            height: 1.2,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 6.h),
                        Row(
                          children: [
                            Icon(
                              Icons.person_outline_rounded,
                              size: 14.w,
                              color: Colors.grey.shade500,
                            ),
                            SizedBox(width: 6.w),
                            Expanded(
                              child: Text(
                                book.author,
                                style: TextStyle(
                                  fontSize: 12.5.sp,
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          children: [
                            Row(
                              children: List.generate(
                                book.copies.clamp(1, 5),
                                (dotIndex) => Container(
                                  margin: EdgeInsets.only(right: 4.w),
                                  width: 7.w,
                                  height: 7.w,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: dotIndex < book.availableCopies
                                        ? statusColor
                                        : Colors.grey.shade300,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              '${book.availableCopies}/${book.copies}',
                              style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // ---- 3. حالة الكتاب والسهم ----
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                            color: statusColor.withOpacity(0.3),
                            width: 0.5.r,
                          ),
                        ),
                        child: Text(
                          isAvailable
                              ? S.of(context).available
                              : S.of(context).Unavailable,
                          style: TextStyle(
                            fontSize: 11.5.sp,
                            fontWeight: FontWeight.w800,
                            color: statusColor,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 14.w,
                        color: Colors.grey.shade400,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showBookDetails(BuildContext context, BookEntity book) {
    final libraryBloc = context.read<LibraryBloc>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.4),
      builder: (context) =>
          BookDetailsSheet(book: book, libraryBloc: libraryBloc),
    );
  }

  void _showBookReservations(BuildContext context, int localBookNumber) {
    final bloc = context.read<BookReservationsLoansBloc>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (context) {
        return BlocProvider.value(
          value: bloc,
          child: BookReservationsBottomSheet(
            localBookNumber: localBookNumber,
            // initialStatus: 'All',
          ),
        );
      },
    );
  }
}
