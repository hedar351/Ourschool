// lib/features/Librarian/domain/usecases/get_librarian_loans_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:school/core/error/failures.dart';
import 'package:school/features/Librarian/domain/Entity/general_entity/librarian_loans_Entity.dart';
import 'package:school/features/Librarian/domain/Repo/Librarian_Repo.dart';

class GetLibrarianLoansUsecase {
  final LibrarianRepo repository;

  GetLibrarianLoansUsecase({required this.repository});

  Future<Either<Failures, LibrarianLoansEntity>> call() async {
    return await repository.getLibrarianLeons();
  }
}
