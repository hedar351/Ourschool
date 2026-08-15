// lib/features/Librarian/UI/Bloc/BookLoansBloc/book_loans_state.dart

part of 'book_loans_bloc.dart';

class BookLoansError extends BookLoansState {
  final String message;
  const BookLoansError({required this.message});
  @override
  List<Object> get props => [message];
}

class BookLoansInitial extends BookLoansState {}

class BookLoansLoaded extends BookLoansState {
  final BookLoanEntity loans;
  final bool isRevalidating;
  final String? errorMessage;
  final int? localBookNumber;

  const BookLoansLoaded({
    required this.loans,
    this.isRevalidating = false,
    this.errorMessage,
    this.localBookNumber,
  });

  @override
  List<Object?> get props => [
    loans,
    isRevalidating,
    errorMessage,
    localBookNumber,
  ];

  BookLoansLoaded copyWith({
    BookLoanEntity? loans,
    bool? isRevalidating,
    String? errorMessage,
    int? localBookNumber,
  }) {
    return BookLoansLoaded(
      loans: loans ?? this.loans,
      isRevalidating: isRevalidating ?? this.isRevalidating,
      errorMessage: errorMessage ?? this.errorMessage,
      localBookNumber: localBookNumber ?? this.localBookNumber,
    );
  }
}

class BookLoansLoading extends BookLoansState {}

abstract class BookLoansState extends Equatable {
  const BookLoansState();
  @override
  List<Object?> get props => [];
}
