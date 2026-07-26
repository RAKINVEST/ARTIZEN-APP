import 'package:artizen/features/branding/data/branding_models.dart';
import 'package:artizen/features/branding/data/branding_repository_impl.dart';
import 'package:artizen/features/template_import/data/template_import_models.dart';
import 'package:artizen/features/template_import/data/template_import_repository_impl.dart';
import 'package:artizen/features/template_import/presentation/recognition_sequence.dart';
import 'package:artizen/features/template_import/presentation/template_import_providers.dart';
import 'package:artizen/features/template_import/presentation/template_import_screen.dart';
import 'package:artizen/shared/providers/current_company_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/fake_repositories.dart';

DocumentAnalysisSummary _analysis({String status = 'completed'}) =>
    DocumentAnalysisSummary(id: 'a1', status: status, filename: 'devis.pdf', documentType: 'quote');

TemplateImportPreview _preview(IdentityVerdict verdict) => TemplateImportPreview(
      analysis: _analysis(),
      detection: const DetectionResult(
        logoDetected: true,
        dominantColors: ['#112233'],
        headerDetected: true,
        footerDetected: false,
        tableDetected: false,
        legalNoticeDetected: false,
        confidenceScore: 0.5,
      ),
      currentCompany: const Company(id: 'co1', legalName: 'Menuiserie Dupont'),
      currentBrand: const BrandProfile(id: 'b1'),
      coherence: IdentityCoherence(verdict: verdict),
    );

ProviderContainer _container(IdentityVerdict verdict) => ProviderContainer(
      overrides: [
        currentCompanyIdProvider.overrideWith((ref) async => 'co1'),
        templateImportRepositoryProvider.overrideWithValue(
          FakeTemplateImportRepository(
            uploadResult: _analysis(status: 'uploaded'),
            processResult: _analysis(),
            preview: _preview(verdict),
            validateResult: BrandingProfile(
              company: const Company(id: 'co1'),
              brand: const BrandProfile(id: 'b1'),
              templates: const [],
            ),
          ),
        ),
        brandingRepositoryProvider.overrideWithValue(
          FakeBrandingRepository(BrandingProfile(
            company: const Company(id: 'co1'),
            brand: const BrandProfile(id: 'b1'),
            templates: const [],
          )),
        ),
      ],
    );

void main() {
  testWidgets('import walks from the picker to the recognition story', (tester) async {
    final container = _container(IdentityVerdict.recognized);
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(home: TemplateImportScreen()),
      ),
    );

    // Idle: the artisan is invited to pick a PDF.
    expect(find.text('Choisir un fichier PDF'), findsOneWidget);

    // Drive the pipeline to PreviewReady (the file picker itself is a platform
    // channel, so we exercise the notifier the screen is bound to).
    await container
        .read(templateImportNotifierProvider.notifier)
        .importFile(filename: 'devis.pdf', bytes: [1, 2, 3]);
    await tester.pump();

    // The screen greets the artisan with the recognition story — not the raw
    // technical preview.
    expect(find.byType(RecognitionSequence), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 640));
    expect(find.textContaining('Nous retrouvons votre identité'), findsOneWidget);
  });
}
