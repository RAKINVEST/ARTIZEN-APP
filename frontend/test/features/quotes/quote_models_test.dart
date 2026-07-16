import 'package:artizen/features/quotes/data/quote_models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Quote', () {
    test('fromJson parses nested lines and keeps every amount as a string', () {
      final json = {
        'id': 'q1',
        'company_id': 'co1',
        'client_id': 'cl1',
        'total_ht': '200.00',
        'total_vat': '40.00',
        'total_ttc': '240.00',
        'lines': [
          {
            'id': 'l1',
            'catalog_item_id': 'i1',
            'designation': 'Chauffe-eau Atlantic 200 L',
            'unit': 'unité',
            'quantity': '2',
            'unit_price_ht': '100.00',
            'vat_rate': '20.00',
            'total_ht': '200.00',
            'total_vat': '40.00',
            'total_ttc': '240.00',
          },
        ],
        'created_at': '2026-01-01T10:00:00Z',
        'updated_at': '2026-01-01T10:00:00Z',
      };

      final quote = Quote.fromJson(json);

      expect(quote.lines, hasLength(1));
      expect(quote.totalTtc, '240.00');
      expect(quote.lines.first.designation, 'Chauffe-eau Atlantic 200 L');
      // Every amount stays a String end to end — nothing here is ever
      // parsed to a number for recalculation.
      expect(quote.totalHt, isA<String>());
      expect(quote.lines.first.totalTtc, isA<String>());
    });
  });

  group('QuoteLineInput', () {
    test('toJson carries only catalog_item_id and quantity — no price field exists', () {
      const input = QuoteLineInput(catalogItemId: 'i1', quantity: '3');

      final json = input.toJson();

      expect(json.keys, containsAll(['catalog_item_id', 'quantity']));
      expect(json.keys, hasLength(2));
    });
  });
}
