import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../domain/dashboard_summary.dart';
import '../dashboard_providers.dart';

/// The "getting started" checklist shown on the dashboard until the artisan
/// has configured their company, added an item, added a client and created a
/// first quote. It removes the blank-slate paralysis by pointing straight at
/// the next thing to do. The caller (dashboard) decides whether to show it —
/// this widget assumes it should render.
class OnboardingChecklist extends ConsumerWidget {
  const OnboardingChecklist({required this.summary, super.key});

  final DashboardSummary summary;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final done = summary.onboardingDoneCount;
    final steps = _buildSteps(context, ref);

    return Card(
      // Inherit the theme's card margin so this aligns with the stat cards
      // below it, which do the same.
      child: Padding(
        padding: const EdgeInsets.all(ArtizenSpacing.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Bienvenue ! Voici comment démarrer',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: ArtizenColors.textPrimary,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () =>
                      ref.read(onboardingDismissedProvider.notifier).state = true,
                  child: const Text('Masquer'),
                ),
              ],
            ),
            const SizedBox(height: ArtizenSpacing.xs),
            _ProgressBar(done: done, total: steps.length),
            const SizedBox(height: ArtizenSpacing.xs),
            for (final step in steps) _StepTile(step: step),
          ],
        ),
      ),
    );
  }

  List<_OnboardingStep> _buildSteps(BuildContext context, WidgetRef ref) {
    // Root, full-screen routes (company profile, new quote) are pushed so the
    // artisan returns here afterwards; on return the summary is invalidated so
    // a just-completed step flips to done. The catalogue/clients tabs are
    // switched to with `go` (they live in the bottom-nav shell).
    Future<void> pushThenRefresh(String location) async {
      await context.push(location);
      ref.invalidate(dashboardSummaryProvider);
    }

    return [
      _OnboardingStep(
        label: 'Configurer mon entreprise',
        icon: Icons.business_outlined,
        done: summary.companyConfigured,
        onTap: () => pushThenRefresh('/company-profile'),
      ),
      _OnboardingStep(
        label: 'Ajouter un article',
        icon: Icons.inventory_2_outlined,
        done: summary.hasCatalogItem,
        onTap: () => context.go('/catalog'),
      ),
      _OnboardingStep(
        label: 'Ajouter un client',
        icon: Icons.people_outline,
        done: summary.hasClient,
        onTap: () => context.go('/clients'),
      ),
      _OnboardingStep(
        label: 'Créer mon premier devis',
        icon: Icons.description_outlined,
        done: summary.hasQuote,
        onTap: () => pushThenRefresh('/quotes/new'),
      ),
    ];
  }
}

/// One checklist milestone: a label, its icon, whether it's done, and where
/// tapping it leads.
class _OnboardingStep {
  const _OnboardingStep({
    required this.label,
    required this.icon,
    required this.done,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool done;
  final VoidCallback onTap;
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({required this.done, required this.total});

  final int done;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(ArtizenRadii.pill),
            child: LinearProgressIndicator(
              value: total == 0 ? 0 : done / total,
              minHeight: 8,
              backgroundColor: ArtizenColors.infoSurface,
            ),
          ),
        ),
        const SizedBox(width: ArtizenSpacing.sm),
        Text(
          '$done/$total',
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: ArtizenColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

class _StepTile extends StatelessWidget {
  const _StepTile({required this.step});

  final _OnboardingStep step;

  @override
  Widget build(BuildContext context) {
    final label = Text(
      step.label,
      style: TextStyle(
        fontSize: 14,
        fontWeight: step.done ? FontWeight.w400 : FontWeight.w500,
        color: step.done ? ArtizenColors.textSecondary : ArtizenColors.textPrimary,
      ),
    );

    return ListTile(
      contentPadding: EdgeInsets.zero,
      dense: true,
      // Done steps are informational only; pending steps navigate.
      onTap: step.done ? null : step.onTap,
      leading: _StepLeading(step: step),
      title: label,
      trailing: step.done
          ? null
          : const Icon(Icons.chevron_right, color: ArtizenColors.textSecondary),
    );
  }
}

class _StepLeading extends StatelessWidget {
  const _StepLeading({required this.step});

  final _OnboardingStep step;

  @override
  Widget build(BuildContext context) {
    if (step.done) {
      return const Icon(Icons.check_circle, color: ArtizenColors.success, size: 28);
    }
    // A soft night-blue disc carrying the step's own icon — reads as "to do"
    // without competing with the gold accents elsewhere on the dashboard.
    return Container(
      width: 28,
      height: 28,
      decoration: const BoxDecoration(
        color: ArtizenColors.infoSurface,
        shape: BoxShape.circle,
      ),
      child: Icon(step.icon, color: ArtizenColors.nightBlue, size: 16),
    );
  }
}
