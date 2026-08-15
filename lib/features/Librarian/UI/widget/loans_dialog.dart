import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/core/widget/Loadingwidget.dart';
import 'package:school/features/Librarian/UI/Bloc/LibrarianReservationsLoansBloc/librarian_reservations_loans_bloc.dart';
import 'package:school/features/Librarian/UI/widget/helpingWidget/getStatusColor.dart';
import 'package:school/features/Librarian/domain/Entity/general_entity/reservations.dart';
import 'package:school/generated/l10n.dart';

class LoansDialog extends StatefulWidget {
  final String initialStatus;

  const LoansDialog({super.key, this.initialStatus = 'All'});

  @override
  State<LoansDialog> createState() => _LoansDialogState();
}

class _LoansDialogState extends State<LoansDialog> {
  List<Reservations>? _lastLoans;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BlocConsumer<
      LibrarianReservationsLoansBloc,
      LibrarianReservationsLoansState
    >(
      listener: (context, state) {
        if (state is LoansError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: colorScheme.error,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              duration: const Duration(seconds: 3),
            ),
          );
        }
        if (state is LoansLoaded) {
          _lastLoans = state.loans.loans;
        }
      },
      builder: (context, state) {
        final isLoading = state is LoansLoading;

        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.r),
          ),
          // backgroundColor: theme.scaffoldBackgroundColor,
          child: Container(
            constraints: BoxConstraints(maxHeight: 680.h, maxWidth: 500.w),
            padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 20.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context, state),
                SizedBox(height: 8.h),

                if (isLoading)
                  LinearProgressIndicator(
                    backgroundColor: Colors.transparent,
                    color: colorScheme.primary,
                    minHeight: 2.5.h,
                  ),

                SizedBox(height: isLoading ? 8.h : 0.h),

                // _buildFilterChips(context),
                SizedBox(height: 16.h),

                Expanded(child: _buildContent(context, state)),
              ],
            ),
          ),
        );
      },
    );
  }

  String formatDate(DateTime? date) {
    if (date == null) return 'غير محدد';
    try {
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
      return 'غير محدد';
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LibrarianReservationsLoansBloc>().add(
        GetLoansEvent(status: null), // ✅ نمرر null لأننا نريد الكل
      );
    });
  }

  // ============================================================
  // ====== المحتوى الرئيسي ======
  // ============================================================

  Widget _buildContent(
    BuildContext context,
    LibrarianReservationsLoansState state,
  ) {
    if (state is LoansLoading && _lastLoans == null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Loadingwidget(),
            SizedBox(height: 12.h),
            Text(
              S.of(context).loadingDataMessage,
              style: TextStyle(
                fontSize: 13.sp,
                color: Theme.of(context).hintColor,
              ),
            ),
          ],
        ),
      );
    }

    if (state is LoansLoading && _lastLoans != null) {
      return _buildLoansList(context, _lastLoans!);
    }

    if (state is LoansLoaded) {
      final loans = state.loans.loans ?? [];
      return _buildLoansList(context, loans);
    }

    if (state is LoansError) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.cloud_off_rounded,
              size: 50.w,
              color: Colors.red.shade400,
            ),
            SizedBox(height: 12.h),
            Text(
              state.message,
              style: TextStyle(
                fontSize: 13.sp,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 14.h),
            OutlinedButton.icon(
              onPressed: () {
                context.read<LibrarianReservationsLoansBloc>().add(
                  GetLoansEvent(status: null),
                );
              },
              icon: Icon(Icons.refresh_rounded, size: 16.w),
              label: Text(S.of(context).retryButton),
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Center(child: Text(S.of(context).loadingDataMessage));
  }

  // ============================================================
  // ====== الهيدر ======
  // ============================================================

  Widget _buildHeader(
    BuildContext context,
    LibrarianReservationsLoansState state,
  ) {
    final theme = Theme.of(context);
    final bloc = context.read<LibrarianReservationsLoansBloc>();
    final isLoading = state is LoansLoading;

    return Column(
      children: [
        Center(
          child: Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: theme.dividerColor,
              borderRadius: BorderRadius.circular(10.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: Colors.green.shade700.withOpacity(0.12),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Icon(
                Icons.copy_all_rounded,
                color: Colors.green.shade800,
                size: 22.w,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).loansManagementTitle,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    S.of(context).loansManagementSubtitle,
                    style: TextStyle(fontSize: 11.sp, color: theme.hintColor),
                  ),
                ],
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(50.r),
                onTap: isLoading
                    ? null
                    : () {
                        bloc.add(RefreshLoansEvent(status: null));
                      },
                child: Container(
                  padding: EdgeInsets.all(6.w),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: theme.dividerColor.withOpacity(0.05),
                  ),
                  child: AnimatedRotation(
                    turns: isLoading ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 800),
                    child: Icon(
                      Icons.refresh_rounded,
                      size: 20.w,
                      color: isLoading
                          ? theme.colorScheme.primary
                          : theme.hintColor,
                    ),
                  ),
                ),
              ),
            ),
            // زر الإغلاق
            Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(50.r),
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: EdgeInsets.all(6.w),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: theme.dividerColor.withOpacity(0.05),
                  ),
                  child: Icon(
                    Icons.close_rounded,
                    size: 20.w,
                    color: theme.hintColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ============================================================
  // ====== بطاقة الاستعارة ======
  // ============================================================

  Widget _buildLoanCard(BuildContext context, Reservations loan) {
    final theme = Theme.of(context);
    final statusColor = getStatusColor(loan.statusName);

    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: theme.dividerColor, width: 2.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      padding: EdgeInsets.all(12.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Icon
          Container(
            width: 46.w,
            height: 46.w,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.08),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.copy_all_rounded,
                  size: 16.w,
                  color: theme.colorScheme.primary,
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),

          // التفاصيل
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  loan.bookTitle ?? S.of(context).unknownBookTitle,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Icon(
                      Icons.person_outline_rounded,
                      size: 13.w,
                      color: theme.hintColor,
                    ),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: Text(
                        loan.studentName ?? S.of(context).unknownStudent,
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: theme.hintColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          size: 11.w,
                          color: theme.hintColor.withOpacity(0.7),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          loan.date != null
                              ? formatDate(loan.date)
                              : S.of(context).unknownDate,
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: theme.hintColor.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time_rounded,
                          size: 11.w,
                          color: theme.hintColor.withOpacity(0.7),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          loan.expiryDate != null
                              ? formatDate(loan.expiryDate)
                              : S.of(context).unknownDate,
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: theme.hintColor.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(width: 8.w),

          // الحالة
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Text(
              _getTranslatedLoanStatus(context, loan.statusName ?? 'Active'),
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.bold,
                color: statusColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // ====== عرض قائمة الاستعارات ======
  // ============================================================

  Widget _buildLoansList(BuildContext context, List<Reservations> loans) {
    if (loans.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Theme.of(context).dividerColor.withOpacity(0.05),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.folder_off_outlined,
                size: 48.w,
                color: Theme.of(context).hintColor.withOpacity(0.5),
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              S.of(context).noLoansTitle,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              S.of(context).noLoansSubtitle,
              style: TextStyle(
                fontSize: 12.sp,
                color: Theme.of(context).hintColor,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        _buildStatsRow(context, loans),
        SizedBox(height: 12.h),
        Expanded(
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemCount: loans.length,
            separatorBuilder: (_, _) => SizedBox(height: 20.h),
            itemBuilder: (_, index) {
              return _buildLoanCard(context, loans[index]);
            },
          ),
        ),
      ],
    );
  }

  // ============================================================
  // ====== الإحصائيات (بدون فواصل رأسية) ======
  // ============================================================

  Widget _buildStatPill({
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          label,
          style: TextStyle(fontSize: 10.sp, color: Theme.of(context).hintColor),
        ),
      ],
    );
  }

  Widget _buildStatsRow(BuildContext context, List<Reservations> loans) {
    final total = loans.length;
    final active = loans.where((l) => l.statusName == 'Active').length;
    final returned = loans.where((l) => l.statusName == 'Returned').length;
    final overdue = loans.where((l) => l.statusName == 'Overdue').length;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Theme.of(context).dividerColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatPill(
            label: S.of(context).statTotal,
            value: '$total',
            color: Colors.blueGrey,
          ),
          _buildStatPill(
            label: S.of(context).statActive,
            value: '$active',
            color: Colors.green.shade600,
          ),
          _buildStatPill(
            label: S.of(context).statReturned,
            value: '$returned',
            color: Colors.blue.shade600,
          ),
          _buildStatPill(
            label: S.of(context).statOverdue,
            value: '$overdue',
            color: Colors.red.shade600,
          ),
        ],
      ),
    );
  }

  // ============================================================
  // ====== دوال مساعدة للترجمة ======
  // ============================================================

  String _getTranslatedLoanStatus(BuildContext context, String status) {
    switch (status) {
      case 'Active':
        return S.of(context).statusActive;
      case 'Returned':
        return S.of(context).statusReturned;
      case 'Overdue':
        return S.of(context).statusOverdue;
      default:
        return status;
    }
  }
}
