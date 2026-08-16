// lib/features/Librarian/UI/Bloc/BookReservationsLoansBloc/book_reservations_loans_state.dart

part of 'book_reservations_loans_bloc.dart';

class BookReservationsError extends BookReservationsLoansState {
  final String message;
  const BookReservationsError({required this.message});
  @override
  List<Object> get props => [message];
}

class BookReservationsInitial extends BookReservationsLoansState {}

class BookReservationsLoaded extends BookReservationsLoansState {
  final BookReservationsEntity reservations;
  final bool isRevalidating;
  final String? errorMessage;
  final String? currentStatus;
  final int? localBookNumber;

  const BookReservationsLoaded({
    required this.reservations,
    this.isRevalidating = false,
    this.errorMessage,
    this.currentStatus,
    this.localBookNumber,
  });

  @override
  List<Object?> get props => [
    reservations,
    isRevalidating,
    errorMessage,
    currentStatus,
    localBookNumber,
  ];

  BookReservationsLoaded copyWith({
    BookReservationsEntity? reservations,
    bool? isRevalidating,
    String? errorMessage,
    String? currentStatus,
    int? localBookNumber,
  }) {
    return BookReservationsLoaded(
      reservations: reservations ?? this.reservations,
      isRevalidating: isRevalidating ?? this.isRevalidating,
      errorMessage: errorMessage ?? this.errorMessage,
      currentStatus: currentStatus ?? this.currentStatus,
      localBookNumber: localBookNumber ?? this.localBookNumber,
    );
  }
}

class BookReservationsLoading extends BookReservationsLoansState {}

abstract class BookReservationsLoansState extends Equatable {
  const BookReservationsLoansState();
  @override
  List<Object?> get props => [];
}
