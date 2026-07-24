// lib/features/SchoolsInfo/data/datasources/school_cache_ds.dart

import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:school/core/error/EXP.dart';
import 'package:school/features/SchoolsInfo/data/models/SchoolWithTeacherModel.dart';

abstract class SchoolCacheDataSource {
  Future<Unit> cacheSchools(SchoolWithTeacherModel schools);
  Future<Unit> deleteSchools();
  Future<SchoolWithTeacherModel> getCachedSchools();
  Stream<SchoolWithTeacherModel> watchCachedSchools();
}

class SchoolCacheDataSourceImpl implements SchoolCacheDataSource {
  static const String _cacheKey = 'public_schools_data';

  final Box<SchoolWithTeacherModel> box;

  SchoolCacheDataSourceImpl({required this.box});

  @override
  Future<Unit> cacheSchools(SchoolWithTeacherModel schools) async {
    await box.put(_cacheKey, schools);
    print('✅ [Cache] Public schools cached successfully');
    return unit;
  }

  @override
  Future<Unit> deleteSchools() async {
    await box.delete(_cacheKey);
    print('🗑️ [Cache] Public schools deleted');
    return unit;
  }

  @override
  Future<SchoolWithTeacherModel> getCachedSchools() async {
    final cached = box.get(_cacheKey);
    if (cached == null) {
      print('⚠️ [Cache] No public schools cached');
      throw EmptyCacheExp();
    }
    print('✅ [Cache] Retrieved public schools from cache');
    return cached;
  }

  @override
  Stream<SchoolWithTeacherModel> watchCachedSchools() {
    return box.watch(key: _cacheKey).map((event) {
      final value = box.get(_cacheKey);
      if (value == null) {
        throw EmptyCacheExp();
      }
      return value;
    });
  }
}
