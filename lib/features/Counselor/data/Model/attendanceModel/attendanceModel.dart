import 'package:hive_flutter/adapters.dart';

import '../../../domain/Entities/attendanceEntity/attendanceEntity.dart';

part 'attendanceModel.g.dart';

@HiveType(typeId: 19)
class Attendancemodel extends HiveObject {
  @HiveField(0)
  final String? date;
  @HiveField(1)
  final String? status;

  Attendancemodel({required this.date, required this.status});

  factory Attendancemodel.fromEntity(AttendanceEntity entity) {
    return Attendancemodel(date: entity.date, status: entity.status);
  }

  factory Attendancemodel.fromJson(Map<String, dynamic> json) {
    return Attendancemodel(date: json['date'], status: json['status']);
  }

  AttendanceEntity toEntity() {
    return AttendanceEntity(date: date, status: status);
  }

  Map<String, dynamic> toJson() {
    return {'date': date, 'status': status};
  }
}
