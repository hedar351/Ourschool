import 'package:flutter/material.dart';
import 'package:school/features/Bulletin/domain/Entities/AnnouncementActivityEntity.dart';
import 'package:school/features/Bulletin/domain/Entities/BulletinEntity.dart';
import 'package:school/features/Bulletin/ui/widget/BulletinCard.dart';
import 'package:school/features/Bulletin/ui/widget/buildSectionHeader.dart';
import 'package:school/generated/l10n.dart';

// ignore: must_be_immutable
class Scaffoldwidget extends StatefulWidget {
  List<BulletinEntity> bulletins;

  Scaffoldwidget({super.key, required this.bulletins});

  @override
  State<Scaffoldwidget> createState() => _ScaffoldwidgetState();
}

class _ScaffoldwidgetState extends State<Scaffoldwidget> {
  @override
  Widget build(BuildContext context) {
    final bulletin = widget.bulletins.first;
    final activities = bulletin.activities ?? [];
    final announcements = bulletin.announcements ?? [];
    // final message = widget.bulletins.first.message;
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
                items: activities,
                isHorizontal: true,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 40),
              _buildSection(
                title: S.of(context).Announcements,
                items: announcements,
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

  Widget _buildHorizontalList(
    List<Announcementactivityentity> items,
    Color color,
  ) {
    return RepaintBoundary(
      child: SizedBox(
        height: 220,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final entity = items[index];
            return Bulletincard(
              key: ValueKey(entity.id),
              entity: entity,
              color: color,
            );
          },
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Announcementactivityentity> items,
    required bool isHorizontal,
    required Color color,
  }) {
    if (items.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Buildsectionheader(title: title, color: color),
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
    return RepaintBoundary(
      child: ListView.separated(
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
      ),
    );
  }
}
