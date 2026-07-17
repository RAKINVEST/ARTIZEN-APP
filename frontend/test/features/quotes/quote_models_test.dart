import 'package:artizen/features/quotes/data/quote_models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Quote', () {
    test('fromJson parses nested lines and keeps every amount as a string', () {
      final json = {
        'id': 'q1',
        'company_id': 'co1',
        'client_id': 'cl1',
        'quote_number': 'DEV-2026-0001',
        'status': 'draft',
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

  group('QuoteStatus', () {
    test('parses the backend wire values, not the French labels', () {
      // The enum travels as 'draft'/'sent'/'accepted'/'refused'; only the
      // label is translated.
      for (final entry in {
        'draft': QuoteStatus.draft,
        'sent': QuoteStatus.sent,
        'accepted': QuoteStatus.accepted,
        'refused': QuoteStatus.refused,
      }.entries) {
        final quote = Quote.fromJson(_quoteJson(status: entry.key));
        expect(quote.status, entry.value);
      }
    });

    test('nextStates mirrors the backend transition table', () {
      // The app must never offer a button the server would refuse with a
      // 409. The backend stays the authority; this only decides what to
      // show.
      expect(QuoteStatus.draft.nextStates, [QuoteStatus.sent]);
      expect(QuoteStatus.sent.nextStates, [QuoteStatus.accepted, QuoteStatus.refused]);
      expect(QuoteStatus.accepted.nextStates, isEmpty);
      expect(QuoteStatus.refused.nextStates, isEmpty);
    });

    test('nothing ever goes back to draft', () {
      // A sent quote is a document the customer holds.
      for (final status in QuoteStatus.values) {
        expect(status.nextStates, isNot(contains(QuoteStatus.draft)));
      }
    });

    test('only a draft is editable', () {
      expect(QuoteStatus.draft.isEditable, isTrue);
      for (final status in [QuoteStatus.sent, QuoteStatus.accepted, QuoteStatus.refused]) {
        expect(status.isEditable, isFalse, reason: '${status.name} must be frozen');
      }
    });

    test('every status has a French label', () {
      for (final status in QuoteStatus.values) {
        expect(status.label, isNotEmpty);
        expect(status.label, isNot(status.name));
      }
    });
  });
}

Map<String, dynamic> _quoteJson({String status = 'draft'}) => {
      'id': 'q1',
      'company_id': 'co1',
      'client_id': 'cl1',
      'quote_number': 'DEV-2026-0001',
      'status': status,
      'total_ht': '100.00',
      'total_vat': '20.00',
      'total_ttc': '120.00',
      'lines': <dynamic>[],
      'created_at': '2026-01-01T10:00:00Z',
      'updated_at': '2026-01-01T10:00:00Z',
    };
