import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school/core/const.dart';
import 'package:school/features/Counselor/domain/Entities/scheduleImageEntity/GetscheduleImageEntity.dart';
import 'package:school/features/Counselor/domain/UseCases/GetScheduleImageUseCase.dart';

part 'schedule_images_event.dart';
part 'schedule_images_state.dart';

class ScheduleImagesBloc
    extends Bloc<ScheduleImagesEvent, ScheduleImagesState> {
  final Getscheduleimageusecase getScheduleImageUseCase;

  ScheduleImagesBloc({required this.getScheduleImageUseCase})
    : super(ScheduleImagesInitial()) {
    on<GetScheduleImageEvent>(_onGet);
  }

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
}
