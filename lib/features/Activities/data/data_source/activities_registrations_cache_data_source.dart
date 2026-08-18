import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:school/core/error/EXP.dart';
import 'package:school/features/Activities/data/model/activities_registrations_model.dart';

abstract class ActivitiesRegistrationsCacheDataSource {
  Future<void> cacheActivitiesRegistrations(
    ActivitiesRegistrationsModel registrations,
    int activityId,
  );
  Future<void> deleteActivitiesRegistrations(int activityId);
  Future<void> deleteAll();
  Future<ActivitiesRegistrationsModel> getCachedActivitiesRegistrations(
    int activityId,
  );
  Stream<ActivitiesRegistrationsModel?> watchCachedActivitiesRegistrations(
    int activityId,
  );
}

class ActivitiesRegistrationsCacheDataSourceImpl
    implements ActivitiesRegistrationsCacheDataSource {
  static const String _keyPrefix = 'activities_registrations_';
  final Box<ActivitiesRegistrationsModel> box;

  ActivitiesRegistrationsCacheDataSourceImpl({required this.box});

  @override
  Future<void> cacheActivitiesRegistrations(
    ActivitiesRegistrationsModel registrations,
    int activityId,
  ) async {
    final key = _getKey(activityId);
    print(
      ' [Activities Registrations Cache] تخزين التسجيلات في الكاش (المفتاح: $key)',
    );
    await box.put(key, registrations);
    print(' [Activities Registrations Cache] تم التخزين بنجاح');
  }

  @override
  Future<void> deleteActivitiesRegistrations(int activityId) async {
    final key = _getKey(activityId);
    print(
      ' [Activities Registrations Cache] حذف التسجيلات من الكاش (المفتاح: $key)',
    );
    await box.delete(key);
    print(' [Activities Registrations Cache] تم الحذف');
  }

  @override
  Future<Unit> deleteAll() async {
    await box.clear();
    return unit;
  }

  @override
  Future<ActivitiesRegistrationsModel> getCachedActivitiesRegistrations(
    int activityId,
  ) async {
    final key = _getKey(activityId);
    print(
      ' [Activities Registrations Cache] محاولة قراءة التسجيلات من الكاش (المفتاح: $key)',
    );
    final cached = box.get(key);
    if (cached == null) {
      print(' [Activities Registrations Cache] الكاش فارغ');
      throw EmptyCacheExp();
    }
    print(' [Activities Registrations Cache] تم استرجاع التسجيلات من الكاش');
    return cached;
  }

  @override
  Stream<ActivitiesRegistrationsModel?> watchCachedActivitiesRegistrations(
    int activityId,
  ) {
    final key = _getKey(activityId);
    print(
      ' [Activities Registrations Cache] بدء مراقبة التغييرات في الكاش (المفتاح: $key)',
    );
    return box.watch(key: key).map((event) {
      final cached = box.get(key);
      if (cached != null) {
        print(' [Activities Registrations Cache] تغيير في التسجيلات');
      } else {
        print(' [Activities Registrations Cache] الكاش أصبح فارغاً');
      }
      return cached;
    });
  }

  String _getKey(int activityId) => '$_keyPrefix$activityId';
}
