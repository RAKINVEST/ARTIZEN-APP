import 'package:artizen/features/quote_assistant/data/quote_suggestion_models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('QuoteSuggestion', () {
    test('fromJson parses items, confidence and comment (snake_case)', () {
      final suggestion = QuoteSuggestion.fromJson({
        'items': [
          {
            'catalog_item_id': 'item-1',
            'designation': 'Chauffe-eau Atlantic 200 L',
            'quantity': '1',
            'reason': 'Correspondance directe',
          },
        ],
        'confidence': 0.94,
        'comment': 'Une seule correspondance claire.',
      });

      expect(suggestion.items, hasLength(1));
      expect(suggestion.items.first.catalogItemId, 'item-1');
      // Quantity stays a String: this feature never computes an amount,
      // only proposes which catalog item (and how much of it) matched.
      expect(suggestion.items.first.quantity, isA<String>());
      expect(suggestion.confidence, 0.94);
      expect(suggestion.comment, 'Une seule correspondance claire.');
    });

    test('fromJson handles an empty suggestion (no match found)', () {
      final suggestion = QuoteSuggestion.fromJson({
        'items': <dynamic>[],
        'confidence': 0.0,
        'comment': 'Aucune correspondance.',
      });

      expect(suggestion.items, isEmpty);
      expect(suggestion.confidence, 0.0);
    });
  });
}
