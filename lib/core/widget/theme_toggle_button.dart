import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school/core/cubit/theme_cubit.dart';

class ThemeToggleButton extends StatelessWidget {
  final Color? iconColor;
  final double? iconSize;

  const ThemeToggleButton({super.key, this.iconColor, this.iconSize = 24});

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.watch<ThemeCubit>();
    final isDark = themeCubit.state == ThemeMode.dark;

    return IconButton(
      icon: Icon(
        isDark ? Icons.light_mode : Icons.dark_mode,
        color: iconColor ?? Theme.of(context).colorScheme.primary,
        size: iconSize,
      ),
      tooltip: isDark ? 'Switch to Light Mode' : 'Switch to Dark Mode',
      onPressed: () {
        final newMode = isDark ? ThemeMode.light : ThemeMode.dark;
        themeCubit.setTheme(newMode);
      },
    );
  }
}
