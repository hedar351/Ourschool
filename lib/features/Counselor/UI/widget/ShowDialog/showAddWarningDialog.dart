import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/features/Counselor/UI/bloc/PostWarnings/post_warnings_bloc.dart';
import 'package:school/features/Counselor/UI/bloc/PostWarnings/post_warnings_event.dart';
import 'package:school/features/Counselor/UI/bloc/PostWarnings/post_warnings_state.dart';
import 'package:school/features/Counselor/UI/bloc/Studentprofile/student_profile_bloc.dart';
import 'package:school/features/Counselor/domain/Entities/StudentsBySectionEntity/studentEntity.dart';
import 'package:school/generated/l10n.dart';

void showAddWarningDialog(BuildContext context, Studententity? student) {
  final int? studentId = student?.localStudentNumber;
  final reasonController = TextEditingController();
  String? selectedType;
  final bloc = context.read<PostWarningBloc>();

  // final double dialogPadding = 16.w;
  final double containerPaddingHorizontal = 12.w;
  final double containerPaddingVertical = 8.h;
  final double fontSize = 16.sp;
  final double iconSize = 24.w;
  // final double textFieldFontSize = 14.sp;
  final double borderRadius = 8.r;

  showDialog(
    context: context,
    builder: (dialogContext) {
      return BlocProvider.value(
        value: bloc,
        child: BlocConsumer<PostWarningBloc, PostWarningState>(
          listener: (context, state) {
            if (state is PostWarningSuccess) {
              context.read<StudentProfileBloc>().add(
                RefreshStudentProfileEvent(localStudentNumber: studentId!),
              );
            }
            if (state is PostWarningError) {
              Navigator.pop(context);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            return AlertDialog(
              title: Text(
                S.of(context).add_warning_title,
                style: TextStyle(fontSize: 18.sp),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: containerPaddingHorizontal,
                      vertical: containerPaddingVertical,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.w),
                      borderRadius: BorderRadius.circular(borderRadius),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            selectedType == null
                                ? S.of(context).select_warning_type
                                : selectedType == 'Behavior'
                                ? S.of(context).type_behavior
                                : S.of(context).type_dismissal_warning,
                            style: TextStyle(fontSize: fontSize),
                          ),
                        ),
                        PopupMenuButton<String>(
                          icon: Icon(Icons.arrow_drop_down, size: iconSize),
                          onSelected: (value) {
                            selectedType = value;
                          },
                          itemBuilder: (BuildContext context) => [
                            PopupMenuItem(
                              value: 'Behavior',
                              child: Text(
                                S.of(context).type_behavior,
                                style: TextStyle(fontSize: 14.sp),
                              ),
                            ),
                            PopupMenuItem(
                              value: 'DismissalWarning',
                              child: Text(
                                S.of(context).type_dismissal_warning,
                                style: TextStyle(fontSize: 14.sp),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),
                  TextField(
                    controller: reasonController,
                    decoration: InputDecoration(
                      labelText: S.of(context).reason,
                      labelStyle: TextStyle(fontSize: 14.sp),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    maxLines: 3,
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: Text(
                    S.of(context).cancel,
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    final type = selectedType;
                    final reason = reasonController.text.trim();
                    if (type != null && reason.isNotEmpty) {
                      context.read<PostWarningBloc>().add(
                        AddPostWarningEvent(
                          localStudentNumber: studentId!,
                          type: type,
                          reason: reason,
                        ),
                      );
                      Navigator.pop(dialogContext);
                    } else {
                      ScaffoldMessenger.of(dialogContext).showSnackBar(
                        SnackBar(
                          content: Text(
                            S.of(context).please_select_type_and_reason,
                            style: TextStyle(fontSize: 14.sp),
                          ),
                        ),
                      );
                    }
                  },
                  child: Text(
                    S.of(context).add,
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
