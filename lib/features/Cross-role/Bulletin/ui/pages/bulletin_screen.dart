import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/core/auto_refresh_mixin.dart';
import 'package:school/core/widget/Loadingwidget.dart';
import 'package:school/core/widget/SnackBar/Message.dart';
import 'package:school/features/Cross-role/Bulletin/ui/bloc/bulletin_bloc.dart';
import 'package:school/features/Cross-role/Bulletin/ui/widget/BulletinCard.dart';
import 'package:school/generated/l10n.dart';

class BulletinScreen extends StatefulWidget {
  const BulletinScreen({super.key});

  @override
  State<BulletinScreen> createState() => _BulletinScreenState();
}

class _BulletinScreenState extends State<BulletinScreen>
    with
        WidgetsBindingObserver,
        AutomaticKeepAliveClientMixin,
        AutoRefreshMixin<BulletinScreen> {
  late SnackBarMessage snackBarMessage;
  int _selectedTab = 0;

  @override
  int get refreshInterval => 240;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final theme = Theme.of(context);

    return BlocConsumer<BulletinBloc, BulletinState>(
      listener: (context, state) {
        if (state is BulletinError) {
          snackBarMessage.errorMessage(
            message: state.message,
            context: context,
          );
        }
      },
      builder: (context, state) {
        if (state is BulletinLoading) {
          return const Center(child: Loadingwidget());
        }

        if (state is BulletinLoaded) {
          if (state.bulletins.isEmpty) {
            return RefreshIndicator(
              onRefresh: _onRefresh,
              color: theme.colorScheme.primary,
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(child: _buildHeader(context, theme)),
                  SliverToBoxAdapter(
                    child: _buildEmptyState(context, theme.colorScheme.primary),
                  ),
                ],
              ),
            );
          }

          final firstBulletin = state.bulletins.first;
          final announcements = firstBulletin.announcements ?? [];
          final activities = firstBulletin.activities ?? [];
          final currentItems = _selectedTab == 0 ? announcements : activities;
          final activeColor = _selectedTab == 0
              ? theme.colorScheme.primary
              : theme.colorScheme.secondary;

          return RefreshIndicator(
            onRefresh: _onRefresh,
            color: activeColor,
            child: SafeArea(
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(child: _buildHeader(context, theme)),

                  SliverToBoxAdapter(
                    child: _buildSegmentedControl(
                      theme,
                      announcements.isNotEmpty,
                      activities.isNotEmpty,
                    ),
                  ),

                  if (currentItems.isEmpty)
                    SliverToBoxAdapter(
                      child: _buildEmptyState(context, activeColor),
                    )
                  else
                    SliverPadding(
                      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 100.h),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: 16.h),
                            child: BulletinCard(
                              entity: currentItems[index],
                              color: activeColor,
                              isHorizontal: false,
                            ),
                          );
                        }, childCount: currentItems.length),
                      ),
                    ),
                ],
              ),
            ),
          );
        }

        if (state is BulletinError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.wifi_off_rounded,
                  size: 64.w,
                  color: theme.colorScheme.error.withOpacity(0.5),
                ),
                SizedBox(height: 16.h),
                Text(
                  state.message,
                  style: theme.textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24.h),
                ElevatedButton.icon(
                  onPressed: _loadData,
                  icon: const Icon(Icons.refresh_rounded),
                  label: Text(S.of(context).retry),
                ),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) _loadData();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    snackBarMessage = SnackBarMessage();
    _loadData();
  }

  @override
  Future<void> onAutoRefresh() async {
    print('🔄 [AutoRefresh] تحديث الكتب تلقائياً...');
    if (mounted) {
      context.read<BulletinBloc>().add(RefreshBulletinsEvent());
    }
  }

  Widget _buildEmptyState(BuildContext context, Color activeColor) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 60.h),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: activeColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.inbox_rounded, size: 48.w, color: activeColor),
            ),
            SizedBox(height: 20.h),
            Text(
              'لا يوجد عناصر لعرضها حالياً',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'اسحب للأسفل لتحديث البيانات',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ThemeData theme) {
    return
    //  SafeArea(
    //   child:
    Padding(
      padding: EdgeInsets.fromLTRB(15.w, 15.h, 15.w, 15.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).Bulletin,
            style: theme.textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            S.of(context).Stay_update_with_activities,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
        ],
      ),
      // ),
    );
  }

  Widget _buildSegmentedControl(
    ThemeData theme,
    bool hasAnnouncements,
    bool hasActivities,
  ) {
    if (!hasActivities) return const SizedBox.shrink();

    final isSelected0 = _selectedTab == 0;
    final isSelected1 = _selectedTab == 1;
    final activeColor = isSelected0
        ? theme.colorScheme.primary
        : theme.colorScheme.secondary;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: Container(
        height: 48.h,
        padding: EdgeInsets.all(4.h),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.5),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: theme.dividerColor.withOpacity(0.3)),
        ),
        child: Stack(
          children: [
            AnimatedAlign(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              alignment: isSelected0
                  ? AlignmentDirectional.centerStart
                  : AlignmentDirectional.centerEnd,
              child: Container(
                width: (1.sw - 40.w - 8.w) / 2,
                height: 40.h,
                decoration: BoxDecoration(
                  color: activeColor,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: activeColor.withOpacity(0.3),
                      blurRadius: 8.r,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => setState(() => _selectedTab = 0),
                    borderRadius: BorderRadius.circular(12.r),
                    child: Center(
                      child: Text(
                        S.of(context).Announcements,
                        style: TextStyle(
                          color: isSelected0
                              ? theme.colorScheme.onPrimary
                              : theme.colorScheme.onSurface.withOpacity(0.6),
                          fontWeight: FontWeight.w700,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () => setState(() => _selectedTab = 1),
                    borderRadius: BorderRadius.circular(12.r),
                    child: Center(
                      child: Text(
                        S.of(context).Activities,
                        style: TextStyle(
                          color: isSelected1
                              ? theme.colorScheme.onPrimary
                              : theme.colorScheme.onSurface.withOpacity(0.6),
                          fontWeight: FontWeight.w700,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _loadData() {
    final bloc = context.read<BulletinBloc>();
    final currentState = bloc.state;
    if (currentState is BulletinInitial || currentState is BulletinError) {
      bloc.add(GetBulletinsEvent());
    } else if (currentState is BulletinLoaded && !currentState.isRevalidating) {
      bloc.add(RevalidateBulletinsEvent());
    }
  }

  Future<void> _onRefresh() async {
    context.read<BulletinBloc>().add(RefreshBulletinsEvent());
  }
}
