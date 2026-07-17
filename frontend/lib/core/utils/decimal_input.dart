/// Normalizes and validates the decimal numbers an artisan types (prices,
/// VAT rates, quantities) before they are sent to the backend.
///
/// A French keyboard produces a comma, and the backend's `Decimal` fields
/// only accept a dot: sending `"45,50"` raw earns a 422 that surfaces as an
/// unexplained "Échec de l'enregistrement". Normalizing at *validation*
/// time only — as the catalog form used to — is worse than not normalizing
/// at all: the field turns green and the request still fails.
///
/// So every screen that collects a decimal must run the text through
/// [normalize] on the way out, and [validate] on the way in. This lives in
/// `core/` rather than in one screen because the catalog form, the quote
/// form and the AI copilot all take the same input.
class DecimalInput {
  const DecimalInput._();

  /// Turns what the artisan typed into what the backend parses:
  /// `"45,50"` -> `"45.50"`. Leaves an already-dotted value untouched.
  static String normalize(String value) => value.trim().replaceAll(',', '.');

  /// [min] is exclusive when [exclusiveMin] is true — quantities must be
  /// strictly positive, whereas a price of 0 is legitimate.
  ///
  /// [maxDecimals] mirrors the backend's `decimal_places` constraint. The
  /// column behind these fields is `Numeric(_, 2)`: refusing a third
  /// decimal here turns a submit-time 422 on the whole quote into an
  /// inline message on the offending field.
  static String? validate(
    String? value, {
    double min = 0,
    bool exclusiveMin = false,
    int maxDecimals = 2,
  }) {
    final text = normalize(value ?? '');
    if (text.isEmpty) return 'Requis';

    final parsed = double.tryParse(text);
    if (parsed == null) return 'Nombre invalide';
    if (exclusiveMin && parsed <= min) return 'Doit être supérieur à $min';
    if (!exclusiveMin && parsed < min) return 'Nombre invalide';

    final separator = text.indexOf('.');
    if (separator != -1 && text.length - separator - 1 > maxDecimals) {
      return 'Maximum $maxDecimals décimales';
    }
    return null;
  }
}
