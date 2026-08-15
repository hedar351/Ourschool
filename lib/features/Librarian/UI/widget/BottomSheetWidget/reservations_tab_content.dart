import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/core/widget/Loadingwidget.dart';
import 'package:school/features/Librarian/UI/Bloc/BookReservationsLoansBloc/book_reservations_loans_bloc.dart';
import 'package:school/features/Librarian/UI/widget/BottomSheetWidget/book_info_card.dart';
import 'package:school/features/Librarian/UI/widget/helpingWidget/getStatusColor.dart';
import 'package:school/features/Librarian/UI/widget/helpingWidget/helpers.dart';
import 'package:school/features/Librarian/domain/Entity/general_entity/reservations.dart';
import 'package:school/generated/l10n.dart';

class ReservationsTabContent extends StatelessWidget {
  final String selectedStatus;
  final ValueChanged<String> onStatusChanged;
  final List<String> statusOptions;
  final int localBookNumber;

  const ReservationsTabContent({
    super.key,
    required this.selectedStatus,
    required this.onStatusChanged,
    required this.statusOptions,
    required this.localBookNumber,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookReservationsLoansBloc, BookReservationsLoansState>(
      builder: (context, state) {
        final isLoading = state is BookReservationsLoading;
        List<Reservations>? lastReservations;

        if (state is BookReservationsLoaded) {
          lastReservations =
              state.reservations.librarianReservationsEntity?.reservations;
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (state is BookReservationsLoaded) ...[
              BookInfoCard(
                title: state.reservations.title ?? '',
                author: state.reservations.author ?? '',
                availableCopies: state.reservations.availableCopies ?? 0,
                reservedCopies: state.reservations.reservedCopies ?? 0,
                availableForLoan: state.reservations.availableForLoan ?? 0,
              ),
              SizedBox(height: 12.h),
            ],
            _buildFilterChips(context),
            SizedBox(height: 16.h),
            Expanded(
              child: _buildReservationsList(context, state, lastReservations),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFilterChips(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: statusOptions.map((status) {
          final isSelected = selectedStatus == status;
          final statusColor = getStatusColor(status);

          return Padding(
            padding: EdgeInsets.only(left: 8.w),
            child: ChoiceChip(
              showCheckmark: false,
              label: Text(getTranslatedStatus(context, status)),
              selected: isSelected,
              labelStyle: TextStyle(
                fontSize: 12.sp,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected
                    ? Colors.white
                    : Theme.of(context).colorScheme.onSurface,
              ),
              selectedColor: statusColor,
              backgroundColor: Theme.of(context).cardColor,
              side: BorderSide(
                color: isSelected
                    ? statusColor
                    : Theme.of(context).dividerColor,
                width: 1.w,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              onSelected: (selected) {
                if (selected && status != selectedStatus) {
                  onStatusChanged(status);
                }
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildReservationsList(
    BuildContext context,
    BookReservationsLoansState state,
    List<Reservations>? lastReservations,
  ) {
    List<Reservations> reservations = [];

    if (state is BookReservationsLoading && lastReservations != null) {
      reservations = lastReservations;
    } else if (state is BookReservationsLoaded) {
      reservations =
          state.reservations.librarianReservationsEntity?.reservations ?? [];
    } else if (state is BookReservationsError) {
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
                context.read<BookReservationsLoansBloc>().add(
                  GetBookReservationsEvent(
                    status: selectedStatus,
                    localBookNumber: localBookNumber,
                  ),
                );
              },
              icon: Icon(Icons.refresh_rounded, size: 16.w),
              label: Text(S.of(context).retryButton),
            ),
          ],
        ),
      );
    } else if (state is BookReservationsLoading && lastReservations == null) {
      return const Center(child: Loadingwidget());
    }

    if (reservations.isEmpty) {
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
              S.of(context).noReservationsForThisBook,
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
      itemCount: reservations.length,
      separatorBuilder: (_, _) => SizedBox(height: 10.h),
      itemBuilder: (context, index) {
        return _buildReservationCard(context, reservations[index]);
      },
    );
  }

  Widget _buildReservationCard(BuildContext context, Reservations reservation) {
    final theme = Theme.of(context);
    final statusColor = getStatusColor(reservation.statusName);

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
                  Icons.menu_book_rounded,
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
                  reservation.studentName ?? S.of(context).unknownStudent,
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
                        reservation.sectionName ?? '',
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
                    SizedBox(width: 4.w),
                    Text(
                      reservation.date != null
                          ? formatDate(reservation.date)
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
              getTranslatedStatus(context, reservation.statusName ?? 'Pending'),
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
}
