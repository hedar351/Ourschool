import 'package:dartz/dartz.dart';
import 'package:school/core/error/EXP.dart';
import 'package:school/core/error/failures.dart';
import 'package:school/core/services/network.dart';
import 'package:school/features/Student/data/DataSource/StudentCacheDataSource.dart';
import 'package:school/features/Student/data/DataSource/StudentRemoteDataSource.dart';
import 'package:school/features/Student/domain/Repo/StudentRepo.dart';
import 'package:school/features/Student/domain/entity/Student-FullProfile/StudentFullProfileEntity.dart';

class StudentRepoImp implements StudentRepo {
  final StudentRemoteDataSource remote;
  final StudentCacheDataSource cache;
  final NetworkInfo networkInfo;

  StudentRepoImp({
    required this.remote,
    required this.cache,
    required this.networkInfo,
  });

  @override
  Future<Either<Failures, Unit>> deleteRegister(int activityId) async {
    print(
      '� [Repo] deleteRegister() - إلغاء التسجيل في النشاط رقم $activityId',
    );

    if (!await networkInfo.isConnected) {
      print('🔴 [Repo] لا يوجد اتصال بالإنترنت');
      return Left(OfflineFailure());
    }

    try {
      await remote.deleteRegister(activityId);
      print(' [Repo] تم إلغاء التسجيل بنجاح');
      await _fetchFromNetworkAndCache();
      return const Right(unit);
    } catch (e) {
      print('🔴 [Repo] فشل إلغاء التسجيل: $e');
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failures, List<Studentfullprofileentity>>>
  getFullprofile() async {
    print(' [Repo] getFullprofile() - محاولة القراءة من الكاش أولاً');
    try {
      final cached = await cache.getCachedProfile();
      print(' [Repo] تم إرجاع البيانات من الكاش');
      return Right([cached.toEntity()]);
    } on EmptyCacheExp {
      print(' [Repo] الكاش فارغ، التوجه للشبكة');
      return await _fetchFromNetworkAndCache();
    } catch (e) {
      print('🔴 [Repo] خطأ غير متوقع في الكاش: $e');
      return Left(EmptyCacheFailure());
    }
  }

  @override
  Future<Either<Failures, List<Studentfullprofileentity>>>
  getFullprofileWithCached() async {
    print(' [Repo] getFullprofileWithCached() - التحقق من الاتصال');
    final isConnected = await networkInfo.isConnected;
    print(isConnected ? ' [Repo] متصل بالإنترنت' : ' [Repo] غير متصل');
    if (isConnected) {
      return await _fetchFromNetworkAndCache();
    } else {
      print('🔴 [Repo] لا يوجد اتصال، إرجاع OfflineFailure');
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failures, Unit>> register(int activityId) async {
    print(' [Repo] register() - التسجيل في النشاط رقم $activityId');

    if (!await networkInfo.isConnected) {
      print('🔴 [Repo] لا يوجد اتصال بالإنترنت');
      return Left(OfflineFailure());
    }

    try {
      await remote.register(activityId);
      print(' [Repo] تم التسجيل بنجاح');
      await _fetchFromNetworkAndCache();
      return const Right(unit);
    } catch (e) {
      print('🔴 [Repo] فشل التسجيل: $e');
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Stream<Either<Failures, List<Studentfullprofileentity>>>
  watchStudentProfile() {
    print(' [Repo] بدء مراقبة الكاش (Stream)');
    return cache.watchCachedProfile().map((model) {
      if (model != null) {
        print(' [Repo] Stream: استلام بيانات من الكاش');
        return Right([model.toEntity()]);
      } else {
        print(' [Repo] Stream: الكاش فارغ');
        return Left(EmptyCacheFailure());
      }
    });
  }

  // ---- Helper ----
  Future<Either<Failures, List<Studentfullprofileentity>>>
  _fetchFromNetworkAndCache() async {
    print(' [Repo] _fetchFromNetworkAndCache() - جلب من الشبكة');
    try {
      final remoteProfile = await remote.getFullProfile();
      print('[Repo] تم جلب البيانات من الشبكة بنجاح');
      await cache.cacheProfile(remoteProfile);
      print(' [Repo] تم تخزين البيانات في الكاش');
      return Right([remoteProfile.toEntity()]);
    } catch (e) {
      print('🔴 [Repo] فشل جلب البيانات من الشبكة: $e');
      return Left(ServerFailure());
    }
  }
}
