import 'package:equatable/equatable.dart';

class Announcementactivityentity extends Equatable {
  final int id;
  final String title;
  final String description;
  final DateTime date;

  const Announcementactivityentity({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
  });

  @override
  List<Object?> get props => [id, title, description, date];
}
