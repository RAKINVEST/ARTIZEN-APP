import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/utils/currency.dart';
import '../../../core/widgets/app_surfaces.dart';
import '../../../core/widgets/async_value_view.dart';
import '../../../shared/providers/current_company_provider.dart';
import '../../branding/presentation/branding_providers.dart';
import '../../quotes/data/quote_models.dart';
import '../../quotes/presentation/quotes_providers.dart';
import '../../quotes/presentation/widgets/quote_status_chip.dart';
import 'dashboard_providers.dart';
import 'widgets/primary_actions_card.dart';
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
    // The artisan's own name — the welcome greets them personally. Read from
    // the already-loaded branding profile (the sidebar uses the same notifier),
    // so it's null only briefly on cold start (the banner falls back gracefully).
    final companyName =
        ref.watch(brandingProfileNotifierProvider).valueOrNull?.company.name;

    return Scaffold(
      backgroundColor: Colors.transparent,
      // No history arrows here on purpose: the dashboard is the home / starting
      // point. The gear jumps straight to the settings tab.
      appBar: AppBar(
        title: const Text('Tableau de bord'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: ArtizenSpacing.sm),
            child: _CircleIconButton(
              icon: Icons.settings_outlined,
              tooltip: 'Paramètres',
              onPressed: () => context.go('/settings'),
            ),
          ),
        ],
      ),
      body: AsyncValueView(
        value: summary,
        onRetry: () => _retry(ref),
        builder: (context, data) => RefreshIndicator(
          onRefresh: () async => _retry(ref),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            children: [
              // A warm, branded welcome — the dashboard must tell the same story
              // as the sign-in: your devis carry your identity, ready in minutes.
              _WelcomeBanner(companyName: companyName),
              const SizedBox(height: ArtizenSpacing.md),
              // Headline actions — "reproduire mon devis" is the core promise and
              // must be reachable without Settings.
              const PrimaryActionsCard(),
              const SizedBox(height: ArtizenSpacing.md),
              const QuickAccessCard(),
              const SizedBox(height: ArtizenSpacing.md),
              // Two headline resource cards.
              Row(
                children: [
                  Expanded(
                    child: StatCard(
                      large: true,
                      icon: Icons.people_outline,
                      label: 'Clients',
                      value: data.clientCount.display,
                      accent: ArtizenAccents.blue,
                      onTap: () => context.go('/clients'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: StatCard(
                      large: true,
                      icon: Icons.inventory_2_outlined,
                      label: 'Articles catalogue',
                      value: data.catalogItemCount.display,
                      accent: ArtizenAccents.violet,
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
              _ResponsiveCardGrid(
                cards: [
                  StatCard(
                    icon: Icons.edit_note_outlined,
                    label: 'Brouillon',
                    value: '${data.draftCount}',
                    accent: ArtizenAccents.slate,
                    onTap: () => _openQuotes(context, ref, QuotesFilter.brouillon),
                  ),
                  StatCard(
                    icon: Icons.schedule_outlined,
                    label: 'En attente',
                    value: '${data.pendingCount}',
                    accent: ArtizenAccents.amber,
                    onTap: () => _openQuotes(context, ref, QuotesFilter.pending),
                  ),
                  StatCard(
                    icon: Icons.description_outlined,
                    label: 'Devis',
                    value: '${data.sentPlusCount}',
                    accent: ArtizenAccents.blue,
                    onTap: () => _openQuotes(context, ref, QuotesFilter.all),
                  ),
                  StatCard(
                    icon: Icons.check_circle_outline,
                    label: 'Devis validés',
                    value: '${data.acceptedCount}',
                    accent: ArtizenAccents.green,
                    onTap: () => _openQuotes(context, ref, QuotesFilter.accepted),
                  ),
                  StatCard(
                    icon: Icons.cancel_outlined,
                    label: 'Devis refusés',
                    value: '${data.refusedCount}',
                    accent: ArtizenAccents.red,
                    onTap: () => _openQuotes(context, ref, QuotesFilter.refused),
                  ),
                ],
              ),
              const SizedBox(height: ArtizenSpacing.md),
              _RecentQuotesCard(
                quotes: data.recentQuotes,
                onOpen: (id) => context.push('/quotes/$id'),
                onSeeAll: () => context.go('/quotes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// The branded welcome — greets the artisan by name and states the promise
/// (identity + speed) in one glance, so the dashboard passes the "5-second test"
/// just like the sign-in. A violet gradient echoes the premium identity while
/// staying within the app's light surface.
class _WelcomeBanner extends StatelessWidget {
  const _WelcomeBanner({this.companyName});

  final String? companyName;

  @override
  Widget build(BuildContext context) {
    final name = (companyName != null && companyName!.trim().isNotEmpty)
        ? companyName!.trim()
        : 'Votre atelier';
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: ArtizenGradients.button,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(ArtizenRadii.card),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF603AF6).withValues(alpha: 0.30),
            blurRadius: 24,
            spreadRadius: -6,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'BIENVENUE DANS VOTRE ATELIER',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.75),
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Vos devis portent votre identité — à votre image, '
                  'prêts en quelques minutes.',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.92),
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 14),
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.fingerprint, color: Colors.white, size: 30),
          ),
        ],
      ),
    );
  }
}

/// Lays a set of stat cards out in a row that reflows: 5 across on a wide
/// screen, 3 on a tablet, 2 on a phone.
class _ResponsiveCardGrid extends StatelessWidget {
  const _ResponsiveCardGrid({required this.cards});

  final List<Widget> cards;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final columns = w >= 760 ? 5 : (w >= 500 ? 3 : 2);
        const spacing = 12.0;
        final itemWidth = (w - spacing * (columns - 1)) / columns;
        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: [
            for (final card in cards)
              SizedBox(width: itemWidth, child: card),
          ],
        );
      },
    );
  }
}

class _RecentQuotesCard extends StatelessWidget {
  const _RecentQuotesCard({
    required this.quotes,
    required this.onOpen,
    required this.onSeeAll,
  });

  final List<Quote> quotes;
  final ValueChanged<String> onOpen;
  final VoidCallback onSeeAll;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.symmetric(vertical: ArtizenSpacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(
              ArtizenSpacing.sm,
              0,
              ArtizenSpacing.sm,
              ArtizenSpacing.xs,
            ),
            child: Text(
              'Derniers devis',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: ArtizenColors.textPrimary,
              ),
            ),
          ),
          if (quotes.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ArtizenSpacing.sm,
                vertical: ArtizenSpacing.sm,
              ),
              child: Text(
                'Aucun devis créé pour le moment.',
                style: TextStyle(color: ArtizenColors.textSecondary),
              ),
            )
          else
            for (var i = 0; i < quotes.length; i++) ...[
              if (i > 0)
                const Divider(height: 1, indent: 16, endIndent: 16),
              _RecentQuoteTile(quote: quotes[i], onTap: () => onOpen(quotes[i].id)),
            ],
          const Divider(height: 1),
          Center(
            child: TextButton.icon(
              onPressed: onSeeAll,
              icon: const Text('Voir tous les devis'),
              label: const Icon(Icons.keyboard_arrow_down, size: 18),
            ),
          ),
        ],
      ),
    );
  }
}

class _RecentQuoteTile extends StatelessWidget {
  const _RecentQuoteTile({required this.quote, required this.onTap});

  final Quote quote;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: ArtizenSpacing.sm,
            vertical: 10,
          ),
          child: Row(
            children: [
              const AccentIconChip(
                icon: Icons.description_outlined,
                accent: ArtizenAccents.slate,
                size: 42,
              ),
              const SizedBox(width: ArtizenSpacing.sm),
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
                      CurrencyFormatter.format(quote.totalTtc),
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
    );
  }
}

/// A white circular icon button — the app-bar affordance in the "web" identity
/// (settings gear, back arrow). Kept here until a second screen needs it, then
/// it graduates to `core/widgets`.
class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({
    required this.icon,
    required this.onPressed,
    this.tooltip,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      elevation: 1,
      shadowColor: ArtizenColors.nightBlue.withValues(alpha: 0.12),
      child: IconButton(
        icon: Icon(icon, color: ArtizenColors.textPrimary, size: 22),
        tooltip: tooltip,
        onPressed: onPressed,
      ),
    );
  }
}
