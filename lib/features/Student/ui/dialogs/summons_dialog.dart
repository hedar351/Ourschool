// // // lib/features/Student/presentation/dialogs/summons_dialog.dart

// // import 'package:flutter/material.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // import 'package:school/features/Student/domain/entity/Student-FullProfile/SummonsEntity.dart';
// // import 'package:school/generated/l10n.dart';

// // class SummonsDialog extends StatelessWidget {
// //   final List<SummonsEntity> summons;

// //   const SummonsDialog({super.key, required this.summons});

// //   @override
// //   Widget build(BuildContext context) {
// //     if (summons.isEmpty) {
// //       return _emptyDialog(context, S.of(context).summons);
// //     }
// //     return AlertDialog(
// //       title: Row(
// //         children: [
// //           Icon(Icons.gavel, color: Colors.purple),
// //           SizedBox(width: 8.w),
// //           Text(S.of(context).summons),
// //         ],
// //       ),
// //       content: SizedBox(
// //         width: double.maxFinite,
// //         child: ListView.separated(
// //           shrinkWrap: true,
// //           itemCount: summons.length,
// //           separatorBuilder: (_, _) => const Divider(),
// //           itemBuilder: (_, i) {
// //             return ListTile(
// //               title: Text('استدعاء رقم ${i + 1}'),
// //               subtitle: Text(summons[i].reason ?? 'التفاصيل غير متوفرة حالياً'),
// //             );
// //           },
// //         ),
// //       ),
// //       actions: [
// //         TextButton(
// //           onPressed: () => Navigator.pop(context),
// //           child: Text(S.of(context).close),
// //         ),
// //       ],
// //     );
// //   }

// //   AlertDialog _emptyDialog(BuildContext context, String title) {
// //     return AlertDialog(
// //       title: Text(title),
// //       content: Text(S.of(context).There_are_no_bulletins_at_the_moment),
// //       actions: [
// //         TextButton(
// //           onPressed: () => Navigator.pop(context),
// //           child: Text(S.of(context).Ok),
// //         ),
// //       ],
// //     );
// //   }
// // }
// // lib/features/Student/presentation/dialogs/summons_dialog.dart

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:school/features/Student/domain/entity/Student-FullProfile/SummonsEntity.dart';
// import 'package:school/features/Student/ui/utils/date_formatter.dart';
// import 'package:school/generated/l10n.dart';

// class SummonsDialog extends StatelessWidget {
//   final List<SummonsEntity> summons;

//   const SummonsDialog({super.key, required this.summons});

//   @override
//   Widget build(BuildContext context) {
//     if (summons.isEmpty) {
//       return _emptyDialog(context, S.of(context).summons);
//     }
//     return AlertDialog(
//       title: Row(
//         children: [
//           Icon(Icons.gavel, color: Colors.purple),
//           SizedBox(width: 8.w),
//           Text(S.of(context).summons),
//         ],
//       ),
//       content: SizedBox(
//         width: double.maxFinite,
//         child: ListView.separated(
//           shrinkWrap: true,
//           itemCount: summons.length,
//           separatorBuilder: (_, _) => const Divider(),
//           itemBuilder: (_, i) {
//             final item = summons[i];
//             return ListTile(
//               leading: Icon(Icons.info, color: Colors.purple),
//               title: Text(item.reason ?? 'استدعاء'),
//               subtitle: Text(
//                 item.date != null
//                     ? formatDate(DateTime.parse(item.date!))
//                     : S.of(context).date_unknown,
//               ),
//               trailing: Text(
//                 item.createdAt != null
//                     ? formatDate(DateTime.parse(item.createdAt!))
//                     : '',
//                 style: TextStyle(fontSize: 12.sp, color: Colors.grey),
//               ),
//             );
//           },
//         ),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () => Navigator.pop(context),
//           child: Text(S.of(context).close),
//         ),
//       ],
//     );
//   }

//   AlertDialog _emptyDialog(BuildContext context, String title) {
//     return AlertDialog(
//       title: Text(title),
//       content: Text(S.of(context).There_are_no_bulletins_at_the_moment),
//       actions: [
//         TextButton(
//           onPressed: () => Navigator.pop(context),
//           child: Text(S.of(context).Ok),
//         ),
//       ],
//     );
//   }
// }
// lib/features/Student/presentation/dialogs/summons_dialog.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/features/Student/domain/entity/Student-FullProfile/SummonsEntity.dart';
import 'package:school/features/Student/ui/utils/date_formatter.dart';
import 'package:school/generated/l10n.dart';

class SummonsDialog extends StatelessWidget {
  final List<SummonsEntity> summons;

  const SummonsDialog({super.key, required this.summons});

  @override
  Widget build(BuildContext context) {
    if (summons.isEmpty) {
      return _emptyDialog(context, S.of(context).summons);
    }
    return AlertDialog(
      title: Row(
        children: [
          Icon(Icons.gavel, color: Colors.purple),
          SizedBox(width: 8.w),
          Text(S.of(context).summons),
        ],
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: summons.length,
          separatorBuilder: (_, _) => const Divider(),
          itemBuilder: (_, i) {
            final item = summons[i];
            return ListTile(
              // leading: Icon(Icons.info, color: Colors.purple),
              title: Text(
                item.reason ?? 'استدعاء',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (item.date != null)
                    Text('التاريخ: ${formatDate(DateTime.parse(item.date!))}'),

                  // if (item.createdAt != null)
                  //   Text(
                  //     'تاريخ الإنشاء: ${formatDate(DateTime.parse(item.createdAt!))}',
                  //   ),
                ],
              ),
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(S.of(context).close),
        ),
      ],
    );
  }

  AlertDialog _emptyDialog(BuildContext context, String title) {
    return AlertDialog(
      title: Text(title),
      content: Text(S.of(context).There_are_no_bulletins_at_the_moment),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(S.of(context).Ok),
        ),
      ],
    );
  }
}
