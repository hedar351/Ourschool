import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/features/Activities/UI/bloc/activitiesBloc/activities_bloc.dart';
import 'package:school/features/Cross-role/Bulletin/domain/Entities/AnnouncementActivityEntity.dart';
import 'package:school/features/Cross-role/Bulletin/ui/bloc/bulletin_bloc.dart';
import 'package:school/features/Librarian/UI/widget/helpingWidget/helpers.dart';
import 'package:school/generated/l10n.dart';

class EditActivityDialog extends StatefulWidget {
  final Announcementactivityentity entity;
  final BuildContext bottomSheetContext;
  const EditActivityDialog({
    super.key,
    required this.entity,
    required this.bottomSheetContext,
  });

  @override
  State<EditActivityDialog> createState() => _EditActivityDialogState();
}

class _EditActivityDialogState extends State<EditActivityDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _expiryDateController;

  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<ActivitiesBloc, ActivitiesState>(
      listener: (context, state) {
        if (state is ActivitiesSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 2),
            ),
          );
          Navigator.pop(context);
          Navigator.pop(widget.bottomSheetContext);

          context.read<BulletinBloc>().add(RefreshBulletinsEvent());
        }
        if (state is ActivitiesError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 3),
            ),
          );
        }
      },
      child: BlocBuilder<ActivitiesBloc, ActivitiesState>(
        builder: (context, state) {
          final isLoading = state is ActivitiesLoading;

          return AlertDialog(
            backgroundColor: theme.scaffoldBackgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.r),
            ),
            title: Row(
              children: [
                Icon(
                  Icons.edit_rounded,
                  color: theme.colorScheme.primary,
                  size: 28.w,
                ),
                SizedBox(width: 10.w),
                Text(
                  S.of(context).edit_activity_title,
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
                  TextFormField(
                    controller: _titleController,
                    enabled: !isLoading,
                    decoration: InputDecoration(
                      labelText: S.of(context).activity_title_label,
                      hintText: S.of(context).activity_title_hint,
                      prefixIcon: Icon(
                        Icons.title_rounded,
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
                        return S.of(context).activity_title_required;
                      }
                      return null;
                    },
                    style: TextStyle(fontSize: 14.sp),
                  ),
                  SizedBox(height: 14.h),

                  TextFormField(
                    controller: _descriptionController,
                    enabled: !isLoading,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: S.of(context).activity_description_label,
                      hintText: S.of(context).activity_description_hint,
                      prefixIcon: Icon(
                        Icons.description_rounded,
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
                        return S.of(context).activity_description_required;
                      }
                      return null;
                    },
                    style: TextStyle(fontSize: 14.sp),
                  ),
                  SizedBox(height: 14.h),

                  TextFormField(
                    controller: _expiryDateController,
                    enabled: !isLoading,
                    readOnly: true,
                    onTap: () => _selectDate(context),
                    decoration: InputDecoration(
                      labelText: S.of(context).activity_expiry_date_label,
                      hintText: S.of(context).activity_expiry_date_hint,
                      prefixIcon: Icon(
                        Icons.calendar_today_rounded,
                        color: theme.colorScheme.primary,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.arrow_drop_down_rounded,
                          color: theme.hintColor,
                        ),
                        onPressed: () => _selectDate(context),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      filled: true,
                      fillColor: theme.cardColor,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return S.of(context).activity_expiry_date_required;
                      }
                      return null;
                    },
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ],
              ),
            ),
            actions: [
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
              ElevatedButton.icon(
                onPressed: isLoading
                    ? null
                    : () {
                        if (_formKey.currentState!.validate()) {
                          final title = _titleController.text.trim();
                          final description = _descriptionController.text
                              .trim();
                          final expiryDate =
                              _selectedDate?.toIso8601String() ?? '';

                          context.read<ActivitiesBloc>().add(
                            EditActivityEvent(
                              localActivityId: widget.entity.id,
                              title: title,
                              description: description,
                              expiryDate: expiryDate,
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
                    : Icon(Icons.save_rounded, size: 20.w),
                label: Text(
                  isLoading ? S.of(context).saving : S.of(context).save,
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
    _descriptionController.dispose();
    _expiryDateController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.entity.title);
    _descriptionController = TextEditingController(
      text: widget.entity.description,
    );
    _expiryDateController = TextEditingController(
      text: formatDate(widget.entity.date),
    );
    _selectedDate = widget.entity.date;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime firstDate =
        (_selectedDate != null && _selectedDate!.isBefore(DateTime.now()))
        ? _selectedDate!
        : DateTime.now();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: firstDate,
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _expiryDateController.text = formatDate(picked);
      });
    }
  }
}
