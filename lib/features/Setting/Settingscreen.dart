import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/core/cubit/locale_cubit.dart';
import 'package:school/core/widget/PopupMenu.dart';
import 'package:school/core/widget/theme_toggle_button.dart';
import 'package:school/features/Auth/ui/bloc/auth_bloc.dart';
import 'package:school/generated/l10n.dart';

import '../onboarding/Ui/onboarding_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with AutomaticKeepAliveClientMixin {
  final double listPadding = 16.w;

  final double cardRadius = 16.r;
  final double cardElevation = 2;
  final double profileCardRadius = 20.r;
  final double profileCardElevation = 3;
  final double profilePadding = 16.w;
  final double avatarRadius = 32.w;
  final double avatarFontSize = 28.sp;
  final double userNameFontSize = 18.sp;
  final double roleFontSize = 12.sp;
  final double gapSmall = 20.h;
  final double gapMedium = 30.h;
  final double titleGap = 16.w;
  final double rolePaddingHorizontal = 10.w;
  final double rolePaddingVertical = 2.h;
  final double roleRadius = 12.r;
  final double logoutButtonPaddingHorizontal = 24.w;
  final double logoutButtonPaddingVertical = 14.h;
  final double logoutButtonRadius = 12.r;
  final double iconSize = 20.w;
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final localeCubit = context.watch<LocaleCubit>();
    final currentLocale = Localizations.localeOf(context).languageCode;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(listPadding),
          children: [
            _buildUserProfileCard(context),
            SizedBox(height: gapSmall),

            // ====== التفضيلات ======
            Card(
              elevation: cardElevation,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(cardRadius),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.brightness_6,
                      color: theme.colorScheme.primary,
                      size: 24.w,
                    ),
                    title: Text(
                      S.of(context).Theme,
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    trailing: ThemeToggleButton(),
                  ),
                  Divider(height: 1.h),
                  ListTile(
                    leading: Icon(
                      Icons.language,
                      color: theme.colorScheme.primary,
                      size: 24.w,
                    ),
                    title: Text(
                      S.of(context).Language,
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    trailing: PopupMenu(
                      currentLocale: currentLocale,
                      cubit: localeCubit,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: gapSmall),

            // ====== الدعم والمعلومات ======
            Card(
              elevation: cardElevation,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(cardRadius),
              ),
              child: Column(
                children: [
                  _buildSupportTile(
                    context,
                    icon: Icons.info_outline,
                    title: S.of(context).about_app,
                    onTap: () => _showAboutDialog(context),
                  ),
                  Divider(height: 1.h),
                  _buildSupportTile(
                    context,
                    icon: Icons.privacy_tip_outlined,
                    title: S.of(context).privacy_policy,
                    onTap: () => _showPrivacyDialog(context),
                  ),
                  Divider(height: 1.h),
                  ListTile(
                    leading: Icon(
                      Icons.info_outline,
                      color: theme.colorScheme.outline,
                      size: 24.w,
                    ),
                    title: Text(
                      S.of(context).version,
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    trailing: Text(
                      S.of(context).app_version,
                      style: TextStyle(
                        color: theme.colorScheme.outline,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: gapMedium),

            // ====== زر تسجيل الخروج ======
            Center(
              child: ElevatedButton.icon(
                onPressed: () => _showLogoutDialog(context),
                icon: Icon(Icons.logout, size: iconSize),
                label: Text(
                  S.of(context).Logout,
                  style: TextStyle(fontSize: 16.sp),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade50,
                  foregroundColor: Colors.red.shade700,
                  elevation: 0,
                  side: BorderSide(color: Colors.red.shade200, width: 1.w),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(logoutButtonRadius),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: logoutButtonPaddingHorizontal,
                    vertical: logoutButtonPaddingVertical,
                  ),
                ),
              ),
            ),

            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // عناصر قائمة الدعم
  // ============================================================
  Widget _buildSupportTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    return ListTile(
      leading: Icon(icon, color: theme.colorScheme.primary, size: 24.w),
      title: Text(title, style: TextStyle(fontSize: 16.sp)),
      trailing: Icon(
        Icons.chevron_right,
        color: theme.colorScheme.outline,
        size: 20.w,
      ),
      onTap: onTap,
    );
  }

  // ============================================================
  // بطاقة الملف الشخصي
  // ============================================================
  Widget _buildUserProfileCard(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        String name = S.of(context).unknown_name;
        String role = '';

        if (state is AuthLoaded) {
          name = state.user.name ?? S.of(context).unknown_name;
          role = state.user.role ?? '';
        }

        return Card(
          elevation: profileCardElevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(profileCardRadius),
          ),
          child: Padding(
            padding: EdgeInsets.all(profilePadding),
            child: Row(
              children: [
                CircleAvatar(
                  radius: avatarRadius,
                  backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
                  child: Text(
                    name.isNotEmpty ? name[0].toUpperCase() : '?',
                    style: TextStyle(
                      fontSize: avatarFontSize,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
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
                          fontSize: userNameFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (role.isNotEmpty)
                        Container(
                          margin: EdgeInsets.only(top: 4.h),
                          padding: EdgeInsets.symmetric(
                            horizontal: rolePaddingHorizontal,
                            vertical: rolePaddingVertical,
                          ),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(roleRadius),
                          ),
                          child: Text(
                            _translateRole(role, context),
                            style: TextStyle(
                              fontSize: roleFontSize,
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ============================================================
  // ديالوغات الدعم
  // ============================================================
  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(S.of(context).about_app),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(S.of(context).app_title),
            SizedBox(height: 8.h),
            Text(S.of(context).app_version_info),
            SizedBox(height: 8.h),
            Text(S.of(context).app_description),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(S.of(context).close, style: TextStyle(fontSize: 14.sp)),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // ديالوغ تسجيل الخروج
  // ============================================================
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(S.of(context).Logout, style: TextStyle(fontSize: 18.sp)),
        content: Text(
          S.of(context).want_to_logout,
          style: TextStyle(fontSize: 16.sp),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              S.of(context).cancel,
              style: TextStyle(fontSize: 14.sp),
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
              backgroundColor: Colors.red.shade700,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              S.of(context).Logout,
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
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
        title: Text(
          S.of(context).privacy_policy,
          style: TextStyle(fontSize: 18.sp),
        ),
        content: Text(
          S.of(context).privacy_policy_text,
          style: TextStyle(fontSize: 16.sp),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(S.of(context).close, style: TextStyle(fontSize: 14.sp)),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // ترجمة الأدوار
  // ============================================================
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
