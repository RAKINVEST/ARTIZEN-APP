import '../../branding/data/branding_models.dart';
import '../data/template_import_models.dart';

/// The contract the presentation layer depends on for the "importer un
/// ancien devis PDF" flow. Four steps, matching the pipeline exactly:
/// upload -> process (analysis) -> preview (detection) -> validate.
abstract class TemplateImportRepository {
  Future<DocumentAnalysisSummary> uploadQuotePdf({
    required String companyId,
    required String filename,
    required List<int> bytes,
  });

  Future<DocumentAnalysisSummary> processAnalysis(String analysisId);

  Future<TemplateImportPreview> getPreview(String analysisId);

  Future<BrandingProfile> validate(String analysisId, TemplateImportValidateInput input);
}
