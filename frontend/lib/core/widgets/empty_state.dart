import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'app_surfaces.dart';

/// The "vide" state, used identically on every list screen. A pastel violet
/// icon chip over a legible secondary-colour message — never the near-white
/// `outline` tone, which read as blank on the light background.
class EmptyState extends StatelessWidget {
  const EmptyState({
    required this.message,
    this.icon = Icons.inbox_outlined,
    super.key,
  });

  final String message;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AccentIconChip(
              icon: icon,
              accent: ArtizenAccents.violet,
              size: 72,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: const TextStyle(
                color: ArtizenColors.textSecondary,
                fontSize: 15,
                height: 1.4,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
