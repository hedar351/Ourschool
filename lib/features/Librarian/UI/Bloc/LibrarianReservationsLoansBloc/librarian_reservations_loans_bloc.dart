// lib/features/Librarian/UI/Bloc/LibrarianReservationsLoansBloc/librarian_reservations_loans_bloc.dart

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school/core/const.dart';
import 'package:school/features/Librarian/domain/Entity/general_entity/librarian_loans_Entity.dart';
import 'package:school/features/Librarian/domain/Entity/general_entity/librarian_reservations_Entity.dart';
import 'package:school/features/Librarian/domain/Repo/Librarian_Repo.dart';
import 'package:school/features/Librarian/domain/UseCase/GetLibrarianLoansUsecase.dart';
import 'package:school/features/Librarian/domain/UseCase/getLibrarianReservationsUseCase.dart';

part 'librarian_reservations_loans_event.dart';
part 'librarian_reservations_loans_state.dart';

class LibrarianReservationsLoansBloc
    extends
        Bloc<LibrarianReservationsLoansEvent, LibrarianReservationsLoansState> {
  final GetLibrarianReservationsUseCase getLibrarianReservationsUseCase;
  final GetLibrarianLoansUsecase getLibrarianLoansUsecase;
  final LibrarianRepo librarianRepo;

  Stream<LibrarianReservationsEntity>? _cachedReservationsStream;
  StreamSubscription? _reservationsSubscription;

  //  جاري الإعارات (للتحضير للمستقبل)
  Stream<LibrarianLoansEntity>? _cachedLoansStream;
  StreamSubscription? _loansSubscription;

  LibrarianReservationsLoansBloc({
    required this.getLibrarianReservationsUseCase,
    required this.librarianRepo,
    required this.getLibrarianLoansUsecase,
  }) : super(ReservationsInitial()) {
    // ---- أحداث الحجوزات ----
    on<GetReservationsEvent>(_onGetReservations);
    on<RefreshReservationsEvent>(_onRefreshReservations);
    on<RevalidateReservationsEvent>(_onRevalidateReservations);
    on<WatchCachedReservationsEvent>(_onWatchCachedReservations);
    on<UpdateCachedReservationsEvent>(_onUpdateCachedReservations);

    // ---- أحداث الإعارات ----
    on<GetLoansEvent>(_onGetLoans);
    on<RefreshLoansEvent>(_onRefreshLoans);
    on<RevalidateLoansEvent>(_onRevalidateLoans);
    on<WatchCachedLoansEvent>(_onWatchCachedLoans);
    on<UpdateCachedLoansEvent>(_onUpdateCachedLoans);

    // ---- حدث إعادة التعيين ----
    on<ResetLibrarianReservationsLoansState>(_onReset);
  }
  @override
  Future<void> close() {
    _reservationsSubscription?.cancel();
    _loansSubscription?.cancel();
    return super.close();
  }

  // ============================================================
  // ====== LOANS (جديد) ======
  // ============================================================

  Future<void> _onGetLoans(
    GetLoansEvent event,
    Emitter<LibrarianReservationsLoansState> emit,
  ) async {
    emit(LoansLoading());
    final either = await getLibrarianLoansUsecase();
    either.fold(
      (failure) => emit(LoansError(message: mapFailureToMessage(failure))),
      (loans) {
        emit(
          LoansLoaded(
            loans: loans,
            isRevalidating: false,
            currentStatus: event.status,
          ),
        );
        add(WatchCachedLoansEvent(status: event.status));
      },
    );
  }

  // ============================================================
  // ====== RESERVATIONS ======
  // ============================================================

  Future<void> _onGetReservations(
    GetReservationsEvent event,
    Emitter<LibrarianReservationsLoansState> emit,
  ) async {
    emit(ReservationsLoading());

    final either = await getLibrarianReservationsUseCase(
      event.status ?? 'Pending',
    );
    either.fold(
      (failure) =>
          emit(ReservationsError(message: mapFailureToMessage(failure))),
      (reservations) {
        emit(
          ReservationsLoaded(
            reservations: reservations,
            isRevalidating: false,
            currentStatus: event.status,
          ),
        );
        add(WatchCachedReservationsEvent(status: event.status));
      },
    );
  }

  Future<void> _onRefreshLoans(
    RefreshLoansEvent event,
    Emitter<LibrarianReservationsLoansState> emit,
  ) async {
    final either = await librarianRepo.getLibrarianLeonsWithCache();
    either.fold(
      (failure) => emit(LoansError(message: mapFailureToMessage(failure))),
      (loans) {
        emit(
          LoansLoaded(
            loans: loans,
            isRevalidating: false,
            currentStatus: event.status,
          ),
        );
      },
    );
  }

  Future<void> _onRefreshReservations(
    RefreshReservationsEvent event,
    Emitter<LibrarianReservationsLoansState> emit,
  ) async {
    final either = await librarianRepo.getgetLibrarianReservationsWithCache(
      event.status ?? 'Pending',
    );
    either.fold(
      (failure) =>
          emit(ReservationsError(message: mapFailureToMessage(failure))),
      (reservations) {
        emit(
          ReservationsLoaded(
            reservations: reservations,
            isRevalidating: false,
            currentStatus: event.status,
          ),
        );
      },
    );
  }

  // ============================================================
  // ====== RESET ======
  // ============================================================

  Future<void> _onReset(
    ResetLibrarianReservationsLoansState event,
    Emitter<LibrarianReservationsLoansState> emit,
  ) {
    emit(ReservationsInitial());
    return Future.value();
  }

  Future<void> _onRevalidateLoans(
    RevalidateLoansEvent event,
    Emitter<LibrarianReservationsLoansState> emit,
  ) async {
    if (state is LoansLoaded) {
      final currentState = state as LoansLoaded;
      emit(currentState.copyWith(isRevalidating: true));
    }

    final networkEither = await librarianRepo.getLibrarianLeons();
    networkEither.fold(
      (failure) {
        if (state is LoansLoaded) {
          final currentState = state as LoansLoaded;
          emit(
            currentState.copyWith(
              isRevalidating: false,
              errorMessage: mapFailureToMessage(failure),
            ),
          );
        }
      },
      (loans) {
        if (state is LoansLoaded) {
          final currentState = state as LoansLoaded;
          emit(
            currentState.copyWith(isRevalidating: false, errorMessage: null),
          );
        }
      },
    );
  }

  Future<void> _onRevalidateReservations(
    RevalidateReservationsEvent event,
    Emitter<LibrarianReservationsLoansState> emit,
  ) async {
    if (state is ReservationsLoaded) {
      final currentState = state as ReservationsLoaded;
      emit(currentState.copyWith(isRevalidating: true));
    }

    final networkEither = await librarianRepo.getLibrarianReservations(
      event.status ?? 'Pending',
    );
    networkEither.fold(
      (failure) {
        if (state is ReservationsLoaded) {
          final currentState = state as ReservationsLoaded;
          emit(
            currentState.copyWith(
              isRevalidating: false,
              errorMessage: mapFailureToMessage(failure),
            ),
          );
        }
      },
      (reservations) {
        if (state is ReservationsLoaded) {
          final currentState = state as ReservationsLoaded;
          emit(
            currentState.copyWith(isRevalidating: false, errorMessage: null),
          );
        }
      },
    );
  }

  Future<void> _onUpdateCachedLoans(
    UpdateCachedLoansEvent event,
    Emitter<LibrarianReservationsLoansState> emit,
  ) async {
    if (state is LoansLoaded) {
      final currentState = state as LoansLoaded;
      emit(currentState.copyWith(loans: event.loans));
    } else {
      emit(LoansLoaded(loans: event.loans, isRevalidating: false));
    }
  }

  Future<void> _onUpdateCachedReservations(
    UpdateCachedReservationsEvent event,
    Emitter<LibrarianReservationsLoansState> emit,
  ) async {
    if (state is ReservationsLoaded) {
      final currentState = state as ReservationsLoaded;
      emit(currentState.copyWith(reservations: event.reservations));
    } else {
      emit(
        ReservationsLoaded(
          reservations: event.reservations,
          isRevalidating: false,
        ),
      );
    }
  }

  Future<void> _onWatchCachedLoans(
    WatchCachedLoansEvent event,
    Emitter<LibrarianReservationsLoansState> emit,
  ) async {
    await _loansSubscription?.cancel();
    _cachedLoansStream = librarianRepo.watchCachedgetLibrarianLeons();
    _loansSubscription = _cachedLoansStream?.listen((loans) {
      if (state is LoansLoaded) {
        add(UpdateCachedLoansEvent(loans: loans));
      }
    });
  }

  Future<void> _onWatchCachedReservations(
    WatchCachedReservationsEvent event,
    Emitter<LibrarianReservationsLoansState> emit,
  ) async {
    await _reservationsSubscription?.cancel();
    _cachedReservationsStream = librarianRepo
        .watchCachedgetLibrarianReservations(event.status ?? 'Pending');
    _reservationsSubscription = _cachedReservationsStream?.listen((
      reservations,
    ) {
      if (state is ReservationsLoaded) {
        add(UpdateCachedReservationsEvent(reservations: reservations));
      }
    });
  }
}
