import 'package:equatable/equatable.dart';

class SummonsEntity extends Equatable {
  final String? reason;

  final String? date;

  final String? createdAt;

  const SummonsEntity({
    required this.reason,
    required this.date,
    required this.createdAt,
  });
  @override
  List<Object?> get props => [reason, date, createdAt];
}
