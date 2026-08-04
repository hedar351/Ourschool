import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/features/Student/domain/entity/Library/BookEntity.dart';
import 'package:school/features/Student/ui/bloc/libraryBloc/library_bloc.dart';
import 'package:school/generated/l10n.dart';

class BookCard extends StatelessWidget {
  final BookEntity book;
  final int index;

  const BookCard({super.key, required this.book, required this.index});

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
            onTap: () => _showBookDetails(context, book),
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
                      // Text(
                      //   '${book.localBookNumber}',
                      //   style: TextStyle(
                      //     fontSize: 18.sp,
                      //     fontWeight: FontWeight.w800,
                      //     color: Colors.white,
                      //     letterSpacing: -0.5,
                      //   ),
                      // ),
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
}

class BookDetailsSheet extends StatefulWidget {
  final BookEntity book;
  final LibraryBloc libraryBloc;

  const BookDetailsSheet({
    super.key,
    required this.book,
    required this.libraryBloc,
  });

  @override
  State<BookDetailsSheet> createState() => _BookDetailsSheetState();
}

class _BookDetailsSheetState extends State<BookDetailsSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  bool _isReserving = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isAvailable = widget.book.isAvailable;
    final statusColor = isAvailable
        ? const Color(0xFF10B981)
        : const Color(0xFFEF4444);

    return BlocListener<LibraryBloc, LibraryState>(
      bloc: widget.libraryBloc,
      listener: (context, state) {
        if (state is LibraryReserved) {
          setState(() => _isReserving = false);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.white, size: 20.w),
                  SizedBox(width: 8.w),
                  Expanded(child: Text(state.message)),
                ],
              ),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 2),
            ),
          );

          Navigator.pop(context);

          Future.delayed(const Duration(milliseconds: 300), () {
            if (mounted) {
              widget.libraryBloc.add(RefreshBooksEvent());
              Future.delayed(const Duration(milliseconds: 500), () {
                if (mounted) {
                  widget.libraryBloc.add(ResetReserveStateEvent());
                }
              });
            }
          });
        }
        // في _BookDetailsSheet

        if (state is LibraryReserveError) {
          setState(() => _isReserving = false);

          final isAlreadyReserved = state.message.contains('طلب حجز معلق');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                isAlreadyReserved
                    ? ' لديك طلب حجز معلق على هذا الكتاب'
                    : state.message,
              ),
              backgroundColor: isAlreadyReserved ? Colors.orange : Colors.red,
              duration: const Duration(seconds: 3),
            ),
          );
          Navigator.pop(context);

          Future.delayed(const Duration(milliseconds: 100), () {
            if (mounted) {
              widget.libraryBloc.add(ResetReserveStateEvent());
            }
          });
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 30.w,
              offset: Offset(0, -10.h),
            ),
          ],
        ),
        padding: EdgeInsets.fromLTRB(
          24.w,
          16.h,
          24.w,
          MediaQuery.of(context).viewInsets.bottom + 24.h,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // مؤشر السحب
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 24.h),

            // العنوان والأيقونة
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(14.w),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        theme.colorScheme.primary,
                        theme.colorScheme.primary.withOpacity(0.7),
                      ],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: theme.colorScheme.primary.withOpacity(0.3),
                        blurRadius: 10.w,
                        offset: Offset(0, 4.h),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.menu_book_rounded,
                    color: Colors.white,
                    size: 28.w,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.book.title,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurface,
                          height: 1.3,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'بواسطة: ${widget.book.author}',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 28.h),

            // المحتوى المتحرك
            FadeTransition(
              opacity: _fadeAnim,
              child: SlideTransition(
                position: _slideAnim,
                child: Container(
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: theme.cardColor,
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: theme.dividerColor.withOpacity(0.1),
                      width: 1.5.r,
                    ),
                  ),
                  child: Column(
                    children: [
                      _buildModernDetailRow(
                        icon: Icons.person_rounded,
                        label: 'المؤلف',
                        value: widget.book.author,
                        theme: theme,
                      ),
                      Divider(
                        height: 24.h,
                        thickness: 1,
                        color: theme.dividerColor.withOpacity(0.1),
                      ),
                      _buildModernDetailRow(
                        icon: Icons.copy_all_rounded,
                        label: 'النسخ المتاحة',
                        value:
                            '${widget.book.availableCopies} من أصل ${widget.book.copies}',
                        theme: theme,
                      ),
                      Divider(
                        height: 24.h,
                        thickness: 1,
                        color: theme.dividerColor.withOpacity(0.1),
                      ),
                      _buildModernDetailRow(
                        icon: isAvailable
                            ? Icons.check_circle_rounded
                            : Icons.cancel_rounded,
                        label: 'حالة الاستعارة',
                        value: isAvailable
                            ? 'متاح للاستعارة الآن'
                            : 'غير متاح حالياً',
                        valueColor: statusColor,
                        theme: theme,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 20.h),

            if (isAvailable)
              SizedBox(
                width: double.infinity,
                height: 54.h,
                child: ElevatedButton.icon(
                  onPressed: _isReserving ? null : _reserveBook,
                  icon: _isReserving
                      ? SizedBox(
                          width: 20.w,
                          height: 20.w,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.w,
                          ),
                        )
                      : Icon(Icons.bookmark_add_rounded, size: 22.w),
                  label: Text(
                    _isReserving
                        ? S.of(context).reserving
                        : S.of(context).reserve_book,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    disabledBackgroundColor: Colors.grey.shade300,
                  ),
                ),
              ),

            SizedBox(height: 12.h),

            // ---- زر إغلاق ----
            SizedBox(
              width: double.infinity,
              height: 48.h,
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
                child: Text(
                  S.of(context).close,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.8, curve: Curves.easeOut),
      ),
    );
    _slideAnim = Tween<Offset>(begin: const Offset(0, 0.15), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.3, 1.0, curve: Curves.easeOutQuart),
          ),
        );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.forward();
    });
  }

  // ---- دوال مساعدة ----
  Widget _buildModernDetailRow({
    required IconData icon,
    required String label,
    required String value,
    Color? valueColor,
    required ThemeData theme,
  }) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: (valueColor ?? Colors.grey).withOpacity(0.1),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Icon(
            icon,
            size: 18.w,
            color: valueColor ?? Colors.grey.shade600,
          ),
        ),
        SizedBox(width: 14.w),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13.5.sp,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Text(
          value,
          textAlign: TextAlign.end,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: valueColor ?? theme.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }

  // ---- حجز الكتاب ----
  void _reserveBook() {
    setState(() => _isReserving = true);
    widget.libraryBloc.add(
      ReserveBookEvent(localBookNumber: widget.book.localBookNumber),
    );
  }
}
