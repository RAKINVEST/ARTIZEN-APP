import '../../quotes/data/quote_models.dart';

/// Not a backend resource — just a client-side bundle of numbers already
/// fetched via the clients/catalog/quotes repositories (see
/// `dashboard_providers.dart`). No new HTTP call, no duplicated fetching
/// logic: it only counts lists those features already load.
class DashboardSummary {
  const DashboardSummary({
    required this.clientCount,
    required this.catalogItemCount,
    required this.quoteCount,
    required this.recentQuotes,
  });

  final int clientCount;
  final int catalogItemCount;
  final int quoteCount;
  final List<Quote> recentQuotes;
}
