import 'dart:async';

import 'package:flutter/material.dart';

mixin AutoRefreshMixin<T extends StatefulWidget> on State<T> {
  Timer? _refreshTimer;

  int get refreshInterval => 300;

  @override
  void dispose() {
    _stopAutoRefresh();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _startAutoRefresh();
  }

  Future<void> onAutoRefresh();

  void pauseAutoRefresh() {
    _stopAutoRefresh();
  }

  void restartAutoRefresh() {
    _startAutoRefresh();
  }

  void resumeAutoRefresh() {
    _startAutoRefresh();
  }

  void _startAutoRefresh() {
    _stopAutoRefresh();

    _refreshTimer = Timer.periodic(Duration(seconds: refreshInterval), (timer) {
      onAutoRefresh();
    });
  }

  void _stopAutoRefresh() {
    _refreshTimer?.cancel();
    _refreshTimer = null;
  }
}
