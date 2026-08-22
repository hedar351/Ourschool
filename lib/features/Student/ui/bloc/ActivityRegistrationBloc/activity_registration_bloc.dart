// lib/features/Student/ui/bloc/ActivityRegistrationBloc/activity_registration_bloc.dart

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school/core/const.dart';
import 'package:school/features/Student/domain/Repo/StudentRepo.dart';
import 'package:school/features/Student/domain/useCase/delete_register_use_case.dart';
import 'package:school/features/Student/domain/useCase/register_use_case.dart';

part 'activity_registration_event.dart';
part 'activity_registration_state.dart';

class ActivityRegistrationBloc
    extends Bloc<ActivityRegistrationEvent, ActivityRegistrationState> {
  final RegisterUseCase registerUseCase;
  final DeleteRegisterUseCase deleteRegisterUseCase;
  final StudentRepo studentRepo;

  ActivityRegistrationBloc({
    required this.registerUseCase,
    required this.deleteRegisterUseCase,
    required this.studentRepo,
  }) : super(ActivityRegistrationInitial()) {
    on<RegisterActivityEvent>(_onRegister);
    on<DeleteRegisterActivityEvent>(_onDeleteRegister);
    on<ResetActivityRegistrationState>(_onReset);
  }

  // ============================================================
  // ====== DELETE REGISTER ======
  // ============================================================

  Future<void> _onDeleteRegister(
    DeleteRegisterActivityEvent event,
    Emitter<ActivityRegistrationState> emit,
  ) async {
    emit(ActivityRegistrationLoading());
    print("ActivityRegistrationLoading========================");
    final result = await deleteRegisterUseCase(event.activityId);
    result.fold(
      (failure) => emit(
        ActivityRegistrationError(message: mapFailureToMessage(failure)),
      ),
      (_) => emit(
        const ActivityRegistrationSuccess(message: 'تم إلغاء التسجيل بنجاح'),
      ),
    );
  }

  // ============================================================
  // ====== REGISTER ======
  // ============================================================

  Future<void> _onRegister(
    RegisterActivityEvent event,
    Emitter<ActivityRegistrationState> emit,
  ) async {
    emit(ActivityRegistrationLoading());
    final result = await registerUseCase(event.activityId);
    result.fold(
      (failure) => emit(
        ActivityRegistrationError(message: mapFailureToMessage(failure)),
      ),
      (_) => emit(
        const ActivityRegistrationSuccess(
          message: 'تم التسجيل في النشاط بنجاح',
        ),
      ),
    );
  }

  // ============================================================
  // ====== RESET ======
  // ============================================================

  Future<void> _onReset(
    ResetActivityRegistrationState event,
    Emitter<ActivityRegistrationState> emit,
  ) {
    emit(ActivityRegistrationInitial());
    return Future.value();
  }
}
