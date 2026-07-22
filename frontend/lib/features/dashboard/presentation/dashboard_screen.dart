import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/currency.dart';
import '../../../core/widgets/async_value_view.dart';
import '../../../shared/providers/current_company_provider.dart';
import '../../quotes/presentation/quotes_providers.dart';
import '../../quotes/presentation/widgets/quote_status_chip.dart';
import 'dashboard_providers.dart';
import 'widgets/quick_access_card.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  // A cached failed/aborted currentCompanyIdProvider would otherwise stay
  // stuck forever: invalidating only dashboardSummaryProvider re-runs its
  // body, but that body just re-reads the same poisoned cached Future.
  void _retry(WidgetRef ref) {
    ref.invalidate(currentCompanyIdProvider);
    ref.invalidate(dashboardSummaryProvider);
  }

  /// Open the devis list already filtered to [filter] (and titled to match):
  /// tapping "En attente" lands on the pending devis, "Devis" on all of them.
  /// Pushed over the dashboard (not a tab switch) so its back arrow returns
  /// here directly, rather than walking the sequential section arrows.
  ///
  /// The filter only lives for this drill-down: once the artisan pops back
  /// (`push` completes), it's reset to "Tous" so the Devis *tab* in the bottom
  /// bar always opens on every devis — never stuck on the last card's filter.
  Future<void> _openQuotes(
    BuildContext context,
    WidgetRef ref,
    QuotesFilter filter,
  ) async {
    ref.read(quotesFilterProvider.notifier).state = filter;
    await context.push('/quotes-view');
    if (context.mounted) {
      ref.read(quotesFilterProvider.notifier).state = QuotesFilter.all;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summary = ref.watch(dashboardSummaryProvider);

    return Scaffold(
      // No history arrows here on purpose: the dashboard is the home / starting
      // point, so "back" and "forward" have nothing useful to do. The arrows
      // live on the other sections (Clients, Catalogue, Devis, Paramètres),
      // which is where returning to the dashboard actually matters.
      appBar: AppBar(title: const Text('Tableau de bord')),
      body: AsyncValueView(
        value: summary,
        onRetry: () => _retry(ref),
        builder: (context, data) => RefreshIndicator(
          onRefresh: () async => _retry(ref),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const QuickAccessCard(),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      icon: Icons.people_outline,
                      label: 'Clients',
                      value: data.clientCount.display,
                      onTap: () => context.go('/clients'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _StatCard(
                      icon: Icons.inventory_2_outlined,
                      label: 'Articles catalogue',
                      value: data.catalogItemCount.display,
                      onTap: () => context.go('/catalog'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // The quote life cycle, left to right: Brouillon → En attente →
              // Devis (envoyés & +), then the two outcomes Validés / Refusés.
              // Each tile opens the devis list already filtered to itself.
              // Brouillons and en-attente are *not* counted in "Devis".
              Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      icon: Icons.edit_note_outlined,
                      label: 'Brouillon',
                      value: '${data.draftCount}',
                      onTap: () =>
                          _openQuotes(context, ref, QuotesFilter.brouillon),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _StatCard(
                      icon: Icons.schedule_outlined,
                      label: 'En attente',
                      value: '${data.pendingCount}',
                      onTap: () =>
                          _openQuotes(context, ref, QuotesFilter.pending),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _StatCard(
                      icon: Icons.description_outlined,
                      label: 'Devis',
                      value: '${data.sentPlusCount}',
                      onTap: () => _openQuotes(context, ref, QuotesFilter.all),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _StatCard(
                      icon: Icons.check_circle_outline,
                      label: 'Devis validés',
                      value: '${data.acceptedCount}',
                      onTap: () =>
                          _openQuotes(context, ref, QuotesFilter.accepted),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _StatCard(
                      icon: Icons.cancel_outlined,
                      label: 'Devis refusés',
                      value: '${data.refusedCount}',
                      onTap: () =>
                          _openQuotes(context, ref, QuotesFilter.refused),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                'Derniers devis',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              if (data.recentQuotes.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text('Aucun devis créé pour le moment.'),
                )
              else
                for (final quote in data.recentQuotes)
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.description_outlined),
                      // Same identity as everywhere else: the number and
                      // the status. The line count told the artisan nothing
                      // they were looking for.
                      title: Text(
                        quote.quoteNumber,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(CurrencyFormatter.format(quote.totalTtc)),
                      trailing: QuoteStatusChip(
                        status: quote.status,
                        compact: true,
                      ),
                      onTap: () => context.push('/quotes/${quote.id}'),
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: theme.colorScheme.primary),
              const SizedBox(height: 8),
              Text(value, style: theme.textTheme.headlineSmall),
              Text(label, style: theme.textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}
