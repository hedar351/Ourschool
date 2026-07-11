import 'package:flutter/material.dart';
import 'package:school/features/BulletinScreen/BulletinCard.dart';
import 'package:school/features/BulletinScreen/buildSectionHeader.dart';

import '../../generated/l10n.dart';

class BulletinItem {
  final String title;
  final DateTime date;
  final String description;
  final IconData icon;

  const BulletinItem({
    required this.title,
    required this.date,
    required this.description,
    required this.icon,
  });
}

class BulletinScreen extends StatefulWidget {
  const BulletinScreen({super.key});

  @override
  State<BulletinScreen> createState() => _BulletinScreenState();
}

class _BulletinScreenState extends State<BulletinScreen> {
  final List<BulletinItem> _activities = [
    BulletinItem(
      title: "مسابقة العلوم",
      date: DateTime(2025, 5, 20),
      description: "مسابقة في العلوم لجميع الصفوف",
      icon: Icons.science,
    ),
    BulletinItem(
      title: "رحلة مدرسية",
      date: DateTime(2025, 5, 25),
      description: "رحلة إلى حديقة الحيوانات",
      icon: Icons.tour,
    ),
    BulletinItem(
      title: "ورشة فنية",
      date: DateTime(2025, 6, 1),
      description: "ورشة رسم للأطفال",
      icon: Icons.palette,
    ),
    BulletinItem(
      title: "يوم الرياضة",
      date: DateTime(2025, 6, 5),
      description: "أنشطة رياضية متنوعة",
      icon: Icons.sports_soccer,
    ),
  ];

  final List<BulletinItem> _announcements = [
    BulletinItem(
      title: "إعلان هام",
      date: DateTime(2025, 5, 18),
      description: "سيتم تعليق الدوام يوم الخميس بسبب ظروف الطقس",
      icon: Icons.warning_amber_rounded,
    ),
    BulletinItem(
      title: "اجتماع أولياء الأمور",
      date: DateTime(2025, 5, 22),
      description: "اجتماع لمناقشة نتائج الفصل الدراسي",
      icon: Icons.people,
    ),
    BulletinItem(
      title: "تسجيل المواد الاختيارية",
      date: DateTime(2025, 6, 10),
      description: "آخر موعد لتسجيل المواد الاختيارية",
      icon: Icons.edit_calendar,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // TODO  BlocBuilder  هون رح استعمل
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              _buildSection(
                title: S.of(context).Activities,
                items: _activities,
                isHorizontal: true,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 40),
              _buildSection(
                title: S.of(context).Announcements,
                items: _announcements,
                isHorizontal: false,
                color: Theme.of(context).colorScheme.secondary,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHorizontalList(List<BulletinItem> items, Color color) {
    return RepaintBoundary(
      child: SizedBox(
        height: 220,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return BulletinCard(
              key: ValueKey(items[index].title),
              item: items[index],
              color: color,
            );
          },
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<BulletinItem> items,
    required bool isHorizontal,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSectionHeader(title, color, context),
        const SizedBox(height: 16),
        isHorizontal
            ? _buildHorizontalList(items, color)
            : _buildVerticalList(items, color),
      ],
    );
  }

  Widget _buildVerticalList(List<BulletinItem> items, Color color) {
    return RepaintBoundary(
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        separatorBuilder: (_, _) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          return BulletinCard(
            key: ValueKey(items[index].title),
            item: items[index],
            color: color,
          );
        },
      ),
    );
  }
}
