import 'package:artizen/features/branding/data/branding_models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BrandingProfile', () {
    test('fromJson parses the aggregate company/brand/templates shape', () {
      final profile = BrandingProfile.fromJson({
        'company': {
          'id': 'co1',
          'name': null,
          'legal_name': 'Plomberie Dupont',
          'siret': '12345678900012',
          'vat_number': null,
          'address_line': null,
          'postal_code': null,
          'city': null,
          'country': 'France',
          'phone': null,
          'email': null,
          'website': null,
        },
        'brand': {
          'id': 'brand1',
          'logo_path': null,
          'primary_color': '#112233',
          'secondary_color': null,
          'font_family': null,
          'tagline': null,
          'signature_path': null,
          'stamp_path': null,
        },
        'templates': [
          {
            'id': 't1',
            'type': 'quote',
            'name': 'devis.pdf',
            'version': 1,
            'is_active': true,
            'created_at': '2026-01-01T10:00:00Z',
            'source_file_path': 'templates/quote/abc.pdf',
          },
        ],
      });

      expect(profile.company.legalName, 'Plomberie Dupont');
      expect(profile.brand.primaryColor, '#112233');
      expect(profile.templates, hasLength(1));
      expect(profile.templates.first.type, TemplateType.quote);
      expect(profile.templates.first.isActive, isTrue);
    });
  });

  group('CompanyUpdateInput', () {
    test('toJson omits unset fields (snake_case, partial update semantics)', () {
      const input = CompanyUpdateInput(legalName: 'Menuiserie Martin', siret: '98765432100019');

      final json = input.toJson();

      expect(json['legal_name'], 'Menuiserie Martin');
      expect(json['siret'], '98765432100019');
      expect(json.containsKey('phone'), isFalse);
      expect(json.containsKey('email'), isFalse);
    });
  });
}
