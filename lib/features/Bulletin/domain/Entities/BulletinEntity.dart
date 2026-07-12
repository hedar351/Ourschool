import 'package:equatable/equatable.dart';
import 'package:school/features/Bulletin/domain/Entities/AnnouncementActivityEntity.dart';

class BulletinEntity extends Equatable {
  final String message;
  final List<Announcementactivityentity>? announcements;
  final List<Announcementactivityentity>? activities;

  const BulletinEntity({
    required this.message,
    required this.announcements,
    required this.activities,
  });

  @override
  List<Object?> get props => [message, announcements, activities];
}
