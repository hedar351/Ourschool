import 'package:flutter/material.dart';
import 'package:school/features/Auth/domain/entities/auth_entities.dart';
import 'package:school/features/core_ui/BulletinScreen/bulletin_screen.dart';
import 'package:school/features/core_ui/Setting/Settingscreen.dart';
import 'package:school/generated/l10n.dart';

class TeacherHomePage extends StatefulWidget {
  final AuthEntities user;
  const TeacherHomePage({super.key, required this.user});

  @override
  State<TeacherHomePage> createState() => _TeacherHomePageState();
}

class _TeacherHomePageState extends State<TeacherHomePage> {
  late final PageController _pageController;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      extendBody: true,

      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          BulletinScreen(),
          Center(
            child: Text(
              'Students - قيد التطوير',
              style: TextStyle(fontSize: 16),
            ),
          ),
          SettingsScreen(),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: theme.shadowColor.withOpacity(0.1),
                  blurRadius: 20,
                  spreadRadius: 5,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: NavigationBarTheme(
                data: NavigationBarThemeData(
                  indicatorColor: theme.colorScheme.primary.withOpacity(0.15),
                  labelTextStyle: WidgetStateProperty.resolveWith((states) {
                    if (states.contains(WidgetState.selected)) {
                      return TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: theme.colorScheme.primary,
                      );
                    }
                    return TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: theme.unselectedWidgetColor,
                    );
                  }),
                ),
                child: NavigationBar(
                  height: 65,
                  backgroundColor: theme.cardColor,
                  surfaceTintColor: Colors.transparent,
                  elevation: 0,
                  selectedIndex: _currentIndex,
                  onDestinationSelected: _onTap,
                  destinations: [
                    _buildNavItem(
                      index: 0,
                      icon: Icons.home_outlined,
                      activeIcon: Icons.home_rounded,
                      label: S.of(context).Home,
                    ),
                    _buildNavItem(
                      index: 1,
                      icon: Icons.people_outline,
                      activeIcon: Icons.people_rounded,
                      label: S.of(context).Students,
                    ),
                    _buildNavItem(
                      index: 2,
                      icon: Icons.settings_outlined,
                      activeIcon: Icons.settings_rounded,
                      label: S.of(context).Settings,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  NavigationDestination _buildNavItem({
    required int index,
    required IconData icon,
    required IconData activeIcon,
    required String label,
  }) {
    final isSelected = _currentIndex == index;

    return NavigationDestination(
      icon: AnimatedScale(
        scale: isSelected ? 1.2 : 1.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutBack,
        child: Icon(icon),
      ),
      selectedIcon: AnimatedScale(
        scale: 1.2,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutBack,
        child: Icon(activeIcon),
      ),
      label: label,
    );
  }

  void _onTap(int index) {
    if (index == _currentIndex) return;

    setState(() => _currentIndex = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutCubic,
    );
  }
}
