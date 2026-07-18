import 'package:freezed_annotation/freezed_annotation.dart';

part 'branding_models.freezed.dart';
part 'branding_models.g.dart';

/// Mirrors `TemplateType` (`app/branding/models.py`).
enum TemplateType {
  @JsonValue('quote')
  quote,
  @JsonValue('invoice')
  invoice,
}

/// The three brand images the backend serves at `GET /branding/asset/{kind}`.
/// The wire value is the enum name itself (`logo` / `signature` / `stamp`),
/// so a kind maps straight into the URL path segment.
enum BrandAssetKind { logo, signature, stamp }

/// Mirrors `CompanyRead`.
@freezed
class Company with _$Company {
  const factory Company({
    required String id,
    String? name,
    String? legalName,
    String? siret,
    String? vatNumber,
    String? addressLine,
    String? postalCode,
    String? city,
    String? country,
    String? phone,
    String? email,
    String? website,
    // Regulatory identity (Phase 1) — mirrors the new `CompanyRead` fields.
    String? legalForm,
    String? shareCapital,
    String? rcsRm,
    String? apeCode,
    String? insuranceName,
    String? insuranceContract,
    String? insuranceCoverage,
    String? rgeNumber,
    String? paymentTerms,
    // Non-nullable on the backend. Defaults keep older JSON (and fixtures
    // that predate these fields) parseable, since `@Default` makes the
    // generated `fromJson` fall back instead of throwing on a missing key.
    @Default('normal') String vatRegime,
    @Default(30) int quoteValidityDays,
  }) = _Company;

  factory Company.fromJson(Map<String, dynamic> json) => _$CompanyFromJson(json);
}

/// Mirrors `BrandProfileRead`.
@freezed
class BrandProfile with _$BrandProfile {
  const factory BrandProfile({
    required String id,
    String? logoPath,
    String? primaryColor,
    String? secondaryColor,
    String? fontFamily,
    String? tagline,
    String? signaturePath,
    String? stampPath,
  }) = _BrandProfile;

  factory BrandProfile.fromJson(Map<String, dynamic> json) => _$BrandProfileFromJson(json);
}

/// Mirrors `DocumentTemplateRead`.
@freezed
class DocumentTemplate with _$DocumentTemplate {
  const factory DocumentTemplate({
    required String id,
    required TemplateType type,
    required String name,
    required int version,
    required bool isActive,
    required DateTime createdAt,
    required String sourceFilePath,
  }) = _DocumentTemplate;

  factory DocumentTemplate.fromJson(Map<String, dynamic> json) => _$DocumentTemplateFromJson(json);
}

/// Mirrors `BrandingProfileRead` (`GET /branding/profile`).
@freezed
class BrandingProfile with _$BrandingProfile {
  const factory BrandingProfile({
    required Company company,
    required BrandProfile brand,
    required List<DocumentTemplate> templates,
  }) = _BrandingProfile;

  factory BrandingProfile.fromJson(Map<String, dynamic> json) => _$BrandingProfileFromJson(json);
}

/// Mirrors `CompanyUpdate`: every field optional, only the ones set are
/// sent (`include_if_null: false`), matching the backend's
/// `exclude_unset=True` partial-update semantics.
@freezed
class CompanyUpdateInput with _$CompanyUpdateInput {
  const factory CompanyUpdateInput({
    String? name,
    String? legalName,
    String? siret,
    String? vatNumber,
    String? addressLine,
    String? postalCode,
    String? city,
    String? country,
    String? phone,
    String? email,
    String? website,
    // Regulatory identity (Phase 1) — mirrors the new `CompanyUpdate` fields.
    String? legalForm,
    String? shareCapital,
    String? rcsRm,
    String? apeCode,
    String? insuranceName,
    String? insuranceContract,
    String? insuranceCoverage,
    String? rgeNumber,
    String? paymentTerms,
    String? vatRegime,
    int? quoteValidityDays,
  }) = _CompanyUpdateInput;

  factory CompanyUpdateInput.fromJson(Map<String, dynamic> json) =>
      _$CompanyUpdateInputFromJson(json);
}

/// Mirrors `BrandProfileUpdate`.
@freezed
class BrandProfileUpdateInput with _$BrandProfileUpdateInput {
  const factory BrandProfileUpdateInput({
    String? primaryColor,
    String? secondaryColor,
    String? fontFamily,
    String? tagline,
  }) = _BrandProfileUpdateInput;

  factory BrandProfileUpdateInput.fromJson(Map<String, dynamic> json) =>
      _$BrandProfileUpdateInputFromJson(json);
}
