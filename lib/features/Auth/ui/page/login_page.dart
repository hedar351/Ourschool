import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/core/widget/SnackBar/Message.dart';
import 'package:school/features/Auth/ui/bloc/auth_bloc.dart';
import 'package:school/generated/l10n.dart';

import '../../../Integration/Routing.dart';
import '../widget/login_footer.dart';
import '../widget/login_form.dart';

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

  final double _horizontalPadding = 28.w;
  final double _verticalPadding = 40.h;
  final double _gap = 24.h;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: _onAuthStateChanged,
        builder: (context, state) {
          final isLoading = state is AuthLoading;
          return Center(
            // ✅ ColoredBox خفيف ومباشر بدلاً من Container لتسريع الرسم
            child: ColoredBox(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: _horizontalPadding,
                    vertical: _verticalPadding,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
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
                      SizedBox(height: _gap),
                      LoginFooter(isLoading: isLoading),
                    ],
                  ),
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
      routing(state.user.role!, context, state);
    } else if (state is AuthInitial) {
      _usernameController.clear();
      _passwordController.clear();
      setState(() {
        _rememberMe = false;
      });
    }
  }
}
