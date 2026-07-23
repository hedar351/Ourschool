import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school/core/const.dart';
import 'package:school/features/Counselor/domain/Entities/scheduleImageEntity/GetscheduleImageEntity.dart';
// import 'package:school/features/Counselor/domain/UseCases/DeleteScheduleImageUseCase.dart';
import 'package:school/features/Counselor/domain/UseCases/GetScheduleImageUseCase.dart';

// import 'package:school/features/Counselor/domain/UseCases/postscheduleImageUseCase.dart';

part 'schedule_images_event.dart';
part 'schedule_images_state.dart';

class ScheduleImagesBloc
    extends Bloc<ScheduleImagesEvent, ScheduleImagesState> {
  final Getscheduleimageusecase getScheduleImageUseCase;
  // final Postscheduleimageusecase uploadScheduleImageUseCase;
  // final Deletescheduleimageusecase deleteScheduleImageUseCase;

  ScheduleImagesBloc({
    required this.getScheduleImageUseCase,
    // required this.uploadScheduleImageUseCase,
    // required this.deleteScheduleImageUseCase,
  }) : super(ScheduleImagesInitial()) {
    on<GetScheduleImageEvent>(_onGet);
    // on<UploadScheduleImageEvent>(_onUpload);
    // on<DeleteScheduleImageEvent>(_onDelete);
  }

  // FutureOr<void> _onDelete(
  //   DeleteScheduleImageEvent event,
  //   Emitter<ScheduleImagesState> emit,
  // ) async {
  //   emit(ScheduleImagesLoading());
  //   final result = await deleteScheduleImageUseCase(
  //     event.localGradeNumber,
  //     event.localSectionNumber,
  //   );
  //   result.fold(
  //     (failure) =>
  //         emit(ScheduleImagesError(message: mapFailureToMessage(failure))),
  //     (entity) => emit(ScheduleImagesDeleted(message: 'تم حذف الصورة بنجاح')),
  //   );
  // }

  FutureOr<void> _onGet(
    GetScheduleImageEvent event,
    Emitter<ScheduleImagesState> emit,
  ) async {
    emit(ScheduleImagesLoading());
    final result = await getScheduleImageUseCase(
      event.localGradeNumber,
      event.localSectionNumber,
    );
    result.fold(
      (failure) =>
          emit(ScheduleImagesError(message: mapFailureToMessage(failure))),
      (image) => emit(ScheduleImagesLoaded(scheduleImage: image)),
    );
  }

  // FutureOr<void> _onUpload(
  //   UploadScheduleImageEvent event,
  //   Emitter<ScheduleImagesState> emit,
  // ) async {
  //   emit(ScheduleImagesLoading());
  //   final result = await uploadScheduleImageUseCase(
  //     event.localGradeNumber,
  //     event.localSectionNumber,
  //     event.imagePath,
  //   );
  //   result.fold(
  //     (failure) =>
  //         emit(ScheduleImagesError(message: mapFailureToMessage(failure))),
  //     (entity) => emit(
  //       ScheduleImagesUploaded(
  //         message: entity.message ?? 'تم رفع الصورة بنجاح',
  //       ),
  //     ),
  //   );
  // }
}
