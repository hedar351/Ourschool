import 'package:flutter/material.dart';
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      if (_activities.isNotEmpty)
                        _buildSection(
                          title: S.of(context).Activities,
                          items: _activities,
                          isHorizontal: true,
                          color: theme.colorScheme.primary,
                        ),
                      if (_activities.isNotEmpty && _announcements.isNotEmpty)
                        const SizedBox(height: 40),
                      if (_announcements.isNotEmpty)
                        _buildSection(
                          title: S.of(context).Announcements,
                          items: _announcements,
                          isHorizontal: false,
                          color: theme.colorScheme.secondary,
                        ),
                      if (_activities.isEmpty && _announcements.isEmpty)
                        _buildEmptySection(context),
                      const SizedBox(height: 20),
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
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Text(
          'لا توجد أنشطة أو إعلانات حالياً',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }

  Widget _buildHorizontalList(
    List<Announcementactivityentity> items,
    Color color,
  ) {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: items.length,
        cacheExtent: 200,
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
        const SizedBox(height: 16),
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
      separatorBuilder: (_, _) => const SizedBox(height: 16),
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
