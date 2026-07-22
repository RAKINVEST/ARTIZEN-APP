import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';

/// The permanent main menu, always visible on the left while the quote is
/// built in the centre — the vision's "boîte à outils" frame. Compact (icons
/// only) on narrow screens so it never eats the workspace.
///
/// Tapping a destination or "Quitter" leaves the assistant — but always
/// through [onLeave], which confirms before discarding an in-progress quote
/// (décision 6). The menu never navigates away directly.
class WizardLeftMenu extends StatelessWidget {
  const WizardLeftMenu({
    required this.compact,
    required this.onLeave,
    super.key,
  });

  final bool compact;

  /// Runs [proceed] to actually leave — but only after the wizard has cleared
  /// (or the artisan has confirmed abandoning) any in-progress draft.
  final void Function(VoidCallback proceed) onLeave;

  static const _destinations = <_MenuDestination>[
    _MenuDestination('Accueil', Icons.home_outlined, '/dashboard'),
    _MenuDestination(
      'Devis',
      Icons.description_outlined,
      '/quotes',
      current: true,
    ),
    _MenuDestination('Clients', Icons.people_outline, '/clients'),
    _MenuDestination(
      'Factures',
      Icons.receipt_long_outlined,
      null,
    ), // pas encore
    _MenuDestination('Paramètres', Icons.settings_outlined, '/settings'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: compact ? 64 : 208,
      color: ArtizenColors.nightBlue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: ArtizenSpacing.md),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: compact ? 0 : ArtizenSpacing.sm,
            ),
            child: Text(
              compact ? 'A' : 'ARTIZEN',
              textAlign: compact ? TextAlign.center : TextAlign.left,
              style: const TextStyle(
                color: ArtizenColors.gold,
                fontFamily: 'Orbitron',
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
          ),
          const SizedBox(height: ArtizenSpacing.md),
          for (final destination in _destinations)
            _MenuItem(
              destination: destination,
              compact: compact,
              onLeave: onLeave,
            ),
          const Spacer(),
          const Divider(color: Colors.white24, height: 1),
          _MenuItem(
            destination: const _MenuDestination('Quitter', Icons.close, null),
            compact: compact,
            onLeave: onLeave,
            onTap: () => context.pop(),
          ),
          const SizedBox(height: ArtizenSpacing.sm),
        ],
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  const _MenuItem({
    required this.destination,
    required this.compact,
    required this.onLeave,
    this.onTap,
  });

  final _MenuDestination destination;
  final bool compact;
  final void Function(VoidCallback proceed) onLeave;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null || destination.route != null;
    final color = destination.current
        ? ArtizenColors.gold
        : enabled
        ? Colors.white
        : Colors.white38;

    final tile = InkWell(
      onTap: !enabled
          ? null
          : () => onLeave(onTap ?? () => context.go(destination.route!)),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: compact ? 0 : ArtizenSpacing.sm,
          vertical: 12,
        ),
        color: destination.current
            ? Colors.white.withValues(alpha: 0.06)
            : null,
        child: Row(
          mainAxisAlignment: compact
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          children: [
            Icon(destination.icon, color: color, size: 22),
            if (!compact) ...[
              const SizedBox(width: ArtizenSpacing.sm),
              Expanded(
                child: Text(
                  destination.label,
                  style: TextStyle(color: color),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ],
        ),
      ),
    );

    return compact ? Tooltip(message: destination.label, child: tile) : tile;
  }
}

class _MenuDestination {
  const _MenuDestination(
    this.label,
    this.icon,
    this.route, {
    this.current = false,
  });

  final String label;
  final IconData icon;
  final String? route;
  final bool current;
}
