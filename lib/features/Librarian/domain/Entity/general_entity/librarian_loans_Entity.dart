import 'package:equatable/equatable.dart';
import 'package:school/features/Librarian/domain/Entity/general_entity/reservations.dart';

class LibrarianLoansEntity extends Equatable {
  final int? totalCount;
  final int? activeCount;
  final int? returnedCount;
  final List<Reservations>? loans;

  const LibrarianLoansEntity({
    required this.totalCount,
    required this.activeCount,
    required this.returnedCount,
    required this.loans,
  });
  @override
  List<Object?> get props => [totalCount, activeCount, returnedCount, loans];
}
