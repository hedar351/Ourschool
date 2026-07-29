import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:school/core/error/EXP.dart';
import 'package:school/features/Counselor/data/Model/StudentsBySectionModel/StudentsBySectionModel.dart';

abstract class CacheTeacherStudentsList {
  Future<Unit> cacheStudents(
    int localGradeNumber,
    int localSectionNumber,
    int localSubjectId,
    int schoolId,
    Studentsbysectionmodel model,
  );
  Future<Unit> deleteStudents();
  Future<Studentsbysectionmodel> getCachedStudents(
    int localGradeNumber,
    int localSectionNumber,
    int localSubjectId,
    int schoolId,
  );
  Stream<Studentsbysectionmodel> watchCachedStudents(
    int localGradeNumber,
    int localSectionNumber,
    int localSubjectId,
    int schoolId,
  );
}

class CacheTeacherStudentsListImp implements CacheTeacherStudentsList {
  final Box<Studentsbysectionmodel> box;

  CacheTeacherStudentsListImp({required this.box});

  @override
  Future<Unit> cacheStudents(
    int localGradeNumber,
    int localSectionNumber,
    int localSubjectId,
    int schoolId,

    Studentsbysectionmodel model,
  ) async {
    final key =
        '${localGradeNumber}_${localSectionNumber}_${localSubjectId}_$schoolId';
    await box.put(key, model);
    return unit;
  }

  @override
  Future<Unit> deleteStudents() async {
    await box.clear();
    return unit;
  }

  @override
  Future<Studentsbysectionmodel> getCachedStudents(
    int localGradeNumber,
    int localSectionNumber,
    int localSubjectId,
    int schoolId,
  ) async {
    final key =
        '${localGradeNumber}_${localSectionNumber}_${localSubjectId}_$schoolId';
    final model = box.get(key);
    if (model == null) throw EmptyCacheExp();
    return model;
  }

  @override
  Stream<Studentsbysectionmodel> watchCachedStudents(
    int localGradeNumber,
    int localSectionNumber,
    int localSubjectId,
    int schoolId,
  ) {
    final key =
        '${localGradeNumber}_${localSectionNumber}_${localSubjectId}_$schoolId';
    return box
        .watch(key: key)
        .map((event) => event.value as Studentsbysectionmodel);
  }
}
