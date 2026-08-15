// lib/features/Librarian/UI/Bloc/BookLoansBloc/book_loans_event.dart

part of 'book_loans_bloc.dart';

abstract class BookLoansEvent extends Equatable {
  const BookLoansEvent();
  @override
  List<Object?> get props => [];
}

class GetBookLoansEvent extends BookLoansEvent {
  final int localBookNumber;
  const GetBookLoansEvent({required this.localBookNumber});
  @override
  List<Object> get props => [localBookNumber];
}

class RefreshBookLoansEvent extends BookLoansEvent {
  final int localBookNumber;
  const RefreshBookLoansEvent({required this.localBookNumber});
  @override
  List<Object> get props => [localBookNumber];
}

class ResetBookLoansState extends BookLoansEvent {}

class RevalidateBookLoansEvent extends BookLoansEvent {
  final int localBookNumber;
  const RevalidateBookLoansEvent({required this.localBookNumber});
  @override
  List<Object> get props => [localBookNumber];
}

class UpdateCachedBookLoansEvent extends BookLoansEvent {
  final BookLoanEntity loans;
  const UpdateCachedBookLoansEvent({required this.loans});
  @override
  List<Object> get props => [loans];
}

class WatchCachedBookLoansEvent extends BookLoansEvent {
  final int localBookNumber;
  const WatchCachedBookLoansEvent({required this.localBookNumber});
  @override
  List<Object> get props => [localBookNumber];
}
