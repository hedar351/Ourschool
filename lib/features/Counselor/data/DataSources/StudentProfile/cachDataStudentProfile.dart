// abstract class Cachdatastudentprofile {}

// class CachdatastudentprofileImp implements Cachdatastudentprofile {}
import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:school/core/error/EXP.dart';
import 'package:school/features/Counselor/data/Model/StudentsProfileModel/Counselor_studentFullProfileModel.dart';

abstract class CacheDataStudentProfile {
  Future<Unit> cacheStudentProfile(CounselorStudentFullProfileModel model);
  Future<Unit> deleteStudentProfile();
  Future<CounselorStudentFullProfileModel> getCachedStudentProfile(
    int localStudentNumber,
  );
  Stream<CounselorStudentFullProfileModel> watchCachedStudentProfile(
    int localStudentNumber,
  );
}

class CacheDataStudentProfileImp implements CacheDataStudentProfile {
  final Box<CounselorStudentFullProfileModel> box;

  CacheDataStudentProfileImp({required this.box});

  @override
  Future<Unit> cacheStudentProfile(
    CounselorStudentFullProfileModel model,
  ) async {
    final key = model.student?.localStudentNumber.toString() ?? 'unknown';
    await box.put(key, model);
    return unit;
  }

  @override
  Future<Unit> deleteStudentProfile() async {
    await box.clear();
    return unit;
  }

  @override
  Future<CounselorStudentFullProfileModel> getCachedStudentProfile(
    int localStudentNumber,
  ) async {
    final key = localStudentNumber.toString();
    final model = box.get(key);
    if (model == null) throw EmptyCacheExp();
    return model;
  }

  @override
  Stream<CounselorStudentFullProfileModel> watchCachedStudentProfile(
    int localStudentNumber,
  ) {
    final key = localStudentNumber.toString();
    return box
        .watch(key: key)
        .map((event) => event.value as CounselorStudentFullProfileModel);
  }
}
