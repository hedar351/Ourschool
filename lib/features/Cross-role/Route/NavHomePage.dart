import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/core/injection.dart' as di;
import 'package:school/features/Bulletin/ui/pages/bulletin_screen.dart';
import 'package:school/features/Counselor/UI/page/ClassAndSectionsScreen.dart';
import 'package:school/features/Cross-role/Setting/Settingscreen.dart';
import 'package:school/features/FirstStep/Auth/domain/entities/auth_entities.dart';
import 'package:school/features/Student/ui/ProfileScreen/page/academic_record_screen.dart%20%20.dart';
import 'package:school/features/Student/ui/bloc/libraryBloc/library_bloc.dart';
import 'package:school/features/Student/ui/bloc/reservation_bloc/reservation_bloc.dart';
import 'package:school/features/Student/ui/libraryScreen/library_screen.dart';
import 'package:school/features/Teacher/ui/bloc/TeacherBloc/teacher_bloc.dart';
import 'package:school/features/Teacher/ui/page/teacher_subjects_screen.dart';
import 'package:school/generated/l10n.dart';

class NavHomePage extends StatefulWidget {
  final AuthEntities user;
  const NavHomePage({super.key, required this.user});

  @override
  State<NavHomePage> createState() => _NavHomePageState();
}

class _NavHomePageState extends State<NavHomePage>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late final PageController _pageController;

  bool get _isStudent => widget.user.role == "Student";
  bool get _isTeacher => widget.user.role == "Teacher";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    return Scaffold(
      extendBody: true,

      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _buildPages(),
      ),
      bottomNavigationBar: _buildCustomNavBar(theme, primaryColor),
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
    _pageController = PageController(initialPage: _currentIndex);
  }

  void _animateToPage(int index) {
    if (index == _currentIndex) return;
    setState(() => _currentIndex = index);

    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOutCubicEmphasized,
    );
  }

  Widget _buildCustomNavBar(ThemeData theme, Color primaryColor) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 20.h),
        child: Container(
          height: 72.h,
          decoration: BoxDecoration(
            color: theme.cardColor.withOpacity(0.95),
            borderRadius: BorderRadius.circular(36.r),
            border: Border.all(
              color: theme.dividerColor.withOpacity(0.15),
              width: 1.w,
            ),
            boxShadow: [
              BoxShadow(
                color: primaryColor.withOpacity(0.1),
                blurRadius: 30.r,
                spreadRadius: 2.r,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(36.r),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNavItem(
                  index: 0,
                  icon: Icons.home_outlined,
                  activeIcon: Icons.home_rounded,
                  label: S.of(context).Home,
                  theme: theme,
                  primaryColor: primaryColor,
                ),
                _buildNavItem(
                  index: 1,
                  icon: _isStudent
                      ? Icons.receipt_long_outlined
                      : Icons.people_outline,
                  activeIcon: _isStudent
                      ? Icons.receipt_long_rounded
                      : Icons.people_rounded,
                  label: _isStudent
                      ? S.of(context).Info
                      : S.of(context).Students,
                  theme: theme,
                  primaryColor: primaryColor,
                ),
                if (_isStudent)
                  _buildNavItem(
                    index: 2,
                    icon: Icons.library_books_outlined,
                    activeIcon: Icons.library_books_rounded,
                    label: S.of(context).library,
                    theme: theme,
                    primaryColor: primaryColor,
                  ),
                _buildNavItem(
                  index: _isStudent ? 3 : 2,
                  icon: Icons.settings_outlined,
                  activeIcon: Icons.settings_rounded,
                  label: S.of(context).Settings,
                  theme: theme,
                  primaryColor: primaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required ThemeData theme,
    required Color primaryColor,
  }) {
    final isSelected = _currentIndex == index;

    return InkWell(
      onTap: () => _animateToPage(index),
      borderRadius: BorderRadius.circular(36.r),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutBack,
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? 20.w : 16.w,
          vertical: 12.h,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? primaryColor.withOpacity(0.12)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(36.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedScale(
              scale: isSelected ? 1.25 : 1.0,
              duration: const Duration(milliseconds: 400),
              curve: Curves.elasticOut,
              child: Icon(
                isSelected ? activeIcon : icon,
                color: isSelected ? primaryColor : theme.hintColor,
                size: 20.w,
              ),
            ),
            SizedBox(width: 6.w),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              width: isSelected ? 70.w : 0.w,
              child: AnimatedOpacity(
                opacity: isSelected ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 200),
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildPages() {
    return [
      const BulletinScreen(),

      if (_isStudent)
        const AcademicRecordScreen()
      else if (_isTeacher)
        BlocProvider(
          create: (_) => di.sl<TeacherBloc>()..add(GetTeacherEvent()),
          child: const TeacherSubjectsScreen(),
        )
      else
        const ClassAndSectionsScreen(),

      if (_isStudent)
        MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => di.sl<LibraryBloc>()),
            BlocProvider(create: (context) => di.sl<ReservationsBloc>()),
          ],
          child: const LibraryScreen(),
        ),

      const SettingsScreen(),
    ];
  }
}
