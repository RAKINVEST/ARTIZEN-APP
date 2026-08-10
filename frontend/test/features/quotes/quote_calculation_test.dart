import 'package:artizen/features/quotes/data/quote_calculation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('QuoteCalculation.vatBreakdown', () {
    test('parses the per-rate VAT ventilation from the calculate response', () {
      final calc = QuoteCalculation.fromJson({
        'total_ht': '200.00',
        'total_vat': '30.00',
        'total_ttc': '230.00',
        'net_total_ht': '200.00',
        'net_total_vat': '30.00',
        'net_total_ttc': '230.00',
        'balance_due': '230.00',
        'lines': <Map<String, dynamic>>[],
        'vat_breakdown': [
          {'rate': '10.00', 'base_ht': '100.00', 'vat_amount': '10.00'},
          {'rate': '20.00', 'base_ht': '100.00', 'vat_amount': '20.00'},
        ],
      });

      expect(calc.vatBreakdown, hasLength(2));
      expect(calc.vatBreakdown[0].rate, '10.00');
      expect(calc.vatBreakdown[0].baseHt, '100.00');
      expect(calc.vatBreakdown[0].vatAmount, '10.00');
      expect(calc.vatBreakdown[1].rate, '20.00');
      expect(calc.vatBreakdown[1].vatAmount, '20.00');
    });

    test('defaults to an empty list when the field is absent (older responses)', () {
      final calc = QuoteCalculation.fromJson({
        'total_ht': '0.00',
        'total_vat': '0.00',
        'total_ttc': '0.00',
        'lines': <Map<String, dynamic>>[],
      });

      expect(calc.vatBreakdown, isEmpty);
    });
  });
}
