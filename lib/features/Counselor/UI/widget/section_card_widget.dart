import 'package:flutter/material.dart';

class SectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final int count;
  final VoidCallback onTap;
  final Color? iconBackgroundColor;

  const SectionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.count,
    required this.onTap,
    this.iconBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = iconBackgroundColor ?? theme.colorScheme.primary;

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: color.withOpacity(0.15), width: 1),
      ),
      color: theme.brightness == Brightness.dark
          ? Colors.grey.shade800.withOpacity(0.6)
          : Colors.white,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        splashColor: color.withOpacity(0.15),
        highlightColor: color.withOpacity(0.05),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color, color.withOpacity(0.7)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: Colors.white, size: 24),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: count > 0
                      ? color.withOpacity(0.12)
                      : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: count > 0
                        ? color.withOpacity(0.2)
                        : Colors.grey.shade300,
                    width: 0.5,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      count > 0 ? Icons.check_circle : Icons.remove_circle,
                      size: 16,
                      color: count > 0 ? color : Colors.grey.shade500,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '$count',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: count > 0 ? color : Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 4),
              Icon(
                Icons.chevron_right,
                color: theme.colorScheme.outline,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
