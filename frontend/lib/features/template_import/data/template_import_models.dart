import 'package:freezed_annotation/freezed_annotation.dart';

import '../../branding/data/branding_models.dart';

part 'template_import_models.freezed.dart';
part 'template_import_models.g.dart';

/// A partial view of `DocumentAnalysisRead` — only the fields this
/// feature's screens actually display. Extra fields the backend sends
/// (`extracted_text`, `blueprint`, ...) are simply ignored by
/// `fromJson`, not an error: no other Flutter feature needs a full
/// `document_analysis` model yet, so building one just for this screen
/// would be speculative.
@freezed
class DocumentAnalysisSummary with _$DocumentAnalysisSummary {
  const factory DocumentAnalysisSummary({
    required String id,
    required String status,
    required String filename,
    required String documentType,
    int? pageCount,
  }) = _DocumentAnalysisSummary;

  factory DocumentAnalysisSummary.fromJson(Map<String, dynamic> json) =>
      _$DocumentAnalysisSummaryFromJson(json);
}

/// Mirrors `DocumentDetectionResultRead` — the heuristic extraction
/// result (logo, colors, layout zones, SIRET/VAT/contact) this screen
/// shows as "detected" values a user can keep or edit.
@freezed
class DetectionResult with _$DetectionResult {
  const factory DetectionResult({
    required bool logoDetected,
    String? logoPosition,
    required List<String> dominantColors,
    required bool headerDetected,
    required bool footerDetected,
    required bool tableDetected,
    String? companyName,
    String? address,
    String? phone,
    String? email,
    String? website,
    String? siret,
    String? vatNumber,
    required bool legalNoticeDetected,
    required double confidenceScore,
  }) = _DetectionResult;

  factory DetectionResult.fromJson(Map<String, dynamic> json) =>
      _$DetectionResultFromJson(json);
}

/// Mirrors `TemplateImportPreviewRead`: detected values *and* the
/// company's current values side by side, so the user can compare
/// before validating.
@freezed
class TemplateImportPreview with _$TemplateImportPreview {
  const factory TemplateImportPreview({
    required DocumentAnalysisSummary analysis,
    required DetectionResult detection,
    required Company currentCompany,
    required BrandProfile currentBrand,
  }) = _TemplateImportPreview;

  factory TemplateImportPreview.fromJson(Map<String, dynamic> json) =>
      _$TemplateImportPreviewFromJson(json);
}

/// Mirrors `TemplateImportValidateRequest`: the *final* values the user
/// confirmed (kept-as-detected or edited), not a diff — every field is
/// optional and only the provided ones are applied server-side.
@freezed
class TemplateImportValidateInput with _$TemplateImportValidateInput {
  const factory TemplateImportValidateInput({
    String? name,
    String? legalName,
    String? siret,
    String? vatNumber,
    String? addressLine,
    String? postalCode,
    String? city,
    String? phone,
    String? email,
    String? website,
    String? primaryColor,
    String? secondaryColor,
  }) = _TemplateImportValidateInput;

  factory TemplateImportValidateInput.fromJson(Map<String, dynamic> json) =>
      _$TemplateImportValidateInputFromJson(json);
}
