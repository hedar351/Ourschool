import 'package:hive/hive.dart';
import 'package:school/features/BulletinScreen/domain/Entities/AnnouncementActivityEntity.dart';

@HiveType(typeId: 0)
class AnnouncementActivityModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final DateTime date;

  AnnouncementActivityModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
  });

  factory AnnouncementActivityModel.fromEntity(
    Announcementactivityentity entity,
  ) {
    return AnnouncementActivityModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      date: entity.date,
    );
  }

  factory AnnouncementActivityModel.fromJson(Map<String, dynamic> json) {
    return AnnouncementActivityModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      date: DateTime.parse(json['date']),
    );
  }

  Announcementactivityentity toEntity() {
    return Announcementactivityentity(
      id: id,
      title: title,
      description: description,
      date: date,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'description': description, 'date': date};
  }
}
