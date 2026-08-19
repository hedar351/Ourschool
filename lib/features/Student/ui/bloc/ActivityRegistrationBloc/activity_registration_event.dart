// lib/features/Student/ui/bloc/ActivityRegistrationBloc/activity_registration_event.dart

part of 'activity_registration_bloc.dart';

// ============================================================
// ====== BASE EVENT ======
// ============================================================

sealed class ActivityRegistrationEvent extends Equatable {
  const ActivityRegistrationEvent();
  @override
  List<Object?> get props => [];
}

// ============================================================
// ====== DELETE REGISTER ======
// ============================================================

class DeleteRegisterActivityEvent extends ActivityRegistrationEvent {
  final int activityId;

  const DeleteRegisterActivityEvent({required this.activityId});

  @override
  List<Object> get props => [activityId];
}

// ============================================================
// ====== REGISTER ======
// ============================================================

class RegisterActivityEvent extends ActivityRegistrationEvent {
  final int activityId;

  const RegisterActivityEvent({required this.activityId});

  @override
  List<Object> get props => [activityId];
}

// ============================================================
// ====== RESET ======
// ============================================================

class ResetActivityRegistrationState extends ActivityRegistrationEvent {}
