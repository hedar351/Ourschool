import 'package:equatable/equatable.dart';

class Reservations extends Equatable {
  final int? id;
  final int? localBookNumber;
  final String? bookTitle;
  final String? bookAuthor;
  final int? localStudentNumber;
  final String? studentName;
  final String? sectionName;
  final int? localSectionNumber;
  final String? gradeName;
  final int? localGradeNumber;
  final DateTime? date;
  final DateTime? expiryDate;
  final bool? isExpired;
  final String? statusName;

  const Reservations({
    required this.id,
    required this.localBookNumber,
    required this.bookTitle,
    required this.localStudentNumber,
    required this.studentName,
    required this.sectionName,
    required this.localSectionNumber,
    required this.gradeName,
    required this.localGradeNumber,
    required this.date,
    required this.expiryDate,
    required this.isExpired,
    required this.statusName,
    required this.bookAuthor,
  });
  @override
  List<Object?> get props => [
    id,
    localBookNumber,
    bookTitle,
    localStudentNumber,
    studentName,
    sectionName,
    localSectionNumber,
    gradeName,
    localGradeNumber,
    date,
    expiryDate,
    isExpired,
    statusName,
    bookAuthor,
  ];
}
