// lib/features/Student/ui/bloc/ActivityRegistrationBloc/activity_registration_state.dart

part of 'activity_registration_bloc.dart';

class ActivityRegistrationError extends ActivityRegistrationState {
  final String message;

  const ActivityRegistrationError({required this.message});

  @override
  List<Object> get props => [message];
}

// ============================================================
// ====== STATES ======
// ============================================================

class ActivityRegistrationInitial extends ActivityRegistrationState {}

class ActivityRegistrationLoading extends ActivityRegistrationState {}

// ============================================================
// ====== BASE STATE ======
// ============================================================

sealed class ActivityRegistrationState extends Equatable {
  const ActivityRegistrationState();
  @override
  List<Object?> get props => [];
}

class ActivityRegistrationSuccess extends ActivityRegistrationState {
  final String message;

  const ActivityRegistrationSuccess({required this.message});

  @override
  List<Object> get props => [message];
}
