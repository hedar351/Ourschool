import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/core/injection.dart' as di;
import 'package:school/features/Librarian/UI/Bloc/BookLoansBloc/book_loans_bloc.dart';
import 'package:school/features/Librarian/UI/Bloc/BookReservationsLoansBloc/book_reservations_loans_bloc.dart';
import 'package:school/features/Librarian/UI/widget/BottomSheetWidget/loans_tab_content.dart';
import 'package:school/features/Librarian/UI/widget/BottomSheetWidget/reservations_tab_content.dart';
import 'package:school/generated/l10n.dart';

class BookReservationsBottomSheet extends StatefulWidget {
  final int localBookNumber;
  final String initialStatus;

  const BookReservationsBottomSheet({
    super.key,
    required this.localBookNumber,
    this.initialStatus = 'Pending',
  });

  @override
  State<BookReservationsBottomSheet> createState() =>
      _BookReservationsBottomSheetState();
}

class _BookReservationsBottomSheetState
    extends State<BookReservationsBottomSheet>
    with SingleTickerProviderStateMixin {
  late String _selectedStatus;
  late TabController _tabController;

  final List<String> _statusOptions = [
    'Pending',
    'Approved',
    'Rejected',
    'Cancelled',
    'Fulfilled',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: context.read<BookReservationsLoansBloc>()),
        BlocProvider(create: (context) => di.sl<BookLoansBloc>()),
      ],
      child: Builder(
        builder: (innerContext) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              _fetchReservations(innerContext);
              _fetchLoans(innerContext);
            }
          });

          return BlocConsumer<
            BookReservationsLoansBloc,
            BookReservationsLoansState
          >(
            listener: (context, state) {
              if (state is BookReservationsError) {
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
            },
            builder: (context, state) {
              final isLoading = state is BookReservationsLoading;

              return Container(
                height: 600.h,
                padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 20.h),
                decoration: BoxDecoration(
                  color: theme.scaffoldBackgroundColor,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(24.r),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(context, state),
                    _buildTabBar(),
                    if (isLoading)
                      LinearProgressIndicator(
                        backgroundColor: Colors.transparent,
                        color: colorScheme.primary,
                        minHeight: 2.5.h,
                      ),
                    SizedBox(height: isLoading ? 8.h : 0.h),
                    Expanded(child: _buildTabBarView(context, state)),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.initialStatus;
    _tabController = TabController(length: 2, vsync: this);
  }

  Widget _buildHeader(BuildContext context, BookReservationsLoansState state) {
    final theme = Theme.of(context);
    final isLoading = state is BookReservationsLoading;

    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: Colors.amber.shade700.withOpacity(0.12),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Icon(
            Icons.bookmarks_rounded,
            color: Colors.amber.shade800,
            size: 22.w,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).bookReservationsTitle,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              Text(
                S.of(context).bookReservationsSubtitle,
                style: TextStyle(fontSize: 11.sp, color: theme.hintColor),
              ),
            ],
          ),
        ),
        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(50.r),
            onTap: isLoading ? null : () => _refreshAll(context),
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
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      controller: _tabController,
      indicatorColor: Theme.of(context).colorScheme.primary,
      labelColor: Theme.of(context).colorScheme.primary,
      unselectedLabelColor: Theme.of(context).hintColor,
      tabs: [
        Tab(text: S.of(context).reserves),
        Tab(text: S.of(context).loans),
      ],
    );
  }

  Widget _buildTabBarView(
    BuildContext context,
    BookReservationsLoansState state,
  ) {
    return TabBarView(
      controller: _tabController,
      children: [
        ReservationsTabContent(
          selectedStatus: _selectedStatus,
          onStatusChanged: (newStatus) {
            setState(() {
              _selectedStatus = newStatus;
            });
            _fetchReservations(context);
          },
          statusOptions: _statusOptions,
          localBookNumber: widget.localBookNumber,
        ),
        LoansTabContent(localBookNumber: widget.localBookNumber),
      ],
    );
  }

  void _fetchLoans(BuildContext context) {
    context.read<BookLoansBloc>().add(
      GetBookLoansEvent(localBookNumber: widget.localBookNumber),
    );
  }

  void _fetchReservations(BuildContext context) {
    context.read<BookReservationsLoansBloc>().add(
      GetBookReservationsEvent(
        status: _selectedStatus,
        localBookNumber: widget.localBookNumber,
      ),
    );
  }

  void _refreshAll(BuildContext context) {
    context.read<BookReservationsLoansBloc>().add(
      RefreshBookReservationsEvent(
        status: _selectedStatus,
        localBookNumber: widget.localBookNumber,
      ),
    );
    context.read<BookLoansBloc>().add(
      RefreshBookLoansEvent(localBookNumber: widget.localBookNumber),
    );
  }
}
