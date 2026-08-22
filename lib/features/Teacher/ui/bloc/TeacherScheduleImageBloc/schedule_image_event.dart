// lib/features/Teacher/UI/Bloc/ScheduleImageBloc/schedule_image_event.dart

part of 'schedule_image_bloc.dart';

// ============================================================
// ====== GET SCHEDULE IMAGE ======
// ============================================================

class GetTeacherScheduleImageEvent extends ScheduleImageEvent {
  final int schoolId;

  const GetTeacherScheduleImageEvent({required this.schoolId});

  @override
  List<Object> get props => [schoolId];
}

// ============================================================
// ====== REFRESH SCHEDULE IMAGE ======
// ============================================================

class RefreshScheduleImageEvent extends ScheduleImageEvent {
  final int schoolId;

  const RefreshScheduleImageEvent({required this.schoolId});

  @override
  List<Object> get props => [schoolId];
}

// ============================================================
// ====== RESET ======
// ============================================================

class ResetScheduleImageState extends ScheduleImageEvent {}

// ============================================================
// ====== BASE EVENT ======
// ============================================================

sealed class ScheduleImageEvent extends Equatable {
  const ScheduleImageEvent();

  @override
  List<Object?> get props => [];
}
