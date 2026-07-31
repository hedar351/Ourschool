// lib/features/Teacher/ui/bloc/Marks/mark_bloc.dart

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school/core/const.dart';
import 'package:school/features/Teacher/domain/UseCases/EditMarkUseCase.dart';
import 'package:school/features/Teacher/domain/UseCases/addMarksUseCase.dart';
import 'package:school/features/Teacher/domain/UseCases/deleteMarksUseCase.dart';

part 'mark_event.dart';
part 'mark_state.dart';

class MarkBloc extends Bloc<MarkEvent, MarkState> {
  final Addmarksusecase addMarksUseCase;
  final Deletemarksusecase deleteMarksUseCase;

  final Editmarkusecase editMarksUseCase;

  MarkBloc({
    required this.addMarksUseCase,
    required this.deleteMarksUseCase,
    required this.editMarksUseCase,
  }) : super(MarkInitial()) {
    on<AddMarkEvent>(_onAddMark);
    on<DeleteEvent>(_onDeleteMark);
    on<EditEvent>(_onEditMark);
  }

  FutureOr<void> _onAddMark(AddMarkEvent event, Emitter<MarkState> emit) async {
    emit(LoadingMarkState());

    final result = await addMarksUseCase(
      event.schoolId,
      event.localStudentNumber,
      event.localSubjectId,
      event.semester,
      event.quizTypeId,
      event.score,
      event.maxScore,
    );

    result.fold(
      (failure) => emit(ErrorMarkState(message: mapFailureToMessage(failure))),
      (_) => emit(const SuccessMarkState(message: 'تم إضافة العلامة بنجاح')),
    );
  }

  FutureOr<void> _onDeleteMark(
    DeleteEvent event,
    Emitter<MarkState> emit,
  ) async {
    emit(LoadingMarkState());

    final result = await deleteMarksUseCase(
      event.schoolId,
      event.localStudentNumber,
      event.localSubjectId,
      event.semester,
      event.quizTypeId,
    );

    result.fold(
      (failure) => emit(ErrorMarkState(message: mapFailureToMessage(failure))),
      (_) => emit(const SuccessMarkState(message: 'تم حذف العلامة بنجاح')),
    );
  }

  FutureOr<void> _onEditMark(EditEvent event, Emitter<MarkState> emit) async {
    emit(LoadingMarkState());

    final result = await editMarksUseCase(
      event.schoolId,
      event.localStudentNumber,
      event.localSubjectId,
      event.semester,
      event.quizTypeId,
      event.score,
      event.maxScore,
    );

    result.fold(
      (failure) => emit(ErrorMarkState(message: mapFailureToMessage(failure))),
      (_) => emit(const SuccessMarkState(message: 'تم تعديل العلامة بنجاح')),
    );
  }
}
