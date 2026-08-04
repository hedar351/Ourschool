import 'package:equatable/equatable.dart';

class ReserveBookInfoEntity extends Equatable {
  final int? id;
  final int? localBookNumber;
  final String? bookTitle;
  final String? date;
  final String? expiryDate;
  final String? status;
  final String? statusName;

  const ReserveBookInfoEntity({
    required this.id,
    required this.localBookNumber,
    required this.bookTitle,
    required this.date,
    required this.expiryDate,
    required this.status,
    required this.statusName,
  });

  @override
  List<Object?> get props => [
    id,
    localBookNumber,
    bookTitle,
    date,
    expiryDate,
    status,
    statusName,
  ];
}
