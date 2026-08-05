import 'package:artizen/features/quote_extraction/data/extracted_quote.dart';
import 'package:flutter_test/flutter_test.dart';

/// Offline: the V2 extraction model must mirror the backend contract and,
/// above all, invent nothing. Amounts are kept verbatim as strings so the
/// reproduction never loses the source's exact figures to float rounding.
void main() {
  group('ExtractedQuote.fromJson', () {
    test('reads a full quote and keeps amounts as printed strings', () {
      final quote = ExtractedQuote.fromJson({
        'document_title': 'DEVIS',
        'number': '2024-0187',
        'dates': {'issued_on': '2024-03-15', 'valid_until': '2024-04-14'},
        'issuer': {'name': 'Menuiserie Bernard', 'siret': '12345678900012'},
        'client': {
          'name': 'Mme Martin',
          'address': {
            'lines': ['3 rue des Lilas', '69100 Villeurbanne'],
          },
        },
        'lines': [
          {'section_header': true, 'designation': 'Menuiserie'},
          {
            'designation': 'Fenêtre PVC',
            'unit': 'u',
            'quantity': 3,
            'unit_price_ht': '240.00',
            'total_ht': '700.00', // printed override, != 3 * 240
          },
        ],
        'totals': {'total_ht': '700.00', 'total_vat': '70.00', 'total_ttc': '770.00'},
        'extraction_confidence': 0.87,
      });

      expect(quote.number, '2024-0187');
      expect(quote.dates.issuedOn, '2024-03-15');
      expect(quote.client.name, 'Mme Martin');
      expect(quote.client.address.lines, ['3 rue des Lilas', '69100 Villeurbanne']);
      expect(quote.lines, hasLength(2));
      expect(quote.lines.first.sectionHeader, isTrue);
      // Verbatim: the printed total is preserved exactly, not recomputed.
      expect(quote.lines[1].totalHt, '700.00');
      expect(quote.totals.totalTtc, '770.00');
      expect(quote.extractionConfidence, 0.87);
    });

    test('an empty payload invents nothing', () {
      final quote = ExtractedQuote.fromJson(const {});
      expect(quote.number, isNull);
      expect(quote.client.name, isNull);
      expect(quote.lines, isEmpty);
      expect(quote.totals.totalTtc, isNull);
      expect(quote.legalMentions, isEmpty);
      expect(quote.extractionConfidence, 0.0);
    });
  });
}
