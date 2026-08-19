import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/core/injection.dart' as di;
import 'package:school/core/widget/Loadingwidget.dart';
import 'package:school/core/widget/SnackBar/Message.dart';
import 'package:school/features/Librarian/UI/Bloc/AddDeleteEdit/add_delete_edit_bloc.dart';
import 'package:school/features/Librarian/UI/Bloc/BookReservationsBloc/book_reservations_loans_bloc.dart';
import 'package:school/features/Librarian/UI/Bloc/LibrarianBloc/librarian_bloc.dart';
import 'package:school/features/Librarian/UI/Bloc/LibrarianReservationsLoansBloc/librarian_reservations_loans_bloc.dart';
import 'package:school/features/Librarian/UI/widget/Dialog/add_book_dialog.dart';
import 'package:school/features/Librarian/UI/widget/Dialog/loans_dialog.dart';
import 'package:school/features/Librarian/UI/widget/Dialog/reservations_dialog.dart';
import 'package:school/features/Student/domain/entity/Library/BookEntity.dart';
import 'package:school/features/Student/ui/libraryScreen/Widget/book_card.dart';
import 'package:school/generated/l10n.dart';

class Booksscreen extends StatefulWidget {
  const Booksscreen({super.key});

  @override
  State<Booksscreen> createState() => _BooksscreenState();
}

class _BooksscreenState extends State<Booksscreen>
    with WidgetsBindingObserver, AutomaticKeepAliveClientMixin {
  late SnackBarMessage snackBarMessage;

  final TextEditingController _searchController = TextEditingController();
  Timer? _debounceTimer;

  final ValueNotifier<List<BookEntity>> _displayedBooksNotifier = ValueNotifier(
    [],
  );
  final ValueNotifier<String> _searchQueryNotifier = ValueNotifier('');
  final ValueNotifier<bool> _isReadyToAnimate = ValueNotifier(false);

  List<BookEntity> _allBooks = [];

  final double _iconSize = 80.w;
  final double _gapSmall = 16.h;
  final double _gapMedium = 8.h;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildSearchBar(context),
            _buildActionButtons(context),
            _buildSearchStats(context),
            Expanded(
              child: BlocConsumer<LibrarianBloc, LibrarianState>(
                listener: (context, state) {
                  if (state is LibrarianError) {
                    snackBarMessage.errorMessage(
                      message: state.message,
                      context: context,
                    );
                  }
                  if (state is LibrarianLoaded) {
                    _allBooks = state.books;
                    _applyFilter();
                  }
                },
                builder: (context, state) {
                  if (state is LibrarianError) {
                    return _buildErrorState(context, state.message);
                  }
                  if (state is LibrarianLoading) {
                    return const Loadingwidget();
                  }

                  if (state is LibrarianLoaded) {
                    if (state.books.isEmpty) {
                      return _buildEmptyState(context);
                    }
                    return _buildBooksList(
                      context,
                      state.books,
                      state.isRevalidating,
                    );
                  }

                  return const Loadingwidget();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _loadData();
    }
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _searchController.dispose();
    _displayedBooksNotifier.dispose();
    _searchQueryNotifier.dispose();
    _isReadyToAnimate.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    snackBarMessage = SnackBarMessage();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _isReadyToAnimate.value = true;
      }
    });

    _loadData();
  }

  void _applyFilter() {
    final query = _searchQueryNotifier.value.toLowerCase().trim();
    if (query.isEmpty) {
      _displayedBooksNotifier.value = _allBooks;
    } else {
      _displayedBooksNotifier.value = _allBooks.where((book) {
        return book.title.toLowerCase().contains(query) ||
            book.author.toLowerCase().contains(query);
      }).toList();
    }
  }

  Widget _buildActionButtons(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                final librarianBloc = context.read<LibrarianBloc>();
                showGeneralDialog(
                  context: context,
                  barrierDismissible: true,
                  barrierLabel: '',
                  transitionDuration: const Duration(milliseconds: 400),
                  barrierColor: Colors.black54,
                  transitionBuilder:
                      (context, animation, secondaryAnimation, child) {
                        final curvedAnimation = CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeOutBack,
                        );
                        return RepaintBoundary(
                          child: ScaleTransition(
                            scale: Tween<double>(
                              begin: 0.7,
                              end: 1.0,
                            ).animate(curvedAnimation),
                            child: FadeTransition(
                              opacity: Tween<double>(
                                begin: 0.0,
                                end: 1.0,
                              ).animate(curvedAnimation),
                              child: child,
                            ),
                          ),
                        );
                      },
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return MultiBlocProvider(
                      providers: [
                        BlocProvider.value(value: librarianBloc),
                        BlocProvider(
                          create: (context) => di.sl<AddDeleteEditBloc>(),
                        ),
                      ],
                      child: const AddBookDialog(),
                    );
                  },
                );
              },
              icon: Icon(Icons.add_circle_outline_rounded, size: 20.w),
              label: Text(S.of(context).add_book),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                padding: EdgeInsets.symmetric(vertical: 10.h),
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                showGeneralDialog(
                  context: context,
                  barrierDismissible: true,
                  barrierLabel: '',
                  transitionDuration: const Duration(milliseconds: 400),
                  barrierColor: Colors.black54,
                  transitionBuilder:
                      (context, animation, secondaryAnimation, child) {
                        final curvedAnimation = CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeOutBack,
                        );
                        return RepaintBoundary(
                          child: ScaleTransition(
                            scale: Tween<double>(
                              begin: 0.7,
                              end: 1.0,
                            ).animate(curvedAnimation),
                            child: FadeTransition(
                              opacity: Tween<double>(
                                begin: 0.0,
                                end: 1.0,
                              ).animate(curvedAnimation),
                              child: child,
                            ),
                          ),
                        );
                      },
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return BlocProvider(
                      create: (context) =>
                          di.sl<LibrarianReservationsLoansBloc>(),
                      child: const ReservationsDialog(initialStatus: 'Pending'),
                    );
                  },
                );
              },
              icon: Icon(
                Icons.bookmark_rounded,
                size: 20.w,
                color: Colors.orange,
              ),
              label: Text(S.of(context).reserves),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange.shade50,
                foregroundColor: Colors.orange.shade700,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                padding: EdgeInsets.symmetric(vertical: 10.h),
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                showGeneralDialog(
                  context: context,
                  barrierDismissible: true,
                  barrierLabel: '',
                  transitionDuration: const Duration(milliseconds: 400),
                  barrierColor: Colors.black54,
                  transitionBuilder:
                      (context, animation, secondaryAnimation, child) {
                        final curvedAnimation = CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeOutBack,
                        );
                        return RepaintBoundary(
                          child: ScaleTransition(
                            scale: Tween<double>(
                              begin: 0.7,
                              end: 1.0,
                            ).animate(curvedAnimation),
                            child: FadeTransition(
                              opacity: Tween<double>(
                                begin: 0.0,
                                end: 1.0,
                              ).animate(curvedAnimation),
                              child: child,
                            ),
                          ),
                        );
                      },
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return BlocProvider(
                      create: (context) =>
                          di.sl<LibrarianReservationsLoansBloc>(),
                      child: const LoansDialog(initialStatus: 'Active'),
                    );
                  },
                );
              },
              icon: Icon(
                Icons.copy_all_rounded,
                size: 20.w,
                color: Colors.green,
              ),
              label: Text(S.of(context).loans),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade50,
                foregroundColor: Colors.green.shade700,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                padding: EdgeInsets.symmetric(vertical: 10.h),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBooksList(
    BuildContext context,
    List<BookEntity> books,
    bool isRevalidating,
  ) {
    return BlocProvider(
      create: (context) => di.sl<BookReservationsLoansBloc>(),
      child: Stack(
        children: [
          RefreshIndicator(
            onRefresh: () async =>
                context.read<LibrarianBloc>().add(RefreshBooksLibrarianEvent()),
            color: Theme.of(context).colorScheme.primary,
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                ValueListenableBuilder<bool>(
                  valueListenable: _isReadyToAnimate,
                  builder: (context, isReady, _) {
                    if (!isReady) {
                      return const SliverToBoxAdapter(child: SizedBox.shrink());
                    }

                    return ValueListenableBuilder<List<BookEntity>>(
                      valueListenable: _displayedBooksNotifier,
                      builder: (context, displayedBooks, _) {
                        if (displayedBooks.isEmpty &&
                            _searchQueryNotifier.value.isNotEmpty) {
                          return SliverFillRemaining(
                            hasScrollBody: false,
                            child: Center(
                              child: Text(
                                '❌ لا توجد نتائج مطابقة',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ),
                          );
                        }

                        return SliverPadding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 8.h,
                          ),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) => BookCard(
                                isStudent: false,
                                key: ValueKey(
                                  displayedBooks[index].localBookNumber,
                                ),
                                book: displayedBooks[index],
                                index: index,
                              ),
                              childCount: displayedBooks.length,
                              addAutomaticKeepAlives: true,
                              addRepaintBoundaries: true,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                SliverToBoxAdapter(child: SizedBox(height: 40.h)),
              ],
            ),
          ),
          if (isRevalidating)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: LinearProgressIndicator(
                backgroundColor: Colors.transparent,
                color: Theme.of(context).colorScheme.primary,
                minHeight: 2.5.h,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.library_books_outlined,
            size: 64.w,
            color: Colors.grey.shade400,
          ),
          SizedBox(height: 12.h),
          Text(
            'لا توجد كتب في المكتبة حالياً',
            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.wifi_off_rounded,
            size: _iconSize,
            color: Colors.red.shade300,
          ),
          SizedBox(height: _gapSmall),
          Text(
            message,
            textAlign: TextAlign.center,
            style: theme.textTheme.titleMedium?.copyWith(fontSize: 16.sp),
          ),
          SizedBox(height: _gapMedium),
          TextButton.icon(
            onPressed: () {
              context.read<LibrarianBloc>().add(RefreshBooksLibrarianEvent());
            },
            icon: Icon(Icons.refresh, size: 20.w),
            label: Text(S.of(context).retry, style: TextStyle(fontSize: 14.sp)),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 6.h),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: theme.dividerColor.withOpacity(0.08),
          width: 1.r,
        ),
      ),
      child: TextField(
        controller: _searchController,
        onChanged: _onSearchChanged,
        decoration: InputDecoration(
          hintText: S.of(context).search_hint,
          hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 13.sp),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: theme.colorScheme.primary,
            size: 22.w,
          ),
          suffixIcon: ValueListenableBuilder<String>(
            valueListenable: _searchQueryNotifier,
            builder: (context, query, _) {
              if (query.isEmpty) return const SizedBox.shrink();
              return IconButton(
                icon: Icon(
                  Icons.clear_rounded,
                  color: Colors.grey.shade500,
                  size: 18.w,
                ),
                onPressed: _clearSearch,
              );
            },
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 14.w,
            vertical: 12.h,
          ),
        ),
      ),
    );
  }

  Widget _buildSearchStats(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
      child: ValueListenableBuilder<String>(
        valueListenable: _searchQueryNotifier,
        builder: (context, query, _) {
          return ValueListenableBuilder<List<BookEntity>>(
            valueListenable: _displayedBooksNotifier,
            builder: (context, displayedBooks, _) {
              return Row(
                children: [
                  Text(
                    query.isEmpty
                        ? S.of(context).total_books
                        : S.of(context).search_results,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    '${displayedBooks.length} ${S.of(context).Books}',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  void _clearSearch() {
    _searchController.clear();
    _searchQueryNotifier.value = '';
    _displayedBooksNotifier.value = _allBooks;
    FocusScope.of(context).unfocus();
  }

  void _loadData() {
    final bloc = context.read<LibrarianBloc>();
    final currentState = bloc.state;

    if (currentState is LibrarianInitial || currentState is LibrarianError) {
      bloc.add(GetBooksLibrarianEvent());
    } else if (currentState is LibrarianLoaded &&
        !currentState.isRevalidating) {
      bloc.add(RevalidateBooksLibrarianEvent());
    }
  }

  void _onSearchChanged(String value) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 250), () {
      _searchQueryNotifier.value = value.trim();
      _applyFilter();
    });
  }
}
