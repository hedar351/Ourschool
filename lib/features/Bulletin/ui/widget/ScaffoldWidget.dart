// lib/features/Bulletin/ui/widget/ScaffoldWidget.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/features/Bulletin/domain/Entities/AnnouncementActivityEntity.dart';
import 'package:school/features/Bulletin/domain/Entities/BulletinEntity.dart';
import 'package:school/features/Bulletin/ui/widget/BulletinCard.dart';
import 'package:school/features/Bulletin/ui/widget/buildSectionHeader.dart';
import 'package:school/generated/l10n.dart';

class Scaffoldwidget extends StatefulWidget {
  final List<BulletinEntity> bulletins;
  final Future<void> Function() onRefresh;

  const Scaffoldwidget({
    super.key,
    required this.bulletins,
    required this.onRefresh,
  });

  @override
  State<Scaffoldwidget> createState() => _ScaffoldwidgetState();
}

class _ScaffoldwidgetState extends State<Scaffoldwidget> {
  late BulletinEntity? _bulletin;
  late List<Announcementactivityentity> _activities;
  late List<Announcementactivityentity> _announcements;

  // ✅ حسابات القيم الثابتة خارج build
  final double _paddingHorizontal = 16.w;
  final double _paddingVertical = 12.h;
  final double _gapSmall = 8.h;
  final double _gapMedium = 16.h;
  final double _gapLarge = 40.h;
  final double _verticalListGap = 16.h;
  final double _listHeight = 220.h;
  final double _emptyPadding = 40.h;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: widget.onRefresh,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: _paddingHorizontal,
                    vertical: _paddingVertical,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: _gapSmall),
                      if (_activities.isNotEmpty)
                        _buildSection(
                          title: S.of(context).Activities,
                          items: _activities,
                          isHorizontal: true,
                          color: theme.colorScheme.primary,
                        ),
                      if (_activities.isNotEmpty && _announcements.isNotEmpty)
                        SizedBox(height: _gapLarge),
                      if (_announcements.isNotEmpty)
                        _buildSection(
                          title: S.of(context).Announcements,
                          items: _announcements,
                          isHorizontal: false,
                          color: theme.colorScheme.secondary,
                        ),
                      if (_activities.isEmpty && _announcements.isEmpty)
                        _buildEmptySection(context),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(Scaffoldwidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.bulletins != widget.bulletins) {
      _initData();
    }
  }

  @override
  void initState() {
    super.initState();
    _initData();
  }

  Widget _buildEmptySection(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: _emptyPadding),
        child: Text(
          'لا توجد أنشطة أو إعلانات حالياً',
          style: theme.textTheme.bodyMedium?.copyWith(fontSize: 14.sp),
        ),
      ),
    );
  }

  Widget _buildHorizontalList(
    List<Announcementactivityentity> items,
    Color color,
  ) {
    return SizedBox(
      height: _listHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: items.length,
        cacheExtent: 200.w,
        itemBuilder: (context, index) {
          final entity = items[index];
          return Bulletincard(
            key: ValueKey(entity.id),
            entity: entity,
            color: color,
          );
        },
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Announcementactivityentity> items,
    required bool isHorizontal,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Buildsectionheader(title: title, color: color, onPressed: () {}),
        SizedBox(height: _gapMedium),
        isHorizontal
            ? _buildHorizontalList(items, color)
            : _buildVerticalList(items, color),
      ],
    );
  }

  Widget _buildVerticalList(
    List<Announcementactivityentity> items,
    Color color,
  ) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      separatorBuilder: (_, _) => SizedBox(height: _verticalListGap),
      itemBuilder: (context, index) {
        final entity = items[index];
        return Bulletincard(
          key: ValueKey(entity.id),
          entity: entity,
          color: color,
        );
      },
    );
  }

  void _initData() {
    _bulletin = widget.bulletins.isNotEmpty
        ? widget.bulletins.first
        : const BulletinEntity(message: '', announcements: [], activities: []);
    _activities = _bulletin!.activities ?? [];
    _announcements = _bulletin!.announcements ?? [];
  }
}
