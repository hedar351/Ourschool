import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
              title: Text(S.of(context).add_warning_title),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
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
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        PopupMenuButton<String>(
                          icon: const Icon(Icons.arrow_drop_down),
                          onSelected: (value) {
                            selectedType = value;
                          },
                          itemBuilder: (BuildContext context) => [
                            PopupMenuItem(
                              value: 'Behavior',
                              child: Text(S.of(context).type_behavior),
                            ),
                            PopupMenuItem(
                              value: 'DismissalWarning',
                              child: Text(S.of(context).type_dismissal_warning),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: reasonController,
                    decoration: InputDecoration(
                      labelText: S.of(context).reason,
                      border: const OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: Text(S.of(context).cancel),
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
                          ),
                        ),
                      );
                    }
                  },
                  child: Text(S.of(context).add),
                ),
              ],
            );
          },
        ),
      );
    },
  );
}
