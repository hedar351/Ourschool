import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school/core/widget/SnackBar/Message.dart';
import 'package:school/features/Auth/ui/bloc/auth_bloc.dart';
import 'package:school/generated/l10n.dart';

import '../../../Teacher/home_page.dart';
import '../../../core_ui/Different/onboarding/Ui/onboarding_screen.dart';
import '../widget/login_footer.dart';
import '../widget/login_form.dart';
import '../widget/login_header.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _snackBarMessage = SnackBarMessage();
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: _onAuthStateChanged,
        builder: (context, state) {
          final isLoading = state is AuthLoading;
          return Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 40,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const LoginHeader(),
                    const SizedBox(height: 48),
                    LoginForm(
                      formKey: _formKey,
                      usernameController: _usernameController,
                      passwordController: _passwordController,
                      rememberMe: _rememberMe,
                      isLoading: isLoading,
                      onRememberMeChanged: (value) {
                        setState(() => _rememberMe = value);
                      },
                      onLoginPressed: _dispatchLoginEvent,
                    ),
                    const SizedBox(height: 24),
                    LoginFooter(isLoading: isLoading),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void routing(String role, BuildContext context, AuthLoaded state) {
    if (role == "Teacher") {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => TeacherHomePage(user: state.user)),
      );
    } else if (role == "Student") {
      // Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(builder: (_) => StudentHomePage(user: state.user)),
      // );
    } else if (role == "Admin") {
      _showUnavailableDialogAndRedirect(context);
    }
  }

  void _dispatchLoginEvent() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
        LoginEvent(
          username: _usernameController.text.trim(),
          password: _passwordController.text.trim(),
          rememberMe: _rememberMe,
        ),
      );
    }
  }

  String _localizedErrorMessage(String key, BuildContext context) {
    switch (key) {
      case "SERVER_FAILURE_MESSAGE":
        return S.of(context).server_failure;
      case "EMPTY_CACHE_FAILURE_MESSAGE":
        return S.of(context).empty_cache_failure;
      case "OFFLINE_FAILURE_MESSAGE":
        return S.of(context).offline_failure;
      default:
        return S.of(context).unexpected_error;
    }
  }

  void _onAuthStateChanged(BuildContext context, AuthState state) {
    if (state is AuthErorr) {
      final message = _localizedErrorMessage(state.message, context);
      _snackBarMessage.errorMessage(message: message, context: context);
    } else if (state is AuthLoaded) {
      routing(state.user.role, context, state);
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
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const WelcomeScreen()),
                );
              },
              child: Text(S.of(context).Ok),
            ),
          ],
        );
      },
    );
  }
}
