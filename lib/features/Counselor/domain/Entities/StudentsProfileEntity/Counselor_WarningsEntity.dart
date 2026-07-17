import 'package:equatable/equatable.dart';

class CounselorWarningsentity extends Equatable {
  final int? id;
  final String? type;
  final String? reason;
  final String? createdAt;

  const CounselorWarningsentity({
    required this.id,
    required this.type,
    required this.reason,
    required this.createdAt,
  });
  @override
  List<Object?> get props => [id, type, reason, createdAt];
}
