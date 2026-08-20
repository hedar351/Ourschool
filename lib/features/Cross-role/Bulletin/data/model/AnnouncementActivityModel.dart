import 'package:hive/hive.dart';
import 'package:school/features/Cross-role/Bulletin/domain/Entities/AnnouncementActivityEntity.dart';

part 'AnnouncementActivityModel.g.dart';

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
  @HiveField(4)
  final String schoolName;
  @HiveField(5)
  final String type;
  @HiveField(6)
  // final DateTime? expiryDate;
  AnnouncementActivityModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.schoolName,
    required this.type,
    // required this.expiryDate,
  });

  factory AnnouncementActivityModel.fromEntity(
    Announcementactivityentity entity,
  ) {
    return AnnouncementActivityModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      date: entity.date,
      schoolName: entity.schoolName,
      type: entity.type,
      // expiryDate: entity.expiryDate,
    );
  }

  factory AnnouncementActivityModel.fromJson(Map<String, dynamic> json) {
    return AnnouncementActivityModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      date: DateTime.parse(json['date']),
      schoolName: json['schoolName'],
      type: json['type'],
      // expiryDate: DateTime.parse(json['expiryDate']),
    );
  }

  Announcementactivityentity toEntity() {
    return Announcementactivityentity(
      id: id,
      title: title,
      description: description,
      date: date,
      schoolName: schoolName,
      type: type,
      // expiryDate: expiryDate,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date,
      'schoolName': schoolName,
      'type': type,
      // 'expiryDate': expiryDate,
    };
  }
}
