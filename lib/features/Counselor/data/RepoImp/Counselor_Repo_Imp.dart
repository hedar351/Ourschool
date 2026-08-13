import 'package:dartz/dartz.dart';
import 'package:school/core/error/EXP.dart';
import 'package:school/core/error/failures.dart';
import 'package:school/core/services/network.dart';
import 'package:school/features/Counselor/data/DataSources/Grade/cachedatasource.dart';
import 'package:school/features/Counselor/data/DataSources/Grade/remotdatasource.dart';
import 'package:school/features/Counselor/data/DataSources/PostWarnings/RemotedataPostWarnings.dart';
import 'package:school/features/Counselor/data/DataSources/StudentList/Cachedatasource.dart';
import 'package:school/features/Counselor/data/DataSources/StudentList/RemotedataSource.dart';
import 'package:school/features/Counselor/data/DataSources/StudentProfile/RemoteDataStudentProfile.dart';
import 'package:school/features/Counselor/data/DataSources/StudentProfile/cachDataStudentProfile.dart';
import 'package:school/features/Counselor/data/DataSources/attendance/attendanceRemoteData.dart';
import 'package:school/features/Counselor/data/DataSources/scheduleImage/remoteDataScheduleImage.dart';
import 'package:school/features/Counselor/domain/Entities/StudentsBySectionEntity/StudentsBySectionEntity.dart';
import 'package:school/features/Counselor/domain/Entities/StudentsProfileEntity/Counselor_WarningsEntity.dart';
import 'package:school/features/Counselor/domain/Entities/StudentsProfileEntity/Counselor_studentFullProfile.dart';
import 'package:school/features/Counselor/domain/Entities/gradeandSectionEntity/gradeEntity.dart';
import 'package:school/features/Counselor/domain/Entities/scheduleImageEntity/GetscheduleImageEntity.dart';
import 'package:school/features/Counselor/domain/Repo/CounselorRepo.dart';

class CounselorRepoImp implements CounselorRepo {
  final RemotdatasourceGrade remote;
  final CachedatasourceGrade cache;
  final NetworkInfo networkInfo;
  final RemotedatasourceStudentList remotedatasourceStudentList;
  final CachedatasourceStudentList cachedatasourceStudentList;
  final RemoteDataStudentProfile remoteStudentProfile;
  final CacheDataStudentProfile cacheStudentProfile;
  final Remotedatapostwarnings remotedatapostwarnings;
  final Remotedatascheduleimage remotedatascheduleimage;
  final AttendanceRemoteDataSource attendanceremotedata;
  CounselorRepoImp({
    required this.remote,
    required this.cache,
    required this.networkInfo,
    required this.remotedatasourceStudentList,
    required this.cachedatasourceStudentList,
    required this.remoteStudentProfile,
    required this.cacheStudentProfile,
    required this.remotedatapostwarnings,
    required this.remotedatascheduleimage,
    required this.attendanceremotedata,
  });

  @override
  Future<Either<Failures, Unit>> addAttendance(
    int localStudentNumber,
    String date,
  ) async {
    if (!await networkInfo.isConnected) {
      print('❌ [Repo] No internet connection');
      return Left(OfflineFailure());
    }
    print(
      '🟡 [Repo] Adding attendance for student: $localStudentNumber on $date',
    );
    final result = await attendanceremotedata.addAttendance(
      localStudentNumber,
      date,
    );
    return result.fold(
      (failure) {
        print('❌ [Repo] Failed to add attendance');
        return Left(failure);
      },
      (_) async {
        print('✅ [Repo] Attendance added successfully');

        _fetchStudentProfileFromNetworkAndCache(localStudentNumber);
        return const Right(unit);
      },
    );
  }

  @override
  Future<Either<Failures, Unit>> deleteAttendance(
    int localStudentNumber,
    String date,
  ) async {
    if (!await networkInfo.isConnected) {
      print(' [Repo] No internet connection');
      return Left(OfflineFailure());
    }

    print(
      ' [Repo] Deleting attendance for student: $localStudentNumber on $date',
    );
    final result = await attendanceremotedata.deleteAttendance(
      localStudentNumber,
      date,
    );

    return result.fold(
      (failure) {
        print(' [Repo] Failed to delete attendance');
        return Left(failure);
      },
      (_) async {
        print('✅ [Repo] Attendance deleted successfully from remote');
        _fetchStudentProfileFromNetworkAndCache(localStudentNumber);
        return Right(unit);
      },
    );
  }

  @override
  Future<Either<Failures, CounselorStudentfullprofile>>
  getCounselorStudentfullProfile(int localStudentNumber) async {
    try {
      final cached = await cacheStudentProfile.getCachedStudentProfile(
        localStudentNumber,
      );
      return Right(cached.toEntity());
    } on EmptyCacheExp {
      return await _fetchStudentProfileFromNetworkAndCache(localStudentNumber);
    }
  }

  @override
  Future<Either<Failures, CounselorStudentfullprofile>>
  getCounselorStudentfullProfileWithCache(int localStudentNumber) async {
    if (await networkInfo.isConnected) {
      return await _fetchStudentProfileFromNetworkAndCache(localStudentNumber);
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failures, List<Gradeentity>>> getGradeAndSection() async {
    try {
      final cached = await cache.getCachedgrades();
      return Right(cached.map((e) => e.toEntity()).toList());
    } on EmptyCacheExp {
      return await _fetchFromNetworkAndCache();
    }
  }

  @override
  Future<Either<Failures, List<Gradeentity>>>
  getGradeAndSectionWithCache() async {
    if (await networkInfo.isConnected) {
      return await _fetchFromNetworkAndCache();
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failures, Getscheduleimageentity>> getscheduleImage(
    int localGradeNumber,
    int localSectionNumber,
  ) async {
    try {
      final model = await remotedatascheduleimage.getscheduleImage(
        localGradeNumber,
        localSectionNumber,
      );
      return Right(model);
    } on ServerExp {
      return Left(ServerFailure());
    } on TokenNotFoundExp {
      return Left(EmptyCacheFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failures, StudentsBySectionEntity>> getStudentsBySection(
    int localGradeNumber,
    int localSectionNumber,
  ) async {
    try {
      final cached = await cachedatasourceStudentList
          .getCachedStudentsBySection(localGradeNumber, localSectionNumber);
      return Right(cached.toEntity());
    } on EmptyCacheExp {
      return await _fetchFromNetworkAndCacheStudentsBySection(
        localGradeNumber,
        localSectionNumber,
      );
    }
  }

  @override
  Future<Either<Failures, StudentsBySectionEntity>>
  getStudentsBySectionWithCache(
    int localGradeNumber,
    int localSectionNumber,
  ) async {
    if (await networkInfo.isConnected) {
      return await _fetchFromNetworkAndCacheStudentsBySection(
        localGradeNumber,
        localSectionNumber,
      );
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failures, CounselorWarningsentity>> postWarnings(
    int localStudentNumber,
    String type,
    String reason,
  ) async {
    if (!await networkInfo.isConnected) {
      print('❌ [Repo] No internet connection');
      return Left(OfflineFailure());
    }

    print('🟡 [Repo] Adding warning for student: $localStudentNumber');

    try {
      final warningModel = await remotedatapostwarnings.warnings(
        localStudentNumber,
        type,
        reason,
      );

      print('✅ [Repo] Warning added successfully');

      _fetchStudentProfileFromNetworkAndCache(localStudentNumber);

      return Right(warningModel.toEntity());
    } catch (e) {
      print('❌ [Repo] Failed to add warning: $e');
      return Left(ServerFailure());
    }
  }

  @override
  Stream<CounselorStudentfullprofile> watchCachedgetCounselorStudentfullProfile(
    int localStudentNumber,
  ) {
    return cacheStudentProfile
        .watchCachedStudentProfile(localStudentNumber)
        .map((model) => model.toEntity());
  }

  @override
  Stream<List<Gradeentity>> watchCachedgetGradeAndSection() {
    return cache.watchCachedgrades().map(
      (models) => models.map((e) => e.toEntity()).toList(),
    );
  }

  @override
  Stream<StudentsBySectionEntity> watchCachedgetStudentsBySection(
    int localGradeNumber,
    int localSectionNumber,
  ) {
    return cachedatasourceStudentList
        .watchCachedStudentsBySection(localGradeNumber, localSectionNumber)
        .map((model) => model.toEntity());
  }

  Future<Either<Failures, List<Gradeentity>>>
  _fetchFromNetworkAndCache() async {
    try {
      final remoted = await remote.getGardeAndSection();
      await cache.cachegrades(remoted);
      return Right(remoted.map((e) => e.toEntity()).toList());
    } catch (e) {
      print("❌ Error in _fetchFromNetworkAndCache: $e");

      return Left(ServerFailure());
    }
  }

  Future<Either<Failures, StudentsBySectionEntity>>
  _fetchFromNetworkAndCacheStudentsBySection(
    int localGradeNumber,
    int localSectionNumber,
  ) async {
    try {
      final remoted = await remotedatasourceStudentList.getStudentsBySection(
        localGradeNumber,
        localSectionNumber,
      );
      await cachedatasourceStudentList.cacheStudentsBySection(
        localGradeNumber,
        localSectionNumber,
        remoted,
      );
      return Right(remoted.toEntity());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failures, CounselorStudentfullprofile>>
  _fetchStudentProfileFromNetworkAndCache(int localStudentNumber) async {
    try {
      final remoted = await remoteStudentProfile.getStudentProfile(
        localStudentNumber,
      );
      print("🟢 [Repo] Remote model created: $remoted");
      final entity = remoted.toEntity();
      print("🟢 [Repo] Entity created: $entity");
      await cacheStudentProfile.cacheStudentProfile(remoted);
      return Right(entity);
    } catch (e, stackTrace) {
      print("🔴 [Repo] Error: $e");
      print("🔴 [Repo] Stack trace: $stackTrace");
      return Left(ServerFailure());
    }
  }
}
