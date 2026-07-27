import 'package:artizen/features/branding/data/branding_models.dart';
import 'package:artizen/features/template_import/data/template_import_models.dart';
import 'package:artizen/features/template_import/presentation/recognition_sequence.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

const _defaultDetection = DetectionResult(
  logoDetected: true,
  dominantColors: ['#112233'],
  headerDetected: true,
  footerDetected: false,
  tableDetected: false,
  legalNoticeDetected: false,
  confidenceScore: 0.5,
);

TemplateImportPreview _preview(IdentityVerdict verdict, {DetectionResult? detection}) =>
    TemplateImportPreview(
      analysis: const DocumentAnalysisSummary(
        id: 'a',
        status: 'completed',
        filename: 'devis.pdf',
        documentType: 'quote',
      ),
      detection: detection ?? _defaultDetection,
      currentCompany: const Company(id: 'c', legalName: 'X'),
      currentBrand: const BrandProfile(id: 'b'),
      coherence: IdentityCoherence(verdict: verdict),
    );

/// Plays the whole timeline. The identity orb pulses on a repeating controller,
/// so `pumpAndSettle` would never return — advance the clock with fixed pumps.
Future<void> _play(
  WidgetTester tester,
  IdentityVerdict verdict,
  VoidCallback onContinue, {
  DetectionResult? detection,
}) async {
  await tester.pumpWidget(
    MaterialApp(
      home: RecognitionSequence(
        preview: _preview(verdict, detection: detection),
        onContinue: onContinue,
      ),
    ),
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

  testWidgets('never claims an identity element the import cannot capture', (tester) async {
    // Guard rail for the promise/reality gap: the detection pipeline captures
    // no font, no page-layout template and no signature, so the screen must
    // never tell the artisan those were "retrouvés". Three hard-coded labels
    // used to promise exactly that — this fails if they ever come back.
    await _play(tester, IdentityVerdict.recognized, () {});

    for (final unbacked in ['typographie', 'mise en page', 'signature']) {
      expect(
        find.textContaining(unbacked),
        findsNothing,
        reason: '"$unbacked" is not captured by the import — must never be claimed',
      );
    }
  });

  testWidgets('shows a « retrouvé » row only for what was actually detected', (tester) async {
    // logo NOT detected, colours present, coordinates present → the screen must
    // drop the logo line and keep the two real ones. Each claim is data-driven.
    const detection = DetectionResult(
      logoDetected: false,
      dominantColors: ['#0A0A0A'],
      headerDetected: false,
      footerDetected: false,
      tableDetected: false,
      companyName: 'SARL Réelle',
      legalNoticeDetected: false,
      confidenceScore: 0.5,
    );
    await _play(tester, IdentityVerdict.recognized, () {}, detection: detection);

    expect(find.textContaining('logo'), findsNothing);
    expect(find.textContaining('couleurs'), findsOneWidget);
    expect(find.textContaining('coordonnées'), findsOneWidget);
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
