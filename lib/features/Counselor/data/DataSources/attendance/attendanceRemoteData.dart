import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:school/core/const.dart';
import 'package:school/core/error/EXP.dart';
import 'package:school/core/error/failures.dart';
import 'package:school/features/FirstStep/Auth/data/datasources/local_data_source.dart';

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

  // @override
  // Future<Either<Failures, Unit>> addAttendance(
  //   int localStudentNumber,
  //   String date,
  // ) async {
  //   try {
  //     final token = await authLocalDataSource.getToken();
  //     if (token.isEmpty) {
  //       throw TokenNotFoundExp();
  //     }
  //     String formattedExpiryDate = date;
  //     try {
  //       final parsedDate = DateTime.parse(date);
  //       formattedExpiryDate =
  //           '${parsedDate.year}-'
  //           '${parsedDate.month.toString().padLeft(2, '0')}-'
  //           '${parsedDate.day.toString().padLeft(2, '0')}'
  //           'T${parsedDate.hour.toString().padLeft(2, '0')}:'
  //           '${parsedDate.minute.toString().padLeft(2, '0')}:'
  //           '${parsedDate.second.toString().padLeft(2, '0')}.000Z';
  //     } catch (e) {
  //       print('⚠️ [Activities Remote] فشل تحليل التاريخ: $e');
  //     }
  //     final url = Uri.parse(
  //       '$baseUrl/counselor/attendance/absent/$localStudentNumber',
  //     );
  //     final body = jsonEncode({
  //       'date': formattedExpiryDate,
  //       "justification": " ",
  //     });

  //     final response = await client.post(
  //       url,
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $token',
  //       },
  //       body: body,
  //     );

  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       print(
  //         ' [Remote] Attendance added successfully for student: $localStudentNumber',
  //       );
  //       return const Right(unit);
  //     } else {
  //       print(' [Remote] Failed to add attendance: ${response.body}');
  //       return Left(ServerFailure());
  //     }
  //   } catch (e) {
  //     print(' [Remote] Error adding attendance: $e');
  //     return Left(ServerFailure());
  //   }
  // }
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

      String formattedDate = date;
      try {
        final parsedDate = DateTime.parse(date);
        formattedDate =
            '${parsedDate.year}-'
            '${parsedDate.month.toString().padLeft(2, '0')}-'
            '${parsedDate.day.toString().padLeft(2, '0')}';
      } catch (e) {
        print('⚠️ [Remote] فشل تحليل التاريخ: $e');
      }

      final url = Uri.parse(
        '$baseUrl/counselor/attendance/absent/$localStudentNumber',
      );

      final body = jsonEncode({'date': formattedDate, 'justification': " "});

      print('📤 [Remote] إرسال طلب إلى: $url');
      print('📤 [Remote] الـ Body: $body');

      final response = await client.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: body,
      );

      print('📥 [Remote] حالة الاستجابة: ${response.statusCode}');
      print('📥 [Remote] نص الرد: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('✅ [Remote] تم إضافة الغياب بنجاح للطالب: $localStudentNumber');
        return const Right(unit);
      } else {
        print('🔴 [Remote] فشل إضافة الغياب: ${response.body}');
        return Left(ServerFailure());
      }
    } catch (e) {
      print('🔴 [Remote] خطأ في إضافة الغياب: $e');
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
      String formattedDate = date;
      try {
        final parsedDate = DateTime.parse(date);
        formattedDate =
            '${parsedDate.year}-'
            '${parsedDate.month.toString().padLeft(2, '0')}-'
            '${parsedDate.day.toString().padLeft(2, '0')}';
      } catch (e) {
        print('⚠️ [Remote] فشل تحليل التاريخ: $e');
      }
      final url = Uri.parse(
        '$baseUrl/counselor/absences/$localStudentNumber?date=$formattedDate',
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
