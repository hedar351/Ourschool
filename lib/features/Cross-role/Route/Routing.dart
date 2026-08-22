import 'package:flutter/material.dart';
import 'package:school/features/Cross-role/Route/NavHomePage.dart';
import 'package:school/features/FirstStep/Auth/ui/bloc/auth_bloc.dart';
import 'package:school/generated/l10n.dart';

void routing(
  String role,
  // String token,
  BuildContext context,
  AuthLoaded state,
) {
  if (role != "Admin" &&
      // role != "Librarian" &&
      role != "Principal" &&
      role != "Secretary") {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) =>
            NavHomePage(user: state.user, key: ValueKey(state.user.id)),
      ),
      (route) => false,
    );
  } else {
    showUnavailableDialogAndRedirect(context);
  }
}

void showUnavailableDialogAndRedirect(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: Text(S.of(context).Unavailable),
        content: Text(S.of(context).account_not_available),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
            },
            child: Text(S.of(context).Ok),
          ),
        ],
      );
    },
  );
}
