// lib/features/Library/domain/usecases/get_books_usecase.dart

import 'package:dartz/dartz.dart';
import 'package:school/core/error/failures.dart';
import 'package:school/features/Student/domain/Repo/library_repo.dart';
import 'package:school/features/Student/domain/entity/Library/reserveEntity.dart';

class ReserveBookUseCase {
  final LibraryRepo repository;

  ReserveBookUseCase({required this.repository});

  Future<Either<Failures, Reserveentity>> call(int localBookNumber) async {
    return await repository.reserveBook(localBookNumber);
  }
}
