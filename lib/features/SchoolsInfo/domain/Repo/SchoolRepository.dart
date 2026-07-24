import 'package:dartz/dartz.dart';
import 'package:school/core/error/failures.dart';

import '../Entities/SchoolWithTeacherEntity.dart';

abstract class SchoolRepository {
  Future<Either<Failures, Schoolwithteacherentity>> getSchoolwithteachere();
  Future<Either<Failures, Schoolwithteacherentity>>
  getSchoolwithteachereWithCached();
  Stream<Schoolwithteacherentity> watchCachedSchoolwithteachere();
}
