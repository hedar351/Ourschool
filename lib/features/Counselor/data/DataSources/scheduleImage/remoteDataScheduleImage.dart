import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:school/core/const.dart';
import 'package:school/core/error/EXP.dart';
import 'package:school/features/Auth/data/datasources/local_data_source.dart';
import 'package:school/features/Counselor/data/Model/scheduleImageModel/GetscheduleImageModel.dart';

abstract class Remotedatascheduleimage {
  // Future<Unit> deleteScheduleImage(
  //   int localGradeNumber,
  //   int localSectionNumber,
  // );
  Future<GetscheduleImageModel> getscheduleImage(
    int localGradeNumber,
    int localSectionNumber,
  );
  // Future<PostscheduleImageModel> postScheduleImage(
  //   int localGradeNumber,
  //   int localSectionNumber,
  //   File image,
  // );
}

class RemotedatascheduleimageImpl implements Remotedatascheduleimage {
  final http.Client client;
  final AuthLocalDataSource authLocalDataSource;

  RemotedatascheduleimageImpl({
    required this.client,
    required this.authLocalDataSource,
  });

  // ------------------- DELETE: حذف صورة الجدول -------------------
  @override
  // Future<Unit> deleteScheduleImage(
  //   int localGradeNumber,
  //   int localSectionNumber,
  // ) async {
  //   final token = await authLocalDataSource.getToken();
  //   if (token.isEmpty) {
  //     print("🔴 [Remote] No token found");
  //     throw TokenNotFoundExp();
  //   }
  //   final url = Uri.parse(
  //     "$baseUrl/counselor/schedule-images/section/$localGradeNumber/$localSectionNumber",
  //   );
  //   print("🟡 [Remote] DELETE schedule image: $url");
  //   final response = await client.delete(
  //     url,
  //     headers: {
  //       "Content-Type": "application/json",
  //       "Authorization": "Bearer $token",
  //     },
  //   );
  //   print("🟡 [Remote] DELETE status: ${response.statusCode}");
  //   print("🟡 [Remote] DELETE body: ${response.body}");
  //   if (response.statusCode == 200 || response.statusCode == 204) {
  //     return unit;
  //   } else {
  //     throw ServerExp();
  //   }
  // }
  // ------------------- GET: جلب صورة الجدول -------------------
  @override
  Future<GetscheduleImageModel> getscheduleImage(
    int localGradeNumber,
    int localSectionNumber,
  ) async {
    final token = await authLocalDataSource.getToken();
    if (token.isEmpty) {
      print("🔴 [Remote] No token found");
      throw TokenNotFoundExp();
    }

    final url = Uri.parse(
      "$baseUrl/counselor/schedule-images/section/$localGradeNumber/$localSectionNumber",
    );
    print("🟡 [Remote] GET schedule image: $url");

    final response = await client.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    print("🟡 [Remote] GET status: ${response.statusCode}");
    print("🟡 [Remote] GET body: ${response.body}");

    if (response.statusCode == 200) {
      final Map<String, dynamic> decoded = json.decode(response.body);
      return GetscheduleImageModel.fromJson(decoded);
    } else {
      throw ServerExp();
    }
  }

  // ------------------- POST: رفع صورة الجدول -------------------
  // @override
  // Future<PostscheduleImageModel> postScheduleImage(
  //   int localGradeNumber,
  //   int localSectionNumber,
  //   File image,
  // ) async {
  //   final token = await authLocalDataSource.getToken();
  //   if (token.isEmpty) {
  //     print("🔴 [Remote] No token found");
  //     throw TokenNotFoundExp();
  //   }

  //   final url = Uri.parse("$baseUrl/counselor/schedule-images/section");
  //   print("🟡 [Remote] POST schedule image: $url");

  //   // بناء طلب multipart
  //   final request = http.MultipartRequest('POST', url);
  //   request.headers['Authorization'] = 'Bearer $token';

  //   // إضافة الحقول النصية
  //   request.fields['LocalGradeNumber'] = localGradeNumber.toString();
  //   request.fields['LocalSectionNumber'] = localSectionNumber.toString();
  //   request.fields['Description'] = 'جدول شعبة';

  //   // إضافة الملف
  //   final multipartFile = await http.MultipartFile.fromPath(
  //     'Image',
  //     image.path,
  //   );
  //   request.files.add(multipartFile);

  //   // إرسال الطلب
  //   final streamedResponse = await request.send();
  //   final response = await http.Response.fromStream(streamedResponse);

  //   print("🟡 [Remote] POST status: ${response.statusCode}");
  //   print("🟡 [Remote] POST body: ${response.body}");

  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     final Map<String, dynamic> decoded = json.decode(response.body);
  //     return PostscheduleImageModel.fromJson(decoded);
  //   } else {
  //     throw ServerExp();
  //   }
  // }
}
