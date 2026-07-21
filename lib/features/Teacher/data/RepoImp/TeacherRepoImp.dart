// import 'package:dartz/dartz.dart';
// import 'package:school/core/error/EXP.dart';
// import 'package:school/core/error/failures.dart';
// import 'package:school/core/network.dart';
// import 'package:school/features/Counselor/domain/Entities/StudentsBySectionEntity/StudentsBySectionEntity.dart';
// import 'package:school/features/Teacher/data/dataSources/GetTeacherFullprofile/cacheDataGetTeacherFullprofile.dart';
// import 'package:school/features/Teacher/data/dataSources/GetTeacherFullprofile/remoteDataGetTeacherFullProfile.dart';
// import 'package:school/features/Teacher/domain/Entities/TeacherProfileEntities/Teacher_fullProfileEntity.dart';
// import 'package:school/features/Teacher/domain/Repo/TeacherRepo.dart';

// class Teacherrepoimp implements Teacherrepo {
//   final RemoteDataTeacherFullProfile remote;
//   final CacheDataTeacherFullProfile cache;
//   final NetworkInfo networkInfo;

//   Teacherrepoimp({
//     required this.remote,
//     required this.cache,
//     required this.networkInfo,
//   });

//   @override
//   Future<Either<Failures, StudentsBySectionEntity>> getStudents(
//     int localGradeNumber,
//     int localSectionNumber,
//     int localSubjectId,
//   ) {
//     // TODO: implement getStudents
//     throw UnimplementedError();
//   }

//   @override
//   Future<Either<Failures, StudentsBySectionEntity>> getStudentsWithCache(
//     int localGradeNumber,
//     int localSectionNumber,
//     int localSubjectId,
//   ) {
//     // TODO: implement getStudentsWithCache
//     throw UnimplementedError();
//   }

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
//   Stream<StudentsBySectionEntity> watchCachedgetStudents(
//     int localGradeNumber,
//     int localSectionNumber,
//     int localSubjectId,
//   ) {
//     return cache
//         .watchCachedStudents(
//           localGradeNumber,
//           localSectionNumber,
//           localSubjectId,
//         )
//         .map((model) => model.toEntity());
//   }

//   @override
//   Stream<TeacherFullprofileentity> watchCachedgetTeacherFullprofile() {
//     return cache.watchCachedTeacherFullProfile().map(
//       (model) => model.toEntity(),
//     );
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
// }
import 'package:dartz/dartz.dart';
import 'package:school/core/error/EXP.dart';
import 'package:school/core/error/failures.dart';
import 'package:school/core/network.dart';
import 'package:school/features/Counselor/domain/Entities/StudentsBySectionEntity/StudentsBySectionEntity.dart';
import 'package:school/features/Teacher/data/dataSources/GetTeacherFullprofile/cacheDataGetTeacherFullprofile.dart';
import 'package:school/features/Teacher/data/dataSources/GetTeacherFullprofile/remoteDataGetTeacherFullProfile.dart';
import 'package:school/features/Teacher/data/dataSources/TeacherStudentsList/CacheTeacherStudentsList.dart';
import 'package:school/features/Teacher/data/dataSources/TeacherStudentsList/RemotedataTeacherStudentsList.dart';
import 'package:school/features/Teacher/domain/Entities/TeacherProfileEntities/Teacher_fullProfileEntity.dart';
import 'package:school/features/Teacher/domain/Repo/TeacherRepo.dart';

class Teacherrepoimp implements Teacherrepo {
  final RemoteDataTeacherFullProfile remote;
  final CacheDataTeacherFullProfile cache;
  final Remotedatateacherstudentslist remoteStudents;
  final CacheTeacherStudentsList cacheStudents;
  final NetworkInfo networkInfo;

  Teacherrepoimp({
    required this.remote,
    required this.cache,
    required this.remoteStudents,
    required this.cacheStudents,
    required this.networkInfo,
  });

  // ---------- Students by Section & Subject ----------
  @override
  Future<Either<Failures, StudentsBySectionEntity>> getStudents(
    int localGradeNumber,
    int localSectionNumber,
    int localSubjectId,
  ) async {
    try {
      final cached = await cacheStudents.getCachedStudents(
        localGradeNumber,
        localSectionNumber,
        localSubjectId,
      );
      return Right(cached.toEntity());
    } on EmptyCacheExp {
      return await _fetchStudentsFromNetworkAndCache(
        localGradeNumber,
        localSectionNumber,
        localSubjectId,
      );
    }
  }

  @override
  Future<Either<Failures, StudentsBySectionEntity>> getStudentsWithCache(
    int localGradeNumber,
    int localSectionNumber,
    int localSubjectId,
  ) async {
    if (await networkInfo.isConnected) {
      return await _fetchStudentsFromNetworkAndCache(
        localGradeNumber,
        localSectionNumber,
        localSubjectId,
      );
    } else {
      return Left(OfflineFailure());
    }
  }

  // ---------- Teacher Full Profile ----------
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

  @override
  Stream<StudentsBySectionEntity> watchCachedgetStudents(
    int localGradeNumber,
    int localSectionNumber,
    int localSubjectId,
  ) {
    return cacheStudents
        .watchCachedStudents(
          localGradeNumber,
          localSectionNumber,
          localSubjectId,
        )
        .map((model) => model.toEntity());
  }

  @override
  Stream<TeacherFullprofileentity> watchCachedgetTeacherFullprofile() {
    return cache.watchCachedTeacherFullProfile().map(
      (model) => model.toEntity(),
    );
  }

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

  Future<Either<Failures, StudentsBySectionEntity>>
  _fetchStudentsFromNetworkAndCache(
    int localGradeNumber,
    int localSectionNumber,
    int localSubjectId,
  ) async {
    try {
      final remoted = await remoteStudents.getStudents(
        localGradeNumber,
        localSectionNumber,
        localSubjectId,
      );
      await cacheStudents.cacheStudents(
        localGradeNumber,
        localSectionNumber,
        localSubjectId,
        remoted,
      );
      return Right(remoted.toEntity());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
