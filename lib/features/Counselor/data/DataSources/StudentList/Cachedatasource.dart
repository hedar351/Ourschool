import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:school/core/error/EXP.dart';
import 'package:school/features/Counselor/data/Model/StudentsBySectionModel/StudentsBySectionModel.dart';

// abstract class CachedatasourceStudentList {
//   Future<Unit> cacheStudentsBySection(Studentsbysectionmodel model);
//   Future<Unit> deleteStudentsBySection();
//   Future<Studentsbysectionmodel> getCachedStudentsBySection();
//   Stream<Studentsbysectionmodel> watchCachedStudentsBySection();
// }

abstract class CachedatasourceStudentList {
  Future<Unit> cacheStudentsBySection(
    int localGradeNumber,
    int localSectionNumber,
    Studentsbysectionmodel model,
  );
  Future<Unit> deleteStudentsBySection();
  Future<Studentsbysectionmodel> getCachedStudentsBySection(
    int localGradeNumber,
    int localSectionNumber,
  );
  Stream<Studentsbysectionmodel> watchCachedStudentsBySection(
    int localGradeNumber,
    int localSectionNumber,
  );
}

class CachedatasourceStudentListImp implements CachedatasourceStudentList {
  final Box<Studentsbysectionmodel> box;

  CachedatasourceStudentListImp({required this.box});

  @override
  Future<Unit> cacheStudentsBySection(
    int localGradeNumber,
    int localSectionNumber,
    Studentsbysectionmodel model,
  ) async {
    final key = '${localGradeNumber}_$localSectionNumber';
    await box.put(key, model);
    return unit;
  }

  @override
  Future<Unit> deleteStudentsBySection() async {
    await box.clear();
    return unit;
  }

  @override
  Future<Studentsbysectionmodel> getCachedStudentsBySection(
    int localGradeNumber,
    int localSectionNumber,
  ) async {
    final key = '${localGradeNumber}_$localSectionNumber';
    final model = box.get(key);
    if (model == null) throw EmptyCacheExp();
    return model;
  }

  @override
  Stream<Studentsbysectionmodel> watchCachedStudentsBySection(
    int localGradeNumber,
    int localSectionNumber,
  ) {
    final key = '${localGradeNumber}_$localSectionNumber';
    return box
        .watch(key: key)
        .map((event) => event.value as Studentsbysectionmodel);
  }
}
