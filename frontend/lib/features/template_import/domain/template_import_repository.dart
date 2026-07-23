import 'dart:typed_data';

import '../../branding/data/branding_models.dart';
import '../data/template_import_models.dart';

/// The contract the presentation layer depends on for the "importer un
/// ancien devis PDF" flow. Upload -> process (analysis) -> preview
/// (detection) -> [sample preview] -> validate.
abstract class TemplateImportRepository {
  Future<DocumentAnalysisSummary> uploadQuotePdf({
    required String companyId,
    required String filename,
    required List<int> bytes,
  });

  Future<DocumentAnalysisSummary> processAnalysis(String analysisId);

  Future<TemplateImportPreview> getPreview(String analysisId);

  /// The "aperçu du rendu": a demo quote drawn with the proposed identity,
  /// rendered server-side without persisting anything, so the artisan sees
  /// their devis à leur image before confirming it with [validate].
  Future<Uint8List> renderProposedSample(
    String analysisId,
    TemplateImportValidateInput input,
  );

  Future<BrandingProfile> validate(
    String analysisId,
    TemplateImportValidateInput input,
  );
}
