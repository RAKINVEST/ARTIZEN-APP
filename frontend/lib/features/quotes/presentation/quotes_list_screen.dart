import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/utils/currency.dart';
import '../../../core/widgets/paged_list_view.dart';
import '../data/quote_models.dart';
import 'quotes_providers.dart';
import 'widgets/quote_status_chip.dart';

class QuotesListScreen extends ConsumerWidget {
  const QuotesListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quotes = ref.watch(quotesNotifierProvider);
    final notifier = ref.read(quotesNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Devis'),
        actions: [
          IconButton(
            icon: const Icon(Icons.auto_awesome),
            tooltip: 'Copilote IA',
            onPressed: () => context.push('/quote-assistant'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/quotes/new'),
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          const _StatusFilterBar(),
          Expanded(
            child: PagedListView(
              value: quotes,
              emptyMessage: 'Aucun devis pour le moment.\nCréez votre premier devis avec le bouton +.',
              emptyIcon: Icons.description_outlined,
              onRetry: notifier.refresh,
              onRefresh: notifier.refresh,
              onLoadMore: notifier.loadMore,
              itemBuilder: (context, quote) => Card(
                child: ListTile(
                  onTap: () => context.push('/quotes/${quote.id}'),
                  leading: const CircleAvatar(child: Icon(Icons.description_outlined)),
                  // The number, not the line count: "DEV-2026-0042" is what
                  // the artisan is scanning the list for.
                  title: Text(
                    quote.quoteNumber,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(CurrencyFormatter.format(quote.totalTtc)),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      QuoteStatusChip(status: quote.status, compact: true),
                      const Icon(Icons.chevron_right),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// The statut filter bar: "Tous" plus one chip per [QuoteStatus]. Selecting a
/// chip sets [quotesStatusFilterProvider], which re-runs the paged fetch with
/// `?status=` server-side — no client-side filtering of a truncated page.
class _StatusFilterBar extends ConsumerWidget {
  const _StatusFilterBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(quotesStatusFilterProvider);

    // null entry = "Tous"; the rest follow the enum order.
    final entries = <(QuoteStatus?, String)>[
      (null, 'Tous'),
      for (final status in QuoteStatus.values) (status, status.label),
    ];

    return SizedBox(
      height: 52,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: entries.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final (status, label) = entries[index];
          final isSelected = status == selected;
          return ChoiceChip(
            label: Text(label),
            selected: isSelected,
            showCheckmark: false,
            selectedColor: ArtizenColors.nightBlue,
            labelStyle: TextStyle(
              color: isSelected ? ArtizenColors.onNightBlue : ArtizenColors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
            onSelected: (_) =>
                ref.read(quotesStatusFilterProvider.notifier).state = status,
          );
        },
      ),
    );
  }
}
