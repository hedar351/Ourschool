import 'package:flutter/material.dart';
import 'package:school/core/cubit/locale_cubit.dart';

class PopupMenu extends StatelessWidget {
  final String currentLocale;

  final LocaleCubit cubit;
  const PopupMenu({
    super.key,
    required this.currentLocale,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Theme.of(context).dividerColor),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.language,
              color: Theme.of(context).colorScheme.primary,
              size: 20,
            ),
            const SizedBox(width: 4),
            Text(
              currentLocale == 'ar' ? 'عربي' : 'EN',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            Icon(
              Icons.arrow_drop_down,
              color: Theme.of(context).colorScheme.primary,
              size: 18,
            ),
          ],
        ),
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 'ar',
          child: Row(
            children: [
              Icon(
                Icons.flag,
                color: Theme.of(context).colorScheme.secondary,
                size: 18,
              ),
              const SizedBox(width: 12),
              const Text('العربية'),
              if (currentLocale == 'ar') const Spacer(),
              if (currentLocale == 'ar')
                Icon(
                  Icons.check,
                  color: Theme.of(context).colorScheme.primary,
                  size: 18,
                ),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'en',
          child: Row(
            children: [
              Icon(
                Icons.flag,
                color: Theme.of(context).colorScheme.primary,
                size: 18,
              ),
              const SizedBox(width: 12),
              const Text('English'),
              if (currentLocale == 'en') const Spacer(),
              if (currentLocale == 'en')
                Icon(
                  Icons.check,
                  color: Theme.of(context).colorScheme.primary,
                  size: 18,
                ),
            ],
          ),
        ),
      ],
      onSelected: (code) => cubit.setLocale(Locale(code)),
    );
  }
}
