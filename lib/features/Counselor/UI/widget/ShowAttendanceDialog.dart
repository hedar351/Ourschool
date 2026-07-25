// lib/features/Counselor/UI/widget/showAttendanceDialog.dart

import 'package:flutter/material.dart';
import 'package:school/features/Counselor/domain/Entities/attendanceEntity/attendanceEntity.dart';
import 'package:school/generated/l10n.dart';

void showAttendanceDialog(
  BuildContext context,
  List<AttendanceEntity> attendance,
) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (dialogContext) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Container(
          padding: const EdgeInsets.all(20),
          constraints: const BoxConstraints(maxWidth: 480, maxHeight: 580),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ====== عنوان Dialog ======
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.event_available,
                      color: Theme.of(context).colorScheme.primary,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      '${S.of(context).Attendance_Record} ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(dialogContext),
                    icon: Icon(
                      Icons.close,
                      color: Theme.of(context).colorScheme.outline,
                      size: 22,
                    ),
                    splashRadius: 24,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(
                      minWidth: 36,
                      minHeight: 36,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // ====== المحتوى ======
              Expanded(
                child: attendance.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.inbox_outlined,
                              size: 56,
                              color: Colors.grey.shade400,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'لا توجد سجلات غياب',
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Column(
                        children: [
                          // ====== رأس الجدول ======
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(
                                context,
                              ).colorScheme.primary.withOpacity(0.08),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                // عمود التاريخ
                                Expanded(
                                  flex: 3,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_today,
                                        size: 15,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        S.of(context).date,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13,
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // مساحة الأزرار
                                const SizedBox(width: 60),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),

                          // ====== قائمة الغيابات ======
                          Expanded(
                            child: ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              itemCount: attendance.length,
                              separatorBuilder: (_, _) =>
                                  const Divider(height: 2, thickness: 0.3),
                              itemBuilder: (context, index) {
                                final record = attendance[index];
                                return _buildAttendanceItem(
                                  context,
                                  record,
                                  index,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
              ),
              const SizedBox(height: 12),

              // ====== أزرار الإجراءات ======
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(dialogContext),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      " ${S.of(context).close}",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

// ====== عنصر الغياب (تاريخ فقط) ======
Widget _buildAttendanceItem(
  BuildContext context,
  AttendanceEntity record,
  int index,
) {
  final isDark = Theme.of(context).brightness == Brightness.dark;

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
    decoration: BoxDecoration(
      color: index.isEven
          ? (isDark
                ? Colors.grey.shade800.withOpacity(0.15)
                : Colors.grey.shade50)
          : Colors.transparent,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        // ====== التاريخ ======
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200.withOpacity(isDark ? 0.2 : 0.5),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Icon(
                    Icons.calendar_today,
                    size: 11,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    record.date ?? 'غير محدد',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),

        // ====== أزرار الإجراءات ======
        SizedBox(
          width: 68,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // زر التعديل
              InkWell(
                onTap: () {
                  // TODO: تعديل الغياب
                },
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.06),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    Icons.edit_outlined,
                    size: 20,
                    color: Colors.blue.shade500,
                  ),
                ),
              ),
              const SizedBox(width: 4),
              // زر الحذف
              InkWell(
                onTap: () {
                  // TODO: حذف الغياب
                },
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.06),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    Icons.delete_outline,
                    size: 20,
                    color: Colors.red.shade500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
