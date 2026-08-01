// lib/features/Navigation/NavHomePage.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/features/Auth/domain/entities/auth_entities.dart';
import 'package:school/features/Bulletin/ui/pages/bulletin_screen.dart';
import 'package:school/features/Setting/Settingscreen.dart';
import 'package:school/features/Teacher/ui/page/teacher_subjects_screen.dart';
import 'package:school/generated/l10n.dart';

import '../Counselor/UI/page/ClassScreen.dart';
import '../Student/ui/page/academic_record_screen.dart  .dart';

class NavHomePage extends StatefulWidget {
  final AuthEntities user;
  const NavHomePage({super.key, required this.user});

  @override
  State<NavHomePage> createState() => _NavHomePageState();
}

class _NavHomePageState extends State<NavHomePage>
    with SingleTickerProviderStateMixin {
  late final PageController _pageController;
  int _currentIndex = 0;

  // ✅ حسابات القيم الثابتة خارج build
  final double _navPaddingLeft = 20.w;
  final double _navPaddingRight = 20.w;
  final double _navPaddingBottom = 16.h;
  final double _navHeight = 65.h;
  final double _navRadius = 30.r;
  final double _blurRadius = 20.w;
  final double _spreadRadius = 5.w;
  final double _selectedFontSize = 13.sp;
  final double _unselectedFontSize = 12.sp;
  final double _scaleMultiplier = 1.2;
  final double _offsetY = 8.h;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    List<Widget> pages = [
      const BulletinScreen(),
      widget.user.role == "Student"
          ? const AcademicRecordScreen()
          : widget.user.role == "Teacher"
          ? const TeacherSubjectsScreen()
          : const ClassScreen(),
      const SettingsScreen(),
    ];

    List<NavigationDestination> destinations = [
      _buildNavItem(
        index: 0,
        icon: Icons.home_outlined,
        activeIcon: Icons.home_rounded,
        label: S.of(context).Home,
      ),
      _buildNavItem(
        index: 1,
        icon: widget.user.role == "Student" ? Icons.receipt : Icons.person,
        activeIcon: widget.user.role == "Student"
            ? Icons.receipt
            : Icons.person,
        label: widget.user.role == "Student"
            ? S.of(context).Info
            : S.of(context).Students,
      ),
      _buildNavItem(
        index: widget.user.role == "Student" ? 3 : 2,
        icon: Icons.settings_outlined,
        activeIcon: Icons.settings_rounded,
        label: S.of(context).Settings,
      ),
    ];

    return Scaffold(
      extendBody: true,
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: pages,
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            _navPaddingLeft,
            0,
            _navPaddingRight,
            _navPaddingBottom,
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(_navRadius),
              boxShadow: [
                BoxShadow(
                  color: theme.shadowColor.withOpacity(0.1),
                  blurRadius: _blurRadius,
                  spreadRadius: _spreadRadius,
                  offset: Offset(0, _offsetY),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(_navRadius),
              child: NavigationBarTheme(
                data: NavigationBarThemeData(
                  indicatorColor: theme.colorScheme.primary.withOpacity(0.15),
                  labelTextStyle: WidgetStateProperty.resolveWith((states) {
                    if (states.contains(WidgetState.selected)) {
                      return TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: _selectedFontSize,
                        color: theme.colorScheme.primary,
                      );
                    }
                    return TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: _unselectedFontSize,
                      color: theme.unselectedWidgetColor,
                    );
                  }),
                ),
                child: NavigationBar(
                  height: _navHeight,
                  backgroundColor: theme.cardColor,
                  surfaceTintColor: Colors.transparent,
                  elevation: 0,
                  selectedIndex: _currentIndex,
                  onDestinationSelected: _onTap,
                  destinations: destinations,
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
        scale: isSelected ? _scaleMultiplier : 1.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutBack,
        child: Icon(icon, size: 24.w),
      ),
      selectedIcon: AnimatedScale(
        scale: _scaleMultiplier,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutBack,
        child: Icon(activeIcon, size: 24.w),
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
