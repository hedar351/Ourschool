import 'package:hive/hive.dart';
import 'package:school/features/Librarian/data/Model/general_Model/librarian_reservations_model.dart';
import 'package:school/features/Librarian/domain/Entity/Book-reservations-loans-Entity/book_reservations_entity.dart';

part 'book_reservations_model.g.dart';

@HiveType(typeId: 36)
class BookReservationsModel extends HiveObject {
  @HiveField(0)
  final int? id;

  @HiveField(1)
  final String? title;

  @HiveField(2)
  final int? localBookNumber;

  @HiveField(3)
  final String? author;

  @HiveField(4)
  final int? availableCopies;

  @HiveField(5)
  final int? reservedCopies;

  @HiveField(6)
  final int? availableForLoan;

  @HiveField(7)
  final LibrarianReservationsModel? librarianReservationsModel;

  BookReservationsModel({
    required this.id,
    required this.title,
    required this.localBookNumber,
    required this.author,
    required this.availableCopies,
    required this.reservedCopies,
    required this.availableForLoan,
    required this.librarianReservationsModel,
  });

  // ----- fromEntity -----
  factory BookReservationsModel.fromEntity(BookReservationsEntity entity) {
    return BookReservationsModel(
      id: entity.id,
      title: entity.title,
      localBookNumber: entity.localBookNumber,
      author: entity.author,
      availableCopies: entity.availableCopies,
      reservedCopies: entity.reservedCopies,
      availableForLoan: entity.availableForLoan,
      librarianReservationsModel: entity.librarianReservationsEntity != null
          ? LibrarianReservationsModel.fromEntity(
              entity.librarianReservationsEntity!,
            )
          : null,
    );
  }

  // ----- fromJson -----
  factory BookReservationsModel.fromJson(Map<String, dynamic> json) {
    final bookData = json['data']['book'] as Map<String, dynamic>? ?? json;
    return BookReservationsModel(
      id: bookData['id'] as int?,
      title: bookData['title'] as String?,
      localBookNumber: bookData['localBookNumber'] as int?,
      author: bookData['author'] as String?,
      availableCopies: bookData['availableCopies'] as int?,
      reservedCopies: bookData['reservedCopies'] as int?,
      availableForLoan: bookData['availableForLoan'] as int?,
      librarianReservationsModel: LibrarianReservationsModel.fromJson(json),
    );
  }

  // ----- toEntity -----
  BookReservationsEntity toEntity() {
    return BookReservationsEntity(
      id: id,
      title: title,
      localBookNumber: localBookNumber,
      author: author,
      availableCopies: availableCopies,
      reservedCopies: reservedCopies,
      availableForLoan: availableForLoan,
      librarianReservationsEntity: librarianReservationsModel?.toEntity(),
    );
  }

  // ----- toJson -----
  Map<String, dynamic> toJson() {
    return {
      'book': {
        'id': id,
        'title': title,
        'localBookNumber': localBookNumber,
        'author': author,
        'availableCopies': availableCopies,
        'reservedCopies': reservedCopies,
        'availableForLoan': availableForLoan,
      },
      ...?librarianReservationsModel?.toJson(),
    };
  }
}
