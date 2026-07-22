import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../theme/app_theme.dart';

/// Navigation across the app's main sections, shown on each section's AppBar.
/// The order mirrors the bottom bar — Tableau de bord › Clients › Catalogue ›
/// Devis › Paramètres. **Back (←) always returns straight to the Tableau de
/// bord** (home) from any section, so getting there is one tap, never a walk
/// back through the others; **Next (→)** steps forward to the following
/// section. The dashboard itself carries no arrows (it is home) and the last
/// section (Paramètres) drops its "next" — nothing lies beyond it.
class SectionNavArrows extends StatelessWidget {
  const SectionNavArrows({required this.current, super.key});

  /// The route of the section this bar sits on, e.g. `/clients`.
  final String current;

  /// The main sections, in bottom-bar order. Prev/Next step through this list.
  static const order = [
    '/dashboard',
    '/clients',
    '/catalog',
    '/quotes',
    '/settings',
  ];

  @override
  Widget build(BuildContext context) {
    final i = order.indexOf(current);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (i > 0)
          IconButton(
            icon: const Icon(Icons.arrow_back),
            tooltip: 'Tableau de bord',
            color: ArtizenColors.onNightBlue,
            visualDensity: VisualDensity.compact,
            // Back always returns straight home, from any section — no walking
            // the sections one by one to reach the dashboard.
            onPressed: () => context.go(order.first),
          ),
        if (i >= 0 && i < order.length - 1)
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            tooltip: 'Section suivante',
            color: ArtizenColors.onNightBlue,
            visualDensity: VisualDensity.compact,
            onPressed: () => context.go(order[i + 1]),
          ),
      ],
    );
  }
}
