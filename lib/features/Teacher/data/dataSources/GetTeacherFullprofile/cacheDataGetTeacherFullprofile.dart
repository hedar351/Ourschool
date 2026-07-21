import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:school/core/error/EXP.dart';
import 'package:school/features/Teacher/data/Model/TeacherFullProfileModel.dart';

abstract class CacheDataTeacherFullProfile {
  Future<Unit> cacheTeacherFullProfile(TeacherFullProfileModel model);
  Future<Unit> deleteTeacherFullProfile();
  Future<TeacherFullProfileModel> getCachedTeacherFullProfile();
  Stream<TeacherFullProfileModel> watchCachedTeacherFullProfile();
}

class CacheDataTeacherFullProfileImp implements CacheDataTeacherFullProfile {
  final Box<TeacherFullProfileModel> box;
  final key = 'teacher_full_profile';

  CacheDataTeacherFullProfileImp({required this.box});

  @override
  Future<Unit> cacheTeacherFullProfile(TeacherFullProfileModel model) async {
    await box.put(key, model);
    return unit;
  }

  @override
  Future<Unit> deleteTeacherFullProfile() async {
    await box.clear();
    return unit;
  }

  @override
  Future<TeacherFullProfileModel> getCachedTeacherFullProfile() async {
    final model = box.get(key);
    if (model == null) throw EmptyCacheExp();
    return model;
  }

  @override
  Stream<TeacherFullProfileModel> watchCachedTeacherFullProfile() {
    return box
        .watch(key: key)
        .map((event) => event.value as TeacherFullProfileModel);
  }
}
