import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/providers/current_company_provider.dart';
import '../../catalog/data/catalog_repository_impl.dart';
import '../../clients/data/clients_repository_impl.dart';
import '../../quotes/data/quotes_repository_impl.dart';
import '../domain/dashboard_summary.dart';

/// The page size `GET /clients`, `GET /catalog/items` and `GET /quotes`
/// each apply when no `limit` is given — which is always, since no Dart
/// caller passes one.
///
/// Mirrored here (rather than read from anywhere) purely so a full page
/// can be recognised as "possibly more" and shown as "100+" instead of a
/// flat, wrong "100". It is a display honesty guard, never a business
/// rule: nothing here decides anything from this number. If the backend
/// default ever changes, the worst case is that "+" appears one page too
/// early or too late — not a wrong total.
const _backendPageSize = 100;

/// Composes counts from the three feature repositories directly (not
/// through their Riverpod notifiers) — same methods those features already
/// call, no new endpoint, no duplicated fetching logic.
///
/// The three calls are started before any of them is awaited, so they run
/// concurrently even though their result types differ (which rules out
/// `Future.wait`, which needs a single homogeneous type).
final dashboardSummaryProvider = FutureProvider<DashboardSummary>((ref) async {
  final companyId = await ref.watch(currentCompanyIdProvider.future);

  final clientsFuture = ref.watch(clientsRepositoryProvider).list(companyId: companyId);
  final itemsFuture = ref
      .watch(catalogRepositoryProvider)
      .listItems(companyId: companyId, activeOnly: true);
  final quotesFuture = ref.watch(quotesRepositoryProvider).list(companyId: companyId);

  final clients = await clientsFuture;
  final items = await itemsFuture;
  final quotes = await quotesFuture;

  final recentQuotes = [...quotes]..sort((a, b) => b.createdAt.compareTo(a.createdAt));

  return DashboardSummary(
    clientCount: _countOf(clients),
    catalogItemCount: _countOf(items),
    quoteCount: _countOf(quotes),
    recentQuotes: recentQuotes.take(5).toList(),
  );
});

/// A full page means the backend had at least this many rows and possibly
/// more, so the number is a floor — not a total.
ApproximateCount _countOf(List<Object?> page) =>
    ApproximateCount(value: page.length, capped: page.length >= _backendPageSize);
