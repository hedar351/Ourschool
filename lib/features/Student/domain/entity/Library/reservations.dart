import 'package:equatable/equatable.dart';
import 'package:school/features/Student/domain/entity/Library/reserveBookInfoEntity.dart';

class Reservations extends Equatable {
  final String? message;
  final int? totalReservations;
  final int? pendingReservations;
  final int? approvedReservations;
  final List<ReserveBookInfoEntity>? reserveBookInfo;

  const Reservations({
    required this.message,
    required this.totalReservations,
    required this.pendingReservations,
    required this.approvedReservations,
    required this.reserveBookInfo,
  });
  @override
  List<Object?> get props => [
    message,
    totalReservations,
    pendingReservations,
    approvedReservations,
    reserveBookInfo,
  ];
}
