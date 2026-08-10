/// How an article is counted on a quote — the "unit" made *parlante*.
///
/// The field used to be a free-text box holding whatever the artisan typed:
/// trade shorthand like `ml` or `m³`, a bare `unité`, easy to fumble on a
/// phone and inconsistent from one article to the next. It becomes a short,
/// closed list phrased the way an artisan actually reasons about it —
/// *« Comment se compte cet article ? »*.
///
/// [code] is the compact token stored on the item and printed on the quote
/// line (`3 m² × 12,00 €`); [label] is the friendly wording shown in the
/// picker. The codes stay aligned with the vocabulary the seeded catalogue
/// already uses (`unité`, `heure`, `m²`…), so an existing article lands on a
/// friendly label instead of looking "custom".
class SaleUnit {
  const SaleUnit(this.code, this.label);

  /// Stored on the catalog item and shown next to the quantity on a quote.
  final String code;

  /// The wording shown in the picker.
  final String label;
}

/// The friendly options offered in the article form. Storage stays a plain
/// [String] (the [SaleUnit.code]): no enum, no schema change — the backend
/// keeps accepting any unit it always has.
const List<SaleUnit> kSaleUnits = [
  SaleUnit('unité', 'À la pièce'),
  SaleUnit('heure', "À l'heure"),
  SaleUnit('m', 'Au mètre'),
  SaleUnit('m²', 'Au m²'),
  SaleUnit('forfait', 'Au forfait'),
  SaleUnit('kg', 'Au kilo'),
  SaleUnit('L', 'Au litre'),
];

/// The picker wording for [code], falling back to the raw value so an article
/// saved with a unit outside the list — an older `ml`, a `m³`, a `passage` —
/// still displays and can be re-saved unchanged, never silently rewritten.
String saleUnitLabel(String code) {
  for (final unit in kSaleUnits) {
    if (unit.code == code) return unit.label;
  }
  return code;
}
