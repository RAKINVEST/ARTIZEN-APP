import 'package:artizen/features/template_import/data/template_import_models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DetectionResult', () {
    test('fromJson parses detected fields and ignores unrelated JSON keys', () {
      final detection = DetectionResult.fromJson({
        'id': 'detect1',
        'document_analysis_id': 'analysis1',
        'logo_detected': true,
        'logo_position': 'top_left',
        'dominant_colors': ['#112233', '#ffffff'],
        'header_detected': true,
        'footer_detected': false,
        'table_detected': true,
        'company_name': 'Menuiserie Dupont',
        'address': '12 rue des Artisans, 75011 Paris',
        'phone': '0123456789',
        'email': 'contact@menuiserie-dupont.fr',
        'website': 'www.menuiserie-dupont.fr',
        'siret': '12345678900012',
        'vat_number': 'FR12345678901',
        'legal_notice_detected': true,
        'confidence_score': 0.72,
        // Fields the backend also sends but this partial model ignores.
        'detection_details': {'logo': {}},
        'created_at': '2026-01-01T10:00:00Z',
        'updated_at': '2026-01-01T10:00:00Z',
      });

      expect(detection.logoDetected, isTrue);
      expect(detection.dominantColors, ['#112233', '#ffffff']);
      expect(detection.siret, '12345678900012');
      expect(detection.confidenceScore, 0.72);
    });
  });

  group('TemplateImportValidateInput', () {
    test('toJson omits fields the user did not set', () {
      const input = TemplateImportValidateInput(legalName: 'Menuiserie Dupont', siret: '12345678900012');

      final json = input.toJson();

      expect(json['legal_name'], 'Menuiserie Dupont');
      expect(json.containsKey('phone'), isFalse);
      expect(json.containsKey('primary_color'), isFalse);
    });
  });
}
