// lib/features/onboarding/Ui/onboarding_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/core/cubit/locale_cubit.dart';
import 'package:school/core/widget/PopupMenu.dart';
import 'package:school/core/widget/theme_toggle_button.dart';
import 'package:school/features/Auth/ui/page/login_page.dart';
import 'package:school/features/SchoolsInfo/UI/page/schools_screen.dart';

import 'welcome_content_card.dart';
import 'welcome_header.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _fadeAnimation;

  // ✅ حسابات القيم الثابتة خارج build
  final double _horizontalPadding = 24.w;
  final double _verticalPadding = 20.h;
  final double _gapLarge = 48.h;
  final double _gapSmall = 20.h;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LocaleCubit>();
    final currentLocale = Localizations.localeOf(context).languageCode;

    return Scaffold(
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: _horizontalPadding,
                vertical: _verticalPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  WelcomeHeader(),
                  SizedBox(height: _gapLarge),
                  WelcomeContentCard(
                    onLoginPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
                    onExplorePressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SchoolsScreen(),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: _gapSmall),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const ThemeToggleButton(),
                      PopupMenu(currentLocale: currentLocale, cubit: cubit),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _animationController.forward();
  }
}
