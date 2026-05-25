import 'package:flutter/material.dart';
import 'package:school/generated/l10n.dart';

class WelcomeHeader extends StatelessWidget {
  const WelcomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
          ),
          child: Icon(
            Icons.school_rounded,
            size: 80,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        Text(
          S.of(context).title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
            fontFamily: 'Cairo',
          ),
        ),
        const SizedBox(height: 8),
        Text(
          S.of(context).we_build_leaders,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            color: Theme.of(context).colorScheme.secondary,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}
