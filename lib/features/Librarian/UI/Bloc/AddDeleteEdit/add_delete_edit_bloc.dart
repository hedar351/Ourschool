import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school/core/const.dart';
import 'package:school/features/Librarian/domain/UseCase/addBooksUseCase.dart';
import 'package:school/features/Librarian/domain/UseCase/approve_reservations_use_case.dart';
import 'package:school/features/Librarian/domain/UseCase/delete_book_use_case.dart';
import 'package:school/features/Librarian/domain/UseCase/edit_book_use_case.dart';
import 'package:school/features/Librarian/domain/UseCase/post_loans_use_case.dart';
import 'package:school/features/Librarian/domain/UseCase/reject_reservations_use_case.dart';
import 'package:school/features/Librarian/domain/UseCase/return_loans_use_case.dart';

part 'add_delete_edit_event.dart';
part 'add_delete_edit_state.dart';

class AddDeleteEditBloc extends Bloc<AddDeleteEditEvent, AddDeleteEditState> {
  final Addbooksusecase addBooksUseCase;
  final DeleteBookUseCase deleteBookUseCase;
  final EditBookUseCase editBookUseCase;
  final ApproveReservationsUseCase approveReservationsUseCase;
  final RejectReservationsUseCase rejectReservationsUseCase;
  final PostLoansUseCase postLoansUseCase; // ✅ جديد
  final ReturnLoansUseCase returnLoansUseCase;
  AddDeleteEditBloc({
    required this.addBooksUseCase,
    required this.deleteBookUseCase,
    required this.editBookUseCase,
    required this.approveReservationsUseCase,
    required this.rejectReservationsUseCase,
    required this.postLoansUseCase,
    required this.returnLoansUseCase,
    // required this.deleteCache,
  }) : super(AddDeleteEditInitial()) {
    on<AddBookEvent>(_onAddBook);
    on<DeleteBookEvent>(_onDeleteBook);
    on<EditBookEvent>(_onEditBook);
    on<ResetAddDeleteEditState>(_onReset);
    on<ApproveReservationEvent>(_onApproveReservation);
    on<RejectReservationEvent>(_onRejectReservation);
    on<PostLoansEvent>(_onPostLoans); // ✅ جديد
    on<ReturnLoansEvent>(_onReturnLoans); // ✅ جديد
  }
  Future<void> _onAddBook(
    AddBookEvent event,
    Emitter<AddDeleteEditState> emit,
  ) async {
    emit(AddDeleteEditLoading());

    final result = await addBooksUseCase(
      event.title,
      event.author,
      event.copies,
    );

    result.fold(
      (failure) {
        final message = mapFailureToMessage(failure);
        emit(AddDeleteEditError(message: message));
      },
      (_) {
        emit(
          AddDeleteEditSuccess(
            message: ' تم إضافة الكتاب "${event.title}" بنجاح',
          ),
        );
      },
    );
  }

  // ============================================================
  // ====== ADD BOOK ======
  // ============================================================
  Future<void> _onApproveReservation(
    ApproveReservationEvent event,
    Emitter<AddDeleteEditState> emit,
  ) async {
    emit(AddDeleteEditLoading());
    final result = await approveReservationsUseCase(
      event.localBookNumber,
      event.localStudentNumber,
    );
    result.fold(
      (failure) =>
          emit(AddDeleteEditError(message: mapFailureToMessage(failure))),
      (_) => emit(AddDeleteEditSuccess(message: 'تم قبول الحجز بنجاح')),
    );
  }
  // ============================================================
  // ====== DELETE BOOK  ======
  // ============================================================

  Future<void> _onDeleteBook(
    DeleteBookEvent event,
    Emitter<AddDeleteEditState> emit,
  ) async {
    emit(AddDeleteEditLoading());
    final result = await deleteBookUseCase(event.localBookNumber);

    result.fold(
      (failure) =>
          emit(AddDeleteEditError(message: mapFailureToMessage(failure))),
      (_) {
        emit(AddDeleteEditSuccess(message: ' تم حذف الكتاب بنجاح'));
      },
    );
  }

  // ============================================================
  // ====== EDIT BOOK  ======
  // ============================================================

  Future<void> _onEditBook(
    EditBookEvent event,
    Emitter<AddDeleteEditState> emit,
  ) async {
    emit(AddDeleteEditLoading());
    final result = await editBookUseCase(
      event.localBookNumber,
      event.title,
      event.author,
      event.copies,
    );
    result.fold(
      (failure) =>
          emit(AddDeleteEditError(message: mapFailureToMessage(failure))),
      (_) => emit(AddDeleteEditSuccess(message: ' تم تعديل الكتاب بنجاح')),
    );
  }

  // ============================================================
  // ====== POST LOANS (إنشاء إعارة) ======
  // ============================================================

  Future<void> _onPostLoans(
    PostLoansEvent event,
    Emitter<AddDeleteEditState> emit,
  ) async {
    emit(AddDeleteEditLoading());
    final result = await postLoansUseCase(
      event.localBookNumber,
      event.localStudentNumber,
    );
    result.fold(
      (failure) =>
          emit(AddDeleteEditError(message: mapFailureToMessage(failure))),
      (_) => emit(AddDeleteEditSuccess(message: 'تم إنشاء الإعارة بنجاح')),
    );
  }

  Future<void> _onRejectReservation(
    RejectReservationEvent event,
    Emitter<AddDeleteEditState> emit,
  ) async {
    emit(AddDeleteEditLoading());
    final result = await rejectReservationsUseCase(
      event.localBookNumber,
      event.localStudentNumber,
    );
    result.fold(
      (failure) =>
          emit(AddDeleteEditError(message: mapFailureToMessage(failure))),
      (_) => emit(AddDeleteEditSuccess(message: 'تم رفض الحجز بنجاح')),
    );
  }

  // ============================================================
  // ====== RESET ======
  // ============================================================

  Future<void> _onReset(
    ResetAddDeleteEditState event,
    Emitter<AddDeleteEditState> emit,
  ) {
    emit(AddDeleteEditInitial());
    return Future.value();
  }

  // ============================================================
  // ====== RETURN LOANS (إرجاع كتاب) ======
  // ============================================================

  Future<void> _onReturnLoans(
    ReturnLoansEvent event,
    Emitter<AddDeleteEditState> emit,
  ) async {
    emit(AddDeleteEditLoading());
    final result = await returnLoansUseCase(
      event.localBookNumber,
      event.localStudentNumber,
    );
    result.fold(
      (failure) =>
          emit(AddDeleteEditError(message: mapFailureToMessage(failure))),
      (_) => emit(AddDeleteEditSuccess(message: 'تم إرجاع الكتاب بنجاح')),
    );
  }
}
