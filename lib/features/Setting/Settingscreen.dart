import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school/core/cubit/locale_cubit.dart';
import 'package:school/core/widget/PopupMenu.dart';
import 'package:school/core/widget/theme_toggle_button.dart';
import 'package:school/features/Auth/ui/bloc/auth_bloc.dart';
import 'package:school/generated/l10n.dart';

import '../onboarding/Ui/onboarding_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localeCubit = context.watch<LocaleCubit>();
    final currentLocale = Localizations.localeOf(context).languageCode;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      // appBar: AppBar(
      //   title: Text(S.of(context).Settings),
      //   centerTitle: true,
      //   elevation: 0,
      // ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildUserProfileCard(context),

            const SizedBox(height: 20),

            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.brightness_6,
                      color: theme.colorScheme.primary,
                    ),
                    title: Text(S.of(context).Theme),
                    trailing: ThemeToggleButton(),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: Icon(
                      Icons.language,
                      color: theme.colorScheme.primary,
                    ),
                    title: Text(S.of(context).Language),
                    trailing: PopupMenu(
                      currentLocale: currentLocale,
                      cubit: localeCubit,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  _buildSupportTile(
                    context,
                    icon: Icons.info_outline,
                    title: S.of(context).about_app,
                    onTap: () => _showAboutDialog(context),
                  ),
                  const Divider(height: 1),
                  _buildSupportTile(
                    context,
                    icon: Icons.privacy_tip_outlined,
                    title: S.of(context).privacy_policy,
                    onTap: () => _showPrivacyDialog(context),
                  ),
                  const Divider(height: 1),

                  ListTile(
                    leading: Icon(
                      Icons.info_outline,
                      color: theme.colorScheme.outline,
                    ),
                    title: Text(S.of(context).version),
                    trailing: Text(
                      S.of(context).app_version,
                      style: TextStyle(color: theme.colorScheme.outline),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            Center(
              child: ElevatedButton.icon(
                onPressed: () => _showLogoutDialog(context),
                icon: const Icon(Icons.logout, size: 20),
                label: Text(S.of(context).Logout),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade50,
                  foregroundColor: Colors.red.shade700,
                  elevation: 0,
                  side: BorderSide(color: Colors.red.shade200),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 14,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSupportTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    return ListTile(
      leading: Icon(icon, color: theme.colorScheme.primary),
      title: Text(title),
      trailing: Icon(Icons.chevron_right, color: theme.colorScheme.outline),
      onTap: onTap,
    );
  }

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
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
                  child: Text(
                    name.isNotEmpty ? name[0].toUpperCase() : '?',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (role.isNotEmpty)
                        Container(
                          margin: const EdgeInsets.only(top: 4),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            _translateRole(role, context),
                            style: TextStyle(
                              fontSize: 12,
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
            const SizedBox(height: 8),
            Text(S.of(context).app_version_info),
            const SizedBox(height: 8),
            Text(S.of(context).app_description),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(S.of(context).close),
          ),
        ],
      ),
    );
  }

  void _showContactDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(S.of(context).contact_us),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(S.of(context).contact_email),
            const SizedBox(height: 8),
            Text(S.of(context).contact_phone),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(S.of(context).close),
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
        title: Text(S.of(context).Logout),
        content: Text(S.of(context).want_to_logout),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(S.of(context).cancel),
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
            ),
            child: Text(
              S.of(context).Logout,
              style: const TextStyle(color: Colors.white),
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
        title: Text(S.of(context).privacy_policy),
        content: Text(S.of(context).privacy_policy_text),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(S.of(context).close),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // ترجمة الأدوار (مؤقتة)
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
