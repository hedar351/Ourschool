// import 'package:flutter/material.dart';

// // ============================================================
// // البيانات الجديدة (مدارس ← صفوف ← شعب ← طلاب)
// // ============================================================
// final Map<String, dynamic> responseData = {
//   "success": true,
//   "message": "تم جلب بيانات المعلم بنجاح",
//   "data": {
//     "teacher_id": 101,
//     "teacher_name": "أحمد محمد",
//     "schools": [
//       {
//         "school_id": 1,
//         "school_name": "مدارس الأفق النموذجية",
//         "school_address": "الرياض - حي النخيل",
//         "classes": [
//           {
//             "class_id": 101,
//             "class_name": "الصف الأول",
//             "divisions": [
//               {
//                 "division_id": 1011,
//                 "division_name": "شعبة أ",
//                 "students": [
//                   {
//                     "student_id": 1001,
//                     "student_name": "علي أحمد",
//                     "grades": {"midterm": 85, "final": 90},
//                     "extra_marks": [
//                       {"type": "اختبار أول", "mark": 88, "date": "2025-02-15"},
//                       {"type": "اختبار ثاني", "mark": 92, "date": "2025-03-10"},
//                       {"type": "مشروع", "mark": 87, "date": "2025-03-28"},
//                     ],
//                     "rewards": [
//                       {
//                         "reward_id": 1,
//                         "reason": "تفوق في الرياضيات",
//                         "date": "2025-03-15",
//                         "points": 10,
//                       },
//                       {
//                         "reward_id": 2,
//                         "reason": "المواظبة على الحضور",
//                         "date": "2025-03-01",
//                         "points": 5,
//                       },
//                     ],
//                     "study_plan": {
//                       "plan_id": 101,
//                       "start_date": "2025-04-01",
//                       "end_date": "2025-04-30",
//                       "description": "مراجعة قواعد الرياضيات وحل تمارين يومية",
//                       "tasks": [
//                         {
//                           "task_id": 1,
//                           "title": "حل صفحة 15 من التمارين",
//                           "deadline": "2025-04-05",
//                           "completed": false,
//                         },
//                         {
//                           "task_id": 2,
//                           "title": "مراجعة الكسور",
//                           "deadline": "2025-04-12",
//                           "completed": true,
//                         },
//                         {
//                           "task_id": 3,
//                           "title": "حل اختبار تجريبي",
//                           "deadline": "2025-04-20",
//                           "completed": false,
//                         },
//                       ],
//                     },
//                   },
//                   {
//                     "student_id": 1002,
//                     "student_name": "فاطمة الزهراء",
//                     "grades": {"midterm": 78, "final": 82},
//                     "extra_marks": [
//                       {"type": "اختبار أول", "mark": 75, "date": "2025-02-15"},
//                       {"type": "اختبار ثاني", "mark": 80, "date": "2025-03-10"},
//                       {"type": "مشاركة", "mark": 90, "date": "2025-01-20"},
//                     ],
//                     "rewards": [
//                       {
//                         "reward_id": 3,
//                         "reason": "تحسن ملحوظ في القراءة",
//                         "date": "2025-03-01",
//                         "points": 8,
//                       },
//                     ],
//                     "study_plan": {
//                       "plan_id": 102,
//                       "start_date": "2025-04-01",
//                       "end_date": "2025-04-25",
//                       "description": "تحسين مهارات الكتابة والتعبير",
//                       "tasks": [
//                         {
//                           "task_id": 4,
//                           "title": "كتابة فقرة يومية",
//                           "deadline": "2025-04-05",
//                           "completed": false,
//                         },
//                         {
//                           "task_id": 5,
//                           "title": "قراءة قصة قصيرة",
//                           "deadline": "2025-04-12",
//                           "completed": false,
//                         },
//                       ],
//                     },
//                   },
//                   {
//                     "student_id": 1003,
//                     "student_name": "محمد سعيد",
//                     "grades": {"midterm": 70, "final": 75},
//                     "extra_marks": [
//                       {"type": "اختبار أول", "mark": 68, "date": "2025-02-15"},
//                       {"type": "اختبار ثاني", "mark": 72, "date": "2025-03-10"},
//                     ],
//                     "rewards": [],
//                     "study_plan": null,
//                   },
//                 ],
//               },
//               {
//                 "division_id": 1012,
//                 "division_name": "شعبة ب",
//                 "students": [
//                   {
//                     "student_id": 1004,
//                     "student_name": "يوسف عمر",
//                     "grades": {"midterm": 92, "final": 88},
//                     "extra_marks": [
//                       {"type": "اختبار أول", "mark": 95, "date": "2025-02-15"},
//                       {"type": "اختبار ثاني", "mark": 90, "date": "2025-03-10"},
//                       {"type": "مشروع", "mark": 98, "date": "2025-03-25"},
//                     ],
//                     "rewards": [
//                       {
//                         "reward_id": 4,
//                         "reason": "المركز الأول في مسابقة الرياضيات",
//                         "date": "2025-03-20",
//                         "points": 20,
//                       },
//                       {
//                         "reward_id": 5,
//                         "reason": "مساعدة المعلم",
//                         "date": "2025-02-10",
//                         "points": 5,
//                       },
//                     ],
//                     "study_plan": {
//                       "plan_id": 103,
//                       "start_date": "2025-04-01",
//                       "end_date": "2025-04-30",
//                       "description": "التحضير لمسابقة الرياضيات الوطنية",
//                       "tasks": [
//                         {
//                           "task_id": 6,
//                           "title": "حل 20 مسألة إضافية",
//                           "deadline": "2025-04-05",
//                           "completed": true,
//                         },
//                         {
//                           "task_id": 7,
//                           "title": "مراجعة قوانين الهندسة",
//                           "deadline": "2025-04-15",
//                           "completed": false,
//                         },
//                       ],
//                     },
//                   },
//                   {
//                     "student_id": 1005,
//                     "student_name": "سارة خالد",
//                     "grades": {"midterm": 88, "final": 91},
//                     "extra_marks": [
//                       {"type": "اختبار أول", "mark": 86, "date": "2025-02-15"},
//                       {"type": "اختبار ثاني", "mark": 90, "date": "2025-03-10"},
//                     ],
//                     "rewards": [],
//                     "study_plan": null,
//                   },
//                 ],
//               },
//             ],
//           },
//           {
//             "class_id": 102,
//             "class_name": "الصف الثاني",
//             "divisions": [
//               {
//                 "division_id": 1021,
//                 "division_name": "شعبة أ",
//                 "students": [
//                   {
//                     "student_id": 2001,
//                     "student_name": "حسن إبراهيم",
//                     "grades": {"midterm": 65, "final": 70},
//                     "extra_marks": [
//                       {"type": "اختبار أول", "mark": 60, "date": "2025-02-15"},
//                       {"type": "اختبار ثاني", "mark": 68, "date": "2025-03-10"},
//                     ],
//                     "rewards": [],
//                     "study_plan": null,
//                   },
//                   {
//                     "student_id": 2002,
//                     "student_name": "نورا عبدالله",
//                     "grades": {"midterm": 95, "final": 98},
//                     "extra_marks": [
//                       {"type": "اختبار أول", "mark": 94, "date": "2025-02-15"},
//                       {"type": "اختبار ثاني", "mark": 97, "date": "2025-03-10"},
//                       {"type": "مشروع", "mark": 100, "date": "2025-03-25"},
//                     ],
//                     "rewards": [
//                       {
//                         "reward_id": 6,
//                         "reason": "الامتياز في العلوم",
//                         "date": "2025-03-25",
//                         "points": 15,
//                       },
//                     ],
//                     "study_plan": {
//                       "plan_id": 104,
//                       "start_date": "2025-04-01",
//                       "end_date": "2025-04-20",
//                       "description": "مشروع العلوم: بحث عن الطاقة المتجددة",
//                       "tasks": [
//                         {
//                           "task_id": 8,
//                           "title": "اختيار موضوع البحث",
//                           "deadline": "2025-04-02",
//                           "completed": true,
//                         },
//                         {
//                           "task_id": 9,
//                           "title": "جمع المعلومات",
//                           "deadline": "2025-04-10",
//                           "completed": false,
//                         },
//                       ],
//                     },
//                   },
//                 ],
//               },
//               {
//                 "division_id": 1022,
//                 "division_name": "شعبة ب",
//                 "students": [
//                   {
//                     "student_id": 2003,
//                     "student_name": "ليان مصطفى",
//                     "grades": {"midterm": 80, "final": 84},
//                     "extra_marks": [
//                       {"type": "اختبار أول", "mark": 82, "date": "2025-02-15"},
//                       {"type": "اختبار ثاني", "mark": 79, "date": "2025-03-10"},
//                     ],
//                     "rewards": [
//                       {
//                         "reward_id": 7,
//                         "reason": "الاجتهاد في حل الواجبات",
//                         "date": "2025-03-05",
//                         "points": 7,
//                       },
//                     ],
//                     "study_plan": null,
//                   },
//                 ],
//               },
//             ],
//           },
//         ],
//       },
//       {
//         "school_id": 2,
//         "school_name": "مدارس الفكر الحديث",
//         "school_address": "جدة - حي الروضة",
//         "classes": [
//           {
//             "class_id": 201,
//             "class_name": "الصف الأول",
//             "divisions": [
//               {
//                 "division_id": 2011,
//                 "division_name": "شعبة أ",
//                 "students": [
//                   {
//                     "student_id": 3001,
//                     "student_name": "ليلى علي",
//                     "grades": {"midterm": 95, "final": 97},
//                     "extra_marks": [
//                       {"type": "اختبار أول", "mark": 93, "date": "2025-02-15"},
//                       {"type": "اختبار ثاني", "mark": 96, "date": "2025-03-10"},
//                     ],
//                     "rewards": [
//                       {
//                         "reward_id": 8,
//                         "reason": "المركز الثاني في الإلقاء",
//                         "date": "2025-03-28",
//                         "points": 12,
//                       },
//                     ],
//                     "study_plan": null,
//                   },
//                   {
//                     "student_id": 3002,
//                     "student_name": "أحمد سمير",
//                     "grades": {"midterm": 55, "final": 60},
//                     "extra_marks": [
//                       {"type": "اختبار أول", "mark": 50, "date": "2025-02-15"},
//                     ],
//                     "rewards": [],
//                     "study_plan": null,
//                   },
//                 ],
//               },
//               {
//                 "division_id": 2012,
//                 "division_name": "شعبة ب",
//                 "students": [
//                   {
//                     "student_id": 3003,
//                     "student_name": "منى رشيد",
//                     "grades": {"midterm": 88, "final": 85},
//                     "extra_marks": [
//                       {"type": "اختبار أول", "mark": 87, "date": "2025-02-15"},
//                       {"type": "مشروع", "mark": 90, "date": "2025-03-25"},
//                     ],
//                     "rewards": [],
//                     "study_plan": {
//                       "plan_id": 105,
//                       "start_date": "2025-04-01",
//                       "end_date": "2025-04-28",
//                       "description": "تعزيز قواعد اللغة العربية",
//                       "tasks": [
//                         {
//                           "task_id": 10,
//                           "title": "حل تدريبات النحو",
//                           "deadline": "2025-04-07",
//                           "completed": false,
//                         },
//                         {
//                           "task_id": 11,
//                           "title": "كتابة موضوع تعبير",
//                           "deadline": "2025-04-14",
//                           "completed": true,
//                         },
//                       ],
//                     },
//                   },
//                 ],
//               },
//             ],
//           },
//           {
//             "class_id": 202,
//             "class_name": "الصف الثالث",
//             "divisions": [
//               {
//                 "division_id": 2021,
//                 "division_name": "شعبة أ",
//                 "students": [
//                   {
//                     "student_id": 4001,
//                     "student_name": "عمر خالد",
//                     "grades": {"midterm": 72, "final": 78},
//                     "extra_marks": [
//                       {"type": "اختبار أول", "mark": 70, "date": "2025-02-15"},
//                       {"type": "اختبار ثاني", "mark": 74, "date": "2025-03-10"},
//                     ],
//                     "rewards": [],
//                     "study_plan": null,
//                   },
//                   {
//                     "student_id": 4002,
//                     "student_name": "جنى وليد",
//                     "grades": {"midterm": 90, "final": 92},
//                     "extra_marks": [
//                       {"type": "اختبار أول", "mark": 89, "date": "2025-02-15"},
//                       {"type": "مشروع", "mark": 95, "date": "2025-03-25"},
//                     ],
//                     "rewards": [
//                       {
//                         "reward_id": 9,
//                         "reason": "أفضل مشروع علمي",
//                         "date": "2025-03-30",
//                         "points": 25,
//                       },
//                     ],
//                     "study_plan": null,
//                   },
//                 ],
//               },
//             ],
//           },
//         ],
//       },
//       {
//         "school_id": 3,
//         "school_name": "مدارس البيان الأهلية",
//         "school_address": "الدمام - حي الفيحاء",
//         "classes": [
//           {
//             "class_id": 301,
//             "class_name": "الصف الأول",
//             "divisions": [
//               {
//                 "division_id": 3011,
//                 "division_name": "شعبة أ",
//                 "students": [
//                   {
//                     "student_id": 5001,
//                     "student_name": "سعيد ماجد",
//                     "grades": {"midterm": 68, "final": 72},
//                     "extra_marks": [],
//                     "rewards": [],
//                     "study_plan": null,
//                   },
//                   {
//                     "student_id": 5002,
//                     "student_name": "أمل ناصر",
//                     "grades": {"midterm": 96, "final": 94},
//                     "extra_marks": [
//                       {"type": "اختبار أول", "mark": 97, "date": "2025-02-15"},
//                       {"type": "اختبار ثاني", "mark": 95, "date": "2025-03-10"},
//                     ],
//                     "rewards": [
//                       {
//                         "reward_id": 10,
//                         "reason": "التميز في اللغة الإنجليزية",
//                         "date": "2025-03-18",
//                         "points": 15,
//                       },
//                     ],
//                     "study_plan": {
//                       "plan_id": 106,
//                       "start_date": "2025-04-01",
//                       "end_date": "2025-04-20",
//                       "description": "إتقان المحادثة الإنجليزية",
//                       "tasks": [
//                         {
//                           "task_id": 12,
//                           "title": "حفظ 20 كلمة جديدة",
//                           "deadline": "2025-04-05",
//                           "completed": false,
//                         },
//                         {
//                           "task_id": 13,
//                           "title": "كتابة فقرة عن العائلة",
//                           "deadline": "2025-04-12",
//                           "completed": true,
//                         },
//                         {
//                           "task_id": 14,
//                           "title": "ممارسة المحادثة مع زميل",
//                           "deadline": "2025-04-19",
//                           "completed": false,
//                         },
//                       ],
//                     },
//                   },
//                 ],
//               },
//               {
//                 "division_id": 3012,
//                 "division_name": "شعبة ب",
//                 "students": [
//                   {
//                     "student_id": 5003,
//                     "student_name": "ريم فواز",
//                     "grades": {"midterm": 84, "final": 88},
//                     "extra_marks": [
//                       {"type": "اختبار أول", "mark": 82, "date": "2025-02-15"},
//                       {"type": "مشروع", "mark": 90, "date": "2025-03-25"},
//                     ],
//                     "rewards": [],
//                     "study_plan": null,
//                   },
//                 ],
//               },
//             ],
//           },
//         ],
//       },
//       {
//         "school_id": 4,
//         "school_name": "مدارس الريان العالمية",
//         "school_address": "الخبر - حي الأندلس",
//         "classes": [
//           {
//             "class_id": 401,
//             "class_name": "الصف الأول",
//             "divisions": [
//               {
//                 "division_id": 4011,
//                 "division_name": "شعبة أ",
//                 "students": [
//                   {
//                     "student_id": 6001,
//                     "student_name": "لؤي حاتم",
//                     "grades": {"midterm": 77, "final": 81},
//                     "extra_marks": [
//                       {"type": "اختبار أول", "mark": 75, "date": "2025-02-15"},
//                     ],
//                     "rewards": [],
//                     "study_plan": null,
//                   },
//                   {
//                     "student_id": 6002,
//                     "student_name": "جمانة سامر",
//                     "grades": {"midterm": 98, "final": 99},
//                     "extra_marks": [
//                       {"type": "اختبار أول", "mark": 98, "date": "2025-02-15"},
//                       {"type": "اختبار ثاني", "mark": 99, "date": "2025-03-10"},
//                       {"type": "مشروع", "mark": 100, "date": "2025-03-25"},
//                     ],
//                     "rewards": [
//                       {
//                         "reward_id": 11,
//                         "reason": "التفوق العام",
//                         "date": "2025-03-30",
//                         "points": 30,
//                       },
//                       {
//                         "reward_id": 12,
//                         "reason": "المشاركة الفعالة",
//                         "date": "2025-03-20",
//                         "points": 10,
//                       },
//                     ],
//                     "study_plan": {
//                       "plan_id": 107,
//                       "start_date": "2025-04-01",
//                       "end_date": "2025-04-25",
//                       "description": "الاستعداد لمسابقة العلوم",
//                       "tasks": [
//                         {
//                           "task_id": 15,
//                           "title": "مراجعة منهج العلوم",
//                           "deadline": "2025-04-07",
//                           "completed": true,
//                         },
//                         {
//                           "task_id": 16,
//                           "title": "حل نماذج اختبارات سابقة",
//                           "deadline": "2025-04-15",
//                           "completed": false,
//                         },
//                       ],
//                     },
//                   },
//                   {
//                     "student_id": 6003,
//                     "student_name": "رغد هشام",
//                     "grades": {"midterm": 62, "final": 67},
//                     "extra_marks": [
//                       {"type": "اختبار أول", "mark": 60, "date": "2025-02-15"},
//                       {"type": "اختبار ثاني", "mark": 64, "date": "2025-03-10"},
//                     ],
//                     "rewards": [],
//                     "study_plan": null,
//                   },
//                 ],
//               },
//             ],
//           },
//           {
//             "class_id": 402,
//             "class_name": "الصف الثاني",
//             "divisions": [
//               {
//                 "division_id": 4021,
//                 "division_name": "شعبة أ",
//                 "students": [
//                   {
//                     "student_id": 7001,
//                     "student_name": "مالك عادل",
//                     "grades": {"midterm": 88, "final": 86},
//                     "extra_marks": [],
//                     "rewards": [
//                       {
//                         "reward_id": 13,
//                         "reason": "حل واجبات إضافية",
//                         "date": "2025-03-10",
//                         "points": 6,
//                       },
//                     ],
//                     "study_plan": null,
//                   },
//                 ],
//               },
//             ],
//           },
//         ],
//       },
//     ],
//   },
// };

// // ============================================================
// // شاشة عرض الصفوف (مع AppBar واضح)
// // ============================================================
// class ClassesScreen extends StatelessWidget {
//   final Map<String, dynamic> school;
//   const ClassesScreen({super.key, required this.school});

//   @override
//   Widget build(BuildContext context) {
//     final List classes = school['classes'];
//     return Scaffold(
//       appBar: AppBar(title: Text(school['school_name']), centerTitle: true),
//       body: ListView.builder(
//         padding: const EdgeInsets.all(16),
//         itemCount: classes.length,
//         itemBuilder: (context, index) {
//           final classItem = classes[index];
//           return Card(
//             margin: const EdgeInsets.only(bottom: 12),
//             child: ListTile(
//               leading: CircleAvatar(
//                 backgroundColor: Theme.of(context).colorScheme.primary,
//                 child: Text(
//                   classItem['class_name'][0],
//                   style: const TextStyle(color: Colors.white, fontSize: 20),
//                 ),
//               ),
//               title: Text(
//                 classItem['class_name'],
//                 style: const TextStyle(fontWeight: FontWeight.bold),
//               ),
//               subtitle: Text('${classItem['divisions'].length} شعب'),
//               trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//               onTap: () => Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) => DivisionsScreen(
//                     schoolName: school['school_name'],
//                     classItem: classItem,
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// // ============================================================
// // شاشة عرض الشعب
// // ============================================================
// class DivisionsScreen extends StatelessWidget {
//   final String schoolName;
//   final Map<String, dynamic> classItem;
//   const DivisionsScreen({
//     super.key,
//     required this.schoolName,
//     required this.classItem,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final List divisions = classItem['divisions'];
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('$schoolName - ${classItem['class_name']}'),
//         centerTitle: true,
//       ),
//       body: ListView.builder(
//         padding: const EdgeInsets.all(16),
//         itemCount: divisions.length,
//         itemBuilder: (context, index) {
//           final division = divisions[index];
//           return Card(
//             margin: const EdgeInsets.only(bottom: 12),
//             child: ListTile(
//               leading: const Icon(Icons.group),
//               title: Text(
//                 division['division_name'],
//                 style: const TextStyle(fontWeight: FontWeight.bold),
//               ),
//               subtitle: Text('${division['students'].length} طلاب'),
//               trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//               onTap: () => Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) => StudentsListScreen(
//                     schoolName: schoolName,
//                     className: classItem['class_name'],
//                     divisionName: division['division_name'],
//                     students: division['students'],
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// class SchoolsScreen extends StatelessWidget {
//   const SchoolsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final teacherData = responseData['data'];
//     final List schools = teacherData['schools'];
//     // final teacherName = teacherData['teacher_name'];

//     return Scaffold(
//       body: RefreshIndicator(
//         onRefresh: () async => Future.delayed(const Duration(seconds: 1)),
//         child: SafeArea(
//           child: CustomScrollView(
//             slivers: [
//               SliverPadding(
//                 padding: const EdgeInsets.all(16),
//                 sliver: SliverGrid(
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     crossAxisSpacing: 16,
//                     mainAxisSpacing: 16,
//                     childAspectRatio: 0.9,
//                   ),
//                   delegate: SliverChildBuilderDelegate(
//                     (context, index) => _SchoolCard(school: schools[index]),
//                     childCount: schools.length,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // ============================================================
// // شاشة تفاصيل الطالب (مع اكتمال دوال التعديل والإضافة)
// // ============================================================
// class StudentDetailScreen extends StatefulWidget {
//   final Map<String, dynamic> studentData;
//   const StudentDetailScreen({super.key, required this.studentData});

//   @override
//   State<StudentDetailScreen> createState() => _StudentDetailScreenState();
// }

// // ============================================================
// // شاشة عرض الطلاب مع بحث
// // ============================================================
// class StudentsListScreen extends StatefulWidget {
//   final String schoolName;
//   final String className;
//   final String divisionName;
//   final List students;
//   const StudentsListScreen({
//     super.key,
//     required this.schoolName,
//     required this.className,
//     required this.divisionName,
//     required this.students,
//   });

//   @override
//   State<StudentsListScreen> createState() => _StudentsListScreenState();
// }

// class _ExtraMarkCard extends StatelessWidget {
//   final Map<String, dynamic> mark;
//   final VoidCallback onDelete;
//   final VoidCallback onEdit;
//   const _ExtraMarkCard({
//     required this.mark,
//     required this.onDelete,
//     required this.onEdit,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 6),
//       child: ListTile(
//         title: Text('${mark['type']} : ${mark['mark']}/100'),
//         trailing: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             IconButton(
//               icon: const Icon(Icons.edit, size: 18),
//               onPressed: onEdit,
//             ),
//             IconButton(
//               icon: const Icon(Icons.delete, size: 18, color: Colors.red),
//               onPressed: onDelete,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _GradeCard extends StatelessWidget {
//   final String label;
//   final int value;
//   final Color color;
//   const _GradeCard({
//     required this.label,
//     required this.value,
//     required this.color,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 8),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(label),
//             Text(
//               '$value/100',
//               style: TextStyle(fontWeight: FontWeight.bold, color: color),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _RewardCard extends StatelessWidget {
//   final Map<String, dynamic> reward;
//   final VoidCallback onDelete;
//   final VoidCallback onEdit;
//   const _RewardCard({
//     required this.reward,
//     required this.onDelete,
//     required this.onEdit,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: Colors.amber.shade50,
//       margin: const EdgeInsets.only(bottom: 8),
//       child: ListTile(
//         leading: const Icon(Icons.emoji_events, color: Colors.amber),
//         title: Text(
//           reward['reason'],
//           style: const TextStyle(fontWeight: FontWeight.w500),
//         ),
//         subtitle: Text('${reward['date']} | +${reward['points']} نقطة'),
//         trailing: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             IconButton(
//               icon: const Icon(Icons.edit, size: 18),
//               onPressed: onEdit,
//             ),
//             IconButton(
//               icon: const Icon(Icons.delete, size: 18, color: Colors.red),
//               onPressed: onDelete,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _SchoolCard extends StatelessWidget {
//   final Map<String, dynamic> school;
//   const _SchoolCard({required this.school});

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Card(
//       elevation: 4,
//       shadowColor: theme.colorScheme.primary.withOpacity(0.2),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
//       child: InkWell(
//         borderRadius: BorderRadius.circular(24),
//         onTap: () => Navigator.push(
//           context,
//           MaterialPageRoute(builder: (_) => ClassesScreen(school: school)),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 Icons.school_outlined,
//                 size: 56,
//                 color: theme.colorScheme.primary,
//               ),
//               const SizedBox(height: 12),
//               Text(
//                 school['school_name'],
//                 style: theme.textTheme.titleMedium,
//                 textAlign: TextAlign.center,
//                 maxLines: 2,
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 '${school['classes'].length} صفوف',
//                 style: theme.textTheme.bodySmall,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // ============================================================
// // ويدجتات مساعدة
// // ============================================================
// class _SectionHeader extends StatelessWidget {
//   final String title;
//   final IconData icon;
//   const _SectionHeader({required this.title, required this.icon});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Icon(icon, color: Theme.of(context).colorScheme.primary),
//         const SizedBox(width: 8),
//         Text(title, style: Theme.of(context).textTheme.titleMedium),
//       ],
//     );
//   }
// }

// class _StudentDetailScreenState extends State<StudentDetailScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Map<String, dynamic> student;
//   final bool _isExpanded = false;

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final grades = student['grades'];
//     final avg = ((grades['midterm'] as int) + (grades['final'] as int)) ~/ 2;
//     final avgColor = avg >= 90
//         ? Colors.green
//         : avg >= 75
//         ? Colors.orange
//         : Colors.red;

//     return Scaffold(
//       appBar: AppBar(title: Text(student['student_name']), centerTitle: true),
//       body: FadeTransition(
//         opacity: _controller,
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Card(
//                 child: Padding(
//                   padding: const EdgeInsets.all(20),
//                   child: Column(
//                     children: [
//                       const Icon(Icons.bar_chart, size: 40),
//                       const SizedBox(height: 12),
//                       Text('المعدل العام', style: theme.textTheme.titleLarge),
//                       const SizedBox(height: 16),
//                       TweenAnimationBuilder<double>(
//                         tween: Tween(begin: 0.0, end: avg.toDouble()),
//                         duration: const Duration(milliseconds: 1500),
//                         builder: (context, value, _) => Text(
//                           '${value.toInt()}%',
//                           style: theme.textTheme.displayMedium?.copyWith(
//                             color: avgColor,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 12),
//                       TweenAnimationBuilder<double>(
//                         tween: Tween(begin: 0.0, end: avg / 100),
//                         duration: const Duration(milliseconds: 1000),
//                         builder: (context, value, _) => LinearProgressIndicator(
//                           value: value,
//                           backgroundColor: Colors.grey[200],
//                           color: avgColor,
//                           minHeight: 10,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 24),
//               _SectionHeader(title: '📊 الدرجات', icon: Icons.grade),
//               const SizedBox(height: 12),
//               _GradeCard(
//                 label: 'امتحان نصفي',
//                 value: grades['midterm'],
//                 color: Colors.blue,
//               ),
//               _GradeCard(
//                 label: 'امتحان نهائي',
//                 value: grades['final'],
//                 color: Colors.green,
//               ),
//               if (student['extra_marks'].isNotEmpty) ...[
//                 const SizedBox(height: 8),
//                 Text('علامات أخرى', style: theme.textTheme.titleSmall),
//                 ...List.generate(
//                   student['extra_marks'].length,
//                   (index) => _ExtraMarkCard(
//                     mark: student['extra_marks'][index],
//                     onDelete: () => _deleteMark(index),
//                     onEdit: () => _editMarkDialog(index),
//                   ),
//                 ),
//               ],
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: TextButton.icon(
//                   onPressed: _showAddMarkDialog,
//                   icon: const Icon(Icons.add),
//                   label: const Text('إضافة علامة'),
//                 ),
//               ),
//               const SizedBox(height: 24),
//               _SectionHeader(title: '🏆 المكافآت', icon: Icons.emoji_events),
//               const SizedBox(height: 8),
//               if (student['rewards'].isNotEmpty)
//                 ...List.generate(
//                   student['rewards'].length,
//                   (index) => _RewardCard(
//                     reward: student['rewards'][index],
//                     onDelete: () => _deleteReward(index),
//                     onEdit: () => _editRewardDialog(index),
//                   ),
//                 )
//               else
//                 Text('لا توجد مكافآت', style: theme.textTheme.bodySmall),
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: TextButton.icon(
//                   onPressed: _showAddRewardDialog,
//                   icon: const Icon(Icons.add),
//                   label: const Text('إضافة مكافأة'),
//                 ),
//               ),
//               const SizedBox(height: 24),
//               _SectionHeader(
//                 title: '📅 الخطة الدراسية',
//                 icon: Icons.calendar_month,
//               ),
//               const SizedBox(height: 8),
//               if (student['study_plan'] != null)
//                 _StudyPlanCard(
//                   plan: student['study_plan'],
//                   onAddTask: _showAddTaskDialog,
//                   onEditTask: _editTaskDialog,
//                   onDeleteTask: _deleteTask,
//                 )
//               else
//                 Text('لا توجد خطة دراسية', style: theme.textTheme.bodySmall),
//               if (student['study_plan'] == null)
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: TextButton.icon(
//                     onPressed: _showAddStudyPlanDialog,
//                     icon: const Icon(Icons.add),
//                     label: const Text('إضافة خطة'),
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   void initState() {
//     super.initState();
//     student = Map.from(widget.studentData);
//     student['extra_marks'] ??= [];
//     student['rewards'] ??= [];
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 500),
//     );
//     _controller.forward();
//   }

//   // -------------------- عمليات التعديل والإضافة (تم إكمالها) --------------------
//   void _deleteMark(int index) =>
//       setState(() => student['extra_marks'].removeAt(index));
//   void _deleteReward(int index) =>
//       setState(() => student['rewards'].removeAt(index));
//   void _deleteTask(int index) =>
//       setState(() => student['study_plan']['tasks'].removeAt(index));

//   void _editMarkDialog(int index) async {
//     final mark = student['extra_marks'][index];
//     final typeController = TextEditingController(text: mark['type']);
//     final markController = TextEditingController(text: mark['mark'].toString());
//     await showDialog(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         title: const Text('تعديل العلامة'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(
//               controller: typeController,
//               decoration: const InputDecoration(labelText: 'نوع الامتحان'),
//             ),
//             TextField(
//               controller: markController,
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(labelText: 'العلامة (0-100)'),
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(ctx),
//             child: const Text('إلغاء'),
//           ),
//           FilledButton(
//             onPressed: () {
//               final newMark = int.tryParse(markController.text);
//               if (typeController.text.isNotEmpty &&
//                   newMark != null &&
//                   newMark >= 0 &&
//                   newMark <= 100) {
//                 setState(() {
//                   student['extra_marks'][index] = {
//                     'type': typeController.text,
//                     'mark': newMark,
//                     'date': mark['date'],
//                   };
//                 });
//                 Navigator.pop(ctx);
//               }
//             },
//             child: const Text('حفظ'),
//           ),
//         ],
//       ),
//     );
//   }

//   void _editRewardDialog(int index) async {
//     final reward = student['rewards'][index];
//     final reasonController = TextEditingController(text: reward['reason']);
//     final pointsController = TextEditingController(
//       text: reward['points'].toString(),
//     );
//     await showDialog(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         title: const Text('تعديل المكافأة'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(
//               controller: reasonController,
//               decoration: const InputDecoration(labelText: 'سبب المكافأة'),
//             ),
//             TextField(
//               controller: pointsController,
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(labelText: 'النقاط'),
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(ctx),
//             child: const Text('إلغاء'),
//           ),
//           FilledButton(
//             onPressed: () {
//               final points = int.tryParse(pointsController.text);
//               if (reasonController.text.isNotEmpty && points != null) {
//                 setState(() {
//                   student['rewards'][index] = {
//                     'reward_id': reward['reward_id'],
//                     'reason': reasonController.text,
//                     'date': reward['date'],
//                     'points': points,
//                   };
//                 });
//                 Navigator.pop(ctx);
//               }
//             },
//             child: const Text('حفظ'),
//           ),
//         ],
//       ),
//     );
//   }

//   void _editTaskDialog(int index) async {
//     final task = student['study_plan']['tasks'][index];
//     final titleController = TextEditingController(text: task['title']);
//     final deadlineController = TextEditingController(text: task['deadline']);
//     await showDialog(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         title: const Text('تعديل المهمة'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(
//               controller: titleController,
//               decoration: const InputDecoration(labelText: 'عنوان المهمة'),
//             ),
//             TextField(
//               controller: deadlineController,
//               decoration: const InputDecoration(labelText: 'تاريخ التسليم'),
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(ctx),
//             child: const Text('إلغاء'),
//           ),
//           FilledButton(
//             onPressed: () {
//               if (titleController.text.isNotEmpty &&
//                   deadlineController.text.isNotEmpty) {
//                 setState(() {
//                   student['study_plan']['tasks'][index] = {
//                     'task_id': task['task_id'],
//                     'title': titleController.text,
//                     'deadline': deadlineController.text,
//                     'completed': task['completed'],
//                   };
//                 });
//                 Navigator.pop(ctx);
//               }
//             },
//             child: const Text('حفظ'),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showAddMarkDialog() async {
//     final typeController = TextEditingController();
//     final markController = TextEditingController();
//     await showDialog(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         title: const Text('إضافة علامة'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(
//               controller: typeController,
//               decoration: const InputDecoration(labelText: 'نوع الامتحان'),
//             ),
//             TextField(
//               controller: markController,
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(labelText: 'العلامة (0-100)'),
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(ctx),
//             child: const Text('إلغاء'),
//           ),
//           FilledButton(
//             onPressed: () {
//               final mark = int.tryParse(markController.text);
//               if (typeController.text.isNotEmpty &&
//                   mark != null &&
//                   mark >= 0 &&
//                   mark <= 100) {
//                 setState(() {
//                   student['extra_marks'].add({
//                     'type': typeController.text,
//                     'mark': mark,
//                     'date': DateTime.now().toIso8601String().substring(0, 10),
//                   });
//                 });
//                 Navigator.pop(ctx);
//               }
//             },
//             child: const Text('إضافة'),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showAddRewardDialog() async {
//     final reasonController = TextEditingController();
//     final pointsController = TextEditingController();
//     await showDialog(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         title: const Text('إضافة مكافأة'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(
//               controller: reasonController,
//               decoration: const InputDecoration(labelText: 'سبب المكافأة'),
//             ),
//             TextField(
//               controller: pointsController,
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(labelText: 'النقاط'),
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(ctx),
//             child: const Text('إلغاء'),
//           ),
//           FilledButton(
//             onPressed: () {
//               final points = int.tryParse(pointsController.text);
//               if (reasonController.text.isNotEmpty && points != null) {
//                 setState(() {
//                   student['rewards'].add({
//                     'reward_id': DateTime.now().millisecondsSinceEpoch,
//                     'reason': reasonController.text,
//                     'date': DateTime.now().toIso8601String().substring(0, 10),
//                     'points': points,
//                   });
//                 });
//                 Navigator.pop(ctx);
//               }
//             },
//             child: const Text('إضافة'),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showAddStudyPlanDialog() async {
//     final descController = TextEditingController();
//     final startController = TextEditingController();
//     final endController = TextEditingController();
//     await showDialog(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         title: const Text('إضافة خطة دراسية'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(
//               controller: descController,
//               decoration: const InputDecoration(labelText: 'وصف الخطة'),
//             ),
//             TextField(
//               controller: startController,
//               decoration: const InputDecoration(
//                 labelText: 'تاريخ البداية (YYYY-MM-DD)',
//               ),
//             ),
//             TextField(
//               controller: endController,
//               decoration: const InputDecoration(
//                 labelText: 'تاريخ النهاية (YYYY-MM-DD)',
//               ),
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(ctx),
//             child: const Text('إلغاء'),
//           ),
//           FilledButton(
//             onPressed: () {
//               if (descController.text.isNotEmpty &&
//                   startController.text.isNotEmpty &&
//                   endController.text.isNotEmpty) {
//                 setState(() {
//                   student['study_plan'] = {
//                     'plan_id': DateTime.now().millisecondsSinceEpoch,
//                     'start_date': startController.text,
//                     'end_date': endController.text,
//                     'description': descController.text,
//                     'tasks': [],
//                   };
//                 });
//                 Navigator.pop(ctx);
//               }
//             },
//             child: const Text('إضافة'),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showAddTaskDialog() async {
//     final titleController = TextEditingController();
//     final deadlineController = TextEditingController();
//     await showDialog(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         title: const Text('إضافة مهمة'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(
//               controller: titleController,
//               decoration: const InputDecoration(labelText: 'عنوان المهمة'),
//             ),
//             TextField(
//               controller: deadlineController,
//               decoration: const InputDecoration(
//                 labelText: 'تاريخ التسليم (YYYY-MM-DD)',
//               ),
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(ctx),
//             child: const Text('إلغاء'),
//           ),
//           FilledButton(
//             onPressed: () {
//               if (titleController.text.isNotEmpty &&
//                   deadlineController.text.isNotEmpty) {
//                 setState(() {
//                   student['study_plan']['tasks'].add({
//                     'task_id': DateTime.now().millisecondsSinceEpoch,
//                     'title': titleController.text,
//                     'deadline': deadlineController.text,
//                     'completed': false,
//                   });
//                 });
//                 Navigator.pop(ctx);
//               }
//             },
//             child: const Text('إضافة'),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _StudentsListScreenState extends State<StudentsListScreen> {
//   late List _filteredStudents;
//   final TextEditingController _searchController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           '${widget.schoolName} - ${widget.className} - ${widget.divisionName}',
//         ),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: TextField(
//               controller: _searchController,
//               decoration: InputDecoration(
//                 hintText: 'بحث عن طالب...',
//                 prefixIcon: const Icon(Icons.search),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(30),
//                   borderSide: BorderSide.none,
//                 ),
//                 filled: true,
//                 fillColor: Colors.grey[100],
//               ),
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               itemCount: _filteredStudents.length,
//               itemBuilder: (context, index) {
//                 final student = _filteredStudents[index];
//                 final grades = student['grades'];
//                 final avg =
//                     ((grades['midterm'] as int) + (grades['final'] as int)) ~/
//                     2;
//                 final avgColor = avg >= 90
//                     ? Colors.green
//                     : avg >= 75
//                     ? Colors.orange
//                     : Colors.red;
//                 return Card(
//                   margin: const EdgeInsets.only(bottom: 12),
//                   child: ListTile(
//                     leading: CircleAvatar(
//                       backgroundColor: theme.colorScheme.primary,
//                       child: Text(
//                         student['student_name'][0],
//                         style: const TextStyle(color: Colors.white),
//                       ),
//                     ),
//                     title: Text(
//                       student['student_name'],
//                       style: const TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     subtitle: Text('المعدل: $avg%'),
//                     trailing: Container(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 10,
//                         vertical: 4,
//                       ),
//                       decoration: BoxDecoration(
//                         color: avgColor.withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: Text(
//                         '$avg%',
//                         style: TextStyle(
//                           color: avgColor,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     onTap: () => Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) =>
//                             StudentDetailScreen(studentData: Map.from(student)),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   @override
//   void initState() {
//     super.initState();
//     _filteredStudents = widget.students;
//     _searchController.addListener(() {
//       setState(() {
//         _filteredStudents = widget.students
//             .where(
//               (student) =>
//                   student['student_name'].contains(_searchController.text),
//             )
//             .toList();
//       });
//     });
//   }
// }

// class _StudyPlanCard extends StatefulWidget {
//   final Map<String, dynamic> plan;
//   final VoidCallback onAddTask;
//   final Function(int) onEditTask;
//   final Function(int) onDeleteTask;
//   const _StudyPlanCard({
//     required this.plan,
//     required this.onAddTask,
//     required this.onEditTask,
//     required this.onDeleteTask,
//   });

//   @override
//   State<_StudyPlanCard> createState() => _StudyPlanCardState();
// }

// class _StudyPlanCardState extends State<_StudyPlanCard> {
//   bool _expanded = false;

//   @override
//   Widget build(BuildContext context) {
//     final tasks = widget.plan['tasks'] as List;
//     final completed = tasks.where((t) => t['completed'] == true).length;
//     return Card(
//       child: Column(
//         children: [
//           ListTile(
//             title: Text(
//               widget.plan['description'],
//               style: const TextStyle(fontWeight: FontWeight.w500),
//             ),
//             subtitle: Text(
//               '${widget.plan['start_date']} → ${widget.plan['end_date']}',
//             ),
//             trailing: IconButton(
//               icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
//               onPressed: () => setState(() => _expanded = !_expanded),
//             ),
//           ),
//           if (_expanded)
//             Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       Text('تقدم المهام: $completed/${tasks.length}'),
//                       const SizedBox(width: 8),
//                       Expanded(
//                         child: LinearProgressIndicator(
//                           value: tasks.isEmpty ? 0 : completed / tasks.length,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 12),
//                   ...List.generate(tasks.length, (index) {
//                     final task = tasks[index];
//                     return ListTile(
//                       leading: Icon(
//                         task['completed']
//                             ? Icons.check_circle
//                             : Icons.radio_button_unchecked,
//                         color: task['completed'] ? Colors.green : Colors.grey,
//                       ),
//                       title: Text(
//                         task['title'],
//                         style: TextStyle(
//                           decoration: task['completed']
//                               ? TextDecoration.lineThrough
//                               : null,
//                         ),
//                       ),
//                       trailing: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           IconButton(
//                             icon: const Icon(Icons.edit, size: 16),
//                             onPressed: () => widget.onEditTask(index),
//                           ),
//                           IconButton(
//                             icon: const Icon(
//                               Icons.delete,
//                               size: 16,
//                               color: Colors.red,
//                             ),
//                             onPressed: () => widget.onDeleteTask(index),
//                           ),
//                         ],
//                       ),
//                     );
//                   }),
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: TextButton.icon(
//                       onPressed: widget.onAddTask,
//                       icon: const Icon(Icons.add),
//                       label: const Text('إضافة مهمة'),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

// ============================================================
// البيانات الجديدة (مدارس ← صفوف ← شعب ← طلاب)
// ============================================================
final Map<String, dynamic> responseData = {
  "success": true,
  "message": "تم جلب بيانات المعلم بنجاح",
  "data": {
    "teacher_id": 101,
    "teacher_name": "أحمد محمد",
    "schools": [
      {
        "school_id": 1,
        "school_name": "مدارس الأفق النموذجية",
        "school_address": "الرياض - حي النخيل",
        "classes": [
          {
            "class_id": 101,
            "class_name": "الصف الأول",
            "divisions": [
              {
                "division_id": 1011,
                "division_name": "شعبة أ",
                "students": [
                  {
                    "student_id": 1001,
                    "student_name": "علي أحمد",
                    "grades": {"midterm": 85, "final": 90},
                    "extra_marks": [
                      {"type": "اختبار أول", "mark": 88, "date": "2025-02-15"},
                      {"type": "اختبار ثاني", "mark": 92, "date": "2025-03-10"},
                      {"type": "مشروع", "mark": 87, "date": "2025-03-28"},
                    ],
                    "rewards": [
                      {
                        "reward_id": 1,
                        "reason": "تفوق في الرياضيات",
                        "date": "2025-03-15",
                        "points": 10,
                      },
                      {
                        "reward_id": 2,
                        "reason": "المواظبة على الحضور",
                        "date": "2025-03-01",
                        "points": 5,
                      },
                    ],
                    "study_plan": {
                      "plan_id": 101,
                      "start_date": "2025-04-01",
                      "end_date": "2025-04-30",
                      "description": "مراجعة قواعد الرياضيات وحل تمارين يومية",
                      "tasks": [
                        {
                          "task_id": 1,
                          "title": "حل صفحة 15 من التمارين",
                          "deadline": "2025-04-05",
                          "completed": false,
                        },
                        {
                          "task_id": 2,
                          "title": "مراجعة الكسور",
                          "deadline": "2025-04-12",
                          "completed": true,
                        },
                        {
                          "task_id": 3,
                          "title": "حل اختبار تجريبي",
                          "deadline": "2025-04-20",
                          "completed": false,
                        },
                      ],
                    },
                  },
                  {
                    "student_id": 1002,
                    "student_name": "فاطمة الزهراء",
                    "grades": {"midterm": 78, "final": 82},
                    "extra_marks": [
                      {"type": "اختبار أول", "mark": 75, "date": "2025-02-15"},
                      {"type": "اختبار ثاني", "mark": 80, "date": "2025-03-10"},
                      {"type": "مشاركة", "mark": 90, "date": "2025-01-20"},
                    ],
                    "rewards": [
                      {
                        "reward_id": 3,
                        "reason": "تحسن ملحوظ في القراءة",
                        "date": "2025-03-01",
                        "points": 8,
                      },
                    ],
                    "study_plan": {
                      "plan_id": 102,
                      "start_date": "2025-04-01",
                      "end_date": "2025-04-25",
                      "description": "تحسين مهارات الكتابة والتعبير",
                      "tasks": [
                        {
                          "task_id": 4,
                          "title": "كتابة فقرة يومية",
                          "deadline": "2025-04-05",
                          "completed": false,
                        },
                        {
                          "task_id": 5,
                          "title": "قراءة قصة قصيرة",
                          "deadline": "2025-04-12",
                          "completed": false,
                        },
                      ],
                    },
                  },
                  {
                    "student_id": 1003,
                    "student_name": "محمد سعيد",
                    "grades": {"midterm": 70, "final": 75},
                    "extra_marks": [
                      {"type": "اختبار أول", "mark": 68, "date": "2025-02-15"},
                      {"type": "اختبار ثاني", "mark": 72, "date": "2025-03-10"},
                    ],
                    "rewards": [],
                    "study_plan": null,
                  },
                ],
              },
              {
                "division_id": 1012,
                "division_name": "شعبة ب",
                "students": [
                  {
                    "student_id": 1004,
                    "student_name": "يوسف عمر",
                    "grades": {"midterm": 92, "final": 88},
                    "extra_marks": [
                      {"type": "اختبار أول", "mark": 95, "date": "2025-02-15"},
                      {"type": "اختبار ثاني", "mark": 90, "date": "2025-03-10"},
                      {"type": "مشروع", "mark": 98, "date": "2025-03-25"},
                    ],
                    "rewards": [
                      {
                        "reward_id": 4,
                        "reason": "المركز الأول في مسابقة الرياضيات",
                        "date": "2025-03-20",
                        "points": 20,
                      },
                      {
                        "reward_id": 5,
                        "reason": "مساعدة المعلم",
                        "date": "2025-02-10",
                        "points": 5,
                      },
                    ],
                    "study_plan": {
                      "plan_id": 103,
                      "start_date": "2025-04-01",
                      "end_date": "2025-04-30",
                      "description": "التحضير لمسابقة الرياضيات الوطنية",
                      "tasks": [
                        {
                          "task_id": 6,
                          "title": "حل 20 مسألة إضافية",
                          "deadline": "2025-04-05",
                          "completed": true,
                        },
                        {
                          "task_id": 7,
                          "title": "مراجعة قوانين الهندسة",
                          "deadline": "2025-04-15",
                          "completed": false,
                        },
                      ],
                    },
                  },
                  {
                    "student_id": 1005,
                    "student_name": "سارة خالد",
                    "grades": {"midterm": 88, "final": 91},
                    "extra_marks": [
                      {"type": "اختبار أول", "mark": 86, "date": "2025-02-15"},
                      {"type": "اختبار ثاني", "mark": 90, "date": "2025-03-10"},
                    ],
                    "rewards": [],
                    "study_plan": null,
                  },
                ],
              },
            ],
          },
          {
            "class_id": 102,
            "class_name": "الصف الثاني",
            "divisions": [
              {
                "division_id": 1021,
                "division_name": "شعبة أ",
                "students": [
                  {
                    "student_id": 2001,
                    "student_name": "حسن إبراهيم",
                    "grades": {"midterm": 65, "final": 70},
                    "extra_marks": [
                      {"type": "اختبار أول", "mark": 60, "date": "2025-02-15"},
                      {"type": "اختبار ثاني", "mark": 68, "date": "2025-03-10"},
                    ],
                    "rewards": [],
                    "study_plan": null,
                  },
                  {
                    "student_id": 2002,
                    "student_name": "نورا عبدالله",
                    "grades": {"midterm": 95, "final": 98},
                    "extra_marks": [
                      {"type": "اختبار أول", "mark": 94, "date": "2025-02-15"},
                      {"type": "اختبار ثاني", "mark": 97, "date": "2025-03-10"},
                      {"type": "مشروع", "mark": 100, "date": "2025-03-25"},
                    ],
                    "rewards": [
                      {
                        "reward_id": 6,
                        "reason": "الامتياز في العلوم",
                        "date": "2025-03-25",
                        "points": 15,
                      },
                    ],
                    "study_plan": {
                      "plan_id": 104,
                      "start_date": "2025-04-01",
                      "end_date": "2025-04-20",
                      "description": "مشروع العلوم: بحث عن الطاقة المتجددة",
                      "tasks": [
                        {
                          "task_id": 8,
                          "title": "اختيار موضوع البحث",
                          "deadline": "2025-04-02",
                          "completed": true,
                        },
                        {
                          "task_id": 9,
                          "title": "جمع المعلومات",
                          "deadline": "2025-04-10",
                          "completed": false,
                        },
                      ],
                    },
                  },
                ],
              },
              {
                "division_id": 1022,
                "division_name": "شعبة ب",
                "students": [
                  {
                    "student_id": 2003,
                    "student_name": "ليان مصطفى",
                    "grades": {"midterm": 80, "final": 84},
                    "extra_marks": [
                      {"type": "اختبار أول", "mark": 82, "date": "2025-02-15"},
                      {"type": "اختبار ثاني", "mark": 79, "date": "2025-03-10"},
                    ],
                    "rewards": [
                      {
                        "reward_id": 7,
                        "reason": "الاجتهاد في حل الواجبات",
                        "date": "2025-03-05",
                        "points": 7,
                      },
                    ],
                    "study_plan": null,
                  },
                ],
              },
            ],
          },
        ],
      },
      {
        "school_id": 2,
        "school_name": "مدارس الفكر الحديث",
        "school_address": "جدة - حي الروضة",
        "classes": [
          {
            "class_id": 201,
            "class_name": "الصف الأول",
            "divisions": [
              {
                "division_id": 2011,
                "division_name": "شعبة أ",
                "students": [
                  {
                    "student_id": 3001,
                    "student_name": "ليلى علي",
                    "grades": {"midterm": 95, "final": 97},
                    "extra_marks": [
                      {"type": "اختبار أول", "mark": 93, "date": "2025-02-15"},
                      {"type": "اختبار ثاني", "mark": 96, "date": "2025-03-10"},
                    ],
                    "rewards": [
                      {
                        "reward_id": 8,
                        "reason": "المركز الثاني في الإلقاء",
                        "date": "2025-03-28",
                        "points": 12,
                      },
                    ],
                    "study_plan": null,
                  },
                  {
                    "student_id": 3002,
                    "student_name": "أحمد سمير",
                    "grades": {"midterm": 55, "final": 60},
                    "extra_marks": [
                      {"type": "اختبار أول", "mark": 50, "date": "2025-02-15"},
                    ],
                    "rewards": [],
                    "study_plan": null,
                  },
                ],
              },
              {
                "division_id": 2012,
                "division_name": "شعبة ب",
                "students": [
                  {
                    "student_id": 3003,
                    "student_name": "منى رشيد",
                    "grades": {"midterm": 88, "final": 85},
                    "extra_marks": [
                      {"type": "اختبار أول", "mark": 87, "date": "2025-02-15"},
                      {"type": "مشروع", "mark": 90, "date": "2025-03-25"},
                    ],
                    "rewards": [],
                    "study_plan": {
                      "plan_id": 105,
                      "start_date": "2025-04-01",
                      "end_date": "2025-04-28",
                      "description": "تعزيز قواعد اللغة العربية",
                      "tasks": [
                        {
                          "task_id": 10,
                          "title": "حل تدريبات النحو",
                          "deadline": "2025-04-07",
                          "completed": false,
                        },
                        {
                          "task_id": 11,
                          "title": "كتابة موضوع تعبير",
                          "deadline": "2025-04-14",
                          "completed": true,
                        },
                      ],
                    },
                  },
                ],
              },
            ],
          },
          {
            "class_id": 202,
            "class_name": "الصف الثالث",
            "divisions": [
              {
                "division_id": 2021,
                "division_name": "شعبة أ",
                "students": [
                  {
                    "student_id": 4001,
                    "student_name": "عمر خالد",
                    "grades": {"midterm": 72, "final": 78},
                    "extra_marks": [
                      {"type": "اختبار أول", "mark": 70, "date": "2025-02-15"},
                      {"type": "اختبار ثاني", "mark": 74, "date": "2025-03-10"},
                    ],
                    "rewards": [],
                    "study_plan": null,
                  },
                  {
                    "student_id": 4002,
                    "student_name": "جنى وليد",
                    "grades": {"midterm": 90, "final": 92},
                    "extra_marks": [
                      {"type": "اختبار أول", "mark": 89, "date": "2025-02-15"},
                      {"type": "مشروع", "mark": 95, "date": "2025-03-25"},
                    ],
                    "rewards": [
                      {
                        "reward_id": 9,
                        "reason": "أفضل مشروع علمي",
                        "date": "2025-03-30",
                        "points": 25,
                      },
                    ],
                    "study_plan": null,
                  },
                ],
              },
            ],
          },
        ],
      },
      {
        "school_id": 3,
        "school_name": "مدارس البيان الأهلية",
        "school_address": "الدمام - حي الفيحاء",
        "classes": [
          {
            "class_id": 301,
            "class_name": "الصف الأول",
            "divisions": [
              {
                "division_id": 3011,
                "division_name": "شعبة أ",
                "students": [
                  {
                    "student_id": 5001,
                    "student_name": "سعيد ماجد",
                    "grades": {"midterm": 68, "final": 72},
                    "extra_marks": [],
                    "rewards": [],
                    "study_plan": null,
                  },
                  {
                    "student_id": 5002,
                    "student_name": "أمل ناصر",
                    "grades": {"midterm": 96, "final": 94},
                    "extra_marks": [
                      {"type": "اختبار أول", "mark": 97, "date": "2025-02-15"},
                      {"type": "اختبار ثاني", "mark": 95, "date": "2025-03-10"},
                    ],
                    "rewards": [
                      {
                        "reward_id": 10,
                        "reason": "التميز في اللغة الإنجليزية",
                        "date": "2025-03-18",
                        "points": 15,
                      },
                    ],
                    "study_plan": {
                      "plan_id": 106,
                      "start_date": "2025-04-01",
                      "end_date": "2025-04-20",
                      "description": "إتقان المحادثة الإنجليزية",
                      "tasks": [
                        {
                          "task_id": 12,
                          "title": "حفظ 20 كلمة جديدة",
                          "deadline": "2025-04-05",
                          "completed": false,
                        },
                        {
                          "task_id": 13,
                          "title": "كتابة فقرة عن العائلة",
                          "deadline": "2025-04-12",
                          "completed": true,
                        },
                        {
                          "task_id": 14,
                          "title": "ممارسة المحادثة مع زميل",
                          "deadline": "2025-04-19",
                          "completed": false,
                        },
                      ],
                    },
                  },
                ],
              },
              {
                "division_id": 3012,
                "division_name": "شعبة ب",
                "students": [
                  {
                    "student_id": 5003,
                    "student_name": "ريم فواز",
                    "grades": {"midterm": 84, "final": 88},
                    "extra_marks": [
                      {"type": "اختبار أول", "mark": 82, "date": "2025-02-15"},
                      {"type": "مشروع", "mark": 90, "date": "2025-03-25"},
                    ],
                    "rewards": [],
                    "study_plan": null,
                  },
                ],
              },
            ],
          },
        ],
      },
      {
        "school_id": 4,
        "school_name": "مدارس الريان العالمية",
        "school_address": "الخبر - حي الأندلس",
        "classes": [
          {
            "class_id": 401,
            "class_name": "الصف الأول",
            "divisions": [
              {
                "division_id": 4011,
                "division_name": "شعبة أ",
                "students": [
                  {
                    "student_id": 6001,
                    "student_name": "لؤي حاتم",
                    "grades": {"midterm": 77, "final": 81},
                    "extra_marks": [
                      {"type": "اختبار أول", "mark": 75, "date": "2025-02-15"},
                    ],
                    "rewards": [],
                    "study_plan": null,
                  },
                  {
                    "student_id": 6002,
                    "student_name": "جمانة سامر",
                    "grades": {"midterm": 98, "final": 99},
                    "extra_marks": [
                      {"type": "اختبار أول", "mark": 98, "date": "2025-02-15"},
                      {"type": "اختبار ثاني", "mark": 99, "date": "2025-03-10"},
                      {"type": "مشروع", "mark": 100, "date": "2025-03-25"},
                    ],
                    "rewards": [
                      {
                        "reward_id": 11,
                        "reason": "التفوق العام",
                        "date": "2025-03-30",
                        "points": 30,
                      },
                      {
                        "reward_id": 12,
                        "reason": "المشاركة الفعالة",
                        "date": "2025-03-20",
                        "points": 10,
                      },
                    ],
                    "study_plan": {
                      "plan_id": 107,
                      "start_date": "2025-04-01",
                      "end_date": "2025-04-25",
                      "description": "الاستعداد لمسابقة العلوم",
                      "tasks": [
                        {
                          "task_id": 15,
                          "title": "مراجعة منهج العلوم",
                          "deadline": "2025-04-07",
                          "completed": true,
                        },
                        {
                          "task_id": 16,
                          "title": "حل نماذج اختبارات سابقة",
                          "deadline": "2025-04-15",
                          "completed": false,
                        },
                      ],
                    },
                  },
                  {
                    "student_id": 6003,
                    "student_name": "رغد هشام",
                    "grades": {"midterm": 62, "final": 67},
                    "extra_marks": [
                      {"type": "اختبار أول", "mark": 60, "date": "2025-02-15"},
                      {"type": "اختبار ثاني", "mark": 64, "date": "2025-03-10"},
                    ],
                    "rewards": [],
                    "study_plan": null,
                  },
                ],
              },
            ],
          },
          {
            "class_id": 402,
            "class_name": "الصف الثاني",
            "divisions": [
              {
                "division_id": 4021,
                "division_name": "شعبة أ",
                "students": [
                  {
                    "student_id": 7001,
                    "student_name": "مالك عادل",
                    "grades": {"midterm": 88, "final": 86},
                    "extra_marks": [],
                    "rewards": [
                      {
                        "reward_id": 13,
                        "reason": "حل واجبات إضافية",
                        "date": "2025-03-10",
                        "points": 6,
                      },
                    ],
                    "study_plan": null,
                  },
                ],
              },
            ],
          },
        ],
      },
    ],
  },
};

// ============================================================
// شاشة عرض الصفوف (مع AppBar واضح)
// ============================================================
class ClassesScreen extends StatelessWidget {
  final Map<String, dynamic> school;
  const ClassesScreen({super.key, required this.school});

  @override
  Widget build(BuildContext context) {
    final List classes = school['classes'];
    return Scaffold(
      appBar: AppBar(title: Text(school['school_name']), centerTitle: true),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: classes.length,
        itemBuilder: (context, index) {
          final classItem = classes[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: Text(
                  classItem['class_name'][0],
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              title: Text(
                classItem['class_name'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('${classItem['divisions'].length} شعب'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DivisionsScreen(
                    schoolName: school['school_name'],
                    classItem: classItem,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ============================================================
// شاشة عرض الشعب
// ============================================================
class DivisionsScreen extends StatelessWidget {
  final String schoolName;
  final Map<String, dynamic> classItem;
  const DivisionsScreen({
    super.key,
    required this.schoolName,
    required this.classItem,
  });

  @override
  Widget build(BuildContext context) {
    final List divisions = classItem['divisions'];
    return Scaffold(
      appBar: AppBar(
        title: Text('$schoolName - ${classItem['class_name']}'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: divisions.length,
        itemBuilder: (context, index) {
          final division = divisions[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: const Icon(Icons.group),
              title: Text(
                division['division_name'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('${division['students'].length} طلاب'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => StudentsListScreen(
                    schoolName: schoolName,
                    className: classItem['class_name'],
                    divisionName: division['division_name'],
                    students: division['students'],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'نظام إدارة المعلم',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.teal,
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.grey[50],
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.teal,
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.grey[900],
      ),
      themeMode: ThemeMode.system,
      home: const SchoolsScreen(),
    );
  }
}

// ============================================================
// الشاشة الرئيسية: عرض المدارس في GridView
// ============================================================
class SchoolsScreen extends StatelessWidget {
  const SchoolsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final teacherData = responseData['data'];
    final List schools = teacherData['schools'];

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async => Future.delayed(const Duration(seconds: 1)),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.9,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => _SchoolCard(school: schools[index]),
                    childCount: schools.length,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// شاشة تفاصيل الطالب (تم إزالة المعدل العام)
// ============================================================
class StudentDetailScreen extends StatefulWidget {
  final Map<String, dynamic> studentData;
  const StudentDetailScreen({super.key, required this.studentData});

  @override
  State<StudentDetailScreen> createState() => _StudentDetailScreenState();
}

// ============================================================
// شاشة عرض الطلاب مع بحث (تم تحسين ألوان الخانة)
// ============================================================
class StudentsListScreen extends StatefulWidget {
  final String schoolName;
  final String className;
  final String divisionName;
  final List students;
  const StudentsListScreen({
    super.key,
    required this.schoolName,
    required this.className,
    required this.divisionName,
    required this.students,
  });

  @override
  State<StudentsListScreen> createState() => _StudentsListScreenState();
}

class _ExtraMarkCard extends StatelessWidget {
  final Map<String, dynamic> mark;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  const _ExtraMarkCard({
    required this.mark,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 6),
      child: ListTile(
        title: Text('${mark['type']} : ${mark['mark']}/100'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, size: 18),
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(Icons.delete, size: 18, color: Colors.red),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}

class _GradeCard extends StatelessWidget {
  final String label;
  final int value;
  final Color color;
  const _GradeCard({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label),
            Text(
              '$value/100',
              style: TextStyle(fontWeight: FontWeight.bold, color: color),
            ),
          ],
        ),
      ),
    );
  }
}

class _RewardCard extends StatelessWidget {
  final Map<String, dynamic> reward;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  const _RewardCard({
    required this.reward,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.amber.shade50,
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: const Icon(Icons.emoji_events, color: Colors.amber),
        title: Text(
          reward['reason'],
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Text('${reward['date']} | +${reward['points']} نقطة'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, size: 18),
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(Icons.delete, size: 18, color: Colors.red),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}

class _SchoolCard extends StatelessWidget {
  final Map<String, dynamic> school;
  const _SchoolCard({required this.school});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 4,
      shadowColor: theme.colorScheme.primary.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ClassesScreen(school: school)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.school_outlined,
                size: 56,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(height: 12),
              Text(
                school['school_name'],
                style: theme.textTheme.titleMedium,
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
              const SizedBox(height: 8),
              Text(
                '${school['classes'].length} صفوف',
                style: theme.textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// ويدجتات مساعدة
// ============================================================
class _SectionHeader extends StatelessWidget {
  final String title;
  final IconData icon;
  const _SectionHeader({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 8),
        Text(title, style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }
}

// ============================================================
// باقي الكود (StudentDetailScreenState مع إزالة المعدل العام)
// ============================================================
class _StudentDetailScreenState extends State<StudentDetailScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Map<String, dynamic> student;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final grades = student['grades'];

    return Scaffold(
      appBar: AppBar(title: Text(student['student_name']), centerTitle: true),
      body: FadeTransition(
        opacity: _controller,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // الدرجات
              _SectionHeader(title: '📊 الدرجات', icon: Icons.grade),
              const SizedBox(height: 12),
              _GradeCard(
                label: 'امتحان نصفي',
                value: grades['midterm'],
                color: Colors.blue,
              ),
              _GradeCard(
                label: 'امتحان نهائي',
                value: grades['final'],
                color: Colors.green,
              ),
              if (student['extra_marks'].isNotEmpty) ...[
                const SizedBox(height: 8),
                Text('علامات أخرى', style: theme.textTheme.titleSmall),
                ...List.generate(
                  student['extra_marks'].length,
                  (index) => _ExtraMarkCard(
                    mark: student['extra_marks'][index],
                    onDelete: () => _deleteMark(index),
                    onEdit: () => _editMarkDialog(index),
                  ),
                ),
              ],
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: _showAddMarkDialog,
                  icon: const Icon(Icons.add),
                  label: const Text('إضافة علامة'),
                ),
              ),
              const SizedBox(height: 24),

              // المكافآت
              _SectionHeader(title: '🏆 المكافآت', icon: Icons.emoji_events),
              const SizedBox(height: 8),
              if (student['rewards'].isNotEmpty)
                ...List.generate(
                  student['rewards'].length,
                  (index) => _RewardCard(
                    reward: student['rewards'][index],
                    onDelete: () => _deleteReward(index),
                    onEdit: () => _editRewardDialog(index),
                  ),
                )
              else
                Text('لا توجد مكافآت', style: theme.textTheme.bodySmall),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: _showAddRewardDialog,
                  icon: const Icon(Icons.add),
                  label: const Text('إضافة مكافأة'),
                ),
              ),
              const SizedBox(height: 24),

              // الخطة الدراسية
              _SectionHeader(
                title: '📅 الخطة الدراسية',
                icon: Icons.calendar_month,
              ),
              const SizedBox(height: 8),
              if (student['study_plan'] != null)
                _StudyPlanCard(
                  plan: student['study_plan'],
                  onAddTask: _showAddTaskDialog,
                  onEditTask: _editTaskDialog,
                  onDeleteTask: _deleteTask,
                )
              else
                Text('لا توجد خطة دراسية', style: theme.textTheme.bodySmall),
              if (student['study_plan'] == null)
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: _showAddStudyPlanDialog,
                    icon: const Icon(Icons.add),
                    label: const Text('إضافة خطة'),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    student = Map.from(widget.studentData);
    student['extra_marks'] ??= [];
    student['rewards'] ??= [];
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _controller.forward();
  }

  // -------------------- عمليات التعديل والإضافة --------------------
  void _deleteMark(int index) =>
      setState(() => student['extra_marks'].removeAt(index));
  void _deleteReward(int index) =>
      setState(() => student['rewards'].removeAt(index));
  void _deleteTask(int index) =>
      setState(() => student['study_plan']['tasks'].removeAt(index));

  void _editMarkDialog(int index) async {
    final mark = student['extra_marks'][index];
    final typeController = TextEditingController(text: mark['type']);
    final markController = TextEditingController(text: mark['mark'].toString());
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('تعديل العلامة'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: typeController,
              decoration: const InputDecoration(labelText: 'نوع الامتحان'),
            ),
            TextField(
              controller: markController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'العلامة (0-100)'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('إلغاء'),
          ),
          FilledButton(
            onPressed: () {
              final newMark = int.tryParse(markController.text);
              if (typeController.text.isNotEmpty &&
                  newMark != null &&
                  newMark >= 0 &&
                  newMark <= 100) {
                setState(() {
                  student['extra_marks'][index] = {
                    'type': typeController.text,
                    'mark': newMark,
                    'date': mark['date'],
                  };
                });
                Navigator.pop(ctx);
              }
            },
            child: const Text('حفظ'),
          ),
        ],
      ),
    );
  }

  void _editRewardDialog(int index) async {
    final reward = student['rewards'][index];
    final reasonController = TextEditingController(text: reward['reason']);
    final pointsController = TextEditingController(
      text: reward['points'].toString(),
    );
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('تعديل المكافأة'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: reasonController,
              decoration: const InputDecoration(labelText: 'سبب المكافأة'),
            ),
            TextField(
              controller: pointsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'النقاط'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('إلغاء'),
          ),
          FilledButton(
            onPressed: () {
              final points = int.tryParse(pointsController.text);
              if (reasonController.text.isNotEmpty && points != null) {
                setState(() {
                  student['rewards'][index] = {
                    'reward_id': reward['reward_id'],
                    'reason': reasonController.text,
                    'date': reward['date'],
                    'points': points,
                  };
                });
                Navigator.pop(ctx);
              }
            },
            child: const Text('حفظ'),
          ),
        ],
      ),
    );
  }

  void _editTaskDialog(int index) async {
    final task = student['study_plan']['tasks'][index];
    final titleController = TextEditingController(text: task['title']);
    final deadlineController = TextEditingController(text: task['deadline']);
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('تعديل المهمة'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'عنوان المهمة'),
            ),
            TextField(
              controller: deadlineController,
              decoration: const InputDecoration(labelText: 'تاريخ التسليم'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('إلغاء'),
          ),
          FilledButton(
            onPressed: () {
              if (titleController.text.isNotEmpty &&
                  deadlineController.text.isNotEmpty) {
                setState(() {
                  student['study_plan']['tasks'][index] = {
                    'task_id': task['task_id'],
                    'title': titleController.text,
                    'deadline': deadlineController.text,
                    'completed': task['completed'],
                  };
                });
                Navigator.pop(ctx);
              }
            },
            child: const Text('حفظ'),
          ),
        ],
      ),
    );
  }

  void _showAddMarkDialog() async {
    final typeController = TextEditingController();
    final markController = TextEditingController();
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('إضافة علامة'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: typeController,
              decoration: const InputDecoration(labelText: 'نوع الامتحان'),
            ),
            TextField(
              controller: markController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'العلامة (0-100)'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('إلغاء'),
          ),
          FilledButton(
            onPressed: () {
              final mark = int.tryParse(markController.text);
              if (typeController.text.isNotEmpty &&
                  mark != null &&
                  mark >= 0 &&
                  mark <= 100) {
                setState(() {
                  student['extra_marks'].add({
                    'type': typeController.text,
                    'mark': mark,
                    'date': DateTime.now().toIso8601String().substring(0, 10),
                  });
                });
                Navigator.pop(ctx);
              }
            },
            child: const Text('إضافة'),
          ),
        ],
      ),
    );
  }

  void _showAddRewardDialog() async {
    final reasonController = TextEditingController();
    final pointsController = TextEditingController();
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('إضافة مكافأة'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: reasonController,
              decoration: const InputDecoration(labelText: 'سبب المكافأة'),
            ),
            TextField(
              controller: pointsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'النقاط'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('إلغاء'),
          ),
          FilledButton(
            onPressed: () {
              final points = int.tryParse(pointsController.text);
              if (reasonController.text.isNotEmpty && points != null) {
                setState(() {
                  student['rewards'].add({
                    'reward_id': DateTime.now().millisecondsSinceEpoch,
                    'reason': reasonController.text,
                    'date': DateTime.now().toIso8601String().substring(0, 10),
                    'points': points,
                  });
                });
                Navigator.pop(ctx);
              }
            },
            child: const Text('إضافة'),
          ),
        ],
      ),
    );
  }

  void _showAddStudyPlanDialog() async {
    final descController = TextEditingController();
    final startController = TextEditingController();
    final endController = TextEditingController();
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('إضافة خطة دراسية'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: descController,
              decoration: const InputDecoration(labelText: 'وصف الخطة'),
            ),
            TextField(
              controller: startController,
              decoration: const InputDecoration(
                labelText: 'تاريخ البداية (YYYY-MM-DD)',
              ),
            ),
            TextField(
              controller: endController,
              decoration: const InputDecoration(
                labelText: 'تاريخ النهاية (YYYY-MM-DD)',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('إلغاء'),
          ),
          FilledButton(
            onPressed: () {
              if (descController.text.isNotEmpty &&
                  startController.text.isNotEmpty &&
                  endController.text.isNotEmpty) {
                setState(() {
                  student['study_plan'] = {
                    'plan_id': DateTime.now().millisecondsSinceEpoch,
                    'start_date': startController.text,
                    'end_date': endController.text,
                    'description': descController.text,
                    'tasks': [],
                  };
                });
                Navigator.pop(ctx);
              }
            },
            child: const Text('إضافة'),
          ),
        ],
      ),
    );
  }

  void _showAddTaskDialog() async {
    final titleController = TextEditingController();
    final deadlineController = TextEditingController();
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('إضافة مهمة'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'عنوان المهمة'),
            ),
            TextField(
              controller: deadlineController,
              decoration: const InputDecoration(
                labelText: 'تاريخ التسليم (YYYY-MM-DD)',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('إلغاء'),
          ),
          FilledButton(
            onPressed: () {
              if (titleController.text.isNotEmpty &&
                  deadlineController.text.isNotEmpty) {
                setState(() {
                  student['study_plan']['tasks'].add({
                    'task_id': DateTime.now().millisecondsSinceEpoch,
                    'title': titleController.text,
                    'deadline': deadlineController.text,
                    'completed': false,
                  });
                });
                Navigator.pop(ctx);
              }
            },
            child: const Text('إضافة'),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// شاشة عرض الطلاب (مع تحسين ألوان البحث)
// ============================================================
class _StudentsListScreenState extends State<StudentsListScreen> {
  late List _filteredStudents;
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.schoolName} - ${widget.className} - ${widget.divisionName}',
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              style: theme.textTheme.bodyMedium,
              decoration: InputDecoration(
                hintText: 'بحث عن طالب...',
                hintStyle: theme.textTheme.bodySmall?.copyWith(
                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                ),
                filled: true,
                fillColor: isDark ? Colors.grey[800] : Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                    color: theme.colorScheme.primary,
                    width: 1.5,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _filteredStudents.length,
              itemBuilder: (context, index) {
                final student = _filteredStudents[index];
                final grades = student['grades'];
                final avg =
                    ((grades['midterm'] as int) + (grades['final'] as int)) ~/
                    2;
                final avgColor = avg >= 90
                    ? Colors.green
                    : avg >= 75
                    ? Colors.orange
                    : Colors.red;
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: theme.colorScheme.primary,
                      child: Text(
                        student['student_name'][0],
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(
                      student['student_name'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('المعدل: $avg%'),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: avgColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '$avg%',
                        style: TextStyle(
                          color: avgColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            StudentDetailScreen(studentData: Map.from(student)),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _filteredStudents = widget.students;
    _searchController.addListener(() {
      setState(() {
        _filteredStudents = widget.students
            .where(
              (student) =>
                  student['student_name'].contains(_searchController.text),
            )
            .toList();
      });
    });
  }
}

class _StudyPlanCard extends StatefulWidget {
  final Map<String, dynamic> plan;
  final VoidCallback onAddTask;
  final Function(int) onEditTask;
  final Function(int) onDeleteTask;
  const _StudyPlanCard({
    required this.plan,
    required this.onAddTask,
    required this.onEditTask,
    required this.onDeleteTask,
  });

  @override
  State<_StudyPlanCard> createState() => _StudyPlanCardState();
}

class _StudyPlanCardState extends State<_StudyPlanCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final tasks = widget.plan['tasks'] as List;
    final completed = tasks.where((t) => t['completed'] == true).length;
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text(
              widget.plan['description'],
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              '${widget.plan['start_date']} → ${widget.plan['end_date']}',
            ),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () => setState(() => _expanded = !_expanded),
            ),
          ),
          if (_expanded)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text('تقدم المهام: $completed/${tasks.length}'),
                      const SizedBox(width: 8),
                      Expanded(
                        child: LinearProgressIndicator(
                          value: tasks.isEmpty ? 0 : completed / tasks.length,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ...List.generate(tasks.length, (index) {
                    final task = tasks[index];
                    return ListTile(
                      leading: Icon(
                        task['completed']
                            ? Icons.check_circle
                            : Icons.radio_button_unchecked,
                        color: task['completed'] ? Colors.green : Colors.grey,
                      ),
                      title: Text(
                        task['title'],
                        style: TextStyle(
                          decoration: task['completed']
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, size: 16),
                            onPressed: () => widget.onEditTask(index),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              size: 16,
                              color: Colors.red,
                            ),
                            onPressed: () => widget.onDeleteTask(index),
                          ),
                        ],
                      ),
                    );
                  }),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton.icon(
                      onPressed: widget.onAddTask,
                      icon: const Icon(Icons.add),
                      label: const Text('إضافة مهمة'),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
