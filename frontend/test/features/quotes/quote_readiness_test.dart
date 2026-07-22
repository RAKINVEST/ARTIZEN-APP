import 'package:artizen/features/quotes/data/quote_readiness.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('QuoteReadiness.fromJson', () {
    test('parses a ready verdict with no issues', () {
      final readiness = QuoteReadiness.fromJson({
        'ready': true,
        'issues': <dynamic>[],
      });

      expect(readiness.ready, isTrue);
      expect(readiness.issues, isEmpty);
    });

    test('parses each issue with its target and (optional) field', () {
      final readiness = QuoteReadiness.fromJson({
        'ready': false,
        'issues': [
          {
            'code': 'missing_siret',
            'label': 'SIRET manquant',
            'target': 'company_profile',
            'field': 'siret',
          },
          {
            'code': 'missing_client_address',
            'label': 'Adresse du client manquante',
            'target': 'client',
            'field': null,
          },
        ],
      });

      expect(readiness.ready, isFalse);
      expect(readiness.issues, hasLength(2));
      expect(readiness.issues.first.target, ReadinessTarget.companyProfile);
      expect(readiness.issues.first.field, 'siret');
      expect(readiness.issues[1].target, ReadinessTarget.client);
      expect(readiness.issues[1].field, isNull);
    });

    test('an unrecognised target degrades to ReadinessTarget.unknown', () {
      final readiness = QuoteReadiness.fromJson({
        'ready': false,
        'issues': [
          {'code': 'x', 'label': 'y', 'target': 'some_future_target'},
        ],
      });

      // A new backend target must not throw an old client — it stays visible
      // but simply isn't navigable.
      expect(readiness.issues.single.target, ReadinessTarget.unknown);
    });
  });
}
