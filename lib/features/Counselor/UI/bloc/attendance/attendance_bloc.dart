// lib/features/Counselor/UI/bloc/Attendance/attendance_bloc.dart

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school/core/const.dart';
import 'package:school/features/Counselor/domain/UseCases/AddAttendanceUseCase.dart';
import 'package:school/features/Counselor/domain/UseCases/DeleteAttendanceUseCase.dart';

part 'attendance_event.dart';
part 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final AddAttendanceUseCase addAttendanceUseCase;
  final DeleteAttendanceUseCase deleteAttendanceUseCase;

  AttendanceBloc({
    required this.addAttendanceUseCase,
    required this.deleteAttendanceUseCase,
  }) : super(AttendanceInitial()) {
    on<AddAttendanceEvent>(_onAddAttendance);
    on<DeleteAttendanceEvent>(_onDeleteAttendance);
    on<ResetAttendanceEvent>(_onReset);
  }

  // ====== إضافة غياب ======
  FutureOr<void> _onAddAttendance(
    AddAttendanceEvent event,
    Emitter<AttendanceState> emit,
  ) async {
    emit(AttendanceLoading());

    final result = await addAttendanceUseCase(
      event.localStudentNumber,
      event.date,
    );

    result.fold(
      (failure) => emit(AttendanceError(message: mapFailureToMessage(failure))),
      (_) => emit(const AttendanceSuccess(message: 'تم تسجيل الغياب بنجاح')),
    );
  }

  // ====== حذف غياب ======
  FutureOr<void> _onDeleteAttendance(
    DeleteAttendanceEvent event,
    Emitter<AttendanceState> emit,
  ) async {
    emit(AttendanceLoading());

    final result = await deleteAttendanceUseCase(
      event.localStudentNumber,
      event.date,
    );

    result.fold(
      (failure) => emit(AttendanceError(message: mapFailureToMessage(failure))),
      (_) => emit(const AttendanceSuccess(message: 'تم حذف الغياب بنجاح')),
    );
  }

  // ====== إعادة تعيين الحالة ======
  FutureOr<void> _onReset(
    ResetAttendanceEvent event,
    Emitter<AttendanceState> emit,
  ) {
    emit(AttendanceInitial());
  }
}
