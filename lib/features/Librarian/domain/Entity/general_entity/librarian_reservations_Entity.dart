import 'package:equatable/equatable.dart';
import 'package:school/features/Librarian/domain/Entity/general_entity/reservations.dart';

class LibrarianReservationsEntity extends Equatable {
  final int? totalCount;
  final int? pendingCount;
  final int? approvedCount;
  final int? rejectedCount;
  final int? cancelledCount;
  final int? expiredCount;
  final List<Reservations>? reservations;
  const LibrarianReservationsEntity({
    required this.totalCount,
    required this.pendingCount,
    required this.approvedCount,
    required this.rejectedCount,
    required this.cancelledCount,
    required this.expiredCount,
    required this.reservations,
  });

  @override
  List<Object?> get props => [
    totalCount,
    pendingCount,
    approvedCount,
    rejectedCount,
    cancelledCount,
    expiredCount,
    reservations,
  ];
}
