import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/providers/current_company_provider.dart';
import '../../catalog/data/catalog_repository_impl.dart';
import '../../clients/data/clients_repository_impl.dart';
import '../../quotes/data/quotes_repository_impl.dart';
import '../domain/dashboard_summary.dart';

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
    clientCount: clients.length,
    catalogItemCount: items.length,
    quoteCount: quotes.length,
    recentQuotes: recentQuotes.take(5).toList(),
  );
});
