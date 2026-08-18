
part of 'activities_bloc.dart';

class ActivitiesError extends ActivitiesState {
  final String message;

  const ActivitiesError({required this.message});

  @override
  List<Object> get props => [message];
}

// ============================================================
// ====== STATES ======
// ============================================================

class ActivitiesInitial extends ActivitiesState {}

class ActivitiesLoading extends ActivitiesState {}

// ============================================================
// ====== BASE STATE ======
// ============================================================

sealed class ActivitiesState extends Equatable {
  const ActivitiesState();
  @override
  List<Object?> get props => [];
}

class ActivitiesSuccess extends ActivitiesState {
  final String message;

  const ActivitiesSuccess({required this.message});

  @override
  List<Object> get props => [message];
}
