import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:school/core/error/EXP.dart';
import 'package:school/features/Counselor/data/Model/StudentsBySectionModel/StudentsBySectionModel.dart';

abstract class CachedatasourceStudentList {
  Future<Unit> cacheStudentsBySection(Studentsbysectionmodel model);
  Future<Unit> deleteStudentsBySection();
  Future<Studentsbysectionmodel> getCachedStudentsBySection();
  Stream<Studentsbysectionmodel> watchCachedStudentsBySection();
}

class CachedatasourceStudentListImp implements CachedatasourceStudentList {
  final Box<Studentsbysectionmodel> box;

  CachedatasourceStudentListImp({required this.box});

  @override
  Future<Unit> cacheStudentsBySection(Studentsbysectionmodel model) async {
    await box.clear();
    await box.add(model);
    return unit;
  }

  @override
  Future<Unit> deleteStudentsBySection() async {
    await box.clear();
    return unit;
  }

  @override
  Future<Studentsbysectionmodel> getCachedStudentsBySection() async {
    if (box.isEmpty) {
      throw EmptyCacheExp();
    }
    return box.values.first;
  }

  @override
  Stream<Studentsbysectionmodel> watchCachedStudentsBySection() {
    return box.watch().map((event) => box.values.first);
  }
}
