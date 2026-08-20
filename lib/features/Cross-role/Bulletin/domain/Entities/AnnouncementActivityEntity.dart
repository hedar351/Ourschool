import 'package:equatable/equatable.dart';

class Announcementactivityentity extends Equatable {
  final int id;
  final String title;
  final String description;
  final DateTime date;
  // final DateTime? expiryDate;

  final String schoolName;
  final String type;
  const Announcementactivityentity({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.schoolName,
    required this.type,
    // required this.expiryDate,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    date,
    schoolName,
    type,
    // expiryDate,
  ];
}
