part of 'activities_bloc.dart';

// ============================================================
// ====== BASE EVENT ======
// ============================================================

sealed class ActivitiesEvent extends Equatable {
  const ActivitiesEvent();
  @override
  List<Object?> get props => [];
}

// ============================================================
// ====== ADD ACTIVITY ======
// ============================================================

class AddActivityEvent extends ActivitiesEvent {
  final String title;
  final String description;
  final String expiryDate;

  const AddActivityEvent({
    required this.title,
    required this.description,
    required this.expiryDate,
  });

  @override
  List<Object> get props => [title, description, expiryDate];
}

class ApproveRegistrationEvent extends ActivitiesEvent {
  final int activityId;
  final int studentLocalNumber;

  const ApproveRegistrationEvent({
    required this.activityId,
    required this.studentLocalNumber,
  });

  @override
  List<Object> get props => [activityId, studentLocalNumber];
}

// ============================================================
// ====== DELETE ACTIVITY ======
// ============================================================

class DeleteActivityEvent extends ActivitiesEvent {
  final int localActivityId;

  const DeleteActivityEvent({required this.localActivityId});

  @override
  List<Object> get props => [localActivityId];
}

// ============================================================
// ====== EDIT ACTIVITY ======
// ============================================================

class EditActivityEvent extends ActivitiesEvent {
  final int localActivityId;
  final String title;
  final String description;
  final String expiryDate;

  const EditActivityEvent({
    required this.localActivityId,
    required this.title,
    required this.description,
    required this.expiryDate,
  });

  @override
  List<Object> get props => [localActivityId, title, description, expiryDate];
}

// ============================================================
// ====== REJECT REGISTRATION ======
// ============================================================

class RejectRegistrationEvent extends ActivitiesEvent {
  final int activityId;
  final int studentLocalNumber;

  const RejectRegistrationEvent({
    required this.activityId,
    required this.studentLocalNumber,
  });

  @override
  List<Object> get props => [activityId, studentLocalNumber];
}

// ============================================================
// ====== RESET ======
// ============================================================

class ResetActivitiesState extends ActivitiesEvent {}
