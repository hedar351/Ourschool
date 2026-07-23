// import 'package:school/features/Counselor/data/Model/scheduleImageModel/GetscheduleImageModel.dart';
// import 'package:school/features/Counselor/domain/Entities/scheduleImageEntity/PostscheduleImageEntity.dart';

// class PostscheduleImageModel extends PostscheduleImageEntity {
//   const PostscheduleImageModel({
//     required super.message,
//     required super.getscheduleimageentity,
//   });

//   factory PostscheduleImageModel.fromJson(Map<String, dynamic> json) {
//     final innerData = json['scheduleImage'] as Map<String, dynamic>?;

//     return PostscheduleImageModel(
//       message: json['message'] as String?,
//       getscheduleimageentity: innerData != null
//           ? GetscheduleImageModel.fromJson(innerData)
//           : null,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'message': message,
//       'getscheduleimageentity':
//           (getscheduleimageentity as GetscheduleImageModel).toJson(),
//     };
//   }
// }
