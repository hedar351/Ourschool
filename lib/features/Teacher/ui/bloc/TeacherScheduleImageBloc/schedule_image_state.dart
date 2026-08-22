// lib/features/Teacher/UI/Bloc/ScheduleImageBloc/schedule_image_state.dart

part of 'schedule_image_bloc.dart';

// ============================================================
// ====== ERROR STATE ======
// ============================================================

class ScheduleImageError extends ScheduleImageState {
  final String message;

  const ScheduleImageError({required this.message});

  @override
  List<Object> get props => [message];
}

// ============================================================
// ====== INITIAL STATE ======
// ============================================================

class ScheduleImageInitial extends ScheduleImageState {}

// ============================================================
// ====== LOADED STATE ======
// ============================================================

class ScheduleImageLoaded extends ScheduleImageState {
  final Getscheduleimageentity scheduleImage;
  final bool isRefreshing;
  final String? errorMessage;

  const ScheduleImageLoaded({
    required this.scheduleImage,
    this.isRefreshing = false,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [scheduleImage, isRefreshing, errorMessage];

  ScheduleImageLoaded copyWith({
    Getscheduleimageentity? scheduleImage,
    bool? isRefreshing,
    String? errorMessage,
  }) {
    return ScheduleImageLoaded(
      scheduleImage: scheduleImage ?? this.scheduleImage,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

// ============================================================
// ====== LOADING STATE ======
// ============================================================

class ScheduleImageLoading extends ScheduleImageState {}

// ============================================================
// ====== BASE STATE ======
// ============================================================

sealed class ScheduleImageState extends Equatable {
  const ScheduleImageState();

  @override
  List<Object?> get props => [];
}
