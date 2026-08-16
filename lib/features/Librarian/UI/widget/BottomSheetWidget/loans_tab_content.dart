import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/core/widget/Loadingwidget.dart';
import 'package:school/features/Librarian/UI/Bloc/BookLoansBloc/book_loans_bloc.dart';
import 'package:school/features/Librarian/UI/widget/helpingWidget/getStatusColor.dart';
import 'package:school/features/Librarian/UI/widget/helpingWidget/helpers.dart';
import 'package:school/features/Librarian/domain/Entity/general_entity/reservations.dart';
import 'package:school/generated/l10n.dart';

class LoansTabContent extends StatelessWidget {
  final int localBookNumber;

  const LoansTabContent({super.key, required this.localBookNumber});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookLoansBloc, BookLoansState>(
      builder: (context, state) {
        // final isLoading = state is BookLoansLoading;
        List<Reservations>? lastLoans;

        if (state is BookLoansLoaded) {
          lastLoans = state.loans.reservations;
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (state is BookLoansLoaded) ...[
              _buildBookInfoCard(context, state),
              SizedBox(height: 12.h),
            ],
            SizedBox(height: 16.h),
            Expanded(child: _buildLoansList(context, state, lastLoans)),
          ],
        );
      },
    );
  }

  Widget _buildBookInfoCard(BuildContext context, BookLoansLoaded state) {
    final theme = Theme.of(context);
    final book = state.loans;
    final stats = book.statisticsLoans;

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
            book.title?.isNotEmpty == true
                ? book.title!
                : S.of(context).unknownTitle,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
          if (book.author?.isNotEmpty == true) ...[
            SizedBox(height: 4.h),
            Text(
              '${S.of(context).authorLabel}: ${book.author}',
              style: TextStyle(fontSize: 13.sp, color: theme.hintColor),
            ),
          ],
          // SizedBox(height: 8.h),
          // Row(children: [

          //   ],
          // ),
          if (stats != null) ...[
            SizedBox(height: 8.h),
            Divider(height: 1.h, color: theme.dividerColor.withOpacity(0.3)),
            SizedBox(height: 8.h),
            Row(
              children: [
                _buildInfoChip(
                  context,
                  label: S.of(context).statTotalLoans,
                  value: '${stats.totalLoans ?? 0}',
                  color: Colors.blueGrey,
                ),
                SizedBox(width: 4.w),
                _buildInfoChip(
                  context,
                  label: S.of(context).statActiveLoans,
                  value: '${stats.activeLoans ?? 0}',
                  color: Colors.green.shade600,
                ),
                SizedBox(width: 4.w),
                _buildInfoChip(
                  context,
                  label: S.of(context).statReturnedLoans,
                  value: '${stats.returnedLoans ?? 0}',
                  color: Colors.blue.shade600,
                ),
                SizedBox(width: 4.w),
                _buildInfoChip(
                  context,
                  label: S.of(context).statOverdueLoans,
                  value: '${stats.overdueLoans ?? 0}',
                  color: Colors.red.shade600,
                ),
              ],
            ),
          ],
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
          SizedBox(width: 2.w),
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

  Widget _buildLoanCard(BuildContext context, Reservations loan) {
    final theme = Theme.of(context);
    final statusColor = getStatusColor(loan.statusName);

    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: theme.dividerColor, width: 1.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.all(12.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  loan.studentName ?? S.of(context).unknownStudent,
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
                      Icons.school_rounded,
                      size: 13.w,
                      color: theme.hintColor,
                    ),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: Text(
                        loan.sectionName ?? '',
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
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 11.w,
                      color: theme.hintColor.withOpacity(0.7),
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      loan.date != null
                          ? formatDate(loan.date)
                          : S.of(context).unknownDate,
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: theme.hintColor.withOpacity(0.8),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Icon(
                      Icons.access_time_rounded,
                      size: 11.w,
                      color: theme.hintColor.withOpacity(0.7),
                    ),
                    SizedBox(width: 2.w),
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
          ),
          SizedBox(width: 8.w),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Text(
              getTranslatedStatus(context, loan.statusName ?? 'Active'),
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

  Widget _buildLoansList(
    BuildContext context,
    BookLoansState state,
    List<Reservations>? lastLoans,
  ) {
    List<Reservations> loans = [];

    if (state is BookLoansLoading && lastLoans != null) {
      loans = lastLoans;
    } else if (state is BookLoansLoaded) {
      loans = state.loans.reservations ?? [];
    } else if (state is BookLoansError) {
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
                context.read<BookLoansBloc>().add(
                  GetBookLoansEvent(localBookNumber: localBookNumber),
                );
              },
              icon: Icon(Icons.refresh_rounded, size: 16.w),
              label: Text(S.of(context).retryButton),
            ),
          ],
        ),
      );
    } else if (state is BookLoansLoading && lastLoans == null) {
      return const Center(child: Loadingwidget());
    }

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
              S.of(context).noLoansForThisBook,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              S.of(context).tryAnotherFilter,
              style: TextStyle(
                fontSize: 12.sp,
                color: Theme.of(context).hintColor,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: loans.length,
      separatorBuilder: (_, _) => SizedBox(height: 10.h),
      itemBuilder: (context, index) {
        return _buildLoanCard(context, loans[index]);
      },
    );
  }
}
