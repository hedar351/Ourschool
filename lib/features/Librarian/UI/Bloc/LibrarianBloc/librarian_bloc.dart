import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school/core/const.dart';
import 'package:school/features/Librarian/domain/Repo/Librarian_Repo.dart';
import 'package:school/features/Librarian/domain/UseCase/getBooksLibrarianUseCase.dart';
import 'package:school/features/Student/domain/entity/Library/BookEntity.dart';

part 'librarian_event.dart';
part 'librarian_state.dart';

class LibrarianBloc extends Bloc<LibrarianEvent, LibrarianState> {
  final Getbookslibrarianusecase getBooksLibrarianUseCase;
  final LibrarianRepo librarianRepo;

  Stream<List<BookEntity>>? _cachedStream;
  StreamSubscription? _subscription;

  LibrarianBloc({
    required this.getBooksLibrarianUseCase,
    required this.librarianRepo,
  }) : super(LibrarianInitial()) {
    on<GetBooksLibrarianEvent>(_onGetBooks);
    on<RefreshBooksLibrarianEvent>(_onRefreshBooks);
    on<RevalidateBooksLibrarianEvent>(_onRevalidateBooks);
    on<WatchCachedBooksLibrarianEvent>(_onWatchCachedBooks);
    on<UpdateCachedBooksLibrarianEvent>(_onUpdateCachedBooks);
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }

  // ============================================================
  // ====== GET BOOKS (First Load) ======
  // ============================================================

  Future<void> _onGetBooks(
    GetBooksLibrarianEvent event,
    Emitter<LibrarianState> emit,
  ) async {
    emit(LibrarianLoading());
    final either = await getBooksLibrarianUseCase();
    either.fold(
      (failure) => emit(LibrarianError(message: mapFailureToMessage(failure))),
      (books) {
        emit(LibrarianLoaded(books: books, isRevalidating: false));
        add(WatchCachedBooksLibrarianEvent());
      },
    );
  }

  // ============================================================
  // ====== REFRESH (Pull to Refresh) ======
  // ============================================================

  Future<void> _onRefreshBooks(
    RefreshBooksLibrarianEvent event,
    Emitter<LibrarianState> emit,
  ) async {
    final either = await librarianRepo.getBooksWithCacheLibrarian();
    either.fold(
      (failure) => emit(LibrarianError(message: mapFailureToMessage(failure))),
      (books) {
        emit(LibrarianLoaded(books: books, isRevalidating: false));
      },
    );
  }

  // ============================================================
  // ====== REVALIDATE (Background Update) ======
  // ============================================================

  Future<void> _onRevalidateBooks(
    RevalidateBooksLibrarianEvent event,
    Emitter<LibrarianState> emit,
  ) async {
    if (state is LibrarianLoaded) {
      final currentState = state as LibrarianLoaded;
      emit(currentState.copyWith(isRevalidating: true));
    }

    final networkEither = await librarianRepo.getBooksLibrarian();
    networkEither.fold(
      (failure) {
        if (state is LibrarianLoaded) {
          final currentState = state as LibrarianLoaded;
          emit(
            currentState.copyWith(
              isRevalidating: false,
              errorMessage: mapFailureToMessage(failure),
            ),
          );
        }
      },
      (books) {
        if (state is LibrarianLoaded) {
          final currentState = state as LibrarianLoaded;
          emit(
            currentState.copyWith(isRevalidating: false, errorMessage: null),
          );
        }
      },
    );
  }

  // ============================================================
  // ====== UPDATE CACHED (Background Update) ======
  // ============================================================

  Future<void> _onUpdateCachedBooks(
    UpdateCachedBooksLibrarianEvent event,
    Emitter<LibrarianState> emit,
  ) async {
    if (state is LibrarianLoaded) {
      final currentState = state as LibrarianLoaded;
      emit(currentState.copyWith(books: event.books));
    } else {
      emit(LibrarianLoaded(books: event.books, isRevalidating: false));
    }
  }

  // ============================================================
  // ====== WATCH CACHED (Stream) ======
  // ============================================================

  Future<void> _onWatchCachedBooks(
    WatchCachedBooksLibrarianEvent event,
    Emitter<LibrarianState> emit,
  ) async {
    await _subscription?.cancel();
    _cachedStream = librarianRepo.watchCachedBooksLibrarian();
    _subscription = _cachedStream?.listen((books) {
      if (state is LibrarianLoaded) {
        add(UpdateCachedBooksLibrarianEvent(books: books));
      }
    });
  }
}
