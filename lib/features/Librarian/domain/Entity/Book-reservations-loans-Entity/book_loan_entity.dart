import 'package:equatable/equatable.dart';
import 'package:school/features/Librarian/domain/Entity/Book-reservations-loans-Entity/statistics_loans.dart';
import 'package:school/features/Librarian/domain/Entity/general_entity/reservations.dart';

class BookLoanEntity extends Equatable {
  final int? id;
  final String? title;
  final int? localBookNumber;
  final String? author;
  final int? totalCopies;
  final int? availableCopies;
  final int? reservedCopies;
  final int? availableForLoan;
  final bool? isAvailable;
  final StatisticsLoans? statisticsLoans;
  final List<Reservations>? reservations;

  const BookLoanEntity({
    required this.id,
    required this.title,
    required this.localBookNumber,
    required this.author,
    required this.totalCopies,
    required this.availableCopies,
    required this.reservedCopies,
    required this.availableForLoan,
    required this.isAvailable,
    required this.statisticsLoans,
    required this.reservations,
  });
  @override
  List<Object?> get props => [
    id,
    title,
    localBookNumber,
    author,
    totalCopies,
    availableCopies,
    reservedCopies,
    availableForLoan,
    isAvailable,
    statisticsLoans,
    reservations,
  ];
}
