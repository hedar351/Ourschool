// lib/features/Counselor/data/DataSources/Attendance/remote_attendance_ds.dart

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:school/core/const.dart';
import 'package:school/core/error/EXP.dart';
import 'package:school/core/error/failures.dart';
import 'package:school/features/Auth/data/datasources/local_data_source.dart';

abstract class AttendanceRemoteDataSource {
  Future<Either<Failures, Unit>> addAttendance(
    int localStudentNumber,
    String date,
  );
  Future<Either<Failures, Unit>> deleteAttendance(
    int localStudentNumber,
    String date,
  );
}

class AttendanceRemoteDataSourceImpl implements AttendanceRemoteDataSource {
  final http.Client client;
  final AuthLocalDataSource authLocalDataSource;

  AttendanceRemoteDataSourceImpl({
    required this.client,
    required this.authLocalDataSource,
  });

  @override
  Future<Either<Failures, Unit>> addAttendance(
    int localStudentNumber,
    String date,
  ) async {
    try {
      final token = await authLocalDataSource.getToken();
      if (token.isEmpty) {
        throw TokenNotFoundExp();
      }

      final url = Uri.parse(
        '$baseUrl/counselor/attendance/absent/$localStudentNumber',
      );
      final body = jsonEncode({'date': date, "justification": " "});

      final response = await client.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: body,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print(
          ' [Remote] Attendance added successfully for student: $localStudentNumber',
        );
        return const Right(unit);
      } else {
        print(' [Remote] Failed to add attendance: ${response.body}');
        return Left(ServerFailure());
      }
    } catch (e) {
      print(' [Remote] Error adding attendance: $e');
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failures, Unit>> deleteAttendance(
    int localStudentNumber,
    String date,
  ) async {
    try {
      final token = await authLocalDataSource.getToken();
      if (token.isEmpty) {
        throw TokenNotFoundExp();
      }

      final url = Uri.parse(
        '$baseUrl/counselor/absences/$localStudentNumber?date=$date',
      );

      final response = await client.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        print(
          ' [Remote] Attendance deleted successfully for student: $localStudentNumber on $date',
        );
        return const Right(unit);
      } else {
        print(' [Remote] Failed to delete attendance: ${response.body}');
        return Left(ServerFailure());
      }
    } catch (e) {
      print(' [Remote] Error deleting attendance: $e');
      return Left(ServerFailure());
    }
  }
}
