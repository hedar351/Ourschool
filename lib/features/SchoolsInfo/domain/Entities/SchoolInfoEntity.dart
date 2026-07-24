import 'package:equatable/equatable.dart';
import 'package:school/features/SchoolsInfo/domain/Entities/TeacherInfoEntity.dart';

class SchoolInfoEntity extends Equatable {
  final int? id;
  final String? name;
  final String? typename;
  final String? address;
  final String? phone;
  final List<TeacherInfoEntity>? teacherInfo;

  const SchoolInfoEntity({
    required this.id,
    required this.name,
    required this.typename,
    required this.address,
    required this.phone,
    required this.teacherInfo,
  });

  @override
  List<Object?> get props => [id, name, typename, address, phone, teacherInfo];
}
