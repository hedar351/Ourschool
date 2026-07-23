part of 'schedule_images_bloc.dart';

// class DeleteScheduleImageEvent extends ScheduleImagesEvent {
//   final int localGradeNumber;
//   final int localSectionNumber;

//   const DeleteScheduleImageEvent({
//     required this.localGradeNumber,
//     required this.localSectionNumber,
//   });

//   @override
//   List<Object?> get props => [localGradeNumber, localSectionNumber];
// }

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

// class UploadScheduleImageEvent extends ScheduleImagesEvent {
//   final int localGradeNumber;
//   final int localSectionNumber;
//   final String imagePath;

//   const UploadScheduleImageEvent({
//     required this.localGradeNumber,
//     required this.localSectionNumber,
//     required this.imagePath,
//   });

//   @override
//   List<Object?> get props => [localGradeNumber, localSectionNumber, imagePath];
// }
