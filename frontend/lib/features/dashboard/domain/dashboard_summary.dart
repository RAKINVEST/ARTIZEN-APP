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
    required this.companyHasSiret,
    this.draftCount = 0,
    this.pendingCount = 0,
    this.sentPlusCount = 0,
    this.acceptedCount = 0,
    this.refusedCount = 0,
  });

  final ApproximateCount clientCount;
  final ApproximateCount catalogItemCount;
  final ApproximateCount quoteCount;
  final List<Quote> recentQuotes;

  /// Quotes by life-cycle stage, counted from the same page as [quoteCount].
  /// "Brouillon" = draft (editable, not yet a devis), "En attente" = pending
  /// (validated, awaiting sending), and the "Devis" total = [sentPlusCount] =
  /// sent + accepted + refused (the devis proper — a brouillon or en-attente
  /// never counts here). "Validés" = accepted, "Refusés" = refused. Counted,
  /// never decided here (the status lives on the backend).
  final int draftCount;
  final int pendingCount;
  final int sentPlusCount;
  final int acceptedCount;
  final int refusedCount;

  /// Whether the company already carries a SIRET — the signal the onboarding
  /// checklist uses to mark "Configurer mon entreprise" as done. Read from
  /// `/branding/profile`, never computed here.
  final bool companyHasSiret;

  /// The four onboarding milestones, in order. A step is done once its
  /// underlying data exists; the checklist disappears when all four are done.
  bool get companyConfigured => companyHasSiret;
  bool get hasCatalogItem => catalogItemCount.value > 0;
  bool get hasClient => clientCount.value > 0;
  bool get hasQuote => quoteCount.value > 0;

  /// How many onboarding steps are complete (0–4).
  int get onboardingDoneCount => [
    companyConfigured,
    hasCatalogItem,
    hasClient,
    hasQuote,
  ].where((done) => done).length;

  /// True once every onboarding step is done — the checklist stops showing.
  bool get onboardingComplete => onboardingDoneCount == 4;
}
