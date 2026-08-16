import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/features/Cross-role/Bulletin/domain/Entities/AnnouncementActivityEntity.dart';
import 'package:school/features/Cross-role/Bulletin/domain/Entities/BulletinEntity.dart';
import 'package:school/features/Cross-role/Bulletin/ui/widget/BulletinCard.dart';
import 'package:school/features/Cross-role/Bulletin/ui/widget/buildSectionHeader.dart';
import 'package:school/generated/l10n.dart';

class AnimatedEntryWidget extends StatefulWidget {
  final Widget child;
  final int delay;

  const AnimatedEntryWidget({
    super.key,
    required this.child,
    required this.delay,
  });

  @override
  State<AnimatedEntryWidget> createState() => _AnimatedEntryWidgetState();
}

class ScaffoldWidget extends StatefulWidget {
  final List<BulletinEntity> bulletins;
  final Future<void> Function() onRefresh;

  const ScaffoldWidget({
    super.key,
    required this.bulletins,
    required this.onRefresh,
  });

  @override
  State<ScaffoldWidget> createState() => _ScaffoldWidgetState();
}

class _AnimatedEntryWidgetState extends State<AnimatedEntryWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(position: _slideAnimation, child: widget.child),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) _controller.forward();
    });
  }
}

class _ScaffoldWidgetState extends State<ScaffoldWidget>
    with AutomaticKeepAliveClientMixin {
  late List<Announcementactivityentity> _activities;
  late List<Announcementactivityentity> _announcements;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final theme = Theme.of(context);
    return RefreshIndicator(
      onRefresh: widget.onRefresh,
      color: theme.colorScheme.primary,
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(child: SizedBox(height: 16.h)),

          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                if (_activities.isNotEmpty) ...[
                  AnimatedEntryWidget(
                    delay: 100,
                    child: BuildSectionHeader(
                      title: S.of(context).Activities,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  _buildHorizontalList(_activities, theme.colorScheme.primary),
                  SizedBox(height: 32.h),
                ],
                if (_announcements.isNotEmpty) ...[
                  AnimatedEntryWidget(
                    delay: _activities.isNotEmpty ? 200 : 100,
                    child: BuildSectionHeader(
                      title: S.of(context).Announcements,
                      color: theme.colorScheme.secondary,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  _buildVerticalList(
                    _announcements,
                    theme.colorScheme.secondary,
                  ),
                ],
                if (_activities.isEmpty && _announcements.isEmpty)
                  AnimatedEntryWidget(
                    delay: 100,
                    child: _buildEmptySection(context),
                  ),
                SizedBox(height: 100.h),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void didUpdateWidget(ScaffoldWidget oldWidget) {
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox_rounded, size: 64.w, color: Colors.grey.shade300),
          SizedBox(height: 16.h),
          Text(
            'لا توجد أنشطة أو إعلانات حالياً',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalList(
    List<Announcementactivityentity> items,
    Color color,
  ) {
    return SizedBox(
      height: 220.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return AnimatedEntryWidget(
            delay: 300 + (index * 100),
            child: BulletinCard(
              key: ValueKey(items[index].id),
              entity: items[index],
              color: color,
              isStudent: true,
            ),
          );
        },
      ),
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
      separatorBuilder: (_, _) => SizedBox(height: 16.h),
      itemBuilder: (context, index) {
        return AnimatedEntryWidget(
          delay: 300 + (index * 100),
          child: BulletinCard(
            key: ValueKey(items[index].id),
            entity: items[index],
            color: color,
            isStudent: true,
          ),
        );
      },
    );
  }

  void _initData() {
    if (widget.bulletins.isNotEmpty) {
      _activities = widget.bulletins.first.activities ?? [];
      _announcements = widget.bulletins.first.announcements ?? [];
    } else {
      _activities = [];
      _announcements = [];
    }
  }
}
