// lib/features/Librarian/UI/widget/Dialog/showDeleteConfirmation.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/core/injection.dart' as di;
import 'package:school/features/Librarian/UI/Bloc/AddDeleteEdit/add_delete_edit_bloc.dart';
import 'package:school/generated/l10n.dart';

void showDeleteConfirmation(BuildContext context, int localBookNumber) {
  final theme = Theme.of(context);

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => BlocProvider(
      create: (context) => di.sl<AddDeleteEditBloc>(),
      child: AlertDialog(
        backgroundColor: theme.scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
        ),
        title: Row(
          children: [
            Icon(
              Icons.warning_amber_rounded,
              color: Colors.red.shade600,
              size: 28.w,
            ),
            SizedBox(width: 10.w),
            Text(
              S.of(context).delete,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ],
        ),
        content: Text(
          S.of(context).delet_book,
          style: TextStyle(
            fontSize: 14.sp,
            color: theme.colorScheme.onSurface.withOpacity(0.8),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              S.of(context).cancel,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade600,
              ),
            ),
          ),
          BlocBuilder<AddDeleteEditBloc, AddDeleteEditState>(
            builder: (context, state) {
              final isLoading = state is AddDeleteEditLoading;
              return ElevatedButton.icon(
                onPressed: isLoading
                    ? null
                    : () {
                        context.read<AddDeleteEditBloc>().add(
                          DeleteBookEvent(localBookNumber: localBookNumber),
                        );
                        Navigator.pop(context);
                      },
                icon: isLoading
                    ? SizedBox(
                        width: 20.w,
                        height: 20.w,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.w,
                        ),
                      )
                    : Icon(Icons.delete_rounded, size: 20.w),
                label: Text(
                  isLoading ? 'جاري الحذف...' : S.of(context).delete,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade600,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 12.h,
                  ),
                  disabledBackgroundColor: Colors.grey.shade300,
                ),
              );
            },
          ),
        ],
      ),
    ),
  );
}
