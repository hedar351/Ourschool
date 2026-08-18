
part of 'activities_registrations_bloc.dart';

class ActivitiesRegistrationsError extends ActivitiesRegistrationsState {
  final String message;
  const ActivitiesRegistrationsError({required this.message});
  @override
  List<Object> get props => [message];
}

// ============================================================
// ====== STATES ======
// ============================================================

class ActivitiesRegistrationsInitial extends ActivitiesRegistrationsState {}

class ActivitiesRegistrationsLoaded extends ActivitiesRegistrationsState {
  final ActivitiesRegistrationsEntity registrations;
  final bool isRevalidating;
  final String? errorMessage;
  final int? activityId;

  const ActivitiesRegistrationsLoaded({
    required this.registrations,
    this.isRevalidating = false,
    this.errorMessage,
    this.activityId,
  });

  @override
  List<Object?> get props => [
    registrations,
    isRevalidating,
    errorMessage,
    activityId,
  ];

  ActivitiesRegistrationsLoaded copyWith({
    ActivitiesRegistrationsEntity? registrations,
    bool? isRevalidating,
    String? errorMessage,
    int? activityId,
  }) {
    return ActivitiesRegistrationsLoaded(
      registrations: registrations ?? this.registrations,
      isRevalidating: isRevalidating ?? this.isRevalidating,
      errorMessage: errorMessage ?? this.errorMessage,
      activityId: activityId ?? this.activityId,
    );
  }
}

class ActivitiesRegistrationsLoading extends ActivitiesRegistrationsState {}

// ============================================================
// ====== BASE STATE ======
// ============================================================

sealed class ActivitiesRegistrationsState extends Equatable {
  const ActivitiesRegistrationsState();
  @override
  List<Object?> get props => [];
}
