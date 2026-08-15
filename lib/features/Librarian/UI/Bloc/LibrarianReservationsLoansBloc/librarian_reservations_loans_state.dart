// lib/features/Librarian/UI/Bloc/LibrarianReservationsLoansBloc/librarian_reservations_loans_state.dart

part of 'librarian_reservations_loans_bloc.dart';

// ============================================================
// ====== BASE STATE ======
// ============================================================

sealed class LibrarianReservationsLoansState extends Equatable {
  const LibrarianReservationsLoansState();

  @override
  List<Object?> get props => [];
}

class LoansError extends LibrarianReservationsLoansState {
  final String message;
  const LoansError({required this.message});
  @override
  List<Object> get props => [message];
}

// ============================================================
// ====== LOANS STATES  ======
// ============================================================

class LoansInitial extends LibrarianReservationsLoansState {}

class LoansLoaded extends LibrarianReservationsLoansState {
  final LibrarianLoansEntity loans;
  final bool isRevalidating;
  final String? errorMessage;
  final String? currentStatus;

  const LoansLoaded({
    required this.loans,
    this.isRevalidating = false,
    this.errorMessage,
    this.currentStatus,
  });

  @override
  List<Object?> get props => [
    loans,
    isRevalidating,
    errorMessage,
    currentStatus,
  ];

  LoansLoaded copyWith({
    LibrarianLoansEntity? loans,
    bool? isRevalidating,
    String? errorMessage,
    String? currentStatus,
  }) {
    return LoansLoaded(
      loans: loans ?? this.loans,
      isRevalidating: isRevalidating ?? this.isRevalidating,
      errorMessage: errorMessage ?? this.errorMessage,
      currentStatus: currentStatus ?? this.currentStatus,
    );
  }
}

class LoansLoading extends LibrarianReservationsLoansState {}

class ReservationsError extends LibrarianReservationsLoansState {
  final String message;

  const ReservationsError({required this.message});

  @override
  List<Object> get props => [message];
}

// ============================================================
// ====== RESERVATIONS STATES ======
// ============================================================

class ReservationsInitial extends LibrarianReservationsLoansState {}

class ReservationsLoaded extends LibrarianReservationsLoansState {
  final LibrarianReservationsEntity reservations;
  final bool isRevalidating;
  final String? errorMessage;
  final String? currentStatus; // الحالة المختارة حالياً

  const ReservationsLoaded({
    required this.reservations,
    this.isRevalidating = false,
    this.errorMessage,
    this.currentStatus,
  });

  @override
  List<Object?> get props => [
    reservations,
    isRevalidating,
    errorMessage,
    currentStatus,
  ];

  ReservationsLoaded copyWith({
    LibrarianReservationsEntity? reservations,
    bool? isRevalidating,
    String? errorMessage,
    String? currentStatus,
  }) {
    return ReservationsLoaded(
      reservations: reservations ?? this.reservations,
      isRevalidating: isRevalidating ?? this.isRevalidating,
      errorMessage: errorMessage ?? this.errorMessage,
      currentStatus: currentStatus ?? this.currentStatus,
    );
  }
}

class ReservationsLoading extends LibrarianReservationsLoansState {}
