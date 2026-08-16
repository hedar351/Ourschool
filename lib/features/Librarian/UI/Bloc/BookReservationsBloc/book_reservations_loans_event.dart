// lib/features/Librarian/UI/Bloc/BookReservationsLoansBloc/book_reservations_loans_event.dart

part of 'book_reservations_loans_bloc.dart';

abstract class BookReservationsLoansEvent extends Equatable {
  const BookReservationsLoansEvent();
  @override
  List<Object?> get props => [];
}

class GetBookReservationsEvent extends BookReservationsLoansEvent {
  final String? status;
  final int localBookNumber;
  const GetBookReservationsEvent({this.status, required this.localBookNumber});
  @override
  List<Object?> get props => [status, localBookNumber];
}

class RefreshBookReservationsEvent extends BookReservationsLoansEvent {
  final String? status;
  final int localBookNumber;
  const RefreshBookReservationsEvent({
    this.status,
    required this.localBookNumber,
  });
  @override
  List<Object?> get props => [status, localBookNumber];
}

class ResetBookReservationsState extends BookReservationsLoansEvent {}

class RevalidateBookReservationsEvent extends BookReservationsLoansEvent {
  final String? status;
  final int localBookNumber;
  const RevalidateBookReservationsEvent({
    this.status,
    required this.localBookNumber,
  });
  @override
  List<Object?> get props => [status, localBookNumber];
}

class UpdateCachedBookReservationsEvent extends BookReservationsLoansEvent {
  final BookReservationsEntity reservations;
  const UpdateCachedBookReservationsEvent({required this.reservations});
  @override
  List<Object> get props => [reservations];
}

class WatchCachedBookReservationsEvent extends BookReservationsLoansEvent {
  final String? status;
  final int localBookNumber;
  const WatchCachedBookReservationsEvent({
    this.status,
    required this.localBookNumber,
  });
  @override
  List<Object?> get props => [status, localBookNumber];
}
