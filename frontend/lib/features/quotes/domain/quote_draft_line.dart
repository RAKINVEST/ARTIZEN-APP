import '../../catalog/data/catalog_models.dart';

/// One line being assembled in the "new quote" form, before it's ever sent
/// to the backend: a catalog item and a (mutable, still-being-typed)
/// quantity kept as the raw string the user entered.
///
/// The amount is intentionally *not* stored here — it's derived on the fly
/// by `QuotePreviewCalculator` for display, and authoritatively recomputed
/// by the backend on submit. Keeping only (item, quantity) means a quantity
/// edit can never leave a stale total behind.
class QuoteDraftLine {
  const QuoteDraftLine({required this.item, required this.quantity});

  final CatalogItem item;
  final String quantity;

  QuoteDraftLine copyWith({String? quantity}) {
    return QuoteDraftLine(item: item, quantity: quantity ?? this.quantity);
  }
}
