import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:school/core/error/EXP.dart';
import 'package:school/features/Counselor/data/Model/gradeandSectionModel/gradeModel.dart';

abstract class Cachedatasource {
  Future<Unit> cachegrades(List<GradeModel> grade);
  Future<Unit> deletegrades();
  Future<List<GradeModel>> getCachedgrades();
  Stream<List<GradeModel>> watchCachedgrades();
}

class CachedatasourceImp extends Cachedatasource {
  final Box<GradeModel> boxGrade;

  CachedatasourceImp({required this.boxGrade});

  @override
  Future<Unit> cachegrades(List<GradeModel> grade) async {
    await boxGrade.clear();
    await boxGrade.addAll(grade);
    return unit;
  }

  @override
  Future<Unit> deletegrades() async {
    await boxGrade.clear();
    return unit;
  }

  @override
  Future<List<GradeModel>> getCachedgrades() async {
    if (boxGrade.isEmpty) {
      throw EmptyCacheExp();
    }
    return boxGrade.values.toList();
  }

  @override
  Stream<List<GradeModel>> watchCachedgrades() {
    return boxGrade.watch().map((event) => boxGrade.values.toList());
  }
}
