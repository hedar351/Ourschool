// lib/features/Librarian/UI/LibrarianBloc/AddDeleteEditBloc/add_delete_edit_event.dart

part of 'add_delete_edit_bloc.dart';

// ============================================================
// ====== ADD BOOK ======
// ============================================================

class AddBookEvent extends AddDeleteEditEvent {
  final String title;
  final String author;
  final int copies;

  const AddBookEvent({
    required this.title,
    required this.author,
    required this.copies,
  });

  @override
  List<Object?> get props => [title, author, copies];
}

// ============================================================
// ====== DELETE BOOK (للتحضير للمستقبل) ======
// ============================================================

// class DeleteBookEvent extends AddDeleteEditEvent {
//   final int localBookNumber;
//   const DeleteBookEvent({required this.localBookNumber});
//   @override
//   List<Object?> get props => [localBookNumber];
// }

// ============================================================
// ====== EDIT BOOK (للتحضير للمستقبل) ======
// ============================================================

// class EditBookEvent extends AddDeleteEditEvent {
//   final int localBookNumber;
//   final String title;
//   final String author;
//   final int copies;
//   const EditBookEvent({
//     required this.localBookNumber,
//     required this.title,
//     required this.author,
//     required this.copies,
//   });
//   @override
//   List<Object?> get props => [localBookNumber, title, author, copies];
// }

// ============================================================
// ====== RESET STATE ======
// ============================================================

// ============================================================
// ====== BASE EVENT ======
// ============================================================

sealed class AddDeleteEditEvent extends Equatable {
  const AddDeleteEditEvent();

  @override
  List<Object?> get props => [];
}

/// إعادة تعيين الحالة إلى Initial (لإخفاء رسائل النجاح/الخطأ)
class ResetAddDeleteEditState extends AddDeleteEditEvent {}
