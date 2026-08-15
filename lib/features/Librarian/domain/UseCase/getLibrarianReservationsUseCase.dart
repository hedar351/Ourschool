// lib/features/Librarian/domain/usecases/get_librarian_reservations_usecase.dart

import 'package:dartz/dartz.dart';
import 'package:school/core/error/failures.dart';
import 'package:school/features/Librarian/domain/Entity/general_entity/librarian_reservations_Entity.dart';
import 'package:school/features/Librarian/domain/Repo/Librarian_Repo.dart';

class GetLibrarianReservationsUseCase {
  final LibrarianRepo repository;

  GetLibrarianReservationsUseCase({required this.repository});

  Future<Either<Failures, LibrarianReservationsEntity>> call(
    String status,
  ) async {
    return await repository.getLibrarianReservations(status);
  }
}
