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
}
