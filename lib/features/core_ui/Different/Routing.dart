import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school/core/widget/Loadingwidget.dart';
import 'package:school/features/Auth/ui/bloc/auth_bloc.dart';
import 'package:school/features/Teacher/home_page.dart';
import 'package:school/features/core_ui/Different/onboarding/Ui/onboarding_screen.dart';
import 'package:school/generated/l10n.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoaded) {
          final role = state.user.role;
          routing(role, context, state);
        } else if (state is AuthInitial || state is AuthErorr) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const WelcomeScreen()),
          );
        }
      },
      child: const Scaffold(body: Center(child: Loadingwidget())),
    );
  }

  void routing(String role, BuildContext context, AuthLoaded state) {
    if (role == "Teacher") {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => TeacherHomePage(user: state.user)),
      );
    } else if (role == "Student") {
    } else if (role == "Admin") {
      _showUnavailableDialogAndRedirect(context);
    }
  }

  void _showUnavailableDialogAndRedirect(BuildContext context) {
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
}
