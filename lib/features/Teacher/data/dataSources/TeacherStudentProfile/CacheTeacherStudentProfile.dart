// // lib/features/Teacher/data/dataSources/TeacherStudentProfile/cacheTeacherStudentProfile.dart

import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:school/core/error/EXP.dart';
import 'package:school/features/Teacher/data/Model/TeacherStudentProfileModel/TeacherStudentProfileModel.dart';

abstract class CacheTeacherStudentProfile {
  // ====== تخزين الكاش ======
  Future<Unit> cacheTeacherStudentProfile(
    int localStudentNumber,
    int schoolId,
    TeacherStudentProfileModel profile,
  );

  Future<Unit> deleteCachedTeacherStudentProfile();

  // ====== جلب الكاش ======
  Future<TeacherStudentProfileModel> getCachedTeacherStudentProfile(
    int localStudentNumber,
    int schoolId,
  );

  // ====== مراقبة الكاش (تحديث حي) ======
  Stream<TeacherStudentProfileModel> watchCachedTeacherStudentProfile(
    int localStudentNumber,
    int schoolId,
  );
}

class CacheTeacherStudentProfileImpl implements CacheTeacherStudentProfile {
  final Box<TeacherStudentProfileModel> box;

  CacheTeacherStudentProfileImpl({required this.box});

  @override
  Future<Unit> cacheTeacherStudentProfile(
    int localStudentNumber,
    int schoolId,
    TeacherStudentProfileModel profile,
  ) async {
    final key = _getKey(localStudentNumber, schoolId);
    await box.put(key, profile);
    return unit;
  }

  // ====== 🆕 حذف الكاش ======
  @override
  Future<Unit> deleteCachedTeacherStudentProfile() async {
    // final key = _getKey(localStudentNumber, schoolId);
    await box.clear();
    // print('🗑️ [Cache] Deleted teacher student profile: $key');
    return unit;
  }

  @override
  Future<TeacherStudentProfileModel> getCachedTeacherStudentProfile(
    int localStudentNumber,
    int schoolId,
  ) async {
    final key = _getKey(localStudentNumber, schoolId);
    final cached = box.get(key);
    if (cached == null) {
      throw EmptyCacheExp();
    }
    return cached;
  }

  @override
  Stream<TeacherStudentProfileModel> watchCachedTeacherStudentProfile(
    int localStudentNumber,
    int schoolId,
  ) {
    final key = _getKey(localStudentNumber, schoolId);
    return box.watch(key: key).map((event) {
      final value = box.get(key);
      if (value == null) {
        throw EmptyCacheExp();
      }
      return value;
    });
  }

  // ====== دالة مساعدة لتوليد المفتاح ======
  String _getKey(int localStudentNumber, int schoolId) {
    return 'teacher_student_${localStudentNumber}_$schoolId';
  }
}
