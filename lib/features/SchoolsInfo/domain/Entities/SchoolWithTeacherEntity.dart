import 'package:equatable/equatable.dart';
import 'package:school/features/SchoolsInfo/domain/Entities/SchoolInfoEntity.dart';

class Schoolwithteacherentity extends Equatable {
  final String? message;
  final List<SchoolInfoEntity>? schoolInfo;

  const Schoolwithteacherentity({
    required this.message,
    required this.schoolInfo,
  });

  @override
  List<Object?> get props => [message, schoolInfo];
}
