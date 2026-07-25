part of 'schedule_images_bloc.dart';

final class ScheduleImagesError extends ScheduleImagesState {
  final String message;

  const ScheduleImagesError({required this.message});

  @override
  List<Object?> get props => [message];
}

final class ScheduleImagesInitial extends ScheduleImagesState {}

final class ScheduleImagesLoaded extends ScheduleImagesState {
  final Getscheduleimageentity scheduleImage;

  const ScheduleImagesLoaded({required this.scheduleImage});

  @override
  List<Object?> get props => [scheduleImage];
}

final class ScheduleImagesLoading extends ScheduleImagesState {}

sealed class ScheduleImagesState extends Equatable {
  const ScheduleImagesState();

  @override
  List<Object?> get props => [];
}
