import 'package:intl/intl.dart';

/// Formats amounts the backend already computed. Never used to compute
/// anything — `QuoteCalculator` (backend) is the only place a total is
/// derived; this only reformats the string it returns for display.
class CurrencyFormatter {
  const CurrencyFormatter._();

  static final NumberFormat _format = NumberFormat.currency(
    locale: 'fr_FR',
    symbol: '€',
    decimalDigits: 2,
  );

  /// [backendAmount] is the decimal string the backend returned (e.g.
  /// `"240.00"`). Falls back to the raw string if it isn't parseable,
  /// rather than throwing — a display glitch should never crash a screen.
  static String format(String backendAmount) {
    final value = double.tryParse(backendAmount);
    if (value == null) return backendAmount;
    return _format.format(value);
  }

  /// Trims the trailing zeros a `Numeric(10,2)` column always carries: the
  /// artisan wrote "1", not "1.00". Mirrors the backend PDF renderer's own
  /// quantity formatting so the screen and the document agree. French
  /// decimal comma. Falls back to the raw string when it has no fractional
  /// part or isn't a plain decimal — never throws.
  static String formatQuantity(String backendQuantity) {
    if (!backendQuantity.contains('.')) return backendQuantity;
    final trimmed = backendQuantity
        .replaceAll(RegExp(r'0+$'), '')
        .replaceAll(RegExp(r'\.$'), '');
    return trimmed.replaceAll('.', ',');
  }
}
