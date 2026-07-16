import 'package:artizen/features/branding/data/branding_models.dart';
import 'package:artizen/features/branding/data/branding_repository_impl.dart';
import 'package:artizen/features/template_import/data/template_import_models.dart';
import 'package:artizen/features/template_import/data/template_import_repository_impl.dart';
import 'package:artizen/features/template_import/presentation/template_import_providers.dart';
import 'package:artizen/shared/providers/current_company_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/fake_repositories.dart';

Company _company() => const Company(id: 'co1', legalName: 'Ancien Nom');

BrandProfile _brand() => const BrandProfile(id: 'brand1');

DocumentAnalysisSummary _analysis({String status = 'uploaded'}) => DocumentAnalysisSummary(
      id: 'analysis1',
      status: status,
      filename: 'devis.pdf',
      documentType: 'quote',
    );

DetectionResult _detection() => const DetectionResult(
      logoDetected: true,
      dominantColors: ['#112233'],
      headerDetected: true,
      footerDetected: false,
      tableDetected: false,
      companyName: 'Menuiserie Dupont',
      legalNoticeDetected: false,
      confidenceScore: 0.5,
    );

TemplateImportPreview _preview() => TemplateImportPreview(
      analysis: _analysis(status: 'completed'),
      detection: _detection(),
      currentCompany: _company(),
      currentBrand: _brand(),
    );

BrandingProfile _brandingProfile() =>
    BrandingProfile(company: _company(), brand: _brand(), templates: const []);

ProviderContainer _container() => ProviderContainer(
      overrides: [
        currentCompanyIdProvider.overrideWith((ref) async => 'co1'),
        templateImportRepositoryProvider.overrideWithValue(
          FakeTemplateImportRepository(
            uploadResult: _analysis(),
            processResult: _analysis(status: 'completed'),
            preview: _preview(),
            validateResult: _brandingProfile(),
          ),
        ),
        brandingRepositoryProvider.overrideWithValue(FakeBrandingRepository(_brandingProfile())),
      ],
    );

void main() {
  test('importFile walks upload -> process -> preview and reaches PreviewReady', () async {
    final container = _container();
    addTearDown(container.dispose);

    await container.read(templateImportNotifierProvider.notifier).importFile(
          filename: 'devis.pdf',
          bytes: [1, 2, 3],
        );

    final state = container.read(templateImportNotifierProvider);
    expect(state, isA<TemplateImportPreviewReady>());
    expect(
      (state as TemplateImportPreviewReady).preview.detection.companyName,
      'Menuiserie Dupont',
    );
  });

  test('validate reaches Done after a successful preview', () async {
    final container = _container();
    addTearDown(container.dispose);

    await container.read(templateImportNotifierProvider.notifier).importFile(
          filename: 'devis.pdf',
          bytes: [1, 2, 3],
        );
    await container.read(templateImportNotifierProvider.notifier).validate(
          const TemplateImportValidateInput(legalName: 'Menuiserie Dupont'),
        );

    expect(container.read(templateImportNotifierProvider), isA<TemplateImportDone>());
  });

  test('reset returns to Idle from any state', () async {
    final container = _container();
    addTearDown(container.dispose);

    await container.read(templateImportNotifierProvider.notifier).importFile(
          filename: 'devis.pdf',
          bytes: [1, 2, 3],
        );
    container.read(templateImportNotifierProvider.notifier).reset();

    expect(container.read(templateImportNotifierProvider), isA<TemplateImportIdle>());
  });
}
