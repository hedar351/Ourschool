import 'package:equatable/equatable.dart';
import 'package:school/features/Student/domain/entity/Library/reserveBookInfoEntity.dart';

class Reserveentity extends Equatable {
  final String? message;
  final ReserveBookInfoEntity? reserveBookInfo;

  const Reserveentity({required this.message, required this.reserveBookInfo});
  @override
  List<Object?> get props => [message, reserveBookInfo];
}
