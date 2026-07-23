import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_components.dart';
import '../../../../core/widgets/app_surfaces.dart';

/// The dashboard's headline actions — what a brand-new artisan reaches for in the
/// first seconds, without ever opening Settings.
///
/// Reproducing an existing devis (ARTIZEN adapts to *their* model, not the other
/// way round) is the product's core promise, so it gets a dedicated, explained
/// hero here rather than being buried in configuration — otherwise many users
/// would never discover what makes ARTIZEN valuable. The advanced model
/// management (view / replace / remove / import history / re-analyse) stays in
/// Settings → Modèle de devis.
class PrimaryActionsCard extends StatelessWidget {
  const PrimaryActionsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // The flagship, first-level action, explained.
          _ReproduceHero(onTap: () => context.push('/template-import')),
          const SizedBox(height: ArtizenSpacing.sm),
          // The two other headline actions. "Nouveau devis" opens the guided
          // wizard (same target as the quotes-list FAB) — it had no dashboard
          // entry before this.
          LayoutBuilder(
            builder: (context, constraints) {
              final newQuote = _ActionTile(
                icon: Icons.post_add_outlined,
                label: 'Nouveau devis',
                accent: ArtizenAccents.blue,
                onTap: () => context.push('/assistant'),
              );
              final clients = _ActionTile(
                icon: Icons.people_outline,
                label: 'Mes clients',
                accent: ArtizenAccents.green,
                onTap: () => context.go('/clients'),
              );
              if (constraints.maxWidth < 420) {
                return Column(
                  children: [
                    newQuote,
                    const SizedBox(height: ArtizenSpacing.xs),
                    clients,
                  ],
                );
              }
              return Row(
                children: [
                  Expanded(child: newQuote),
                  const SizedBox(width: ArtizenSpacing.sm),
                  Expanded(child: clients),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

/// The explained, tinted "Reproduire un devis existant" panel with its CTA.
class _ReproduceHero extends StatelessWidget {
  const _ReproduceHero({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ArtizenAccents.violet.bg,
        borderRadius: BorderRadius.circular(ArtizenRadii.card),
      ),
      padding: const EdgeInsets.all(ArtizenSpacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const AccentIconChip(
                icon: Icons.picture_as_pdf_outlined,
                accent: ArtizenAccents.violet,
                size: 52,
              ),
              const SizedBox(width: ArtizenSpacing.sm),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Reproduire un devis existant',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: ArtizenColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Importez un ancien devis PDF et ARTIZEN recrée '
                      'automatiquement votre modèle.',
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.3,
                        color: ArtizenColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: ArtizenSpacing.sm),
          SizedBox(
            width: double.infinity,
            child: GradientButton(
              gradient: ArtizenGradients.button,
              icon: Icons.upload_file_outlined,
              label: 'Reproduire mon devis',
              height: 48,
              onPressed: onTap,
            ),
          ),
        ],
      ),
    );
  }
}

/// A bordered, tappable headline action (icon chip + label + chevron).
class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.icon,
    required this.label,
    required this.accent,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final ArtizenAccent accent;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(ArtizenRadii.button),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: ArtizenColors.border),
            borderRadius: BorderRadius.circular(ArtizenRadii.button),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Row(
            children: [
              AccentIconChip(icon: icon, accent: accent, size: 40),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: ArtizenColors.textPrimary,
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
