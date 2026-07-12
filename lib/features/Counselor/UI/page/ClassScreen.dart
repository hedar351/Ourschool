import 'package:flutter/material.dart';

// ============================================================
// البيانات الموسعة (طلاب أكثر، مواد أكثر، مكافآت وإنذارات)
// ============================================================
final Map<String, dynamic> responseData = {
  "success": true,
  "message": "تم جلب البيانات بنجاح",
  "data": {
    "موجه_id": 31,
    "موجه_name": "أحمد جاد",
    "class": {
      "class_name": "الصف الأول الثانوي",
      "divisions": [
        // ========== شعبة أ ==========
        {
          "division_name": "شعبة أ",
          "students": [
            {
              "student_id": 1001,
              "student_name": "علي أحمد",
              "subjects": [
                {
                  "name": "اللغة العربية",
                  "oral": 80,
                  "midterm": 85,
                  "final": 90,
                },
                {
                  "name": "اللغة الإنجليزية",
                  "oral": 85,
                  "midterm": 88,
                  "final": 92,
                },
                {"name": "الرياضيات", "oral": 88, "midterm": 85, "final": 90},
                {"name": "العلوم", "oral": 75, "midterm": 82, "final": 88},
                {
                  "name": "الدراسات الاجتماعية",
                  "oral": 90,
                  "midterm": 85,
                  "final": 92,
                },
                {"name": "الحاسوب", "oral": 95, "midterm": 90, "final": 94},
                {
                  "name": "التربية الإسلامية",
                  "oral": 92,
                  "midterm": 94,
                  "final": 96,
                },
                {
                  "name": "التربية الفنية",
                  "oral": 88,
                  "midterm": 86,
                  "final": 90,
                },
                {
                  "name": "التربية الرياضية",
                  "oral": 100,
                  "midterm": 95,
                  "final": 98,
                },
                {
                  "name": "المهارات الحياتية",
                  "oral": 85,
                  "midterm": 88,
                  "final": 91,
                },
              ],
              "rewards": [
                {
                  "reward_id": 1,
                  "reason": "تفوق في اختبار الرياضيات",
                  "date": "2025-03-15",
                  "points": 10,
                },
                {
                  "reward_id": 2,
                  "reason": "المركز الأول في مسابقة الروبوت",
                  "date": "2025-02-10",
                  "points": 25,
                },
              ],
              "warnings": [],
            },
            {
              "student_id": 1002,
              "student_name": "فاطمة الزهراء",
              "subjects": [
                {
                  "name": "اللغة العربية",
                  "oral": 92,
                  "midterm": 94,
                  "final": 96,
                },
                {
                  "name": "اللغة الإنجليزية",
                  "oral": 88,
                  "midterm": 90,
                  "final": 93,
                },
                {"name": "الرياضيات", "oral": 85, "midterm": 87, "final": 89},
                {"name": "العلوم", "oral": 90, "midterm": 92, "final": 95},
                {
                  "name": "الدراسات الاجتماعية",
                  "oral": 86,
                  "midterm": 89,
                  "final": 91,
                },
                {"name": "الحاسوب", "oral": 94, "midterm": 96, "final": 98},
                {
                  "name": "التربية الإسلامية",
                  "oral": 98,
                  "midterm": 99,
                  "final": 100,
                },
                {
                  "name": "التربية الفنية",
                  "oral": 92,
                  "midterm": 94,
                  "final": 96,
                },
                {
                  "name": "التربية الرياضية",
                  "oral": 95,
                  "midterm": 93,
                  "final": 97,
                },
                {
                  "name": "المهارات الحياتية",
                  "oral": 90,
                  "midterm": 92,
                  "final": 95,
                },
              ],
              "rewards": [
                {
                  "reward_id": 3,
                  "reason": "المركز الأول في مسابقة اللغة العربية",
                  "date": "2025-03-20",
                  "points": 20,
                },
                {
                  "reward_id": 4,
                  "reason": "الطالبة المثالية لهذا الشهر",
                  "date": "2025-02-28",
                  "points": 30,
                },
              ],
              "warnings": [],
            },
            {
              "student_id": 1003,
              "student_name": "محمد سعيد",
              "subjects": [
                {
                  "name": "اللغة العربية",
                  "oral": 65,
                  "midterm": 70,
                  "final": 75,
                },
                {
                  "name": "اللغة الإنجليزية",
                  "oral": 60,
                  "midterm": 65,
                  "final": 70,
                },
                {"name": "الرياضيات", "oral": 68, "midterm": 72, "final": 78},
                {"name": "العلوم", "oral": 60, "midterm": 68, "final": 72},
                {
                  "name": "الدراسات الاجتماعية",
                  "oral": 70,
                  "midterm": 74,
                  "final": 80,
                },
                {"name": "الحاسوب", "oral": 72, "midterm": 75, "final": 78},
                {
                  "name": "التربية الإسلامية",
                  "oral": 80,
                  "midterm": 82,
                  "final": 85,
                },
                {
                  "name": "التربية الفنية",
                  "oral": 75,
                  "midterm": 78,
                  "final": 80,
                },
                {
                  "name": "التربية الرياضية",
                  "oral": 85,
                  "midterm": 83,
                  "final": 88,
                },
                {
                  "name": "المهارات الحياتية",
                  "oral": 70,
                  "midterm": 73,
                  "final": 76,
                },
              ],
              "rewards": [],
              "warnings": [
                {
                  "warning_id": 1,
                  "reason": "تأخر عن الحصة 3 مرات",
                  "date": "2025-03-10",
                },
                {
                  "warning_id": 2,
                  "reason": "عدم إكمال الواجب المنزلي",
                  "date": "2025-03-25",
                },
              ],
            },
            {
              "student_id": 1004,
              "student_name": "نور الهدى",
              "subjects": [
                {
                  "name": "اللغة العربية",
                  "oral": 96,
                  "midterm": 98,
                  "final": 99,
                },
                {
                  "name": "اللغة الإنجليزية",
                  "oral": 94,
                  "midterm": 96,
                  "final": 98,
                },
                {"name": "الرياضيات", "oral": 97, "midterm": 96, "final": 99},
                {"name": "العلوم", "oral": 98, "midterm": 97, "final": 100},
                {
                  "name": "الدراسات الاجتماعية",
                  "oral": 92,
                  "midterm": 94,
                  "final": 96,
                },
                {"name": "الحاسوب", "oral": 100, "midterm": 99, "final": 100},
                {
                  "name": "التربية الإسلامية",
                  "oral": 99,
                  "midterm": 100,
                  "final": 100,
                },
                {
                  "name": "التربية الفنية",
                  "oral": 96,
                  "midterm": 97,
                  "final": 98,
                },
                {
                  "name": "التربية الرياضية",
                  "oral": 95,
                  "midterm": 96,
                  "final": 97,
                },
                {
                  "name": "المهارات الحياتية",
                  "oral": 98,
                  "midterm": 99,
                  "final": 100,
                },
              ],
              "rewards": [
                {
                  "reward_id": 5,
                  "reason": "التفوق العام",
                  "date": "2025-03-30",
                  "points": 50,
                },
                {
                  "reward_id": 6,
                  "reason": "أفضل مشروع علمي",
                  "date": "2025-03-20",
                  "points": 30,
                },
              ],
              "warnings": [],
            },
          ],
        },
        // ========== شعبة ب ==========
        {
          "division_name": "شعبة ب",
          "students": [
            {
              "student_id": 1011,
              "student_name": "ليلى علي",
              "subjects": [
                {
                  "name": "اللغة العربية",
                  "oral": 92,
                  "midterm": 95,
                  "final": 97,
                },
                {
                  "name": "اللغة الإنجليزية",
                  "oral": 90,
                  "midterm": 93,
                  "final": 96,
                },
                {"name": "الرياضيات", "oral": 90, "midterm": 93, "final": 96},
                {"name": "العلوم", "oral": 95, "midterm": 96, "final": 98},
                {
                  "name": "الدراسات الاجتماعية",
                  "oral": 88,
                  "midterm": 91,
                  "final": 95,
                },
                {"name": "الحاسوب", "oral": 92, "midterm": 94, "final": 97},
                {
                  "name": "التربية الإسلامية",
                  "oral": 94,
                  "midterm": 96,
                  "final": 98,
                },
                {
                  "name": "التربية الفنية",
                  "oral": 89,
                  "midterm": 92,
                  "final": 94,
                },
                {
                  "name": "التربية الرياضية",
                  "oral": 93,
                  "midterm": 94,
                  "final": 96,
                },
                {
                  "name": "المهارات الحياتية",
                  "oral": 91,
                  "midterm": 93,
                  "final": 95,
                },
              ],
              "rewards": [
                {
                  "reward_id": 7,
                  "reason": "الامتياز في مادة العلوم",
                  "date": "2025-03-25",
                  "points": 15,
                },
              ],
              "warnings": [],
            },
            {
              "student_id": 1012,
              "student_name": "سلمى حسن",
              "subjects": [
                {
                  "name": "اللغة العربية",
                  "oral": 78,
                  "midterm": 82,
                  "final": 85,
                },
                {
                  "name": "اللغة الإنجليزية",
                  "oral": 80,
                  "midterm": 83,
                  "final": 87,
                },
                {"name": "الرياضيات", "oral": 75, "midterm": 79, "final": 83},
                {"name": "العلوم", "oral": 82, "midterm": 85, "final": 88},
                {
                  "name": "الدراسات الاجتماعية",
                  "oral": 76,
                  "midterm": 80,
                  "final": 84,
                },
                {"name": "الحاسوب", "oral": 88, "midterm": 90, "final": 92},
                {
                  "name": "التربية الإسلامية",
                  "oral": 85,
                  "midterm": 87,
                  "final": 90,
                },
                {
                  "name": "التربية الفنية",
                  "oral": 82,
                  "midterm": 85,
                  "final": 88,
                },
                {
                  "name": "التربية الرياضية",
                  "oral": 90,
                  "midterm": 89,
                  "final": 93,
                },
                {
                  "name": "المهارات الحياتية",
                  "oral": 80,
                  "midterm": 83,
                  "final": 86,
                },
              ],
              "rewards": [],
              "warnings": [
                {
                  "warning_id": 3,
                  "reason": "عدم تسليم الواجب مرتين",
                  "date": "2025-03-18",
                },
              ],
            },
            {
              "student_id": 1013,
              "student_name": "كريم مصطفى",
              "subjects": [
                {
                  "name": "اللغة العربية",
                  "oral": 70,
                  "midterm": 74,
                  "final": 78,
                },
                {
                  "name": "اللغة الإنجليزية",
                  "oral": 68,
                  "midterm": 72,
                  "final": 76,
                },
                {"name": "الرياضيات", "oral": 72, "midterm": 75, "final": 79},
                {"name": "العلوم", "oral": 66, "midterm": 70, "final": 74},
                {
                  "name": "الدراسات الاجتماعية",
                  "oral": 74,
                  "midterm": 77,
                  "final": 81,
                },
                {"name": "الحاسوب", "oral": 80, "midterm": 83, "final": 86},
                {
                  "name": "التربية الإسلامية",
                  "oral": 78,
                  "midterm": 80,
                  "final": 83,
                },
                {
                  "name": "التربية الفنية",
                  "oral": 75,
                  "midterm": 78,
                  "final": 81,
                },
                {
                  "name": "التربية الرياضية",
                  "oral": 85,
                  "midterm": 86,
                  "final": 89,
                },
                {
                  "name": "المهارات الحياتية",
                  "oral": 76,
                  "midterm": 79,
                  "final": 82,
                },
              ],
              "rewards": [],
              "warnings": [],
            },
            {
              "student_id": 1014,
              "student_name": "منى عبد الله",
              "subjects": [
                {
                  "name": "اللغة العربية",
                  "oral": 88,
                  "midterm": 91,
                  "final": 94,
                },
                {
                  "name": "اللغة الإنجليزية",
                  "oral": 86,
                  "midterm": 89,
                  "final": 92,
                },
                {"name": "الرياضيات", "oral": 84, "midterm": 87, "final": 90},
                {"name": "العلوم", "oral": 87, "midterm": 90, "final": 93},
                {
                  "name": "الدراسات الاجتماعية",
                  "oral": 85,
                  "midterm": 88,
                  "final": 91,
                },
                {"name": "الحاسوب", "oral": 89, "midterm": 92, "final": 95},
                {
                  "name": "التربية الإسلامية",
                  "oral": 92,
                  "midterm": 94,
                  "final": 96,
                },
                {
                  "name": "التربية الفنية",
                  "oral": 86,
                  "midterm": 89,
                  "final": 92,
                },
                {
                  "name": "التربية الرياضية",
                  "oral": 88,
                  "midterm": 90,
                  "final": 93,
                },
                {
                  "name": "المهارات الحياتية",
                  "oral": 87,
                  "midterm": 90,
                  "final": 93,
                },
              ],
              "rewards": [
                {
                  "reward_id": 8,
                  "reason": "المركز الثالث في مسابقة الحاسوب",
                  "date": "2025-03-28",
                  "points": 10,
                },
              ],
              "warnings": [],
            },
          ],
        },
        // ========== شعبة ج ==========
        {
          "division_name": "شعبة ج",
          "students": [
            {
              "student_id": 1021,
              "student_name": "نور إبراهيم",
              "subjects": [
                {
                  "name": "اللغة العربية",
                  "oral": 95,
                  "midterm": 97,
                  "final": 99,
                },
                {
                  "name": "اللغة الإنجليزية",
                  "oral": 92,
                  "midterm": 95,
                  "final": 98,
                },
                {"name": "الرياضيات", "oral": 94, "midterm": 96, "final": 98},
                {"name": "العلوم", "oral": 96, "midterm": 97, "final": 99},
                {
                  "name": "الدراسات الاجتماعية",
                  "oral": 90,
                  "midterm": 93,
                  "final": 96,
                },
                {"name": "الحاسوب", "oral": 98, "midterm": 99, "final": 100},
                {
                  "name": "التربية الإسلامية",
                  "oral": 97,
                  "midterm": 98,
                  "final": 99,
                },
                {
                  "name": "التربية الفنية",
                  "oral": 94,
                  "midterm": 96,
                  "final": 97,
                },
                {
                  "name": "التربية الرياضية",
                  "oral": 96,
                  "midterm": 97,
                  "final": 98,
                },
                {
                  "name": "المهارات الحياتية",
                  "oral": 95,
                  "midterm": 97,
                  "final": 98,
                },
              ],
              "rewards": [
                {
                  "reward_id": 9,
                  "reason": "التفوق العام",
                  "date": "2025-03-30",
                  "points": 30,
                },
                {
                  "reward_id": 10,
                  "reason": "المشاركة الفعالة في الحصة",
                  "date": "2025-03-15",
                  "points": 10,
                },
              ],
              "warnings": [],
            },
            {
              "student_id": 1022,
              "student_name": "عمر خالد",
              "subjects": [
                {
                  "name": "اللغة العربية",
                  "oral": 60,
                  "midterm": 65,
                  "final": 70,
                },
                {
                  "name": "اللغة الإنجليزية",
                  "oral": 55,
                  "midterm": 60,
                  "final": 65,
                },
                {"name": "الرياضيات", "oral": 62, "midterm": 66, "final": 71},
                {"name": "العلوم", "oral": 58, "midterm": 63, "final": 68},
                {
                  "name": "الدراسات الاجتماعية",
                  "oral": 64,
                  "midterm": 68,
                  "final": 73,
                },
                {"name": "الحاسوب", "oral": 60, "midterm": 65, "final": 70},
                {
                  "name": "التربية الإسلامية",
                  "oral": 68,
                  "midterm": 72,
                  "final": 76,
                },
                {
                  "name": "التربية الفنية",
                  "oral": 65,
                  "midterm": 68,
                  "final": 72,
                },
                {
                  "name": "التربية الرياضية",
                  "oral": 70,
                  "midterm": 72,
                  "final": 75,
                },
                {
                  "name": "المهارات الحياتية",
                  "oral": 62,
                  "midterm": 66,
                  "final": 70,
                },
              ],
              "rewards": [],
              "warnings": [
                {
                  "warning_id": 4,
                  "reason": "الغياب المتكرر",
                  "date": "2025-03-05",
                },
                {
                  "warning_id": 5,
                  "reason": "تأخير في تسليم المشروع",
                  "date": "2025-03-22",
                },
              ],
            },
            {
              "student_id": 1023,
              "student_name": "سارة محمود",
              "subjects": [
                {
                  "name": "اللغة العربية",
                  "oral": 84,
                  "midterm": 87,
                  "final": 90,
                },
                {
                  "name": "اللغة الإنجليزية",
                  "oral": 82,
                  "midterm": 85,
                  "final": 88,
                },
                {"name": "الرياضيات", "oral": 86, "midterm": 89, "final": 92},
                {"name": "العلوم", "oral": 83, "midterm": 86, "final": 89},
                {
                  "name": "الدراسات الاجتماعية",
                  "oral": 81,
                  "midterm": 84,
                  "final": 87,
                },
                {"name": "الحاسوب", "oral": 88, "midterm": 91, "final": 94},
                {
                  "name": "التربية الإسلامية",
                  "oral": 90,
                  "midterm": 92,
                  "final": 94,
                },
                {
                  "name": "التربية الفنية",
                  "oral": 85,
                  "midterm": 88,
                  "final": 91,
                },
                {
                  "name": "التربية الرياضية",
                  "oral": 87,
                  "midterm": 89,
                  "final": 92,
                },
                {
                  "name": "المهارات الحياتية",
                  "oral": 84,
                  "midterm": 87,
                  "final": 90,
                },
              ],
              "rewards": [
                {
                  "reward_id": 11,
                  "reason": "التميز في الأنشطة الصفية",
                  "date": "2025-03-10",
                  "points": 8,
                },
              ],
              "warnings": [],
            },
          ],
        },
        // ========== شعبة د ==========
        {
          "division_name": "شعبة د",
          "students": [
            {
              "student_id": 1031,
              "student_name": "مريم سامي",
              "subjects": [
                {
                  "name": "اللغة العربية",
                  "oral": 88,
                  "midterm": 90,
                  "final": 93,
                },
                {
                  "name": "اللغة الإنجليزية",
                  "oral": 85,
                  "midterm": 88,
                  "final": 91,
                },
                {"name": "الرياضيات", "oral": 82, "midterm": 85, "final": 89},
                {"name": "العلوم", "oral": 86, "midterm": 89, "final": 92},
                {
                  "name": "الدراسات الاجتماعية",
                  "oral": 84,
                  "midterm": 87,
                  "final": 90,
                },
                {"name": "الحاسوب", "oral": 90, "midterm": 92, "final": 95},
                {
                  "name": "التربية الإسلامية",
                  "oral": 92,
                  "midterm": 94,
                  "final": 96,
                },
                {
                  "name": "التربية الفنية",
                  "oral": 88,
                  "midterm": 90,
                  "final": 92,
                },
                {
                  "name": "التربية الرياضية",
                  "oral": 91,
                  "midterm": 92,
                  "final": 94,
                },
                {
                  "name": "المهارات الحياتية",
                  "oral": 86,
                  "midterm": 89,
                  "final": 92,
                },
              ],
              "rewards": [
                {
                  "reward_id": 12,
                  "reason": "أفضل مشروع حاسوب",
                  "date": "2025-03-28",
                  "points": 25,
                },
              ],
              "warnings": [],
            },
            {
              "student_id": 1032,
              "student_name": "يوسف عدنان",
              "subjects": [
                {
                  "name": "اللغة العربية",
                  "oral": 75,
                  "midterm": 79,
                  "final": 83,
                },
                {
                  "name": "اللغة الإنجليزية",
                  "oral": 72,
                  "midterm": 76,
                  "final": 80,
                },
                {"name": "الرياضيات", "oral": 78, "midterm": 81, "final": 85},
                {"name": "العلوم", "oral": 74, "midterm": 78, "final": 82},
                {
                  "name": "الدراسات الاجتماعية",
                  "oral": 76,
                  "midterm": 80,
                  "final": 84,
                },
                {"name": "الحاسوب", "oral": 80, "midterm": 83, "final": 87},
                {
                  "name": "التربية الإسلامية",
                  "oral": 82,
                  "midterm": 85,
                  "final": 88,
                },
                {
                  "name": "التربية الفنية",
                  "oral": 78,
                  "midterm": 81,
                  "final": 84,
                },
                {
                  "name": "التربية الرياضية",
                  "oral": 83,
                  "midterm": 85,
                  "final": 88,
                },
                {
                  "name": "المهارات الحياتية",
                  "oral": 79,
                  "midterm": 82,
                  "final": 85,
                },
              ],
              "rewards": [],
              "warnings": [],
            },
            {
              "student_id": 1033,
              "student_name": "هبة الله مصطفى",
              "subjects": [
                {
                  "name": "اللغة العربية",
                  "oral": 91,
                  "midterm": 93,
                  "final": 95,
                },
                {
                  "name": "اللغة الإنجليزية",
                  "oral": 89,
                  "midterm": 92,
                  "final": 94,
                },
                {"name": "الرياضيات", "oral": 87, "midterm": 90, "final": 93},
                {"name": "العلوم", "oral": 90, "midterm": 92, "final": 95},
                {
                  "name": "الدراسات الاجتماعية",
                  "oral": 88,
                  "midterm": 91,
                  "final": 94,
                },
                {"name": "الحاسوب", "oral": 92, "midterm": 94, "final": 97},
                {
                  "name": "التربية الإسلامية",
                  "oral": 94,
                  "midterm": 96,
                  "final": 98,
                },
                {
                  "name": "التربية الفنية",
                  "oral": 90,
                  "midterm": 92,
                  "final": 94,
                },
                {
                  "name": "التربية الرياضية",
                  "oral": 91,
                  "midterm": 93,
                  "final": 95,
                },
                {
                  "name": "المهارات الحياتية",
                  "oral": 89,
                  "midterm": 92,
                  "final": 94,
                },
              ],
              "rewards": [
                {
                  "reward_id": 13,
                  "reason": "المركز الأول في مسابقة الإلقاء",
                  "date": "2025-03-22",
                  "points": 18,
                },
              ],
              "warnings": [],
            },
          ],
        },
        // ========== شعبة هـ ==========
        {
          "division_name": "شعبة هـ",
          "students": [
            {
              "student_id": 1041,
              "student_name": "خالد فوزي",
              "subjects": [
                {
                  "name": "اللغة العربية",
                  "oral": 79,
                  "midterm": 83,
                  "final": 87,
                },
                {
                  "name": "اللغة الإنجليزية",
                  "oral": 76,
                  "midterm": 80,
                  "final": 84,
                },
                {"name": "الرياضيات", "oral": 81, "midterm": 84, "final": 88},
                {"name": "العلوم", "oral": 78, "midterm": 82, "final": 86},
                {
                  "name": "الدراسات الاجتماعية",
                  "oral": 80,
                  "midterm": 83,
                  "final": 87,
                },
                {"name": "الحاسوب", "oral": 83, "midterm": 86, "final": 89},
                {
                  "name": "التربية الإسلامية",
                  "oral": 85,
                  "midterm": 88,
                  "final": 91,
                },
                {
                  "name": "التربية الفنية",
                  "oral": 82,
                  "midterm": 85,
                  "final": 88,
                },
                {
                  "name": "التربية الرياضية",
                  "oral": 88,
                  "midterm": 89,
                  "final": 92,
                },
                {
                  "name": "المهارات الحياتية",
                  "oral": 81,
                  "midterm": 84,
                  "final": 87,
                },
              ],
              "rewards": [],
              "warnings": [],
            },
            {
              "student_id": 1042,
              "student_name": "رنا كريم",
              "subjects": [
                {
                  "name": "اللغة العربية",
                  "oral": 93,
                  "midterm": 95,
                  "final": 97,
                },
                {
                  "name": "اللغة الإنجليزية",
                  "oral": 91,
                  "midterm": 93,
                  "final": 95,
                },
                {"name": "الرياضيات", "oral": 89, "midterm": 92, "final": 94},
                {"name": "العلوم", "oral": 92, "midterm": 94, "final": 96},
                {
                  "name": "الدراسات الاجتماعية",
                  "oral": 90,
                  "midterm": 93,
                  "final": 95,
                },
                {"name": "الحاسوب", "oral": 93, "midterm": 95, "final": 97},
                {
                  "name": "التربية الإسلامية",
                  "oral": 95,
                  "midterm": 97,
                  "final": 98,
                },
                {
                  "name": "التربية الفنية",
                  "oral": 91,
                  "midterm": 93,
                  "final": 95,
                },
                {
                  "name": "التربية الرياضية",
                  "oral": 92,
                  "midterm": 93,
                  "final": 95,
                },
                {
                  "name": "المهارات الحياتية",
                  "oral": 90,
                  "midterm": 92,
                  "final": 94,
                },
              ],
              "rewards": [
                {
                  "reward_id": 14,
                  "reason": "المركز الثاني في معرض العلوم",
                  "date": "2025-03-27",
                  "points": 12,
                },
              ],
              "warnings": [],
            },
            {
              "student_id": 1043,
              "student_name": "زياد طارق",
              "subjects": [
                {
                  "name": "اللغة العربية",
                  "oral": 68,
                  "midterm": 72,
                  "final": 76,
                },
                {
                  "name": "اللغة الإنجليزية",
                  "oral": 65,
                  "midterm": 69,
                  "final": 73,
                },
                {"name": "الرياضيات", "oral": 70, "midterm": 74, "final": 78},
                {"name": "العلوم", "oral": 66, "midterm": 70, "final": 74},
                {
                  "name": "الدراسات الاجتماعية",
                  "oral": 68,
                  "midterm": 72,
                  "final": 76,
                },
                {"name": "الحاسوب", "oral": 72, "midterm": 75, "final": 78},
                {
                  "name": "التربية الإسلامية",
                  "oral": 74,
                  "midterm": 77,
                  "final": 80,
                },
                {
                  "name": "التربية الفنية",
                  "oral": 70,
                  "midterm": 73,
                  "final": 76,
                },
                {
                  "name": "التربية الرياضية",
                  "oral": 78,
                  "midterm": 79,
                  "final": 82,
                },
                {
                  "name": "المهارات الحياتية",
                  "oral": 69,
                  "midterm": 72,
                  "final": 75,
                },
              ],
              "rewards": [],
              "warnings": [
                {
                  "warning_id": 6,
                  "reason": "إهمال الواجبات",
                  "date": "2025-03-12",
                },
              ],
            },
          ],
        },
        // ========== شعبة و ==========
        {
          "division_name": "شعبة و",
          "students": [
            {
              "student_id": 1051,
              "student_name": "شهد جميل",
              "subjects": [
                {
                  "name": "اللغة العربية",
                  "oral": 96,
                  "midterm": 98,
                  "final": 99,
                },
                {
                  "name": "اللغة الإنجليزية",
                  "oral": 94,
                  "midterm": 96,
                  "final": 98,
                },
                {"name": "الرياضيات", "oral": 92, "midterm": 95, "final": 97},
                {"name": "العلوم", "oral": 95, "midterm": 97, "final": 99},
                {
                  "name": "الدراسات الاجتماعية",
                  "oral": 91,
                  "midterm": 93,
                  "final": 96,
                },
                {"name": "الحاسوب", "oral": 97, "midterm": 98, "final": 100},
                {
                  "name": "التربية الإسلامية",
                  "oral": 98,
                  "midterm": 99,
                  "final": 100,
                },
                {
                  "name": "التربية الفنية",
                  "oral": 94,
                  "midterm": 96,
                  "final": 98,
                },
                {
                  "name": "التربية الرياضية",
                  "oral": 95,
                  "midterm": 96,
                  "final": 98,
                },
                {
                  "name": "المهارات الحياتية",
                  "oral": 93,
                  "midterm": 95,
                  "final": 97,
                },
              ],
              "rewards": [
                {
                  "reward_id": 15,
                  "reason": "المركز الأول على مستوى المدرسة",
                  "date": "2025-03-31",
                  "points": 50,
                },
              ],
              "warnings": [],
            },
            {
              "student_id": 1052,
              "student_name": "عبد الرحمن ناصر",
              "subjects": [
                {
                  "name": "اللغة العربية",
                  "oral": 62,
                  "midterm": 66,
                  "final": 70,
                },
                {
                  "name": "اللغة الإنجليزية",
                  "oral": 59,
                  "midterm": 63,
                  "final": 67,
                },
                {"name": "الرياضيات", "oral": 64, "midterm": 68, "final": 72},
                {"name": "العلوم", "oral": 60, "midterm": 64, "final": 68},
                {
                  "name": "الدراسات الاجتماعية",
                  "oral": 63,
                  "midterm": 67,
                  "final": 71,
                },
                {"name": "الحاسوب", "oral": 66, "midterm": 69, "final": 73},
                {
                  "name": "التربية الإسلامية",
                  "oral": 68,
                  "midterm": 72,
                  "final": 75,
                },
                {
                  "name": "التربية الفنية",
                  "oral": 64,
                  "midterm": 67,
                  "final": 70,
                },
                {
                  "name": "التربية الرياضية",
                  "oral": 72,
                  "midterm": 73,
                  "final": 76,
                },
                {
                  "name": "المهارات الحياتية",
                  "oral": 65,
                  "midterm": 68,
                  "final": 72,
                },
              ],
              "rewards": [],
              "warnings": [
                {
                  "warning_id": 7,
                  "reason": "انخفاض ملحوظ في الدرجات",
                  "date": "2025-03-20",
                },
                {
                  "warning_id": 8,
                  "reason": "الغياب بدون عذر",
                  "date": "2025-03-28",
                },
              ],
            },
          ],
        },
        // ========== شعبة ز ==========
        {
          "division_name": "شعبة ز",
          "students": [
            {
              "student_id": 1061,
              "student_name": "لمى عادل",
              "subjects": [
                {
                  "name": "اللغة العربية",
                  "oral": 87,
                  "midterm": 90,
                  "final": 93,
                },
                {
                  "name": "اللغة الإنجليزية",
                  "oral": 85,
                  "midterm": 88,
                  "final": 91,
                },
                {"name": "الرياضيات", "oral": 83, "midterm": 86, "final": 89},
                {"name": "العلوم", "oral": 86, "midterm": 89, "final": 92},
                {
                  "name": "الدراسات الاجتماعية",
                  "oral": 84,
                  "midterm": 87,
                  "final": 90,
                },
                {"name": "الحاسوب", "oral": 88, "midterm": 91, "final": 94},
                {
                  "name": "التربية الإسلامية",
                  "oral": 90,
                  "midterm": 92,
                  "final": 94,
                },
                {
                  "name": "التربية الفنية",
                  "oral": 86,
                  "midterm": 89,
                  "final": 92,
                },
                {
                  "name": "التربية الرياضية",
                  "oral": 89,
                  "midterm": 90,
                  "final": 93,
                },
                {
                  "name": "المهارات الحياتية",
                  "oral": 85,
                  "midterm": 88,
                  "final": 91,
                },
              ],
              "rewards": [
                {
                  "reward_id": 16,
                  "reason": "أفضل بحث في الدراسات",
                  "date": "2025-03-24",
                  "points": 12,
                },
              ],
              "warnings": [],
            },
            {
              "student_id": 1062,
              "student_name": "عمرو ياسر",
              "subjects": [
                {
                  "name": "اللغة العربية",
                  "oral": 71,
                  "midterm": 75,
                  "final": 79,
                },
                {
                  "name": "اللغة الإنجليزية",
                  "oral": 68,
                  "midterm": 72,
                  "final": 76,
                },
                {"name": "الرياضيات", "oral": 73, "midterm": 76, "final": 80},
                {"name": "العلوم", "oral": 69, "midterm": 73, "final": 77},
                {
                  "name": "الدراسات الاجتماعية",
                  "oral": 72,
                  "midterm": 75,
                  "final": 79,
                },
                {"name": "الحاسوب", "oral": 74, "midterm": 77, "final": 81},
                {
                  "name": "التربية الإسلامية",
                  "oral": 76,
                  "midterm": 79,
                  "final": 83,
                },
                {
                  "name": "التربية الفنية",
                  "oral": 73,
                  "midterm": 76,
                  "final": 80,
                },
                {
                  "name": "التربية الرياضية",
                  "oral": 79,
                  "midterm": 80,
                  "final": 84,
                },
                {
                  "name": "المهارات الحياتية",
                  "oral": 72,
                  "midterm": 75,
                  "final": 79,
                },
              ],
              "rewards": [],
              "warnings": [],
            },
          ],
        },
      ],
    },
  },
};

// ============================================================
// الشاشة الرئيسية: عرض الشعب (بدون زر رجوع)
// ============================================================
class ClassScreen extends StatelessWidget {
  const ClassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = responseData['data'];
    final className = data['class']['class_name'];
    final List divisions = data['class']['divisions'];
    final teacherName = data['موجه_name'];

    return Scaffold(
      appBar: AppBar(
        title: Text('أ. $teacherName - $className'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: divisions.length,
        itemBuilder: (context, index) {
          final division = divisions[index];
          return Hero(
            tag: 'division_${division['division_name']}',
            child: Card(
              margin: const EdgeInsets.only(bottom: 16),
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => StudentsListScreen(
                        className: className,
                        divisionName: division['division_name'],
                        students: division['students'],
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Theme.of(context).colorScheme.primary,
                              Theme.of(
                                context,
                              ).colorScheme.primary.withOpacity(0.7),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: Text(
                            division['division_name'][0],
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              division['division_name'],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(
                                  Icons.people,
                                  size: 16,
                                  color: Colors.grey[600],
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${division['students'].length} طالب/طلاب',
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).colorScheme.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
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
// شاشة تفاصيل الطالب (إنذارات قابلة للإدارة، مكافآت للعرض فقط)
// ============================================================
class StudentDetailScreen extends StatefulWidget {
  final Map<String, dynamic> studentData;
  const StudentDetailScreen({super.key, required this.studentData});

  @override
  State<StudentDetailScreen> createState() => _StudentDetailScreenState();
}

// ============================================================
// شاشة عرض الطلاب في الشعبة (مع بحث)
// ============================================================
class StudentsListScreen extends StatefulWidget {
  final String className;
  final String divisionName;
  final List students;
  const StudentsListScreen({
    super.key,
    required this.className,
    required this.divisionName,
    required this.students,
  });

  @override
  State<StudentsListScreen> createState() => _StudentsListScreenState();
}

class _GradeChip extends StatelessWidget {
  final String label;
  final int value;
  const _GradeChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    Color color = Colors.blue;
    if (value >= 85)
      color = Colors.green;
    else if (value >= 70)
      color = Colors.orange;
    else if (value < 60)
      color = Colors.red;
    return Chip(
      label: Text(
        '$label: $value',
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
      backgroundColor: color.withOpacity(0.1),
    );
  }
}

class _RewardCard extends StatelessWidget {
  final Map<String, dynamic> reward;
  const _RewardCard({required this.reward});

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

class _StudentDetailScreenState extends State<StudentDetailScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Map<String, dynamic> student;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final subjects = student['subjects'] as List;
    final avg = _calculateAverage();
    final avgColor = avg >= 90
        ? Colors.green
        : avg >= 75
        ? Colors.orange
        : Colors.red;

    return Scaffold(
      appBar: AppBar(title: Text(student['student_name']), centerTitle: true),
      body: FadeTransition(
        opacity: _controller,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // بطاقة المعدل العام
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.auto_graph,
                        size: 48,
                        color: Colors.teal,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'المعدل العام',
                        style: theme.textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 16),
                      TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0.0, end: avg),
                        duration: const Duration(milliseconds: 1500),
                        builder: (context, value, _) => Text(
                          '${value.toStringAsFixed(1)}%',
                          style: theme.textTheme.displayMedium?.copyWith(
                            color: avgColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0.0, end: avg / 100),
                        duration: const Duration(milliseconds: 1000),
                        builder: (context, value, _) => LinearProgressIndicator(
                          value: value,
                          backgroundColor: Colors.grey[200],
                          color: avgColor,
                          minHeight: 8,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // المواد الدراسية (ExpansionTile أنيق)
              _SectionHeader(title: '📚 المواد الدراسية', icon: Icons.book),
              const SizedBox(height: 12),
              ...subjects.map(
                (subject) => Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ExpansionTile(
                    tilePadding: const EdgeInsets.symmetric(horizontal: 16),
                    leading: CircleAvatar(
                      backgroundColor: theme.colorScheme.primary.withOpacity(
                        0.1,
                      ),
                      child: Text(
                        subject['name'][0],
                        style: TextStyle(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(
                      subject['name'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _GradeChip(label: 'شفوي', value: subject['oral']),
                            _GradeChip(
                              label: 'نصفي',
                              value: subject['midterm'],
                            ),
                            _GradeChip(label: 'نهائي', value: subject['final']),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // الإنذارات
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _SectionHeader(
                    title: '⚠️ الإنذارات',
                    icon: Icons.warning_amber,
                  ),
                  IconButton(
                    onPressed: _addWarning,
                    icon: const Icon(Icons.add_circle, color: Colors.red),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              if (student['warnings'].isNotEmpty)
                ...List.generate(
                  student['warnings'].length,
                  (index) => _WarningCard(
                    warning: student['warnings'][index],
                    onEdit: () => _editWarning(index),
                    onDelete: () => _deleteWarning(index),
                  ),
                )
              else
                Text('لا توجد إنذارات', style: theme.textTheme.bodySmall),
              const SizedBox(height: 24),

              // المكافآت (عرض فقط)
              _SectionHeader(title: '🏆 المكافآت', icon: Icons.emoji_events),
              const SizedBox(height: 8),
              if (student['rewards'].isNotEmpty)
                ...List.generate(
                  student['rewards'].length,
                  (index) => _RewardCard(reward: student['rewards'][index]),
                )
              else
                Text('لا توجد مكافآت', style: theme.textTheme.bodySmall),
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
    student['rewards'] ??= [];
    student['warnings'] ??= [];
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _controller.forward();
  }

  void _addWarning() async {
    final reasonController = TextEditingController();
    final dateController = TextEditingController(
      text: DateTime.now().toIso8601String().substring(0, 10),
    );
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('⚠️ إضافة إنذار'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: reasonController,
              decoration: const InputDecoration(labelText: 'سبب الإنذار'),
              autofocus: true,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: dateController,
              decoration: const InputDecoration(
                labelText: 'التاريخ (YYYY-MM-DD)',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              final reason = reasonController.text.trim();
              final date = dateController.text.trim();
              if (reason.isNotEmpty && date.isNotEmpty) {
                setState(() {
                  student['warnings'].add({
                    'warning_id': DateTime.now().millisecondsSinceEpoch,
                    'reason': reason,
                    'date': date,
                  });
                });
                Navigator.pop(ctx);
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('إضافة'),
          ),
        ],
      ),
    );
  }

  double _calculateAverage() {
    final subjects = student['subjects'] as List;
    if (subjects.isEmpty) return 0;
    double sum = 0;
    for (var subject in subjects) {
      sum += (subject['final'] as num).toDouble();
    }
    return sum / subjects.length;
  }

  void _deleteWarning(int index) =>
      setState(() => student['warnings'].removeAt(index));

  void _editWarning(int index) async {
    final warning = student['warnings'][index];
    final reasonController = TextEditingController(text: warning['reason']);
    final dateController = TextEditingController(text: warning['date']);
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('✏️ تعديل الإنذار'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: reasonController,
              decoration: const InputDecoration(labelText: 'سبب الإنذار'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: dateController,
              decoration: const InputDecoration(
                labelText: 'التاريخ (YYYY-MM-DD)',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              final reason = reasonController.text.trim();
              final date = dateController.text.trim();
              if (reason.isNotEmpty && date.isNotEmpty) {
                setState(() {
                  student['warnings'][index] = {
                    'warning_id': warning['warning_id'],
                    'reason': reason,
                    'date': date,
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
}

class _StudentsListScreenState extends State<StudentsListScreen> {
  late List _filteredStudents;
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.className} - ${widget.divisionName}'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? Colors.grey[800] : Colors.grey[100],
              borderRadius: BorderRadius.circular(30),
            ),
            child: TextField(
              controller: _searchController,
              style: theme.textTheme.bodyMedium,
              decoration: InputDecoration(
                hintText: '🔍 بحث عن طالب...',
                hintStyle: theme.textTheme.bodySmall?.copyWith(
                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 14,
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
                final avg = _calculateStudentAverage(student['subjects']);
                final avgColor = avg >= 90
                    ? Colors.green
                    : avg >= 75
                    ? Colors.orange
                    : Colors.red;
                return Hero(
                  tag: 'student_${student['student_id']}',
                  child: Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => StudentDetailScreen(
                            studentData: Map.from(student),
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Container(
                              width: 55,
                              height: 55,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    theme.colorScheme.primary,
                                    theme.colorScheme.primaryContainer,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Center(
                                child: Text(
                                  student['student_name'][0],
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    student['student_name'],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  LinearProgressIndicator(
                                    value: avg / 100,
                                    backgroundColor: Colors.grey[200],
                                    color: avgColor,
                                    minHeight: 6,
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: avgColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                '${avg.toStringAsFixed(0)}%',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: avgColor,
                                ),
                              ),
                            ),
                            const Icon(Icons.chevron_right, color: Colors.grey),
                          ],
                        ),
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

  double _calculateStudentAverage(List subjects) {
    if (subjects.isEmpty) return 0;
    double sum = 0;
    for (var subject in subjects) {
      sum += (subject['final'] as num).toDouble();
    }
    return sum / subjects.length;
  }
}

class _WarningCard extends StatelessWidget {
  final Map<String, dynamic> warning;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  const _WarningCard({
    required this.warning,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.red.shade50,
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: const Icon(Icons.warning, color: Colors.red),
        title: Text(
          warning['reason'] ?? 'إنذار',
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Text(warning['date'] ?? 'تاريخ غير محدد'),
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
