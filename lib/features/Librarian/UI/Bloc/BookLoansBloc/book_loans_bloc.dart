// lib/features/Librarian/UI/Bloc/BookLoansBloc/book_loans_bloc.dart

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school/core/const.dart';
import 'package:school/features/Librarian/domain/Entity/Book-reservations-loans-Entity/book_loan_entity.dart';
import 'package:school/features/Librarian/domain/Repo/Librarian_Repo.dart';
import 'package:school/features/Librarian/domain/UseCase/getBookLoansUseCase.dart';

part 'book_loans_event.dart';
part 'book_loans_state.dart';

class BookLoansBloc extends Bloc<BookLoansEvent, BookLoansState> {
  final Getbookloansusecase getBookLoansUseCase;
  final LibrarianRepo librarianRepo;

  Stream<BookLoanEntity>? _cachedStream;
  StreamSubscription? _subscription;

  BookLoansBloc({
    required this.getBookLoansUseCase,
    required this.librarianRepo,
  }) : super(BookLoansInitial()) {
    on<GetBookLoansEvent>(_onGet);
    on<RefreshBookLoansEvent>(_onRefresh);
    on<RevalidateBookLoansEvent>(_onRevalidate);
    on<WatchCachedBookLoansEvent>(_onWatchCached);
    on<UpdateCachedBookLoansEvent>(_onUpdateCached);
    on<ResetBookLoansState>(_onReset);
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }

  Future<void> _onGet(
    GetBookLoansEvent event,
    Emitter<BookLoansState> emit,
  ) async {
    emit(BookLoansLoading());
    final either = await getBookLoansUseCase(event.localBookNumber);
    either.fold(
      (failure) => emit(BookLoansError(message: mapFailureToMessage(failure))),
      (loans) {
        emit(
          BookLoansLoaded(
            loans: loans,
            isRevalidating: false,
            localBookNumber: event.localBookNumber,
          ),
        );
        add(WatchCachedBookLoansEvent(localBookNumber: event.localBookNumber));
      },
    );
  }

  Future<void> _onRefresh(
    RefreshBookLoansEvent event,
    Emitter<BookLoansState> emit,
  ) async {
    final either = await librarianRepo.getBookLoansWithCache(
      event.localBookNumber,
    );
    either.fold(
      (failure) => emit(BookLoansError(message: mapFailureToMessage(failure))),
      (loans) {
        emit(
          BookLoansLoaded(
            loans: loans,
            isRevalidating: false,
            localBookNumber: event.localBookNumber,
          ),
        );
      },
    );
  }

  Future<void> _onRevalidate(
    RevalidateBookLoansEvent event,
    Emitter<BookLoansState> emit,
  ) async {
    if (state is BookLoansLoaded) {
      final currentState = state as BookLoansLoaded;
      emit(currentState.copyWith(isRevalidating: true));
    }

    final networkEither = await librarianRepo.getBookLoans(
      event.localBookNumber,
    );
    networkEither.fold(
      (failure) {
        if (state is BookLoansLoaded) {
          final currentState = state as BookLoansLoaded;
          emit(
            currentState.copyWith(
              isRevalidating: false,
              errorMessage: mapFailureToMessage(failure),
            ),
          );
        }
      },
      (loans) {
        if (state is BookLoansLoaded) {
          final currentState = state as BookLoansLoaded;
          emit(
            currentState.copyWith(isRevalidating: false, errorMessage: null),
          );
        }
      },
    );
  }

  Future<void> _onUpdateCached(
    UpdateCachedBookLoansEvent event,
    Emitter<BookLoansState> emit,
  ) async {
    if (state is BookLoansLoaded) {
      final currentState = state as BookLoansLoaded;
      emit(currentState.copyWith(loans: event.loans));
    } else {
      emit(
        BookLoansLoaded(
          loans: event.loans,
          isRevalidating: false,
          localBookNumber: null,
        ),
      );
    }
  }

  Future<void> _onWatchCached(
    WatchCachedBookLoansEvent event,
    Emitter<BookLoansState> emit,
  ) async {
    await _subscription?.cancel();
    _cachedStream = librarianRepo.watchCachedgetBookLoans(
      event.localBookNumber,
    );
    _subscription = _cachedStream?.listen((loans) {
      if (state is BookLoansLoaded) {
        add(UpdateCachedBookLoansEvent(loans: loans));
      }
    });
  }

  Future<void> _onReset(
    ResetBookLoansState event,
    Emitter<BookLoansState> emit,
  ) {
    emit(BookLoansInitial());
    return Future.value();
  }
}
