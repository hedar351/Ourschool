
part of 'activities_registrations_bloc.dart';

// ============================================================
// ====== BASE EVENT ======
// ============================================================

sealed class ActivitiesRegistrationsEvent extends Equatable {
  const ActivitiesRegistrationsEvent();
  @override
  List<Object?> get props => [];
}

// ============================================================
// ====== GET REGISTRATIONS ======
// ============================================================

class GetActivitiesRegistrationsEvent extends ActivitiesRegistrationsEvent {
  final int activityId;
  const GetActivitiesRegistrationsEvent({required this.activityId});
  @override
  List<Object> get props => [activityId];
}

// ============================================================
// ====== REFRESH REGISTRATIONS ======
// ============================================================

class RefreshActivitiesRegistrationsEvent extends ActivitiesRegistrationsEvent {
  final int activityId;
  const RefreshActivitiesRegistrationsEvent({required this.activityId});
  @override
  List<Object> get props => [activityId];
}

// ============================================================
// ====== RESET ======
// ============================================================

class ResetActivitiesRegistrationsState extends ActivitiesRegistrationsEvent {}

// ============================================================
// ====== REVALIDATE REGISTRATIONS ======
// ============================================================

class RevalidateActivitiesRegistrationsEvent
    extends ActivitiesRegistrationsEvent {
  final int activityId;
  const RevalidateActivitiesRegistrationsEvent({required this.activityId});
  @override
  List<Object> get props => [activityId];
}

// ============================================================
// ====== UPDATE CACHED ======
// ============================================================

class UpdateCachedActivitiesRegistrationsEvent
    extends ActivitiesRegistrationsEvent {
  final ActivitiesRegistrationsEntity registrations;
  const UpdateCachedActivitiesRegistrationsEvent({required this.registrations});
  @override
  List<Object> get props => [registrations];
}

// ============================================================
// ====== WATCH CACHED ======
// ============================================================

class WatchCachedActivitiesRegistrationsEvent
    extends ActivitiesRegistrationsEvent {
  final int activityId;
  const WatchCachedActivitiesRegistrationsEvent({required this.activityId});
  @override
  List<Object> get props => [activityId];
}
