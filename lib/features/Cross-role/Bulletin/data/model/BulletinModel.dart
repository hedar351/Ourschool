import 'package:hive/hive.dart';
import 'package:school/features/Cross-role/Bulletin/data/model/AnnouncementActivityModel.dart';
import 'package:school/features/Cross-role/Bulletin/domain/Entities/BulletinEntity.dart';

part 'BulletinModel.g.dart';

@HiveType(typeId: 1)
class Bulletinmodel extends HiveObject {
  @HiveField(0)
  final String message;
  @HiveField(1)
  final List<AnnouncementActivityModel>? announcements;
  @HiveField(2)
  final List<AnnouncementActivityModel>? activities;

  Bulletinmodel({
    required this.message,
    required this.announcements,
    required this.activities,
  });

  factory Bulletinmodel.fromEntity(BulletinEntity entity) {
    return Bulletinmodel(
      message: entity.message,
      announcements:
          entity.announcements
              ?.map((e) => AnnouncementActivityModel.fromEntity(e))
              .toList() ??
          [],
      activities:
          entity.activities
              ?.map((e) => AnnouncementActivityModel.fromEntity(e))
              .toList() ??
          [],
    );
  }

  factory Bulletinmodel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? {};

    var announcementsJson = data['announcements'] as List? ?? [];
    var activitiesJson = data['activities'] as List? ?? [];

    return Bulletinmodel(
      message: json['message'] ?? '',
      announcements: announcementsJson
          .map((e) => AnnouncementActivityModel.fromJson(e))
          .toList(),
      activities: activitiesJson
          .map((e) => AnnouncementActivityModel.fromJson(e))
          .toList(),
    );
  }

  // من Model إلى Entity
  BulletinEntity toEntity() {
    return BulletinEntity(
      message: message,
      announcements: announcements?.map((e) => e.toEntity()).toList(),
      activities: activities?.map((e) => e.toEntity()).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'announcements': announcements?.map((e) => e.toJson()).toList(),
      'activities': activities?.map((e) => e.toJson()).toList(),
    };
  }
}
