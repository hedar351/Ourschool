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
// ====== BASE EVENT ======
// ============================================================

sealed class AddDeleteEditEvent extends Equatable {
  const AddDeleteEditEvent();

  @override
  List<Object?> get props => [];
}

// ============================================================
// ====== APPROVE RESERVATION ======
// ============================================================

class ApproveReservationEvent extends AddDeleteEditEvent {
  final int localBookNumber;
  final int localStudentNumber;
  const ApproveReservationEvent({
    required this.localBookNumber,
    required this.localStudentNumber,
  });
  @override
  List<Object?> get props => [localBookNumber, localStudentNumber];
}

// ============================================================
// ====== DELETE BOOK  ======
// ============================================================

class DeleteBookEvent extends AddDeleteEditEvent {
  final int localBookNumber;
  const DeleteBookEvent({required this.localBookNumber});
  @override
  List<Object?> get props => [localBookNumber];
}

// ============================================================
// ====== EDIT BOOK  ======
// ============================================================

class EditBookEvent extends AddDeleteEditEvent {
  final int localBookNumber;
  final String title;
  final String author;
  final int copies;
  const EditBookEvent({
    required this.localBookNumber,
    required this.title,
    required this.author,
    required this.copies,
  });
  @override
  List<Object?> get props => [localBookNumber, title, author, copies];
}

// ============================================================
// ====== POST LOANS (إنشاء إعارة) ======
// ============================================================

class PostLoansEvent extends AddDeleteEditEvent {
  final int localBookNumber;
  final int localStudentNumber;
  const PostLoansEvent({
    required this.localBookNumber,
    required this.localStudentNumber,
  });
  @override
  List<Object?> get props => [localBookNumber, localStudentNumber];
}

// ============================================================
// ====== REJECT RESERVATION ======
// ============================================================

class RejectReservationEvent extends AddDeleteEditEvent {
  final int localBookNumber;
  final int localStudentNumber;
  const RejectReservationEvent({
    required this.localBookNumber,
    required this.localStudentNumber,
  });
  @override
  List<Object?> get props => [localBookNumber, localStudentNumber];
}

class ResetAddDeleteEditState extends AddDeleteEditEvent {}

// ============================================================
// ====== RETURN LOANS (إرجاع كتاب) ======
// ============================================================

class ReturnLoansEvent extends AddDeleteEditEvent {
  final int localBookNumber;
  final int localStudentNumber;
  const ReturnLoansEvent({
    required this.localBookNumber,
    required this.localStudentNumber,
  });
  @override
  List<Object?> get props => [localBookNumber, localStudentNumber];
}
