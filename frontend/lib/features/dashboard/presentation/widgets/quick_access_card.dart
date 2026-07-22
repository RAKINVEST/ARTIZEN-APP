import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../dashboard_providers.dart';

/// A permanent quick-access panel on the dashboard: the artisan's shortcuts to
/// the things they come back to — their company details, their catalogues, and
/// adding a client. Unlike an onboarding checklist it never disappears and every
/// tile stays clickable, so "configure my company" is also "come back and edit
/// my company".
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

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(ArtizenSpacing.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: ArtizenSpacing.xs),
              child: Text(
                'Bienvenue',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: ArtizenColors.textPrimary,
                ),
              ),
            ),
            _QuickTile(
              icon: Icons.business_outlined,
              label: 'Configurer mon entreprise',
              onTap: () => pushThenRefresh('/company-profile'),
            ),
            _QuickTile(
              icon: Icons.inventory_2_outlined,
              label: 'Mes catalogues',
              onTap: () => context.go('/catalog'),
            ),
            _QuickTile(
              icon: Icons.home_repair_service_outlined,
              label: 'Ma caisse à outils',
              onTap: () => context.push('/toolbox'),
            ),
            _QuickTile(
              icon: Icons.person_add_alt_1_outlined,
              label: 'Ajouter un client',
              onTap: () => pushThenRefresh('/clients/new'),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickTile extends StatelessWidget {
  const _QuickTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      dense: true,
      onTap: onTap,
      leading: Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          color: ArtizenColors.infoSurface,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: ArtizenColors.nightBlue, size: 20),
      ),
      title: Text(
        label,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: ArtizenColors.textPrimary,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: ArtizenColors.textSecondary,
      ),
    );
  }
}
