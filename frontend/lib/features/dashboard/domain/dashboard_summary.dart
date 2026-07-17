import '../../quotes/data/quote_models.dart';

/// A count the dashboard can honestly display.
///
/// The dashboard counts the length of lists the backend paginates, so past
/// one page the number is not a total — it is the page size. An artisan
/// with 250 clients saw "100", permanently, with nothing to suggest
/// otherwise: a wrong business figure computed on the client, which is
/// precisely what this app's contract forbids.
///
/// Rather than pretend, a capped count renders as "100+". The real fix is
/// a counting endpoint (`GET /clients/count`), which would give the exact
/// total without fetching every row — see docs/AUDIT-V1.md. Until then,
/// "100+" is true and "100" was not.
class ApproximateCount {
  const ApproximateCount({required this.value, required this.capped});

  /// How many rows came back.
  final int value;

  /// Whether the page filled up — i.e. there may be more the client never
  /// saw, making [value] a floor rather than a total.
  final bool capped;

  String get display => capped ? '$value+' : '$value';
}

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

  final ApproximateCount clientCount;
  final ApproximateCount catalogItemCount;
  final ApproximateCount quoteCount;
  final List<Quote> recentQuotes;
}
