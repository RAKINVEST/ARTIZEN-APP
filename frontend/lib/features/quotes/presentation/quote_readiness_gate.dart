import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_theme.dart';
import '../data/quote_models.dart';
import '../data/quote_readiness.dart';
import 'quotes_providers.dart';

/// The shared pre-flight control for emitting a quote (download / print /
/// send). Reusable from any screen that can emit a quote: it asks the backend
/// whether the quote is ready and, when it isn't, shows a sheet listing every
/// blocking issue — each one tappable to jump straight to where it's fixed.
///
/// It never decides conformity itself (the backend is the authority); it only
/// reads the verdict and guides the artisan.
class QuoteReadinessGate {
  const QuoteReadinessGate._();

  /// Refreshes the readiness verdict for [quote] and returns `true` when the
  /// caller may proceed with the emit action. When the quote is not ready it
  /// returns `false` after presenting the "Devis non conforme" sheet (and
  /// routing to any issue the artisan taps). A failed check throws, so a
  /// caller wrapping this in its own try/catch fails closed — a quote whose
  /// conformity can't be confirmed is never emitted by accident.
  static Future<bool> ensureReady({
    required BuildContext context,
    required WidgetRef ref,
    required Quote quote,
  }) async {
    // `refresh` (not `read`) so a fix made elsewhere since the badge loaded is
    // picked up, and the badge — watching the same provider — updates too.
    final readiness = await ref.refresh(quoteReadinessProvider(quote.id).future);
    if (readiness.ready) return true;
    if (!context.mounted) return false;

    final selected = await showModalBottomSheet<ReadinessIssue>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) => _NotReadySheet(issues: readiness.issues),
    );
    if (selected != null && context.mounted) {
      _navigateToIssue(context, quote, selected);
    }
    return false;
  }

  /// Routes to where a single issue is fixed, based on its [ReadinessTarget].
  static void _navigateToIssue(BuildContext context, Quote quote, ReadinessIssue issue) {
    switch (issue.target) {
      case ReadinessTarget.companyProfile:
        final field = issue.field;
        final location = (field == null || field.isEmpty)
            ? '/company-profile'
            // Carry the field so "Mon entreprise" can focus/scroll to it.
            : Uri(path: '/company-profile', queryParameters: {'field': field}).toString();
        context.push(location);
      case ReadinessTarget.client:
        context.push('/clients/${quote.clientId}/edit');
      case ReadinessTarget.quote:
        // The quote is usually the very screen the gate was opened from; only
        // navigate when the gate was triggered from elsewhere (e.g. a list).
        final alreadyHere = GoRouterState.of(context).matchedLocation == '/quotes/${quote.id}';
        if (!alreadyHere) context.push('/quotes/${quote.id}');
      case ReadinessTarget.unknown:
        // No known destination — the label already told the artisan what to
        // check. Do nothing rather than navigate somewhere misleading.
        break;
    }
  }
}

/// The "Devis non conforme" sheet: every blocking issue as a tappable row.
class _NotReadySheet extends StatelessWidget {
  const _NotReadySheet({required this.issues});

  final List<ReadinessIssue> issues;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          ArtizenSpacing.sm,
          0,
          ArtizenSpacing.sm,
          ArtizenSpacing.sm,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.error_outline, color: ArtizenColors.error),
                const SizedBox(width: ArtizenSpacing.xs),
                Expanded(
                  child: Text('Devis non conforme', style: theme.textTheme.titleMedium),
                ),
              ],
            ),
            const SizedBox(height: ArtizenSpacing.xs),
            Text(
              'Complétez ces points avant de télécharger, imprimer ou envoyer '
              'ce devis. Touchez un élément pour le corriger.',
              style: theme.textTheme.bodySmall?.copyWith(color: ArtizenColors.textSecondary),
            ),
            const SizedBox(height: ArtizenSpacing.sm),
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: issues.length,
                separatorBuilder: (_, _) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final issue = issues[index];
                  final navigable = issue.target != ReadinessTarget.unknown;
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.circle, size: 12, color: ArtizenColors.error),
                    title: Text(issue.label),
                    trailing: navigable ? const Icon(Icons.chevron_right) : null,
                    // Returning the issue lets the caller navigate with the
                    // page context after the sheet has closed.
                    onTap: navigable ? () => Navigator.of(context).pop(issue) : null,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A compact status pill for the quote detail header: green "Prêt à émettre"
/// once every requirement is met, amber "À compléter" (with the issue count)
/// while something is missing, neutral while checking or if the check itself
/// is unavailable — the latter must never read as a conformity failure.
class QuoteReadinessBadge extends ConsumerWidget {
  const QuoteReadinessBadge({required this.quoteId, super.key});

  final String quoteId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final readiness = ref.watch(quoteReadinessProvider(quoteId));
    return readiness.when(
      loading: () => const _ReadinessPill(
        icon: Icons.hourglass_empty,
        label: 'Vérification…',
        color: ArtizenColors.textSecondary,
      ),
      error: (_, _) => const _ReadinessPill(
        icon: Icons.help_outline,
        label: 'Conformité indisponible',
        color: ArtizenColors.textSecondary,
      ),
      data: (data) => data.ready
          ? const _ReadinessPill(
              icon: Icons.verified_outlined,
              label: 'Prêt à émettre',
              color: ArtizenColors.success,
            )
          : _ReadinessPill(
              icon: Icons.error_outline,
              label: 'À compléter (${data.issues.length})',
              color: ArtizenColors.warning,
            ),
    );
  }
}

class _ReadinessPill extends StatelessWidget {
  const _ReadinessPill({required this.icon, required this.label, required this.color});

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: ArtizenSpacing.xs, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(ArtizenRadii.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
