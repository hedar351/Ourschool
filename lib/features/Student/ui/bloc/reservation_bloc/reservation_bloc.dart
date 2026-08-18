import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school/core/const.dart';
import 'package:school/features/Student/domain/Repo/library_repo.dart';
import 'package:school/features/Student/domain/entity/Library/reservations.dart';
import 'package:school/features/Student/domain/useCase/GetReserveBookUseCase.dart';
import 'package:school/features/Student/ui/bloc/reservation_bloc/reservation_event.dart';
import 'package:school/features/Student/ui/bloc/reservation_bloc/reservation_state.dart';

class ReservationsBloc extends Bloc<ReservationEvent, ReservationsState> {
  final Getreservebookusecase getReserveBookUseCase;
  final LibraryRepo libraryRepo;

  Stream<Reservations>? _cachedStream;
  StreamSubscription? _subscription;

  ReservationsBloc({
    required this.getReserveBookUseCase,
    required this.libraryRepo,
  }) : super(ReservationsInitial()) {
    on<GetReservationsEvent>(_onGetReservations);
    on<RefreshReservationsEvent>(_onRefreshReservations);
    on<RevalidateReservationsEvent>(_onRevalidateReservations);
    on<WatchCachedReservationsEvent>(_onWatchCachedReservations);
    on<UpdateCachedReservationsEvent>(_onUpdateCachedReservations);
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }

  Future<void> _onGetReservations(
    GetReservationsEvent event,
    Emitter<ReservationsState> emit,
  ) async {
    emit(ReservationsLoading());
    final either = await getReserveBookUseCase();
    either.fold(
      (failure) =>
          emit(ReservationsError(message: mapFailureToMessage(failure))),
      (reservations) {
        emit(
          ReservationsLoaded(reservations: reservations, isRevalidating: false),
        );
        add(WatchCachedReservationsEvent());
      },
    );
  }

  // ---- Refresh (Pull to Refresh) ----
  Future<void> _onRefreshReservations(
    RefreshReservationsEvent event,
    Emitter<ReservationsState> emit,
  ) async {
    final either = await libraryRepo.getReserveBookWithCache();
    either.fold(
      (failure) =>
          emit(ReservationsError(message: mapFailureToMessage(failure))),
      (reservations) {
        emit(
          ReservationsLoaded(reservations: reservations, isRevalidating: false),
        );
      },
    );
  }

  // ---- Revalidate (Background Update) ----
  Future<void> _onRevalidateReservations(
    RevalidateReservationsEvent event,
    Emitter<ReservationsState> emit,
  ) async {
    if (state is ReservationsLoaded) {
      final currentState = state as ReservationsLoaded;
      emit(currentState.copyWith(isRevalidating: true));
    }

    final networkEither = await libraryRepo.getReserveBook();
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

  // ---- Update Cached (Background Update) ----
  Future<void> _onUpdateCachedReservations(
    UpdateCachedReservationsEvent event,
    Emitter<ReservationsState> emit,
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

  // ---- Watch Cached (Stream) ----
  Future<void> _onWatchCachedReservations(
    WatchCachedReservationsEvent event,
    Emitter<ReservationsState> emit,
  ) async {
    await _subscription?.cancel();
    _cachedStream = libraryRepo.watchCachedReserveBook();
    _subscription = _cachedStream?.listen((reservations) {
      if (state is ReservationsLoaded) {
        add(UpdateCachedReservationsEvent(reservations: reservations));
      }
    });
  }
}
