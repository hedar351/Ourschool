// lib/features/Counselor/UI/widget/ShowDialog/showAddAttendanceDialog.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/features/Counselor/UI/bloc/attendance/attendance_bloc.dart';
import 'package:school/generated/l10n.dart';

void showAddAttendanceDialog(BuildContext context, int? localStudentNumber) {
  final DateTime now = DateTime.now();
  DateTime selectedDate = DateTime(now.year, now.month, now.day);

  final attendanceBloc = context.read<AttendanceBloc>();

  // ✅ حسابات القيم الثابتة خارج build
  final double titleIconSize = 24.w;
  final double titleFontSize = 18.sp;
  final double titleGap = 10.w;
  final double containerPaddingHorizontal = 16.w;
  final double containerPaddingVertical = 12.h;
  final double containerBorderRadius = 12.r;
  final double calendarIconSize = 22.w;
  final double calendarGap = 12.w;
  final double calendarFontSize = 16.sp;
  final double editIconSize = 20.w;
  final double editButtonSize = 36.w;
  final double infoIconSize = 14.w;
  final double infoFontSize = 12.sp;
  final double contentGap = 12.h;
  final double infoGap = 6.w;
  final double buttonBorderRadius = 8.r;
  final double dialogBorderRadius = 8.r;

  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (dialogContext) {
      return BlocProvider.value(
        value: attendanceBloc,
        child: StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Row(
                children: [
                  Icon(
                    Icons.event_available,
                    color: Theme.of(context).colorScheme.primary,
                    size: titleIconSize,
                  ),
                  SizedBox(width: titleGap),
                  Text(
                    ' ',
                    style: TextStyle(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: containerPaddingHorizontal,
                      vertical: containerPaddingVertical,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(
                          context,
                        ).colorScheme.primary.withOpacity(0.3),
                        width: 1.w,
                      ),
                      borderRadius: BorderRadius.circular(
                        containerBorderRadius,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          color: Theme.of(context).colorScheme.primary,
                          size: calendarIconSize,
                        ),
                        SizedBox(width: calendarGap),
                        Expanded(
                          child: Text(
                            _formatDate(selectedDate),
                            style: TextStyle(
                              fontSize: calendarFontSize,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: selectedDate,
                              firstDate: DateTime(2000),
                              lastDate: DateTime.now(),
                              builder: (context, child) {
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                    colorScheme: ColorScheme(
                                      brightness: Theme.of(context).brightness,
                                      primary: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                      onPrimary: Theme.of(
                                        context,
                                      ).colorScheme.onPrimary,
                                      secondary: Theme.of(
                                        context,
                                      ).colorScheme.secondary,
                                      onSecondary: Theme.of(
                                        context,
                                      ).colorScheme.onSecondary,
                                      error: Theme.of(
                                        context,
                                      ).colorScheme.error,
                                      onError: Theme.of(
                                        context,
                                      ).colorScheme.onError,
                                      surface: Theme.of(context).cardColor,
                                      onSurface: Theme.of(
                                        context,
                                      ).colorScheme.onSurface,
                                      outline: Theme.of(
                                        context,
                                      ).colorScheme.outline,
                                      surfaceTint: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                    ),
                                    textButtonTheme: TextButtonThemeData(
                                      style: TextButton.styleFrom(
                                        foregroundColor: Theme.of(
                                          context,
                                        ).colorScheme.primary,
                                      ),
                                    ),
                                    textTheme: Theme.of(context).textTheme
                                        .copyWith(
                                          titleLarge: Theme.of(context)
                                              .textTheme
                                              .titleLarge
                                              ?.copyWith(
                                                color: Theme.of(
                                                  context,
                                                ).colorScheme.onSurface,
                                              ),
                                          bodyLarge: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(
                                                color: Theme.of(
                                                  context,
                                                ).colorScheme.onSurface,
                                              ),
                                        ),
                                  ),
                                  child: child!,
                                );
                              },
                            );

                            if (picked != null) {
                              setState(() {
                                selectedDate = DateTime(
                                  picked.year,
                                  picked.month,
                                  picked.day,
                                );
                              });
                            }
                          },
                          icon: Icon(
                            Icons.edit_calendar,
                            color: Theme.of(context).colorScheme.primary,
                            size: editIconSize,
                          ),
                          splashRadius: 20.r,
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(
                            minWidth: editButtonSize,
                            minHeight: editButtonSize,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: contentGap),

                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: infoIconSize,
                        color: Colors.grey.shade500,
                      ),
                      SizedBox(width: infoGap),
                      Text(
                        'السنة: ${selectedDate.year}',
                        style: TextStyle(
                          fontSize: infoFontSize,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: Text(
                    S.of(context).cancel,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);

                    final dateString =
                        '${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}';

                    attendanceBloc.add(
                      AddAttendanceEvent(
                        localStudentNumber: localStudentNumber!,
                        date: dateString,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(buttonBorderRadius),
                    ),
                    minimumSize: Size(80.w, 40.h),
                  ),
                  child: Text(
                    S.of(context).Log,
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ),
              ],
            );
          },
        ),
      );
    },
  );
}

String _formatDate(DateTime date) {
  final months = [
    'يناير',
    'فبراير',
    'مارس',
    'أبريل',
    'مايو',
    'يونيو',
    'يوليو',
    'أغسطس',
    'سبتمبر',
    'أكتوبر',
    'نوفمبر',
    'ديسمبر',
  ];
  return '${date.day} ${months[date.month - 1]} ${date.year}';
}
