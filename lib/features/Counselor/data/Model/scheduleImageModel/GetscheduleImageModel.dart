import 'package:school/features/Counselor/domain/Entities/scheduleImageEntity/GetscheduleImageEntity.dart';

class GetscheduleImageModel extends Getscheduleimageentity {
  const GetscheduleImageModel({
    required super.id,
    required super.imageUrl,
    required super.createdAt,
    required super.gradeName,
    required super.sectionName,
  });

  factory GetscheduleImageModel.fromJson(Map<String, dynamic> json) {
    return GetscheduleImageModel(
      id: json['id'] ?? 0,
      imageUrl: json['imageUrl'] ?? '',
      createdAt: json['createdAt'] ?? '',
      gradeName: json['gradeName'] ?? '',
      sectionName: json['sectionName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'createdAt': createdAt,
      'gradeName': gradeName,
      'sectionName': sectionName,
    };
  }
}
