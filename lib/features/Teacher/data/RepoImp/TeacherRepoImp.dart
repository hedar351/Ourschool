import 'package:dartz/dartz.dart';
// ======================================================================
// ====== CORE ======
// ======================================================================
import 'package:school/core/error/EXP.dart';
import 'package:school/core/error/failures.dart';
import 'package:school/core/services/network.dart';
// ======================================================================
// ====== DOMAIN ======
// ======================================================================
import 'package:school/features/Counselor/domain/Entities/StudentsBySectionEntity/StudentsBySectionEntity.dart';
// ======================================================================
// ====== DATA SOURCES ======
// ======================================================================

// ----- Teacher Full Profile -----
import 'package:school/features/Teacher/data/dataSources/GetTeacherFullprofile/cacheDataGetTeacherFullprofile.dart';
import 'package:school/features/Teacher/data/dataSources/GetTeacherFullprofile/remoteDataGetTeacherFullProfile.dart';
import 'package:school/features/Teacher/data/dataSources/Marks/MarksRemoteDataSources.dart';
// ----- Teacher Student Profile -----
import 'package:school/features/Teacher/data/dataSources/TeacherStudentProfile/CacheTeacherStudentProfile.dart';
import 'package:school/features/Teacher/data/dataSources/TeacherStudentProfile/RemoteTeacherStudentProfile.dart';
// ----- Teacher Students List -----
import 'package:school/features/Teacher/data/dataSources/TeacherStudentsList/CacheTeacherStudentsList.dart';
import 'package:school/features/Teacher/data/dataSources/TeacherStudentsList/RemotedataTeacherStudentsList.dart';
import 'package:school/features/Teacher/domain/Entities/TeacherProfileEntities/Teacher_fullProfileEntity.dart';
import 'package:school/features/Teacher/domain/Entities/TeacherStudentProfile/TeacherStudentProfileEntity.dart';
import 'package:school/features/Teacher/domain/Repo/TeacherRepo.dart';

class Teacherrepoimp implements Teacherrepo {
  // ----- Teacher Full Profile -----
  final RemoteDataTeacherFullProfile remote;
  final CacheDataTeacherFullProfile cache;

  // ----- Teacher Students List -----
  final Remotedatateacherstudentslist remoteStudents;
  final CacheTeacherStudentsList cacheStudents;

  // ----- Teacher Student Profile -----
  final RemoteTeacherStudentProfile remoteStudentProfile;
  final CacheTeacherStudentProfile cacheStudentProfile;

  final Marksremotedatasources marksremotedatasources;
  // ----- Core -----
  final NetworkInfo networkInfo;

  Teacherrepoimp({
    required this.remote,
    required this.cache,
    required this.remoteStudents,
    required this.cacheStudents,
    required this.remoteStudentProfile,
    required this.cacheStudentProfile,
    required this.networkInfo,
    required this.marksremotedatasources,
  });

  @override
  Future<Either<Failures, Unit>> addMarks(
    int schoolId,
    int localStudentNumber,
    int localSubjectId,
    int semester,
    int quizTypeId,
    double score,
    double maxScore,
  ) async {
    if (!await networkInfo.isConnected) {
      print(' [Repo] No internet connection');
      return Left(OfflineFailure());
    }

    final remote = await marksremotedatasources.remoteAddMarks(
      schoolId,
      localStudentNumber,
      localSubjectId,
      semester,
      quizTypeId,
      score,
      maxScore,
    );

    return remote.fold(
      (failure) {
        print(' [Repo] Failed to add mark');
        return Left(failure);
      },
      (_) async {
        print(' [Repo] Mark added successfully');
        _fetchStudentProfileFromNetworkAndCache(localStudentNumber, schoolId);
        return const Right(unit);
      },
    );
  }

  @override
  Future<Either<Failures, Unit>> deleteMarks(
    int schoolId,
    int localStudentNumber,
    int localSubjectId,
    int semester,
    int quizTypeId,
  ) async {
    if (!await networkInfo.isConnected) {
      print(' [Repo] No internet connection');
      return Left(OfflineFailure());
    }

    final remote = await marksremotedatasources.remoteDeleteMarks(
      schoolId,
      localStudentNumber,
      localSubjectId,
      semester,
      quizTypeId,
    );

    return remote.fold(
      (failure) {
        print(' [Repo] Failed to delete mark');
        return Left(failure);
      },
      (_) async {
        print(' [Repo] Mark deleted successfully');
        _fetchStudentProfileFromNetworkAndCache(localStudentNumber, schoolId);

        return const Right(unit);
      },
    );
  }

  @override
  Future<Either<Failures, Unit>> editMarks(
    int schoolId,
    int localStudentNumber,
    int localSubjectId,
    int semester,
    int quizTypeId,
    double score,
    double maxScore,
  ) async {
    if (!await networkInfo.isConnected) {
      print(' [Repo] No internet connection');
      return Left(OfflineFailure());
    }

    final remote = await marksremotedatasources.remoteEditMarks(
      schoolId,
      localStudentNumber,
      localSubjectId,
      semester,
      quizTypeId,
      score,
      maxScore,
    );

    return remote.fold(
      (failure) {
        print(' [Repo] Failed to Edit mark');
        return Left(failure);
      },
      (_) async {
        print(' [Repo] Mark Edited successfully');
        _fetchStudentProfileFromNetworkAndCache(localStudentNumber, schoolId);

        return const Right(unit);
      },
    );
  }

  // ====================================================================
  // ====== 1. STUDENTS BY SECTION & SUBJECT ======
  // ====================================================================

  @override
  Future<Either<Failures, StudentsBySectionEntity>> getStudents(
    int localGradeNumber,
    int localSectionNumber,
    int localSubjectId,
    int schoolId,
  ) async {
    try {
      final cached = await cacheStudents.getCachedStudents(
        localGradeNumber,
        localSectionNumber,
        localSubjectId,
        schoolId,
      );
      return Right(cached.toEntity());
    } on EmptyCacheExp {
      return await _fetchStudentsFromNetworkAndCache(
        localGradeNumber,
        localSectionNumber,
        localSubjectId,
        schoolId,
      );
    }
  }

  @override
  Future<Either<Failures, StudentsBySectionEntity>> getStudentsWithCache(
    int localGradeNumber,
    int localSectionNumber,
    int localSubjectId,
    int schoolId,
  ) async {
    if (await networkInfo.isConnected) {
      return await _fetchStudentsFromNetworkAndCache(
        localGradeNumber,
        localSectionNumber,
        localSubjectId,
        schoolId,
      );
    } else {
      return Left(OfflineFailure());
    }
  }

  // ====================================================================
  // ====== 2. TEACHER FULL PROFILE ======
  // ====================================================================

  @override
  Future<Either<Failures, TeacherFullprofileentity>>
  getTeacherFullprofile() async {
    try {
      final cached = await cache.getCachedTeacherFullProfile();
      return Right(cached.toEntity());
    } on EmptyCacheExp {
      return await _fetchFromNetworkAndCache();
    }
  }

  @override
  Future<Either<Failures, TeacherFullprofileentity>>
  getTeacherFullprofileWithCache() async {
    if (await networkInfo.isConnected) {
      return await _fetchFromNetworkAndCache();
    } else {
      return Left(OfflineFailure());
    }
  }

  // ====================================================================
  // ====== 3. TEACHER STUDENT PROFILE ======
  // ====================================================================

  @override
  Future<Either<Failures, Teacherstudentprofileentity>>
  getTeacherStudentsProfile(int localStudentNumber, int schoolId) async {
    try {
      final cachedResult = await cacheStudentProfile
          .getCachedTeacherStudentProfile(localStudentNumber, schoolId);

      return Right(cachedResult.toEntity());
    } on EmptyCacheExp {
      return await _fetchStudentProfileFromNetworkAndCache(
        localStudentNumber,
        schoolId,
      );
    }
  }

  @override
  Future<Either<Failures, Teacherstudentprofileentity>>
  getTeacherStudentsProfileWithCached(
    int localStudentNumber,
    int schoolId,
  ) async {
    if (await networkInfo.isConnected) {
      return await _fetchStudentProfileFromNetworkAndCache(
        localStudentNumber,
        schoolId,
      );
    } else {
      return Left(OfflineFailure());
    }
  }

  // ====================================================================
  // ====== 4. STREAMS (CACHE WATCHERS) ======
  // ====================================================================

  @override
  Stream<StudentsBySectionEntity> watchCachedgetStudents(
    int localGradeNumber,
    int localSectionNumber,
    int localSubjectId,
    int schoolId,
  ) {
    return cacheStudents
        .watchCachedStudents(
          localGradeNumber,
          localSectionNumber,
          localSubjectId,
          schoolId,
        )
        .map((model) => model.toEntity());
  }

  @override
  Stream<TeacherFullprofileentity> watchCachedgetTeacherFullprofile() {
    return cache.watchCachedTeacherFullProfile().map(
      (model) => model.toEntity(),
    );
  }

  @override
  Stream<Teacherstudentprofileentity> watchCacheTeacherStudentsProfile(
    int localStudentNumber,
    int schoolId,
  ) {
    return cacheStudentProfile
        .watchCachedTeacherStudentProfile(localStudentNumber, schoolId)
        .map((model) => model.toEntity());
  }

  // ====================================================================
  // ====== 5. PRIVATE HELPERS ======
  // ====================================================================

  // ----- 5.1 Fetch Teacher Full Profile -----
  Future<Either<Failures, TeacherFullprofileentity>>
  _fetchFromNetworkAndCache() async {
    try {
      final remoted = await remote.getTeacherFullProfile();
      await cache.cacheTeacherFullProfile(remoted);
      return Right(remoted.toEntity());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  // ----- 5.3 Fetch Student Profile -----
  Future<Either<Failures, Teacherstudentprofileentity>>
  _fetchStudentProfileFromNetworkAndCache(
    int localStudentNumber,
    int schoolId,
  ) async {
    try {
      final remoted = await remoteStudentProfile.getTeacherStudentProfile(
        localStudentNumber,
        schoolId,
      );
      await cacheStudentProfile.cacheTeacherStudentProfile(
        localStudentNumber,
        schoolId,
        remoted,
      );
      return Right(remoted.toEntity());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  // ----- 5.2 Fetch Students by Section -----
  Future<Either<Failures, StudentsBySectionEntity>>
  _fetchStudentsFromNetworkAndCache(
    int localGradeNumber,
    int localSectionNumber,
    int localSubjectId,
    int schoolId,
  ) async {
    try {
      final remoted = await remoteStudents.getStudents(
        localGradeNumber,
        localSectionNumber,
        localSubjectId,
        schoolId,
      );
      await cacheStudents.cacheStudents(
        localGradeNumber,
        localSectionNumber,
        localSubjectId,
        schoolId,
        remoted,
      );
      return Right(remoted.toEntity());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
