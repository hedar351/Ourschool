
import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school/core/const.dart';
import 'package:school/features/Activities/domain/repo/activites_repo.dart';
import 'package:school/features/Activities/domain/useCase/add_activity_use_case.dart'
    show AddActivityUseCase;
import 'package:school/features/Activities/domain/useCase/delete_activity_use_case.dart';
import 'package:school/features/Activities/domain/useCase/edit_activity_use_case.dart';

part 'activities_event.dart';
part 'activities_state.dart';

class ActivitiesBloc extends Bloc<ActivitiesEvent, ActivitiesState> {
  final AddActivityUseCase addActivityUseCase;
  final EditActivityUseCase editActivityUseCase;
  final DeleteActivityUseCase deleteActivityUseCase;
  final ActivitesRepo activitiesRepo;

  StreamSubscription? _subscription;

  ActivitiesBloc({
    // required this.getActivitiesUseCase,
    required this.addActivityUseCase,
    required this.editActivityUseCase,
    required this.deleteActivityUseCase,
    required this.activitiesRepo,
  }) : super(ActivitiesInitial()) {
    on<AddActivityEvent>(_onAddActivity);
    on<EditActivityEvent>(_onEditActivity);
    on<DeleteActivityEvent>(_onDeleteActivity);

    on<ResetActivitiesState>(_onReset);
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }

  // ============================================================
  // ====== ADD ACTIVITY ======
  // ============================================================

  Future<void> _onAddActivity(
    AddActivityEvent event,
    Emitter<ActivitiesState> emit,
  ) async {
    emit(ActivitiesLoading());
    final result = await addActivityUseCase(
      event.title,
      event.description,
      event.expiryDate,
    );
    result.fold(
      (failure) => emit(ActivitiesError(message: mapFailureToMessage(failure))),
      (_) {
        emit(ActivitiesSuccess(message: 'تم إضافة النشاط بنجاح'));
        // add(RefreshActivitiesEvent());
      },
    );
  }

  // ============================================================
  // ====== DELETE ACTIVITY ======
  // ============================================================

  Future<void> _onDeleteActivity(
    DeleteActivityEvent event,
    Emitter<ActivitiesState> emit,
  ) async {
    emit(ActivitiesLoading());
    final result = await deleteActivityUseCase(event.localActivityId);
    result.fold(
      (failure) => emit(ActivitiesError(message: mapFailureToMessage(failure))),
      (_) {
        emit(ActivitiesSuccess(message: 'تم حذف النشاط بنجاح'));
        // add(RefreshActivitiesEvent());
      },
    );
  }

  // ============================================================
  // ====== EDIT ACTIVITY ======
  // ============================================================

  Future<void> _onEditActivity(
    EditActivityEvent event,
    Emitter<ActivitiesState> emit,
  ) async {
    emit(ActivitiesLoading());
    final result = await editActivityUseCase(
      event.localActivityId,
      event.title,
      event.description,
      event.expiryDate,
    );
    result.fold(
      (failure) => emit(ActivitiesError(message: mapFailureToMessage(failure))),
      (_) {
        emit(ActivitiesSuccess(message: 'تم تعديل النشاط بنجاح'));
        // add(RefreshActivitiesEvent());
      },
    );
  }

  Future<void> _onReset(
    ResetActivitiesState event,
    Emitter<ActivitiesState> emit,
  ) {
    emit(ActivitiesInitial());
    return Future.value();
  }
}
