// lib/features/Librarian/UI/LibrarianBloc/AddDeleteEditBloc/add_delete_edit_bloc.dart

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school/core/const.dart';
import 'package:school/features/Librarian/domain/UseCase/addBooksUseCase.dart';

part 'add_delete_edit_event.dart';
part 'add_delete_edit_state.dart';

class AddDeleteEditBloc extends Bloc<AddDeleteEditEvent, AddDeleteEditState> {
  final Addbooksusecase addBooksUseCase;

  AddDeleteEditBloc({
    required this.addBooksUseCase,
    // required Object librarianRepo,
  }) : super(AddDeleteEditInitial()) {
    on<AddBookEvent>(_onAddBook);
    // on<DeleteBookEvent>(_onDeleteBook); // مستقبلاً
    // on<EditBookEvent>(_onEditBook);     // مستقبلاً
    on<ResetAddDeleteEditState>(_onReset);
  }

  // ============================================================
  // ====== ADD BOOK ======
  // ============================================================

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
            message: '✅ تم إضافة الكتاب "${event.title}" بنجاح',
          ),
        );
      },
    );
  }

  // ============================================================
  // ====== DELETE BOOK (مستقبلاً) ======
  // ============================================================

  // Future<void> _onDeleteBook(
  //   DeleteBookEvent event,
  //   Emitter<AddDeleteEditState> emit,
  // ) async {
  //   emit(AddDeleteEditLoading());
  //   final result = await deleteBooksUseCase(event.localBookNumber);
  //   result.fold(
  //     (failure) => emit(AddDeleteEditError(message: mapFailureToMessage(failure))),
  //     (_) => emit(AddDeleteEditSuccess(message: '✅ تم حذف الكتاب بنجاح')),
  //   );
  // }

  // ============================================================
  // ====== EDIT BOOK (مستقبلاً) ======
  // ============================================================

  // Future<void> _onEditBook(
  //   EditBookEvent event,
  //   Emitter<AddDeleteEditState> emit,
  // ) async {
  //   emit(AddDeleteEditLoading());
  //   final result = await editBooksUseCase(
  //     localBookNumber: event.localBookNumber,
  //     title: event.title,
  //     author: event.author,
  //     copies: event.copies,
  //   );
  //   result.fold(
  //     (failure) => emit(AddDeleteEditError(message: mapFailureToMessage(failure))),
  //     (_) => emit(AddDeleteEditSuccess(message: '✅ تم تعديل الكتاب بنجاح')),
  //   );
  // }

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
}
