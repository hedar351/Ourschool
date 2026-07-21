import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school/core/widget/Loadingwidget.dart';
import 'package:school/features/Auth/ui/bloc/auth_bloc.dart';
import 'package:school/features/onboarding/Ui/onboarding_screen.dart';

import 'Routing.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoaded) {
          // final token = state.user.token;
          final role = state.user.role;
          routing(role!, context, state);
        } else if (state is AuthInitial || state is AuthErorr) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const WelcomeScreen()),
            (route) => false,
          );
        }
        //ffgg
      },
      child: const Scaffold(body: Center(child: Loadingwidget())),
    );
  }
}
