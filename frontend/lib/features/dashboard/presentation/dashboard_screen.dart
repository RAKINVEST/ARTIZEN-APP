import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/currency.dart';
import '../../../core/widgets/async_value_view.dart';
import '../../../shared/providers/current_company_provider.dart';
import '../../quotes/presentation/widgets/quote_status_chip.dart';
import 'dashboard_providers.dart';
import 'widgets/onboarding_checklist.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  // A cached failed/aborted currentCompanyIdProvider would otherwise stay
  // stuck forever: invalidating only dashboardSummaryProvider re-runs its
  // body, but that body just re-reads the same poisoned cached Future.
  void _retry(WidgetRef ref) {
    ref.invalidate(currentCompanyIdProvider);
    ref.invalidate(dashboardSummaryProvider);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summary = ref.watch(dashboardSummaryProvider);
    // The manual "Masquer" escape hatch; the checklist also hides itself once
    // every step is done.
    final onboardingDismissed = ref.watch(onboardingDismissedProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Tableau de bord')),
      body: AsyncValueView(
        value: summary,
        onRetry: () => _retry(ref),
        builder: (context, data) => RefreshIndicator(
          onRefresh: () async => _retry(ref),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (!data.onboardingComplete && !onboardingDismissed) ...[
                OnboardingChecklist(summary: data),
                const SizedBox(height: 24),
              ],
              // The guided quote wizard — the main way to create a quote.
              FilledButton.icon(
                onPressed: () => context.push('/assistant'),
                icon: const Icon(Icons.auto_awesome_outlined),
                label: const Text('Nouveau devis guidé'),
                style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(52)),
              ),
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
              _StatCard(
                icon: Icons.description_outlined,
                label: 'Devis',
                value: data.quoteCount.display,
                onTap: () => context.go('/quotes'),
              ),
              const SizedBox(height: 24),
              Text('Derniers devis', style: Theme.of(context).textTheme.titleMedium),
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
                      trailing: QuoteStatusChip(status: quote.status, compact: true),
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
