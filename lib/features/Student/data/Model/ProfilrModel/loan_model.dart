import 'package:hive/hive.dart';
import 'package:school/features/Student/domain/entity/Student-FullProfile/LoansEntity.dart';

part 'loan_model.g.dart';

@HiveType(typeId: 32)
class LoanModel extends HiveObject {
  @HiveField(0)
  final int? localLoanNumber;

  @HiveField(1)
  final int? localBookNumber;

  @HiveField(2)
  final String? bookTitle;

  @HiveField(3)
  final String? loanDate;

  @HiveField(4)
  final String? dueDate;

  LoanModel({
    required this.localLoanNumber,
    required this.localBookNumber,
    required this.bookTitle,
    required this.loanDate,
    required this.dueDate,
  });

  // ----- fromEntity -----
  factory LoanModel.fromEntity(Loansentity entity) {
    return LoanModel(
      localLoanNumber: entity.localLoanNumber,
      localBookNumber: entity.localBookNumber,
      bookTitle: entity.bookTitle,
      loanDate: entity.loanDate,
      dueDate: entity.dueDate,
    );
  }

  // ----- fromJson -----
  factory LoanModel.fromJson(Map<String, dynamic> json) {
    return LoanModel(
      localLoanNumber: json['localLoanNumber'] as int?,
      localBookNumber: json['localBookNumber'] as int?,
      bookTitle: json['bookTitle'] as String?,
      loanDate: json['date'] as String?,
      dueDate: json['expiryDate'] as String?,
    );
  }

  // ----- toEntity -----
  Loansentity toEntity() {
    return Loansentity(
      localLoanNumber: localLoanNumber,
      localBookNumber: localBookNumber,
      bookTitle: bookTitle,
      loanDate: loanDate,
      dueDate: dueDate,
    );
  }

  // ----- toJson -----
  Map<String, dynamic> toJson() {
    return {
      'localLoanNumber': localLoanNumber,
      'localBookNumber': localBookNumber,
      'bookTitle': bookTitle,
      'loanDate': loanDate,
      'dueDate': dueDate,
    };
  }
}
