// lib/features/Library/presentation/bloc/library_bloc.dart

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school/core/const.dart';
import 'package:school/core/error/failures.dart';
import 'package:school/features/Student/domain/Repo/library_repo.dart';
import 'package:school/features/Student/domain/entity/Library/BookEntity.dart';
import 'package:school/features/Student/domain/entity/Library/reserveEntity.dart';
import 'package:school/features/Student/domain/useCase/get_books_usecase.dart';
import 'package:school/features/Student/domain/useCase/reserveBookUseCase.dart';

part 'library_event.dart';
part 'library_state.dart';

class LibraryBloc extends Bloc<LibraryEvent, LibraryState> {
  final GetBooksUseCase getBooksUseCase;
  final ReserveBookUseCase reserveBookUseCase;

  final LibraryRepo libraryRepo;
  Stream<List<BookEntity>>? _cachedStream;
  StreamSubscription? _subscription;

  LibraryBloc({
    required this.getBooksUseCase,
    required this.libraryRepo,
    required this.reserveBookUseCase,
  }) : super(LibraryInitial()) {
    on<GetBooksEvent>(_onGetAll);
    on<RefreshBooksEvent>(_onRefresh);
    on<RevalidateBooksEvent>(_onRevalidate);
    on<WatchCachedBooksEvent>(_onWatchCached);
    on<UpdateCachedBooksEvent>(_onUpdateCached);
    on<ReserveBookEvent>(_onReserveBook);
    on<ResetReserveStateEvent>(_onResetReserveState);
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }

  // ---- Get Books (First Load) ----
  Future<void> _onGetAll(
    GetBooksEvent event,
    Emitter<LibraryState> emit,
  ) async {
    emit(LibraryLoading());
    final either = await getBooksUseCase();
    either.fold(
      (failure) => emit(LibraryError(message: mapFailureToMessage(failure))),
      (books) {
        emit(LibraryLoaded(books: books, isRevalidating: false));
        add(WatchCachedBooksEvent());
      },
    );
  }

  // ---- Refresh (Pull to Refresh) ----
  Future<void> _onRefresh(
    RefreshBooksEvent event,
    Emitter<LibraryState> emit,
  ) async {
    final either = await libraryRepo.getBooksWithCache();
    either.fold(
      (failure) => emit(LibraryError(message: mapFailureToMessage(failure))),
      (books) {
        emit(LibraryLoaded(books: books, isRevalidating: false));
      },
    );
  }

  Future<void> _onReserveBook(
    ReserveBookEvent event,
    Emitter<LibraryState> emit,
  ) async {
    emit(LibraryReserving());

    final result = await reserveBookUseCase(event.localBookNumber);

    result.fold(
      (failure) {
        String message = 'حدث خطأ غير متوقع';

        if (failure is ServerFailure) {
          message = failure.message ?? 'حدث خطأ في الخادم';
        } else {
          message = mapFailureToMessage(failure);
        }

        print('📚 [Bloc] رسالة الخطأ: $message');
        emit(LibraryReserveError(message: message));
      },
      (reserveData) {
        emit(
          LibraryReserved(
            message: reserveData.message ?? 'تم حجز الكتاب بنجاح',
            reserveData: reserveData,
          ),
        );
        _refreshBooksInBackground();
      },
    );
  }

  Future<void> _onResetReserveState(
    ResetReserveStateEvent event,
    Emitter<LibraryState> emit,
  ) async {
    List<BookEntity> books = [];

    if (state is LibraryLoaded) {
      books = (state as LibraryLoaded).books;
    } else if (state is LibraryReserved) {
      final either = await libraryRepo.getBooks();
      either.fold((_) => {}, (b) => books = b);
    } else if (state is LibraryReserveError) {
      final either = await libraryRepo.getBooks();
      either.fold((_) => {}, (b) => books = b);
    } else if (state is LibraryInitial) {
      add(GetBooksEvent());
      return;
    } else {
      final either = await libraryRepo.getBooks();
      either.fold((_) => {}, (b) => books = b);
    }

    emit(LibraryLoaded(books: books, isRevalidating: false));
  }

  // ---- Revalidate (Background Update) ----
  Future<void> _onRevalidate(
    RevalidateBooksEvent event,
    Emitter<LibraryState> emit,
  ) async {
    if (state is LibraryLoaded) {
      final currentState = state as LibraryLoaded;
      emit(currentState.copyWith(isRevalidating: true));
    }

    final networkEither = await libraryRepo.getBooks();
    networkEither.fold(
      (failure) {
        if (state is LibraryLoaded) {
          final currentState = state as LibraryLoaded;
          emit(
            currentState.copyWith(
              isRevalidating: false,
              errorMessage: mapFailureToMessage(failure),
            ),
          );
        }
      },
      (books) {
        if (state is LibraryLoaded) {
          final currentState = state as LibraryLoaded;
          emit(
            currentState.copyWith(isRevalidating: false, errorMessage: null),
          );
        }
      },
    );
  }

  // ---- Update Cached (Background Update) ----
  Future<void> _onUpdateCached(
    UpdateCachedBooksEvent event,
    Emitter<LibraryState> emit,
  ) async {
    if (state is LibraryLoaded) {
      final currentState = state as LibraryLoaded;
      emit(currentState.copyWith(books: event.books));
    } else {
      emit(LibraryLoaded(books: event.books, isRevalidating: false));
    }
  }

  // ---- Watch Cached (Stream) ----
  Future<void> _onWatchCached(
    WatchCachedBooksEvent event,
    Emitter<LibraryState> emit,
  ) async {
    await _subscription?.cancel();
    _cachedStream = libraryRepo.watchCachedBooks();
    _subscription = _cachedStream?.listen((books) {
      if (state is LibraryLoaded) {
        add(UpdateCachedBooksEvent(books: books));
      }
    });
  }

  void _refreshBooksInBackground() {
    Future.delayed(const Duration(milliseconds: 100), () {
      add(RefreshBooksEvent());
    });
  }
}
