/// How an article is counted on a quote.
///
/// The previous field was a free-text "Unité" holding trade jargon like
/// `ml` (mètre linéaire) — meaningless to most artisans and impossible to
/// get right on a phone. It's replaced by a short, closed list phrased as a
/// question the artisan can actually answer: *"Comment se compte cet
/// article ?"*.
///
/// [code] is what gets stored and printed on the quote line
/// (`3 m × 12,00 €`); [label] is what the artisan picks from the menu.
class SaleUnit {
  const SaleUnit(this.code, this.label);

  /// Stored on the catalog item and shown next to the quantity.
  final String code;

  /// The wording shown in the picker.
  final String label;
}

/// The options offered everywhere an article's unit is chosen.
const List<SaleUnit> kSaleUnits = [
  SaleUnit('pièce', 'À la pièce'),
  SaleUnit('h', "À l'heure"),
  SaleUnit('jour', 'À la journée'),
  SaleUnit('m', 'Au mètre'),
  SaleUnit('m²', 'Au mètre carré'),
  SaleUnit('forfait', 'Au forfait'),
  SaleUnit('kg', 'Au kilo'),
  SaleUnit('L', 'Au litre'),
];

/// The wording for [code], falling back to the raw value so an article
/// saved with a custom unit (or an older one such as `ml`) still displays
/// and can be re-saved unchanged.
String saleUnitLabel(String code) {
  for (final unit in kSaleUnits) {
    if (unit.code == code) return unit.label;
  }
  return code;
}
