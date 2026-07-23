import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_surfaces.dart';
import '../dashboard_providers.dart';

/// A permanent quick-access panel on the dashboard: the artisan's shortcuts to
/// the things they come back to — their company details, their catalogues,
/// their toolbox, and adding a client. Unlike an onboarding checklist it never
/// disappears and every tile stays clickable, so "configure my company" is
/// also "come back and edit my company".
///
/// Laid out as a row of pastel chips on a wide screen, wrapping to a 2×2 grid
/// when there is not enough width.
class QuickAccessCard extends ConsumerWidget {
  const QuickAccessCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Full-screen tiles (company profile, new client) are pushed, so the artisan
    // returns to the dashboard afterwards; on return the summary is refreshed so
    // a just-added client shows in the counts. The catalogue lives in the
    // bottom-nav shell, so it is switched to with `go`.
    Future<void> pushThenRefresh(String location) async {
      await context.push(location);
      ref.invalidate(dashboardSummaryProvider);
    }

    final tiles = <_QuickTileData>[
      _QuickTileData(
        icon: Icons.business_outlined,
        label: 'Configurer mon entreprise',
        accent: ArtizenAccents.blue,
        onTap: () => pushThenRefresh('/company-profile'),
      ),
      _QuickTileData(
        icon: Icons.inventory_2_outlined,
        label: 'Mes catalogues',
        accent: ArtizenAccents.violet,
        onTap: () => context.go('/catalog'),
      ),
      _QuickTileData(
        icon: Icons.home_repair_service_outlined,
        label: 'Ma caisse à outils',
        accent: ArtizenAccents.amber,
        onTap: () => context.push('/toolbox'),
      ),
    ];

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: ArtizenSpacing.sm),
            child: Text(
              'Bienvenue',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: ArtizenColors.textPrimary,
              ),
            ),
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              final wide = constraints.maxWidth >= 620;
              if (wide) {
                return Row(
                  children: [
                    for (var i = 0; i < tiles.length; i++) ...[
                      if (i > 0)
                        Container(
                          width: 1,
                          height: 44,
                          color: ArtizenColors.border,
                        ),
                      Expanded(child: _QuickTile(data: tiles[i])),
                    ],
                  ],
                );
              }
              return Wrap(
                runSpacing: ArtizenSpacing.xs,
                children: [
                  for (final tile in tiles)
                    SizedBox(
                      width: (constraints.maxWidth - ArtizenSpacing.sm) / 2,
                      child: _QuickTile(data: tile),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _QuickTileData {
  const _QuickTileData({
    required this.icon,
    required this.label,
    required this.accent,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final ArtizenAccent accent;
  final VoidCallback onTap;
}

class _QuickTile extends StatelessWidget {
  const _QuickTile({required this.data});

  final _QuickTileData data;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: data.onTap,
        borderRadius: BorderRadius.circular(ArtizenRadii.button),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Row(
            children: [
              AccentIconChip(icon: data.icon, accent: data.accent, size: 42),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  data.label,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: ArtizenColors.textPrimary,
                    height: 1.25,
                  ),
                ),
              ),
              const Icon(
                Icons.chevron_right,
                color: ArtizenColors.textSecondary,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
