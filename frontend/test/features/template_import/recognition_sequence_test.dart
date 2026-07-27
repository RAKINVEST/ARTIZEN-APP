import 'package:artizen/features/branding/data/branding_models.dart';
import 'package:artizen/features/template_import/data/template_import_models.dart';
import 'package:artizen/features/template_import/presentation/recognition_sequence.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

TemplateImportPreview _preview(IdentityVerdict verdict) => TemplateImportPreview(
      analysis: const DocumentAnalysisSummary(
        id: 'a',
        status: 'completed',
        filename: 'devis.pdf',
        documentType: 'quote',
      ),
      detection: const DetectionResult(
        logoDetected: true,
        dominantColors: ['#112233'],
        headerDetected: true,
        footerDetected: false,
        tableDetected: false,
        legalNoticeDetected: false,
        confidenceScore: 0.5,
      ),
      currentCompany: const Company(id: 'c', legalName: 'X'),
      currentBrand: const BrandProfile(id: 'b'),
      coherence: IdentityCoherence(verdict: verdict),
    );

/// Plays the whole timeline. The identity orb pulses on a repeating controller,
/// so `pumpAndSettle` would never return — advance the clock with fixed pumps.
Future<void> _play(WidgetTester tester, IdentityVerdict verdict, VoidCallback onContinue) async {
  await tester.pumpWidget(
    MaterialApp(home: RecognitionSequence(preview: _preview(verdict), onContinue: onContinue)),
  );
  for (var i = 0; i < 10; i++) {
    await tester.pump(const Duration(milliseconds: 640));
  }
  await tester.pump(const Duration(milliseconds: 500));
}

void main() {
  testWidgets('recognized: welcomes the artisan and continues to the devis', (tester) async {
    var continued = false;
    await _play(tester, IdentityVerdict.recognized, () => continued = true);

    expect(find.textContaining('reconnu votre entreprise'), findsOneWidget);
    expect(find.textContaining('conserveront cette identité'), findsOneWidget);

    await tester.tap(find.text('Voir mon devis'));
    await tester.pump();
    expect(continued, isTrue);
  });

  testWidgets('unverified: identity found, soft continuation', (tester) async {
    await _play(tester, IdentityVerdict.unverified, () {});
    expect(find.textContaining('identité documentaire a été retrouvée'), findsOneWidget);
    expect(find.text('Voir mon devis'), findsOneWidget);
  });

  testWidgets('reduce motion: the recognition is shown at once, no timed reveal', (tester) async {
    var continued = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) => MediaQuery(
            data: MediaQuery.of(context).copyWith(disableAnimations: true),
            child: RecognitionSequence(
              preview: _preview(IdentityVerdict.recognized),
              onContinue: () => continued = true,
            ),
          ),
        ),
      ),
    );

    // No pumping of the timeline: the verdict and its action are there at once…
    expect(find.textContaining('reconnu votre entreprise'), findsOneWidget);
    expect(find.text('Voir mon devis'), findsOneWidget);

    // …and with no repeating pulse the tree settles — it would hang otherwise.
    await tester.pumpAndSettle();

    await tester.tap(find.text('Voir mon devis'));
    await tester.pump();
    expect(continued, isTrue);
  });

  testWidgets('mismatch: reassuring, never accusatory, gated by the declaration', (tester) async {
    var continued = false;
    await _play(tester, IdentityVerdict.mismatch, () => continued = true);

    expect(find.textContaining('semble appartenir à une autre entreprise'), findsOneWidget);
    // Brand promise: never the words of a control.
    for (final banned in ['fraude', 'contrôle', 'blocage', 'vérification']) {
      expect(find.textContaining(banned), findsNothing, reason: '"$banned" must never appear');
    }

    // Continuer stays inert until the artisan certifies their right.
    await tester.tap(find.text('Continuer'));
    await tester.pump();
    expect(continued, isFalse);

    await tester.tap(find.byType(Checkbox));
    await tester.pump();
    await tester.tap(find.text('Continuer'));
    await tester.pump();
    expect(continued, isTrue);
  });
}
