import 'package:flutter/material.dart';
import 'package:school/generated/l10n.dart';

Widget buildSectionHeader(String title, Color color, BuildContext context) {
  return Row(
    children: [
      Container(
        width: 5,
        height: 26,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      const SizedBox(width: 12),
      Text(
        title,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: color,
          letterSpacing: 0.2,
        ),
      ),
      const Spacer(),
      TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          foregroundColor: color,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(S.of(context).viewAll, style: const TextStyle(fontSize: 14)),
            const SizedBox(width: 4),
            Icon(Icons.arrow_forward_ios, size: 14, color: color),
          ],
        ),
      ),
    ],
  );
}
