import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/features/Librarian/UI/Bloc/AddDeleteEdit/add_delete_edit_bloc.dart';
import 'package:school/features/Librarian/UI/Bloc/LibrarianBloc/librarian_bloc.dart';
import 'package:school/generated/l10n.dart';

class AddBookDialog extends StatefulWidget {
  const AddBookDialog({super.key});

  @override
  State<AddBookDialog> createState() => _AddBookDialogState();
}

class _AddBookDialogState extends State<AddBookDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  final _copiesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<AddDeleteEditBloc, AddDeleteEditState>(
      listener: (context, state) {
        if (state is AddDeleteEditSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 2),
            ),
          );
          Navigator.pop(context);
          context.read<LibrarianBloc>().add(RefreshBooksLibrarianEvent());
        }
        if (state is AddDeleteEditError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 3),
            ),
          );
        }
      },
      child: BlocBuilder<AddDeleteEditBloc, AddDeleteEditState>(
        builder: (context, state) {
          final isLoading = state is AddDeleteEditLoading;

          return AlertDialog(
            // backgroundColor: theme.scaffoldBackgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.r),
            ),
            title: Row(
              children: [
                Icon(
                  Icons.add_circle_outline_rounded,
                  color: theme.colorScheme.primary,
                  size: 28.w,
                ),
                SizedBox(width: 10.w),
                Text(
                  S.of(context).add_book,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // ---- حقل العنوان ----
                  TextFormField(
                    controller: _titleController,
                    enabled: !isLoading,
                    decoration: InputDecoration(
                      labelText: S.of(context).book_title,
                      hintText: S.of(context).book_title_hint,
                      prefixIcon: Icon(
                        Icons.menu_book_rounded,
                        color: theme.colorScheme.primary,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      filled: true,
                      fillColor: theme.cardColor,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return S.of(context).book_title_required;
                      }
                      return null;
                    },
                    style: TextStyle(fontSize: 14.sp),
                  ),
                  SizedBox(height: 14.h),

                  // ---- حقل المؤلف ----
                  TextFormField(
                    controller: _authorController,
                    enabled: !isLoading,
                    decoration: InputDecoration(
                      labelText: S.of(context).book_author,
                      hintText: S.of(context).book_author_hint,
                      prefixIcon: Icon(
                        Icons.person_outline_rounded,
                        color: theme.colorScheme.primary,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      filled: true,
                      fillColor: theme.cardColor,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return S.of(context).book_author_required;
                      }
                      return null;
                    },
                    style: TextStyle(fontSize: 14.sp),
                  ),
                  SizedBox(height: 14.h),

                  // ---- حقل عدد النسخ ----
                  TextFormField(
                    controller: _copiesController,
                    enabled: !isLoading,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: S.of(context).book_copies,
                      hintText: S.of(context).book_copies_hint,
                      prefixIcon: Icon(
                        Icons.copy_all_rounded,
                        color: theme.colorScheme.primary,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      filled: true,
                      fillColor: theme.cardColor,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return S.of(context).book_copies_required;
                      }
                      final copies = int.tryParse(value.trim());
                      if (copies == null || copies <= 0) {
                        return S.of(context).book_copies_positive;
                      }
                      return null;
                    },
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ],
              ),
            ),
            actions: [
              // ---- زر إلغاء ----
              TextButton(
                onPressed: isLoading ? null : () => Navigator.pop(context),
                child: Text(
                  S.of(context).cancel,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
              // ---- زر إضافة ----
              ElevatedButton.icon(
                onPressed: isLoading
                    ? null
                    : () {
                        if (_formKey.currentState!.validate()) {
                          final title = _titleController.text.trim();
                          final author = _authorController.text.trim();
                          final copies = int.parse(
                            _copiesController.text.trim(),
                          );

                          context.read<AddDeleteEditBloc>().add(
                            AddBookEvent(
                              title: title,
                              author: author,
                              copies: copies,
                            ),
                          );
                        }
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
                    : Icon(Icons.add_rounded, size: 20.w),
                label: Text(
                  isLoading ? S.of(context).adding : S.of(context).add,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
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
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _copiesController.dispose();
    super.dispose();
  }
}
