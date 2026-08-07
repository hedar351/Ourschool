import 'package:dartz/dartz.dart';
import 'package:school/core/error/failures.dart';
import 'package:school/features/Student/domain/Repo/library_repo.dart';
import 'package:school/features/Student/domain/entity/Library/reservations.dart';

class Getreservebookusecase {
  final LibraryRepo repository;

  Getreservebookusecase({required this.repository});

  Future<Either<Failures, Reservations>> call() async {
    return await repository.getReserveBook();
  }
}
