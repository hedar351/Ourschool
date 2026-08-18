import 'package:equatable/equatable.dart';
import 'package:school/features/Student/domain/entity/Library/reservations.dart';

class ReservationsError extends ReservationsState {
  final String message;

  const ReservationsError({required this.message});

  @override
  List<Object> get props => [message];
}

class ReservationsInitial extends ReservationsState {}

class ReservationsLoaded extends ReservationsState {
  final Reservations reservations;
  final bool isRevalidating;
  final String? errorMessage;

  const ReservationsLoaded({
    required this.reservations,
    this.isRevalidating = false,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [reservations, isRevalidating, errorMessage];

  ReservationsLoaded copyWith({
    Reservations? reservations,
    bool? isRevalidating,
    String? errorMessage,
  }) {
    return ReservationsLoaded(
      reservations: reservations ?? this.reservations,
      isRevalidating: isRevalidating ?? this.isRevalidating,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class ReservationsLoading extends ReservationsState {}

sealed class ReservationsState extends Equatable {
  const ReservationsState();

  @override
  List<Object?> get props => [];
}
