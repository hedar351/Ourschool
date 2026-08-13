import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:school/core/const.dart';
import 'package:school/core/error/EXP.dart';
import 'package:school/core/error/failures.dart';
import 'package:school/features/FirstStep/Auth/data/datasources/local_data_source.dart';

abstract class Marksremotedatasources {
  Future<Either<Failures, Unit>> remoteAddMarks(
    int schoolId,
    int localStudentNumber,
    int localSubjectId,
    int semester,
    int quizTypeId,
    double score,
    double maxScore,
  );
  Future<Either<Failures, Unit>> remoteDeleteMarks(
    int schoolId,
    int localStudentNumber,
    int localSubjectId,
    int semester,
    int quizTypeId,
  );
  Future<Either<Failures, Unit>> remoteEditMarks(
    int schoolId,
    int localStudentNumber,
    int localSubjectId,
    int semester,
    int quizTypeId,
    double score,
    double maxScore,
  );
}

class MarksremotedatasourcesImp implements Marksremotedatasources {
  final http.Client client;
  final AuthLocalDataSource authLocalDataSource;

  MarksremotedatasourcesImp({
    required this.client,
    required this.authLocalDataSource,
  });
  @override
  Future<Either<Failures, Unit>> remoteAddMarks(
    int schoolId,
    int localStudentNumber,
    int localSubjectId,
    int semester,
    int quizTypeId,
    double score,
    double maxScore,
  ) async {
    try {
      final token = await authLocalDataSource.getToken();
      if (token.isEmpty) {
        throw TokenNotFoundExp();
      }
      final body = {
        // schoolId: schoolId,
        "localStudentNumber": localStudentNumber,
        "localSubjectId": localSubjectId,
        "semester": semester,
        "quizTypeId": quizTypeId,
        "score": score,
        "maxScore": maxScore,
      };
      final respons = await client.post(
        Uri.parse("$baseUrl/teacher/marks/quiz?schoolId=$schoolId"),
        body: jsonEncode(body),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (respons.statusCode == 200) {
        return const Right(unit);
      } else {
        return Left(ServerFailure());
      }
    } on ServerExp {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failures, Unit>> remoteDeleteMarks(
    int schoolId,
    int localStudentNumber,
    int localSubjectId,
    int semester,
    int quizTypeId,
  ) async {
    try {
      final token = await authLocalDataSource.getToken();
      if (token.isEmpty) {
        throw TokenNotFoundExp();
      }
      final respons = await client.delete(
        Uri.parse(
          "$baseUrl/teacher/marks/quiz?localStudentNumber=$localStudentNumber&localSubjectId=$localSubjectId&semester=$semester&quizTypeId=$quizTypeId&schoolId=$schoolId",
        ),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (respons.statusCode == 200) {
        return const Right(unit);
      } else {
        return Left(ServerFailure());
      }
    } on ServerExp {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failures, Unit>> remoteEditMarks(
    int schoolId,
    int localStudentNumber,
    int localSubjectId,
    int semester,
    int quizTypeId,
    double score,
    double maxScore,
  ) async {
    try {
      final token = await authLocalDataSource.getToken();
      if (token.isEmpty) {
        throw TokenNotFoundExp();
      }
      final body = {
        // schoolId: schoolId,
        "localStudentNumber": localStudentNumber,
        "localSubjectId": localSubjectId,
        "semester": semester,
        "quizTypeId": quizTypeId,
        "score": score,
        "maxScore": maxScore,
      };
      final respons = await client.put(
        Uri.parse("$baseUrl/teacher/marks/quiz?schoolId=$schoolId"),
        body: jsonEncode(body),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (respons.statusCode == 200) {
        return const Right(unit);
      } else {
        return Left(ServerFailure());
      }
    } on ServerExp {
      return Left(ServerFailure());
    }
  }
}
