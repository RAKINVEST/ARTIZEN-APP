import 'package:artizen/core/utils/currency.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CurrencyFormatter.formatQuantity', () {
    test('trims the ".00" a Numeric(10,2) column always carries', () {
      expect(CurrencyFormatter.formatQuantity('1.00'), '1');
      expect(CurrencyFormatter.formatQuantity('2.00'), '2');
      expect(CurrencyFormatter.formatQuantity('10.00'), '10');
    });

    test('keeps a meaningful fractional part, with a French comma', () {
      expect(CurrencyFormatter.formatQuantity('2.50'), '2,5');
      expect(CurrencyFormatter.formatQuantity('0.25'), '0,25');
      expect(CurrencyFormatter.formatQuantity('1.50'), '1,5');
    });

    test('leaves a value with no fractional part untouched', () {
      expect(CurrencyFormatter.formatQuantity('3'), '3');
    });
  });

  group('CurrencyFormatter.format', () {
    test('formats a backend decimal string as euros', () {
      // Non-breaking spaces in fr_FR output — assert on the meaningful bits.
      final formatted = CurrencyFormatter.format('1500.00');
      expect(formatted.contains('500'), isTrue);
      expect(formatted.contains('€'), isTrue);
    });

    test('falls back to the raw string when unparseable', () {
      expect(CurrencyFormatter.format('n/a'), 'n/a');
    });
  });
}
