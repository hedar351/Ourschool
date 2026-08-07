// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:school/core/widget/Loadingwidget.dart';
// import 'package:school/features/Student/ui/bloc/reservation_bloc/reservation_bloc.dart';
// import 'package:school/features/Student/ui/bloc/reservation_bloc/reservation_event.dart';
// import 'package:school/features/Student/ui/bloc/reservation_bloc/reservation_state.dart';
// import 'package:school/generated/l10n.dart';

// class ReservationsDialog extends StatefulWidget {
//   final ReservationsBloc reservationsBloc;

//   const ReservationsDialog({super.key, required this.reservationsBloc});

//   @override
//   State<ReservationsDialog> createState() => _ReservationsDialogState();
// }

// class _ReservationsDialogState extends State<ReservationsDialog> {
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return Dialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
//       elevation: 0,
//       backgroundColor: theme.scaffoldBackgroundColor,
//       child: BlocListener<ReservationsBloc, ReservationsState>(
//         bloc: widget.reservationsBloc,
//         listener: (context, state) {
//           if (state is ReservationsError) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text(state.message),
//                 backgroundColor: Colors.red,
//                 duration: const Duration(seconds: 2),
//               ),
//             );
//           }
//         },
//         child: BlocBuilder<ReservationsBloc, ReservationsState>(
//           bloc: widget.reservationsBloc,
//           builder: (context, state) {
//             if (state is ReservationsLoading) {
//               return Container(
//                 height: 400.h,
//                 padding: EdgeInsets.all(24.w),
//                 child: const Center(child: Loadingwidget()),
//               );
//             }

//             if (state is ReservationsLoaded) {
//               final reservations = state.reservations;
//               final list = reservations.reserveBookInfo ?? [];

//               return Container(
//                 constraints: BoxConstraints(maxHeight: 500.h, minHeight: 200.h),
//                 padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 20.h),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     // ---- مؤشر السحب ----
//                     Container(
//                       width: 40.w,
//                       height: 4.h,
//                       decoration: BoxDecoration(
//                         color: Colors.grey.shade300,
//                         borderRadius: BorderRadius.circular(2.r),
//                       ),
//                     ),
//                     SizedBox(height: 16.h),

//                     // ---- العنوان مع الإحصائيات ----
//                     Row(
//                       children: [
//                         Container(
//                           padding: EdgeInsets.all(10.w),
//                           decoration: BoxDecoration(
//                             color: theme.colorScheme.primary.withOpacity(0.1),
//                             shape: BoxShape.circle,
//                           ),
//                           child: Icon(
//                             Icons.bookmark_rounded,
//                             color: theme.colorScheme.primary,
//                             size: 22.w,
//                           ),
//                         ),
//                         SizedBox(width: 12.w),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 S.of(context).My_Reservations,
//                                 style: TextStyle(
//                                   fontSize: 18.sp,
//                                   fontWeight: FontWeight.bold,
//                                   color: theme.colorScheme.onSurface,
//                                 ),
//                               ),
//                               Text(
//                                 '${reservations.totalReservations ?? 0} حجز',
//                                 style: TextStyle(
//                                   fontSize: 13.sp,
//                                   color: Colors.grey.shade600,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),

//                     SizedBox(height: 12.h),

//                     // ---- إحصائيات سريعة ----
//                     Row(
//                       children: [
//                         _buildStatItem(
//                           context,
//                           Icons.library_books_rounded,
//                           '${reservations.totalReservations ?? 0}',
//                           'الإجمالي',
//                         ),
//                         _buildStatItem(
//                           context,
//                           Icons.access_time_rounded,
//                           '${reservations.pendingReservations ?? 0}',
//                           'قيد الانتظار',
//                         ),
//                         _buildStatItem(
//                           context,
//                           Icons.check_circle_rounded,
//                           '${reservations.approvedReservations ?? 0}',
//                           'موافق عليه',
//                         ),
//                       ],
//                     ),

//                     SizedBox(height: 16.h),

//                     // ---- قائمة الحجوزات ----
//                     if (list.isEmpty)
//                       Expanded(
//                         child: Center(
//                           child: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Icon(
//                                 Icons.inbox_outlined,
//                                 size: 48.w,
//                                 color: Colors.grey.shade400,
//                               ),
//                               SizedBox(height: 8.h),
//                               Text(
//                                 'لا توجد حجوزات',
//                                 style: TextStyle(
//                                   fontSize: 14.sp,
//                                   color: Colors.grey.shade600,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       )
//                     else
//                       Expanded(
//                         child: ListView.separated(
//                           shrinkWrap: true,
//                           itemCount: list.length,
//                           separatorBuilder: (_, _) => Divider(
//                             height: 12.h,
//                             color: Colors.grey.shade200,
//                           ),
//                           itemBuilder: (_, i) {
//                             final item = list[i];
//                             final isPending =
//                                 item.status?.toLowerCase() == 'pending';
//                             final statusColor = isPending
//                                 ? Colors.orange
//                                 : Colors.green;

//                             return ListTile(
//                               contentPadding: EdgeInsets.zero,
//                               leading: Container(
//                                 width: 44.w,
//                                 height: 44.w,
//                                 decoration: BoxDecoration(
//                                   color: theme.colorScheme.primary.withOpacity(
//                                     0.1,
//                                   ),
//                                   borderRadius: BorderRadius.circular(12.r),
//                                 ),
//                                 child: Center(
//                                   child: Text(
//                                     '${item.localBookNumber}',
//                                     style: TextStyle(
//                                       fontSize: 16.sp,
//                                       fontWeight: FontWeight.bold,
//                                       color: theme.colorScheme.primary,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               title: Text(
//                                 item.bookTitle ?? 'كتاب',
//                                 style: TextStyle(
//                                   fontSize: 14.sp,
//                                   fontWeight: FontWeight.w600,
//                                   color: theme.colorScheme.onSurface,
//                                 ),
//                                 maxLines: 1,
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                               subtitle: Text(
//                                 item.date != null
//                                     ? 'تاريخ الحجز: ${_formatDate(item.date!)}'
//                                     : '',
//                                 style: TextStyle(
//                                   fontSize: 11.sp,
//                                   color: Colors.grey.shade500,
//                                 ),
//                               ),
//                               trailing: Container(
//                                 padding: EdgeInsets.symmetric(
//                                   horizontal: 10.w,
//                                   vertical: 4.h,
//                                 ),
//                                 decoration: BoxDecoration(
//                                   color: statusColor.withOpacity(0.12),
//                                   borderRadius: BorderRadius.circular(12.r),
//                                 ),
//                                 child: Text(
//                                   item.statusName ?? 'قيد الانتظار',
//                                   style: TextStyle(
//                                     fontSize: 11.sp,
//                                     fontWeight: FontWeight.w600,
//                                     color: statusColor,
//                                   ),
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       ),

//                     SizedBox(height: 16.h),

//                     // ---- زر إغلاق ----
//                     SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton(
//                         onPressed: () => Navigator.pop(context),
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: theme.colorScheme.primary,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(14.r),
//                           ),
//                           padding: EdgeInsets.symmetric(vertical: 12.h),
//                         ),
//                         child: Text(
//                           S.of(context).close,
//                           style: TextStyle(
//                             fontSize: 15.sp,
//                             fontWeight: FontWeight.w600,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             }

//             // حالة خطأ أو غير ذلك
//             if (state is ReservationsError) {
//               return Container(
//                 height: 200.h,
//                 padding: EdgeInsets.all(24.w),
//                 child: Center(
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Icon(
//                         Icons.error_outline,
//                         size: 48.w,
//                         color: Colors.red.shade300,
//                       ),
//                       SizedBox(height: 12.h),
//                       Text(
//                         state.message,
//                         style: TextStyle(
//                           fontSize: 14.sp,
//                           color: Colors.grey.shade700,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                       SizedBox(height: 16.h),
//                       TextButton(
//                         onPressed: () {
//                           widget.reservationsBloc.add(
//                             RefreshReservationsEvent(),
//                           );
//                         },
//                         child: Text(
//                           'إعادة المحاولة',
//                           style: TextStyle(
//                             fontSize: 14.sp,
//                             color: theme.colorScheme.primary,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             }

//             // حالة Initial
//             return Container(
//               height: 200.h,
//               padding: EdgeInsets.all(24.w),
//               child: const Center(child: Text('جاري تحميل البيانات...')),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       widget.reservationsBloc.add(GetReservationsEvent());
//     });
//   }

//   Widget _buildStatItem(
//     BuildContext context,
//     IconData icon,
//     String value,
//     String label,
//   ) {
//     return Expanded(
//       child: Column(
//         children: [
//           Icon(icon, size: 18.w),
//           SizedBox(height: 2.h),
//           Text(
//             value,
//             style: TextStyle(
//               fontSize: 16.sp,
//               fontWeight: FontWeight.bold,
//               color: Theme.of(context).colorScheme.onSurface,
//             ),
//           ),
//           Text(
//             label,
//             style: TextStyle(fontSize: 10.sp, color: Colors.grey.shade500),
//           ),
//         ],
//       ),
//     );
//   }

//   String _formatDate(String dateStr) {
//     try {
//       final date = DateTime.parse(dateStr);
//       const months = [
//         'يناير',
//         'فبراير',
//         'مارس',
//         'أبريل',
//         'مايو',
//         'يونيو',
//         'يوليو',
//         'أغسطس',
//         'سبتمبر',
//         'أكتوبر',
//         'نوفمبر',
//         'ديسمبر',
//       ];
//       return '${date.day} ${months[date.month - 1]} ${date.year}';
//     } catch (_) {
//       return dateStr;
//     }
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/core/widget/Loadingwidget.dart';
import 'package:school/features/Student/ui/bloc/reservation_bloc/reservation_bloc.dart';
import 'package:school/features/Student/ui/bloc/reservation_bloc/reservation_event.dart';
import 'package:school/features/Student/ui/bloc/reservation_bloc/reservation_state.dart';
import 'package:school/generated/l10n.dart';

// ✅ إزالة معامل reservationsBloc من الـ Constructor
class ReservationsBottomSheet extends StatefulWidget {
  const ReservationsBottomSheet({super.key});

  @override
  State<ReservationsBottomSheet> createState() =>
      _ReservationsBottomSheetState();
}

class _ReservationListItem extends StatelessWidget {
  final dynamic item;

  const _ReservationListItem({required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isPending = item.status?.toLowerCase() == 'pending';
    final statusColor = isPending
        ? Colors.orange.shade600
        : Colors.green.shade600;

    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 8.h),

      title: Text(
        item.bookTitle ?? 'كتاب',
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: theme.colorScheme.onSurface,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        item.date != null ? 'تاريخ الحجز: ${_formatDate(item.date!)}' : '',
        style: TextStyle(fontSize: 11.5.sp, color: Colors.grey.shade500),
      ),
      trailing: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        decoration: BoxDecoration(
          color: statusColor.withOpacity(0.12),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Text(
          item.statusName ?? (isPending ? 'قيد الانتظار' : 'مكتمل'),
          style: TextStyle(
            fontSize: 11.sp,
            fontWeight: FontWeight.w700,
            color: statusColor,
          ),
        ),
      ),
    );
  }

  String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      const months = [
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
    } catch (_) {
      return dateStr;
    }
  }
}

class _ReservationsBottomSheetState extends State<ReservationsBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20.w,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      padding: EdgeInsets.fromLTRB(
        20.w,
        12.h,
        20.w,
        MediaQuery.of(context).viewInsets.bottom + 20.h,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          SizedBox(height: 16.h),

          BlocListener<ReservationsBloc, ReservationsState>(
            listener: (context, state) {
              if (state is ReservationsError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red.shade600,
                    behavior: SnackBarBehavior.floating,
                    duration: const Duration(seconds: 2),
                  ),
                );
              }
            },
            child: BlocBuilder<ReservationsBloc, ReservationsState>(
              builder: (context, state) {
                if (state is ReservationsLoading) {
                  return SizedBox(
                    height: 300.h,
                    child: const Center(child: Loadingwidget()),
                  );
                }

                if (state is ReservationsLoaded) {
                  final list = state.reservations.reserveBookInfo ?? [];

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10.w),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.bookmark_rounded,
                              color: theme.colorScheme.primary,
                              size: 22.w,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  S.of(context).My_Reservations,
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    color: theme.colorScheme.onSurface,
                                  ),
                                ),
                                Text(
                                  '${state.reservations.totalReservations ?? 0} حجز',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),

                      Row(
                        children: [
                          _buildStatItem(
                            context,
                            Icons.library_books_rounded,
                            '${state.reservations.totalReservations ?? 0}',
                            'الإجمالي',
                          ),
                          SizedBox(width: 8.w),
                          _buildStatItem(
                            context,
                            Icons.access_time_rounded,
                            '${state.reservations.pendingReservations ?? 0}',
                            'قيد الانتظار',
                          ),
                          SizedBox(width: 8.w),

                          _buildStatItem(
                            context,
                            Icons.check_circle_rounded,
                            '${state.reservations.approvedReservations ?? 0}',
                            'موافق عليه',
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),

                      if (list.isEmpty)
                        SizedBox(
                          height: 200.h,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.inbox_outlined,
                                  size: 48.w,
                                  color: Colors.grey.shade400,
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  'لا توجد حجوزات حالياً',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      else
                        SizedBox(
                          height: 300.h,
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemCount: list.length,
                            separatorBuilder: (_, _) => Divider(
                              height: 1.h,
                              color: Colors.grey.shade200,
                            ),
                            itemBuilder: (context, i) =>
                                _ReservationListItem(item: list[i]),
                          ),
                        ),

                      SizedBox(height: 20.h),

                      SizedBox(
                        width: double.infinity,
                        height: 48.h,
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.r),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            S.of(context).close,
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }

                if (state is ReservationsError) {
                  return SizedBox(
                    height: 250.h,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.error_outline_rounded,
                            size: 48.w,
                            color: Colors.red.shade300,
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            state.message,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey.shade700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 16.h),
                          TextButton(
                            onPressed: () => context
                                .read<ReservationsBloc>()
                                .add(RefreshReservationsEvent()),
                            child: Text(
                              'إعادة المحاولة',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<ReservationsBloc>().add(GetReservationsEvent());
      }
    });
  }

  Widget _buildStatItem(
    BuildContext context,
    IconData icon,
    String value,
    String label,
  ) {
    final theme = Theme.of(context);
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: theme.dividerColor.withOpacity(0.1)),
        ),
        child: Column(
          children: [
            Icon(icon, size: 18.w, color: theme.colorScheme.primary),
            SizedBox(height: 4.h),
            Text(
              value,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
            Text(
              label,
              style: TextStyle(fontSize: 11.sp, color: Colors.grey.shade500),
            ),
          ],
        ),
      ),
    );
  }
}
