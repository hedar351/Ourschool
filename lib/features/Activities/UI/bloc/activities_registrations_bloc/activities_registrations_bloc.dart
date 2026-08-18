
import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school/core/const.dart';
import 'package:school/features/Activities/domain/entity/activities_registrations_entity.dart';
import 'package:school/features/Activities/domain/repo/activites_repo.dart';
import 'package:school/features/Activities/domain/useCase/activities_registrations_use_case.dart';

part 'activities_registrations_event.dart';
part 'activities_registrations_state.dart';

class ActivitiesRegistrationsBloc
    extends Bloc<ActivitiesRegistrationsEvent, ActivitiesRegistrationsState> {
  final ActivitiesRegistrationsUseCase getRegistrationsUseCase;
  final ActivitesRepo activitiesRepo;

  Stream<ActivitiesRegistrationsEntity>? _cachedStream;
  StreamSubscription? _subscription;

  ActivitiesRegistrationsBloc({
    required this.getRegistrationsUseCase,
    required this.activitiesRepo,
  }) : super(ActivitiesRegistrationsInitial()) {
    on<GetActivitiesRegistrationsEvent>(_onGet);
    on<RefreshActivitiesRegistrationsEvent>(_onRefresh);
    on<RevalidateActivitiesRegistrationsEvent>(_onRevalidate);
    on<WatchCachedActivitiesRegistrationsEvent>(_onWatchCached);
    on<UpdateCachedActivitiesRegistrationsEvent>(_onUpdateCached);
    on<ResetActivitiesRegistrationsState>(_onReset);
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }

  // ============================================================
  // ====== GET REGISTRATIONS ======
  // ============================================================

  Future<void> _onGet(
    GetActivitiesRegistrationsEvent event,
    Emitter<ActivitiesRegistrationsState> emit,
  ) async {
    emit(ActivitiesRegistrationsLoading());
    final either = await getRegistrationsUseCase(event.activityId);
    either.fold(
      (failure) => emit(
        ActivitiesRegistrationsError(message: mapFailureToMessage(failure)),
      ),
      (registrations) {
        emit(
          ActivitiesRegistrationsLoaded(
            registrations: registrations,
            isRevalidating: false,
            activityId: event.activityId,
          ),
        );
        add(
          WatchCachedActivitiesRegistrationsEvent(activityId: event.activityId),
        );
      },
    );
  }

  // ============================================================
  // ====== REFRESH REGISTRATIONS ======
  // ============================================================

  Future<void> _onRefresh(
    RefreshActivitiesRegistrationsEvent event,
    Emitter<ActivitiesRegistrationsState> emit,
  ) async {
    final either = await activitiesRepo.getActivitieRegistrationWithCache(
      event.activityId,
    );
    either.fold(
      (failure) => emit(
        ActivitiesRegistrationsError(message: mapFailureToMessage(failure)),
      ),
      (registrations) {
        emit(
          ActivitiesRegistrationsLoaded(
            registrations: registrations,
            isRevalidating: false,
            activityId: event.activityId,
          ),
        );
      },
    );
  }

  // ============================================================
  // ====== RESET ======
  // ============================================================

  Future<void> _onReset(
    ResetActivitiesRegistrationsState event,
    Emitter<ActivitiesRegistrationsState> emit,
  ) {
    emit(ActivitiesRegistrationsInitial());
    return Future.value();
  }

  // ============================================================
  // ====== REVALIDATE ======
  // ============================================================

  Future<void> _onRevalidate(
    RevalidateActivitiesRegistrationsEvent event,
    Emitter<ActivitiesRegistrationsState> emit,
  ) async {
    if (state is ActivitiesRegistrationsLoaded) {
      final currentState = state as ActivitiesRegistrationsLoaded;
      emit(currentState.copyWith(isRevalidating: true));
    }

    final networkEither = await activitiesRepo.getActivitieRegistration(
      event.activityId,
    );
    networkEither.fold(
      (failure) {
        if (state is ActivitiesRegistrationsLoaded) {
          final currentState = state as ActivitiesRegistrationsLoaded;
          emit(
            currentState.copyWith(
              isRevalidating: false,
              errorMessage: mapFailureToMessage(failure),
            ),
          );
        }
      },
      (registrations) {
        if (state is ActivitiesRegistrationsLoaded) {
          final currentState = state as ActivitiesRegistrationsLoaded;
          emit(
            currentState.copyWith(isRevalidating: false, errorMessage: null),
          );
        }
      },
    );
  }

  // ============================================================
  // ====== UPDATE CACHED ======
  // ============================================================

  Future<void> _onUpdateCached(
    UpdateCachedActivitiesRegistrationsEvent event,
    Emitter<ActivitiesRegistrationsState> emit,
  ) async {
    if (state is ActivitiesRegistrationsLoaded) {
      final currentState = state as ActivitiesRegistrationsLoaded;
      emit(currentState.copyWith(registrations: event.registrations));
    } else {
      emit(
        ActivitiesRegistrationsLoaded(
          registrations: event.registrations,
          isRevalidating: false,
          activityId: null,
        ),
      );
    }
  }

  // ============================================================
  // ====== WATCH CACHED ======
  // ============================================================

  Future<void> _onWatchCached(
    WatchCachedActivitiesRegistrationsEvent event,
    Emitter<ActivitiesRegistrationsState> emit,
  ) async {
    await _subscription?.cancel();
    _cachedStream = activitiesRepo.watchCachedActivitieRegistration(
      event.activityId,
    );
    _subscription = _cachedStream?.listen((registrations) {
      if (state is ActivitiesRegistrationsLoaded) {
        add(
          UpdateCachedActivitiesRegistrationsEvent(
            registrations: registrations,
          ),
        );
      }
    });
  }
}
