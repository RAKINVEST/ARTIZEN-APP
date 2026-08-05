import 'package:freezed_annotation/freezed_annotation.dart';

part 'site_model.freezed.dart';
part 'site_model.g.dart';

/// Mirrors the backend's `SiteRead` schema (`app/sites/schemas.py`)
/// field-for-field. A "site" is a jobsite (chantier) attached to exactly one
/// client. Snake_case JSON keys (`customer_id`, `company_id`) are handled by
/// the global `field_rename: snake` in build.yaml, same as every other model.
@freezed
class Site with _$Site {
  const factory Site({
    required String id,
    required String companyId,
    required String customerId,
    required String name,
    String? address,
    required String status,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Site;

  factory Site.fromJson(Map<String, dynamic> json) => _$SiteFromJson(json);

  const Site._();

  /// Archived sites are hidden from the default list but kept as read-only
  /// history — business data is never destroyed (Loi 5).
  bool get isArchived => status == 'archived';
}

/// Create payload — matches `SiteCreate` (client + name required, address
/// optional). `company_id` is added by the repository and overridden from the
/// JWT server-side, so it is never part of this input.
@freezed
class SiteCreateInput with _$SiteCreateInput {
  const factory SiteCreateInput({
    required String customerId,
    required String name,
    @JsonKey(includeIfNull: true) String? address,
  }) = _SiteCreateInput;

  factory SiteCreateInput.fromJson(Map<String, dynamic> json) =>
      _$SiteCreateInputFromJson(json);
}

/// Update payload — matches `SiteUpdate`. `customer_id` is intentionally
/// absent: a site belongs to one client for its whole life. `includeIfNull`
/// lets the artisan clear the address (send explicit null), the same reason
/// `ClientInput` opts its nullable fields back in.
@freezed
class SiteUpdateInput with _$SiteUpdateInput {
  const factory SiteUpdateInput({
    @JsonKey(includeIfNull: true) String? name,
    @JsonKey(includeIfNull: true) String? address,
  }) = _SiteUpdateInput;

  factory SiteUpdateInput.fromJson(Map<String, dynamic> json) =>
      _$SiteUpdateInputFromJson(json);
}
