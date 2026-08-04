import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/core/widget/Loadingwidget.dart';
import 'package:school/core/widget/SnackBar/Message.dart';
import 'package:school/features/Student/domain/entity/Library/BookEntity.dart';
import 'package:school/features/Student/ui/bloc/libraryBloc/library_bloc.dart';
import 'package:school/features/Student/ui/libraryScreen/book_card.dart';
import 'package:school/generated/l10n.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen>
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

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: BlocConsumer<LibraryBloc, LibraryState>(
          listener: (context, state) {
            if (state is LibraryError) {
              snackBarMessage.errorMessage(
                message: state.message,
                context: context,
              );
            }
            if (state is LibraryLoaded) {
              _allBooks = state.books;
              _applyFilter();
            }
            if (state is LibraryLoaded) {
              _applyFilter();
            }
          },
          builder: (context, state) {
            if (state is LibraryLoading) {
              return const Loadingwidget();
            }
            if (state is LibraryLoaded) {
              if (state.books.isEmpty) {
                return _buildEmptyState(context);
              }
              return _buildLoadedState(context, state);
            }
            if (state is LibraryError) {
              return _buildErrorState(context, state.message);
            }
            if (state is LibraryReserving || state is LibraryReserved) {
              if (_allBooks.isEmpty) {
                return const Loadingwidget();
              }
              return _buildLoadedStateWithBooks(
                context,
                _allBooks,
                state is LibraryReserving,
              );
            }
            if (state is LibraryReserveError) {
              if (_allBooks.isEmpty) {
                return const Loadingwidget();
              }
              return _buildLoadedStateWithBooks(context, _allBooks, false);
            }
            return const Loadingwidget();
          },
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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline_rounded,
            size: 64.w,
            color: Colors.red.shade300,
          ),
          SizedBox(height: 12.h),
          Text(message, style: TextStyle(fontSize: 14.sp)),
          SizedBox(height: 12.h),
          TextButton.icon(
            onPressed: () =>
                context.read<LibraryBloc>().add(RefreshBooksEvent()),
            icon: Icon(Icons.refresh_rounded, size: 18.w),
            label: Text(S.of(context).retry),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadedState(BuildContext context, LibraryLoaded state) {
    return _buildLoadedStateWithBooks(context, state.books, false);
  }

  Widget _buildLoadedStateWithBooks(
    BuildContext context,
    List<BookEntity> books,
    bool isReserving,
  ) {
    return Stack(
      children: [
        RefreshIndicator(
          onRefresh: () async =>
              context.read<LibraryBloc>().add(RefreshBooksEvent()),
          color: Theme.of(context).colorScheme.primary,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            slivers: [
              SliverToBoxAdapter(child: _buildSearchBar(context)),
              SliverToBoxAdapter(child: _buildSearchStats(context)),

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
                              '❌ لا توجد نتائج مطابقة لـ "${_searchQueryNotifier.value}"',
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
                            (context, index) {
                              final book = displayedBooks[index];
                              return BookCard(
                                key: ValueKey(book.localBookNumber),
                                book: book,
                                index: index,
                              );
                            },
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

        if (isReserving)
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
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  Spacer(),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(S.of(context).My_Reservations),
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
    final bloc = context.read<LibraryBloc>();
    final currentState = bloc.state;

    if (currentState is LibraryInitial || currentState is LibraryError) {
      bloc.add(GetBooksEvent());
    } else if (currentState is LibraryLoaded && !currentState.isRevalidating) {
      bloc.add(RevalidateBooksEvent());
    }
  }

  void _onSearchChanged(String value) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 200), () {
      _searchQueryNotifier.value = value.trim();
      _applyFilter();
    });
  }
}
