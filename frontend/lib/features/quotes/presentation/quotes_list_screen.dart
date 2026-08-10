import 'package:flutter/material.dart';
import '../../../core/navigation/section_nav_arrows.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/utils/currency.dart';
import '../../../core/widgets/app_surfaces.dart';
import '../../../core/widgets/paged_list_view.dart';
import '../data/quote_models.dart';
import 'quotes_providers.dart';
import 'widgets/quote_status_chip.dart';

/// The pastel accent that matches a quote's status — keeps the list row's icon
/// chip in step with its status pill.
ArtizenAccent accentForStatus(QuoteStatus status) => switch (status) {
  QuoteStatus.draft => ArtizenAccents.slate,
  QuoteStatus.pending => ArtizenAccents.amber,
  QuoteStatus.sent => ArtizenAccents.blue,
  QuoteStatus.accepted => ArtizenAccents.green,
  QuoteStatus.refused => ArtizenAccents.red,
};

/// The colour a filter chip carries — each view keeps the same accent as its
/// dashboard card and its status pill, so "En attente" is amber everywhere,
/// "Validés" green, "Refusés" red, and so on.
ArtizenAccent accentForFilter(QuotesFilter filter) => switch (filter) {
  QuotesFilter.all => ArtizenAccents.violet,
  QuotesFilter.brouillon => ArtizenAccents.slate,
  QuotesFilter.pending => ArtizenAccents.amber,
  QuotesFilter.accepted => ArtizenAccents.green,
  QuotesFilter.refused => ArtizenAccents.red,
};

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
      backgroundColor: Colors.transparent,
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
      floatingActionButton: GradientFab(
        // "Nouveau devis" opens the guided wizard — the single quote-creation
        // path. (The old QuoteFormScreen / `/quotes/new` was removed in V1.1;
        // the copilote IA now feeds the wizard's draft instead.)
        onPressed: () => context.push('/assistant'),
        tooltip: 'Nouveau devis',
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
              itemBuilder: (context, quote) => Padding(
                padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
                child: AppCard(
                  onTap: () => context.push('/quotes/${quote.id}'),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  child: Row(
                    children: [
                      AccentIconChip(
                        icon: Icons.description_outlined,
                        accent: accentForStatus(quote.status),
                        size: 46,
                      ),
                      const SizedBox(width: ArtizenSpacing.sm),
                      // The number, not the line count: "DEV-2026-0042" is what
                      // the artisan is scanning the list for.
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              quote.quoteNumber,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                                color: ArtizenColors.textPrimary,
                              ),
                            ),
                            Text(
                              // The net TTC (== gross when there is no discount).
                              CurrencyFormatter.format(quote.netTotalTtc),
                              style: const TextStyle(
                                color: ArtizenColors.textSecondary,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: ArtizenSpacing.xs),
                      QuoteStatusChip(status: quote.status, compact: true),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.chevron_right,
                        color: ArtizenColors.textSecondary,
                        size: 20,
                      ),
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
          final accent = accentForFilter(filter);
          return ChoiceChip(
            label: Text(filter.chipLabel),
            selected: isSelected,
            showCheckmark: false,
            selectedColor: accent.fg,
            backgroundColor: Colors.white,
            side: BorderSide(
              color: isSelected ? accent.fg : ArtizenColors.border,
            ),
            labelStyle: TextStyle(
              // Selected → filled with its colour, white label. Unselected →
              // white chip whose label already carries the status colour, so
              // the four views read at a glance even before you pick one.
              color: isSelected ? Colors.white : accent.fg,
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
