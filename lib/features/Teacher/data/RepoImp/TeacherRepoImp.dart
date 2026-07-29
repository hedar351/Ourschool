// import 'package:dartz/dartz.dart';
// import 'package:school/core/error/EXP.dart';
// import 'package:school/core/error/failures.dart';
// import 'package:school/core/network.dart';
// import 'package:school/features/Counselor/domain/Entities/StudentsBySectionEntity/StudentsBySectionEntity.dart';
// import 'package:school/features/Teacher/data/dataSources/GetTeacherFullprofile/cacheDataGetTeacherFullprofile.dart';
// import 'package:school/features/Teacher/data/dataSources/GetTeacherFullprofile/remoteDataGetTeacherFullProfile.dart';
// import 'package:school/features/Teacher/data/dataSources/TeacherStudentsList/CacheTeacherStudentsList.dart';
// import 'package:school/features/Teacher/data/dataSources/TeacherStudentsList/RemotedataTeacherStudentsList.dart';
// import 'package:school/features/Teacher/domain/Entities/TeacherProfileEntities/Teacher_fullProfileEntity.dart';
// import 'package:school/features/Teacher/domain/Entities/TeacherStudentProfile/TeacherStudentProfileEntity.dart';
// import 'package:school/features/Teacher/domain/Repo/TeacherRepo.dart';

// class Teacherrepoimp implements Teacherrepo {
//   final RemoteDataTeacherFullProfile remote;
//   final CacheDataTeacherFullProfile cache;
//   final Remotedatateacherstudentslist remoteStudents;
//   final CacheTeacherStudentsList cacheStudents;
//   final NetworkInfo networkInfo;

//   Teacherrepoimp({
//     required this.remote,
//     required this.cache,
//     required this.remoteStudents,
//     required this.cacheStudents,
//     required this.networkInfo,
//   });

//   // ---------- Students by Section & Subject ----------
//   @override
//   Future<Either<Failures, StudentsBySectionEntity>> getStudents(
//     int localGradeNumber,
//     int localSectionNumber,
//     int localSubjectId,
//     int schoolId,
//   ) async {
//     try {
//       final cached = await cacheStudents.getCachedStudents(
//         localGradeNumber,
//         localSectionNumber,
//         localSubjectId,
//         schoolId,
//       );
//       return Right(cached.toEntity());
//     } on EmptyCacheExp {
//       return await _fetchStudentsFromNetworkAndCache(
//         localGradeNumber,
//         localSectionNumber,
//         localSubjectId,
//         schoolId,
//       );
//     }
//   }

//   @override
//   Future<Either<Failures, StudentsBySectionEntity>> getStudentsWithCache(
//     int localGradeNumber,
//     int localSectionNumber,
//     int localSubjectId,
//     int schoolId,
//   ) async {
//     if (await networkInfo.isConnected) {
//       return await _fetchStudentsFromNetworkAndCache(
//         localGradeNumber,
//         localSectionNumber,
//         localSubjectId,
//         schoolId,
//       );
//     } else {
//       return Left(OfflineFailure());
//     }
//   }

//   // ---------- Teacher Full Profile ----------
//   @override
//   Future<Either<Failures, TeacherFullprofileentity>>
//   getTeacherFullprofile() async {
//     try {
//       final cached = await cache.getCachedTeacherFullProfile();
//       return Right(cached.toEntity());
//     } on EmptyCacheExp {
//       return await _fetchFromNetworkAndCache();
//     }
//   }

//   @override
//   Future<Either<Failures, TeacherFullprofileentity>>
//   getTeacherFullprofileWithCache() async {
//     if (await networkInfo.isConnected) {
//       return await _fetchFromNetworkAndCache();
//     } else {
//       return Left(OfflineFailure());
//     }
//   }

//   @override
//   Future<Either<Failures, Teacherstudentprofileentity>>
//   getTeacherStudentsProfile(int localStudentNumber, int schoolId) {
//     // TODO: implement getTeacherStudentsProfile
//     throw UnimplementedError();
//   }

//   @override
//   Future<Either<Failures, Teacherstudentprofileentity>>
//   getTeacherStudentsProfileWithCached(int localStudentNumber, int schoolId) {
//     // TODO: implement getTeacherStudentsProfileWithCached
//     throw UnimplementedError();
//   }

//   @override
//   Stream<StudentsBySectionEntity> watchCachedgetStudents(
//     int localGradeNumber,
//     int localSectionNumber,
//     int localSubjectId,
//     schoolId,
//   ) {
//     return cacheStudents
//         .watchCachedStudents(
//           localGradeNumber,
//           localSectionNumber,
//           localSubjectId,
//           schoolId,
//         )
//         .map((model) => model.toEntity());
//   }

//   @override
//   Stream<TeacherFullprofileentity> watchCachedgetTeacherFullprofile() {
//     return cache.watchCachedTeacherFullProfile().map(
//       (model) => model.toEntity(),
//     );
//   }

//   @override
//   Stream<Teacherstudentprofileentity> watchCacheTeacherStudentsProfile(
//     int localStudentNumber,
//     int schoolId,
//   ) {
//     // TODO: implement watchCacheTeacherStudentsProfile
//     throw UnimplementedError();
//   }

//   Future<Either<Failures, TeacherFullprofileentity>>
//   _fetchFromNetworkAndCache() async {
//     try {
//       final remoted = await remote.getTeacherFullProfile();
//       await cache.cacheTeacherFullProfile(remoted);
//       return Right(remoted.toEntity());
//     } catch (e) {
//       return Left(ServerFailure());
//     }
//   }

//   Future<Either<Failures, StudentsBySectionEntity>>
//   _fetchStudentsFromNetworkAndCache(
//     int localGradeNumber,
//     int localSectionNumber,
//     int localSubjectId,
//     int schoolId,
//   ) async {
//     try {
//       final remoted = await remoteStudents.getStudents(
//         localGradeNumber,
//         localSectionNumber,
//         localSubjectId,
//         schoolId,
//       );
//       await cacheStudents.cacheStudents(
//         localGradeNumber,
//         localSectionNumber,
//         localSubjectId,
//         schoolId,
//         remoted,
//       );
//       return Right(remoted.toEntity());
//     } catch (e) {
//       return Left(ServerFailure());
//     }
//   }
// }
// lib/features/Teacher/data/RepoImp/TeacherRepoImp.dart

// lib/features/Teacher/data/RepoImp/TeacherRepoImp.dart

import 'package:dartz/dartz.dart';
// ======================================================================
// ====== CORE ======
// ======================================================================
import 'package:school/core/error/EXP.dart';
import 'package:school/core/error/failures.dart';
import 'package:school/core/network.dart';
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
// ----- Teacher Student Profile -----
import 'package:school/features/Teacher/data/dataSources/TeacherStudentProfile/CacheTeacherStudentProfile.dart';
import 'package:school/features/Teacher/data/dataSources/TeacherStudentProfile/RemoteTeacherStudentProfile.dart';
// ----- Teacher Students List -----
import 'package:school/features/Teacher/data/dataSources/TeacherStudentsList/CacheTeacherStudentsList.dart';
import 'package:school/features/Teacher/data/dataSources/TeacherStudentsList/RemotedataTeacherStudentsList.dart';
import 'package:school/features/Teacher/domain/Entities/TeacherProfileEntities/Teacher_fullProfileEntity.dart';
import 'package:school/features/Teacher/domain/Entities/TeacherStudentProfile/TeacherStudentProfileEntity.dart';
import 'package:school/features/Teacher/domain/Repo/TeacherRepo.dart';

// ======================================================================
// ====== CLASS IMPLEMENTATION ======
// ======================================================================

class Teacherrepoimp implements Teacherrepo {
  // ====================================================================
  // ====== DEPENDENCIES ======
  // ====================================================================

  // ----- Teacher Full Profile -----
  final RemoteDataTeacherFullProfile remote;
  final CacheDataTeacherFullProfile cache;

  // ----- Teacher Students List -----
  final Remotedatateacherstudentslist remoteStudents;
  final CacheTeacherStudentsList cacheStudents;

  // ----- Teacher Student Profile -----
  final RemoteTeacherStudentProfile remoteStudentProfile;
  final CacheTeacherStudentProfile cacheStudentProfile;

  // ----- Core -----
  final NetworkInfo networkInfo;

  // ====================================================================
  // ====== CONSTRUCTOR ======
  // ====================================================================

  Teacherrepoimp({
    required this.remote,
    required this.cache,
    required this.remoteStudents,
    required this.cacheStudents,
    required this.remoteStudentProfile,
    required this.cacheStudentProfile,
    required this.networkInfo,
  });

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
