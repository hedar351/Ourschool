// lib/features/Student/domain/entity/Student-FullProfile/loansEntity.dart

import 'package:equatable/equatable.dart';

class Loansentity extends Equatable {
  final int? localLoanNumber;
  final int? localBookNumber;
  final String? bookTitle;
  final String? loanDate;
  final String? dueDate;

  const Loansentity({
    required this.localLoanNumber,
    required this.localBookNumber,
    required this.bookTitle,
    required this.loanDate,
    required this.dueDate,
  });

  @override
  List<Object?> get props => [
    localLoanNumber,
    localBookNumber,
    bookTitle,
    loanDate,
    dueDate,
  ];
}
