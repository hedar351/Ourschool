import 'package:flutter/material.dart';
import 'package:school/features/SchoolsInfo/UI/page/schools_screen.dart';
import 'package:school/generated/l10n.dart';

class LoginFooter extends StatelessWidget {
  final bool isLoading;

  const LoginFooter({super.key, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Divider(color: Theme.of(context).dividerColor)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                S.of(context).or_explore,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodySmall?.color,
                ),
              ),
            ),
            Expanded(child: Divider(color: Theme.of(context).dividerColor)),
          ],
        ),
        const SizedBox(height: 24),
        OutlinedButton.icon(
          onPressed: isLoading
              ? null
              : () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SchoolsScreen(),
                    ),
                  );
                },
          icon: Icon(
            Icons.school_outlined,
            color: Theme.of(context).colorScheme.primary,
          ),
          label: Text(
            S.of(context).browse_school,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 16,
            ),
          ),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 25),
            side: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 1.5,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ],
    );
  }
}
