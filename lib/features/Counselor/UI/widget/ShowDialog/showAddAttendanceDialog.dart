import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school/features/Counselor/UI/bloc/attendance/attendance_bloc.dart';
import 'package:school/generated/l10n.dart';

void showAddAttendanceDialog(BuildContext context, int? localStudentNumber) {
  final DateTime now = DateTime.now();
  DateTime selectedDate = DateTime(now.year, now.month, now.day);

  final attendanceBloc = context.read<AttendanceBloc>();

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
                  ),
                  const SizedBox(width: 10),
                  Text(
                    ' ',
                    style: TextStyle(
                      fontSize: 18,
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(
                          context,
                        ).colorScheme.primary.withOpacity(0.3),
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          color: Theme.of(context).colorScheme.primary,
                          size: 22,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            _formatDate(selectedDate),
                            style: TextStyle(
                              fontSize: 16,
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
                              // locale: const Locale('ar'),
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
                            size: 20,
                          ),
                          splashRadius: 20,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(
                            minWidth: 36,
                            minHeight: 36,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 14,
                        color: Colors.grey.shade500,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'السنة: ${selectedDate.year}',
                        style: TextStyle(
                          fontSize: 12,
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
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(S.of(context).Log),
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
