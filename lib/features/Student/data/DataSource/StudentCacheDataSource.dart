import 'package:hive/hive.dart';
import 'package:school/core/error/EXP.dart';
import 'package:school/features/Student/data/Model/ProfilrModel/StudentFullProfileModel.dart';

abstract class StudentCacheDataSource {
  Future<void> cacheProfile(StudentFullProfileModel profile);
  Future<void> deleteProfile();
  Future<StudentFullProfileModel> getCachedProfile();
  Stream<StudentFullProfileModel?> watchCachedProfile();
}

class StudentCacheDataSourceImpl implements StudentCacheDataSource {
  static const String _key = 'studentProfile';
  final Box<StudentFullProfileModel> box;

  StudentCacheDataSourceImpl({required this.box});

  @override
  Future<void> cacheProfile(StudentFullProfileModel profile) async {
    print('💾 [Cache] تخزين الملف الشخصي في الكاش (مفتاح: $_key)');
    await box.put(_key, profile);
    print('✅ [Cache] تم التخزين بنجاح');
  }

  @override
  Future<void> deleteProfile() async {
    print('🗑️ [Cache] حذف الملف الشخصي من الكاش');
    await box.delete(_key);
    print('✅ [Cache] تم الحذف');
  }

  @override
  Future<StudentFullProfileModel> getCachedProfile() async {
    print('📂 [Cache] محاولة قراءة الملف الشخصي من الكاش');
    final profile = box.get(_key);
    if (profile == null) {
      print('⚠️ [Cache] الكاش فارغ، رمي EmptyCacheExp');
      throw EmptyCacheExp();
    }
    print('✅ [Cache] تم استرجاع البيانات من الكاش بنجاح');
    return profile;
  }

  @override
  Stream<StudentFullProfileModel?> watchCachedProfile() {
    print('👀 [Cache] بدء مراقبة التغييرات في الكاش');
    return box.watch(key: _key).map((event) {
      print('🔄 [Cache] تغيير في الكاش (مفتاح: ${event.key})');
      final updated = box.get(_key);
      print(
        updated != null
            ? '✅ [Cache] تم استرجاع بيانات محدثة'
            : '⚠️ [Cache] الكاش أصبح فارغاً',
      );
      return updated;
    });
  }
}
