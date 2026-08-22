// lib/features/Teacher/UI/Bloc/ScheduleImageBloc/schedule_image_bloc.dart

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school/core/const.dart';
import 'package:school/features/Counselor/domain/Entities/scheduleImageEntity/GetscheduleImageEntity.dart';
import 'package:school/features/Teacher/domain/UseCases/get_teacher_schedule_image_use_case.dart';

part 'schedule_image_event.dart';
part 'schedule_image_state.dart';

class ScheduleImageBloc extends Bloc<ScheduleImageEvent, ScheduleImageState> {
  final GetTeacherScheduleImageUseCase getTeacherScheduleImageUseCase;

  ScheduleImageBloc({required this.getTeacherScheduleImageUseCase})
    : super(ScheduleImageInitial()) {
    on<GetTeacherScheduleImageEvent>(_onGetScheduleImage);
    on<RefreshScheduleImageEvent>(_onRefreshScheduleImage);
    on<ResetScheduleImageState>(_onReset);
  }

  // ============================================================
  // ====== GET SCHEDULE IMAGE ======
  // ============================================================

  Future<void> _onGetScheduleImage(
    GetTeacherScheduleImageEvent event,
    Emitter<ScheduleImageState> emit,
  ) async {
    emit(ScheduleImageLoading());
    print("🟡 [Bloc] جلب صورة الجدول للمدرسة ID: ${event.schoolId}");

    final result = await getTeacherScheduleImageUseCase(event.schoolId);

    result.fold(
      (failure) {
        print("🔴 [Bloc] فشل جلب صورة الجدول: ${failure.toString()}");
        emit(ScheduleImageError(message: mapFailureToMessage(failure)));
      },
      (scheduleImage) {
        print("✅ [Bloc] تم جلب صورة الجدول بنجاح");
        emit(ScheduleImageLoaded(scheduleImage: scheduleImage));
      },
    );
  }

  // ============================================================
  // ====== REFRESH SCHEDULE IMAGE ======
  // ============================================================

  Future<void> _onRefreshScheduleImage(
    RefreshScheduleImageEvent event,
    Emitter<ScheduleImageState> emit,
  ) async {
    print("🔄 [Bloc] تحديث صورة الجدول");

    if (state is ScheduleImageLoaded) {
      final currentState = state as ScheduleImageLoaded;
      emit(currentState.copyWith(isRefreshing: true));
    }

    final result = await getTeacherScheduleImageUseCase(event.schoolId);

    result.fold(
      (failure) {
        print("🔴 [Bloc] فشل تحديث صورة الجدول: ${failure.toString()}");
        if (state is ScheduleImageLoaded) {
          final currentState = state as ScheduleImageLoaded;
          emit(
            currentState.copyWith(
              isRefreshing: false,
              errorMessage: mapFailureToMessage(failure),
            ),
          );
        } else {
          emit(ScheduleImageError(message: mapFailureToMessage(failure)));
        }
      },
      (scheduleImage) {
        print("✅ [Bloc] تم تحديث صورة الجدول بنجاح");
        if (state is ScheduleImageLoaded) {
          final currentState = state as ScheduleImageLoaded;
          emit(
            currentState.copyWith(
              scheduleImage: scheduleImage,
              isRefreshing: false,
              errorMessage: null,
            ),
          );
        } else {
          emit(ScheduleImageLoaded(scheduleImage: scheduleImage));
        }
      },
    );
  }

  // ============================================================
  // ====== RESET ======
  // ============================================================

  Future<void> _onReset(
    ResetScheduleImageState event,
    Emitter<ScheduleImageState> emit,
  ) async {
    print("🔄 [Bloc] إعادة تعيين حالة صورة الجدول");
    emit(ScheduleImageInitial());
  }
}
