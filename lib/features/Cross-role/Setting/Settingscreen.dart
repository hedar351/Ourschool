import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/core/cubit/locale_cubit.dart';
import 'package:school/core/theme/animated_theme_switcher.dart';
import 'package:school/core/widget/PopupMenu.dart';
import 'package:school/core/widget/theme_toggle_button.dart';
import 'package:school/features/FirstStep/Auth/ui/bloc/auth_bloc.dart';
import 'package:school/generated/l10n.dart';

import '../../FirstStep/onboarding/Ui/onboarding_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _AnimatedSlide extends StatelessWidget {
  final Widget child;
  final AnimationController controller;
  final int delay;

  const _AnimatedSlide({
    required this.child,
    required this.controller,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    final animation =
        Tween<Offset>(begin: const Offset(0, 0.15), end: Offset.zero).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(delay / 1000, 1.0, curve: Curves.easeOutQuart),
          ),
        );
    final fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(delay / 1000, 1.0, curve: Curves.easeOut),
      ),
    );

    return FadeTransition(
      opacity: fadeAnimation,
      child: SlideTransition(position: animation, child: child),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Divider(
        height: 1.h,
        thickness: 1,
        color: Theme.of(context).dividerColor.withOpacity(0.1),
      ),
    );
  }
}

class _ModernLogoutButton extends StatelessWidget {
  const _ModernLogoutButton();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => _showLogoutDialog(context),
      icon: Icon(Icons.logout_rounded, size: 20.w),
      label: Text(
        S.of(context).Logout,
        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red.shade50,
        foregroundColor: Colors.red.shade600,
        elevation: 0,
        side: BorderSide(color: Colors.red.shade100, width: 1.5.r),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        padding: EdgeInsets.symmetric(vertical: 16.h),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        title: Row(
          children: [
            Icon(
              Icons.warning_amber_rounded,
              color: Colors.red.shade600,
              size: 24.w,
            ),
            SizedBox(width: 8.w),
            Text(
              S.of(context).Logout,
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        content: Text(
          S.of(context).want_to_logout,
          style: TextStyle(
            fontSize: 15.sp,
            color: Colors.grey.shade700,
            height: 1.4,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              S.of(context).cancel,
              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.read<AuthBloc>().add(LogoutEvent());
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const WelcomeScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade600,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            ),
            child: Text(
              S.of(context).Logout,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ModernProfileCard extends StatelessWidget {
  const _ModernProfileCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (previous, current) =>
          previous.runtimeType != current.runtimeType,
      builder: (context, state) {
        String name = S.of(context).unknown_name;
        String role = '';

        if (state is AuthLoaded) {
          name = state.user.name ?? S.of(context).unknown_name;
          role = state.user.role ?? '';
        }

        return Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                theme.colorScheme.primary,
                theme.colorScheme.primary.withOpacity(0.85),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24.r),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.primary.withOpacity(0.3),
                blurRadius: 15.w,
                offset: Offset(0, 8.h),
              ),
            ],
          ),
          child: Row(
            children: [
              // Avatar مع حلقة بيضاء
              Container(
                padding: EdgeInsets.all(3.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: CircleAvatar(
                  radius: 34.w,
                  backgroundColor: theme.colorScheme.surface,
                  child: Text(
                    name.isNotEmpty ? name[0].toUpperCase() : '?',
                    style: TextStyle(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w800,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 6.h),
                    if (role.isNotEmpty)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 5.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                            width: 0.5.r,
                          ),
                        ),
                        child: Text(
                          _translateRole(role, context),
                          style: TextStyle(
                            fontSize: 12.5.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _translateRole(String role, BuildContext context) {
    switch (role.toLowerCase()) {
      case 'teacher':
        return S.of(context).role_teacher;
      case 'counselor':
        return S.of(context).role_counselor;
      case 'student':
        return S.of(context).role_student;
      case 'admin':
        return S.of(context).role_admin;
      default:
        return role;
    }
  }
}

class _ModernSettingTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _ModernSettingTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20.r),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(9.w),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(icon, color: iconColor, size: 22.w),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ),
              // ?trailing,
              if (trailing == null && onTap != null)
                Icon(
                  Icons.chevron_left_rounded,
                  color: theme.colorScheme.outline.withOpacity(0.5),
                  size: 22.w,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingsScreenState extends State<SettingsScreen>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isDarkMode = false;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final theme = Theme.of(context);
    _isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(child: SizedBox(height: 16.h)),

            SliverToBoxAdapter(
              child: AnimatedThemeSwitcher(
                isDarkMode: _isDarkMode,
                child: _AnimatedSlide(
                  controller: _animationController,
                  delay: 0,
                  child: const _ModernProfileCard(),
                ),
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: 24.h)),

            SliverToBoxAdapter(
              child: AnimatedThemeSwitcher(
                isDarkMode: _isDarkMode,
                child: _AnimatedSlide(
                  controller: _animationController,
                  delay: 100,
                  child: _SettingsSection(
                    title: S.of(context).preferences,
                    children: [
                      _ModernSettingTile(
                        icon: Icons.brightness_6_rounded,
                        iconColor: const Color(0xFF8B5CF6),
                        title: S.of(context).Theme,
                        trailing: const ThemeToggleButton(),
                      ),
                      _Divider(),
                      _ModernSettingTile(
                        icon: Icons.language_rounded,
                        iconColor: const Color(0xFF3B82F6),
                        title: S.of(context).Language,
                        trailing: PopupMenu(
                          currentLocale: Localizations.localeOf(
                            context,
                          ).languageCode,
                          cubit: context.read<LocaleCubit>(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 24.h)),

            SliverToBoxAdapter(
              child: AnimatedThemeSwitcher(
                isDarkMode: _isDarkMode,
                child: _AnimatedSlide(
                  controller: _animationController,
                  delay: 200,
                  child: _SettingsSection(
                    title: S.of(context).support_and_info,
                    children: [
                      _ModernSettingTile(
                        icon: Icons.info_rounded,
                        iconColor: const Color(0xFF10B981),
                        title: S.of(context).about_app,
                        onTap: () => _showAboutDialog(context),
                      ),
                      _Divider(),
                      _ModernSettingTile(
                        icon: Icons.privacy_tip_rounded,
                        iconColor: const Color(0xFFF59E0B),
                        title: S.of(context).privacy_policy,
                        onTap: () => _showPrivacyDialog(context),
                      ),
                      _Divider(),
                      _ModernSettingTile(
                        icon: Icons.new_releases_rounded,
                        iconColor: const Color(0xFF6366F1),
                        title: S.of(context).version,
                        trailing: Text(
                          S.of(context).app_version,
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: theme.colorScheme.outline,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 32.h)),

            SliverToBoxAdapter(
              child: AnimatedThemeSwitcher(
                isDarkMode: _isDarkMode,
                child: _AnimatedSlide(
                  controller: _animationController,
                  delay: 300,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: const _ModernLogoutButton(),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 40.h)),
          ],
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
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _animationController.forward();
  }

  // ---------------------------------------------------------
  // Dialogs Logic (محفوظ كما هو مع تحسين بسيط في الشكل)
  // ---------------------------------------------------------
  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        title: Text(
          S.of(context).about_app,
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).app_title,
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8.h),
            Text(
              S.of(context).app_version_info,
              style: TextStyle(color: Colors.grey.shade600),
            ),
            SizedBox(height: 12.h),
            Text(
              S.of(context).app_description,
              style: TextStyle(color: Colors.grey.shade700, height: 1.4),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              S.of(context).close,
              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  void _showPrivacyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        title: Text(
          S.of(context).privacy_policy,
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          child: Text(
            S.of(context).privacy_policy_text,
            style: TextStyle(
              fontSize: 15.sp,
              height: 1.5,
              color: Colors.grey.shade700,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              S.of(context).close,
              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SettingsSection({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 4.w, bottom: 8.h),
            child: Text(
              title.toUpperCase(),
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w700,
                color: theme.colorScheme.outline.withOpacity(0.8),
                letterSpacing: 1.2,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: theme.dividerColor.withOpacity(0.1),
                width: 1.r,
              ),
            ),
            child: Column(children: children),
          ),
        ],
      ),
    );
  }
}
