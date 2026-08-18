part of 'schedule_images_bloc.dart';

class GetScheduleImageEvent extends ScheduleImagesEvent {
  final int localGradeNumber;
  final int localSectionNumber;

  const GetScheduleImageEvent({
    required this.localGradeNumber,
    required this.localSectionNumber,
  });

  @override
  List<Object?> get props => [localGradeNumber, localSectionNumber];
}

sealed class ScheduleImagesEvent extends Equatable {
  const ScheduleImagesEvent();

  @override
  List<Object?> get props => [];
}
