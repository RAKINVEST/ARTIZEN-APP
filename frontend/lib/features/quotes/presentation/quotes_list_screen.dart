import 'package:flutter/material.dart';
import '../../../core/navigation/section_nav_arrows.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/utils/currency.dart';
import '../../../core/widgets/paged_list_view.dart';
import 'quotes_providers.dart';
import 'widgets/quote_status_chip.dart';

class QuotesListScreen extends ConsumerWidget {
  const QuotesListScreen({this.asPushedView = false, super.key});

  /// True when opened *over* another screen (a dashboard card drilling into
  /// its filtered devis), so the AppBar shows a plain back arrow that returns
  /// there. False for the bottom-bar tab, which instead carries the sequential
  /// section arrows (← Catalogue, → Paramètres).
  final bool asPushedView;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quotes = ref.watch(quotesNotifierProvider);
    final notifier = ref.read(quotesNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        // Pushed from a dashboard card → the default back arrow (pops straight
        // back to the dashboard). As the tab → the section arrows.
        leading: asPushedView
            ? null
            : const SectionNavArrows(current: '/quotes'),
        leadingWidth: asPushedView ? null : 96,
        // Follows the active view: "Devis", "Devis en attente", "Devis
        // validés" or "Devis refusés" — so a dashboard card that filters the
        // list also names it.
        title: Text(ref.watch(quotesFilterProvider).title),
        actions: [
          IconButton(
            icon: const Icon(Icons.auto_awesome),
            tooltip: 'Copilote IA',
            onPressed: () => context.push('/quote-assistant'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        // "Nouveau devis" now opens the guided wizard (V1). The old
        // QuoteFormScreen (/quotes/new) is deprecated — no visible link points
        // to it anymore.
        onPressed: () => context.push('/assistant'),
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          const _StatusFilterBar(),
          Expanded(
            child: PagedListView(
              value: quotes,
              emptyMessage:
                  'Aucun devis pour le moment.\nCréez votre premier devis avec le bouton +.',
              emptyIcon: Icons.description_outlined,
              onRetry: notifier.refresh,
              onRefresh: notifier.refresh,
              onLoadMore: notifier.loadMore,
              itemBuilder: (context, quote) => Card(
                child: ListTile(
                  onTap: () => context.push('/quotes/${quote.id}'),
                  leading: const CircleAvatar(
                    child: Icon(Icons.description_outlined),
                  ),
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

/// The view filter bar: one chip per [QuotesFilter] (Tous / En attente /
/// Validés / Refusés). Selecting a chip sets [quotesFilterProvider], which
/// re-runs the paged fetch with `?status=` server-side (En attente sends two)
/// — no client-side filtering of a truncated page.
class _StatusFilterBar extends ConsumerWidget {
  const _StatusFilterBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(quotesFilterProvider);

    return SizedBox(
      height: 52,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: QuotesFilter.values.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final filter = QuotesFilter.values[index];
          final isSelected = filter == selected;
          return ChoiceChip(
            label: Text(filter.chipLabel),
            selected: isSelected,
            showCheckmark: false,
            selectedColor: ArtizenColors.nightBlue,
            labelStyle: TextStyle(
              color: isSelected
                  ? ArtizenColors.onNightBlue
                  : ArtizenColors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
            onSelected: (_) =>
                ref.read(quotesFilterProvider.notifier).state = filter,
          );
        },
      ),
    );
  }
}
