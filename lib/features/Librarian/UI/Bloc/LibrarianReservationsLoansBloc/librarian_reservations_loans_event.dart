// lib/features/Librarian/UI/Bloc/LibrarianReservationsLoansBloc/librarian_reservations_loans_event.dart

part of 'librarian_reservations_loans_bloc.dart';

// ============================================================
// ====== LOANS EVENTS  ======
// ============================================================

class GetLoansEvent extends LibrarianReservationsLoansEvent {
  final String? status;
  const GetLoansEvent({this.status});
  @override
  List<Object?> get props => [status];
}

// ============================================================
// ====== RESERVATIONS EVENTS ======
// ============================================================

class GetReservationsEvent extends LibrarianReservationsLoansEvent {
  final String? status;

  const GetReservationsEvent({this.status});

  @override
  List<Object?> get props => [status];
}

// ============================================================
// ====== BASE EVENT ======
// ============================================================

sealed class LibrarianReservationsLoansEvent extends Equatable {
  const LibrarianReservationsLoansEvent();

  @override
  List<Object?> get props => [];
}

class RefreshLoansEvent extends LibrarianReservationsLoansEvent {
  final String? status;
  const RefreshLoansEvent({this.status});
  @override
  List<Object?> get props => [status];
}

class RefreshReservationsEvent extends LibrarianReservationsLoansEvent {
  final String? status;

  const RefreshReservationsEvent({this.status});

  @override
  List<Object?> get props => [status];
}

class ResetLibrarianReservationsLoansState
    extends LibrarianReservationsLoansEvent {}

class RevalidateLoansEvent extends LibrarianReservationsLoansEvent {
  final String? status;
  const RevalidateLoansEvent({this.status});
  @override
  List<Object?> get props => [status];
}

class RevalidateReservationsEvent extends LibrarianReservationsLoansEvent {
  final String? status;

  const RevalidateReservationsEvent({this.status});

  @override
  List<Object?> get props => [status];
}

class UpdateCachedLoansEvent extends LibrarianReservationsLoansEvent {
  final LibrarianLoansEntity loans;
  const UpdateCachedLoansEvent({required this.loans});
  @override
  List<Object> get props => [loans];
}

// ============================================================
// ====== RESET STATE ======
// ============================================================

class UpdateCachedReservationsEvent extends LibrarianReservationsLoansEvent {
  final LibrarianReservationsEntity reservations;

  const UpdateCachedReservationsEvent({required this.reservations});

  @override
  List<Object> get props => [reservations];
}

class WatchCachedLoansEvent extends LibrarianReservationsLoansEvent {
  final String? status;
  const WatchCachedLoansEvent({this.status});
  @override
  List<Object?> get props => [status];
}

class WatchCachedReservationsEvent extends LibrarianReservationsLoansEvent {
  final String? status;

  const WatchCachedReservationsEvent({this.status});

  @override
  List<Object?> get props => [status];
}
