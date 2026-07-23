import 'package:equatable/equatable.dart';

class Getscheduleimageentity extends Equatable {
  final int? id;
  final String imageUrl;
  final String? createdAt;
  final String? gradeName;
  final String? sectionName;
  const Getscheduleimageentity({
    required this.id,
    required this.imageUrl,
    required this.createdAt,
    required this.gradeName,
    required this.sectionName,
  });

  @override
  List<Object?> get props => [id, imageUrl, createdAt, gradeName, sectionName];
}
