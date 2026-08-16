// lib/features/Librarian/UI/Bloc/BookReservationsLoansBloc/book_reservations_loans_bloc.dart

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school/core/const.dart';
import 'package:school/features/Librarian/domain/Entity/Book-reservations-loans-Entity/book_reservations_entity.dart';
import 'package:school/features/Librarian/domain/Repo/Librarian_Repo.dart';
import 'package:school/features/Librarian/domain/UseCase/getBookReservationsUseCase.dart';

part 'book_reservations_loans_event.dart';
part 'book_reservations_loans_state.dart';

class BookReservationsLoansBloc
    extends Bloc<BookReservationsLoansEvent, BookReservationsLoansState> {
  final Getbookreservationsusecase getBookReservationsUseCase;
  final LibrarianRepo librarianRepo;

  Stream<BookReservationsEntity>? _cachedStream;
  StreamSubscription? _subscription;

  BookReservationsLoansBloc({
    required this.getBookReservationsUseCase,
    required this.librarianRepo,
  }) : super(BookReservationsInitial()) {
    on<GetBookReservationsEvent>(_onGet);
    on<RefreshBookReservationsEvent>(_onRefresh);
    on<RevalidateBookReservationsEvent>(_onRevalidate);
    on<WatchCachedBookReservationsEvent>(_onWatchCached);
    on<UpdateCachedBookReservationsEvent>(_onUpdateCached);
    on<ResetBookReservationsState>(_onReset);
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }

  Future<void> _onGet(
    GetBookReservationsEvent event,
    Emitter<BookReservationsLoansState> emit,
  ) async {
    emit(BookReservationsLoading());
    final either = await getBookReservationsUseCase(
      event.status ?? 'All',
      event.localBookNumber,
    );
    either.fold(
      (failure) =>
          emit(BookReservationsError(message: mapFailureToMessage(failure))),
      (reservations) {
        emit(
          BookReservationsLoaded(
            reservations: reservations,
            isRevalidating: false,
            currentStatus: event.status,
            localBookNumber: event.localBookNumber,
          ),
        );
        add(
          WatchCachedBookReservationsEvent(
            status: event.status,
            localBookNumber: event.localBookNumber,
          ),
        );
      },
    );
  }

  Future<void> _onRefresh(
    RefreshBookReservationsEvent event,
    Emitter<BookReservationsLoansState> emit,
  ) async {
    final either = await librarianRepo.getBookReservationsWithCache(
      event.status ?? 'All',
      event.localBookNumber,
    );
    either.fold(
      (failure) =>
          emit(BookReservationsError(message: mapFailureToMessage(failure))),
      (reservations) {
        emit(
          BookReservationsLoaded(
            reservations: reservations,
            isRevalidating: false,
            currentStatus: event.status,
            localBookNumber: event.localBookNumber,
          ),
        );
      },
    );
  }

  Future<void> _onReset(
    ResetBookReservationsState event,
    Emitter<BookReservationsLoansState> emit,
  ) {
    emit(BookReservationsInitial());
    return Future.value();
  }

  Future<void> _onRevalidate(
    RevalidateBookReservationsEvent event,
    Emitter<BookReservationsLoansState> emit,
  ) async {
    if (state is BookReservationsLoaded) {
      final currentState = state as BookReservationsLoaded;
      emit(currentState.copyWith(isRevalidating: true));
    }

    final networkEither = await librarianRepo.getBookReservations(
      event.status ?? 'All',
      event.localBookNumber,
    );
    networkEither.fold(
      (failure) {
        if (state is BookReservationsLoaded) {
          final currentState = state as BookReservationsLoaded;
          emit(
            currentState.copyWith(
              isRevalidating: false,
              errorMessage: mapFailureToMessage(failure),
            ),
          );
        }
      },
      (reservations) {
        if (state is BookReservationsLoaded) {
          final currentState = state as BookReservationsLoaded;
          emit(
            currentState.copyWith(isRevalidating: false, errorMessage: null),
          );
        }
      },
    );
  }

  Future<void> _onUpdateCached(
    UpdateCachedBookReservationsEvent event,
    Emitter<BookReservationsLoansState> emit,
  ) async {
    if (state is BookReservationsLoaded) {
      final currentState = state as BookReservationsLoaded;
      emit(currentState.copyWith(reservations: event.reservations));
    } else {
      emit(
        BookReservationsLoaded(
          reservations: event.reservations,
          isRevalidating: false,
          currentStatus: null,
          localBookNumber: null,
        ),
      );
    }
  }

  Future<void> _onWatchCached(
    WatchCachedBookReservationsEvent event,
    Emitter<BookReservationsLoansState> emit,
  ) async {
    await _subscription?.cancel();
    _cachedStream = librarianRepo.watchCachedgetBookReservations(
      event.status ?? 'All',
      event.localBookNumber,
    );
    _subscription = _cachedStream?.listen((reservations) {
      if (state is BookReservationsLoaded) {
        add(UpdateCachedBookReservationsEvent(reservations: reservations));
      }
    });
  }
}
