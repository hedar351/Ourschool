import 'package:hive/hive.dart';
import 'package:school/features/Librarian/data/Model/Book-reservations-loans-Model/statistics_loans_model.dart';
import 'package:school/features/Librarian/data/Model/general_Model/librarian_reservation_model.dart';
import 'package:school/features/Librarian/domain/Entity/Book-reservations-loans-Entity/book_loan_entity.dart';

part 'book_loan_model.g.dart';

@HiveType(typeId: 38)
class BookLoanModel extends HiveObject {
  @HiveField(0)
  final int? id;

  @HiveField(1)
  final String? title;

  @HiveField(2)
  final int? localBookNumber;

  @HiveField(3)
  final String? author;

  @HiveField(4)
  final int? totalCopies;

  @HiveField(5)
  final int? availableCopies;

  @HiveField(6)
  final int? reservedCopies;

  @HiveField(7)
  final int? availableForLoan;

  @HiveField(8)
  final bool? isAvailable;

  @HiveField(9)
  final StatisticsLoansModel? statisticsLoans;

  @HiveField(10)
  final List<LibrarianReservationModel>? loans;

  BookLoanModel({
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
    required this.loans,
  });

  factory BookLoanModel.fromEntity(BookLoanEntity entity) {
    return BookLoanModel(
      id: entity.id,
      title: entity.title,
      localBookNumber: entity.localBookNumber,
      author: entity.author,
      totalCopies: entity.totalCopies,
      availableCopies: entity.availableCopies,
      reservedCopies: entity.reservedCopies,
      availableForLoan: entity.availableForLoan,
      isAvailable: entity.isAvailable,
      statisticsLoans: entity.statisticsLoans != null
          ? StatisticsLoansModel.fromEntity(entity.statisticsLoans!)
          : null,
      loans: entity.reservations
          ?.map((e) => LibrarianReservationModel.fromEntity(e))
          .toList(),
    );
  }

  factory BookLoanModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? {};
    final bookData = data['book'] as Map<String, dynamic>? ?? {};
    final statisticsData = data['statistics'] as Map<String, dynamic>? ?? {};
    final loansData = data['loans'] as List? ?? [];

    return BookLoanModel(
      id: bookData['id'] as int?,
      title: bookData['title'] as String?,
      localBookNumber: bookData['localBookNumber'] as int?,
      author: bookData['author'] as String?,
      totalCopies: bookData['totalCopies'] as int?,
      availableCopies: bookData['availableCopies'] as int?,
      reservedCopies: bookData['reservedCopies'] as int?,
      availableForLoan: bookData['availableForLoan'] as int?,
      isAvailable: bookData['isAvailable'] as bool?,
      statisticsLoans: StatisticsLoansModel.fromJson(statisticsData),
      loans: loansData
          .map((e) => LibrarianReservationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  BookLoanEntity toEntity() {
    return BookLoanEntity(
      id: id,
      title: title,
      localBookNumber: localBookNumber,
      author: author,
      totalCopies: totalCopies,
      availableCopies: availableCopies,
      reservedCopies: reservedCopies,
      availableForLoan: availableForLoan,
      isAvailable: isAvailable,
      statisticsLoans: statisticsLoans?.toEntity(),
      reservations: loans?.map((e) => e.toEntity()).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': {
        'book': {
          'id': id,
          'title': title,
          'localBookNumber': localBookNumber,
          'author': author,
          'totalCopies': totalCopies,
          'availableCopies': availableCopies,
          'reservedCopies': reservedCopies,
          'availableForLoan': availableForLoan,
          'isAvailable': isAvailable,
        },
        'statistics': statisticsLoans?.toJson(),
        'loans': loans?.map((e) => e.toJson()).toList(),
      },
    };
  }
}