import 'package:equatable/equatable.dart';
import 'package:school/features/Librarian/domain/Entity/general_entity/librarian_reservations_Entity.dart';

class BookReservationsEntity extends Equatable {
  final int? id;
  final String? title;
  final int? localBookNumber;
  final String? author;
  final int? availableCopies;
  final int? reservedCopies;
  final int? availableForLoan;
  final LibrarianReservationsEntity? librarianReservationsEntity;

  const BookReservationsEntity({
    required this.id,
    required this.title,
    required this.localBookNumber,
    required this.author,
    required this.availableCopies,
    required this.reservedCopies,
    required this.availableForLoan,
    required this.librarianReservationsEntity,
  });
  @override
  List<Object?> get props => [
    id,
    title,
    localBookNumber,
    author,
    availableCopies,
    reservedCopies,
    availableForLoan,
    librarianReservationsEntity,
  ];
}
