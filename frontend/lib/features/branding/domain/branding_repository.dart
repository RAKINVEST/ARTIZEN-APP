import 'dart:typed_data';

import '../data/branding_models.dart';

/// The contract the presentation layer depends on for the company's
/// identity (`Company`/`BrandProfile`/`DocumentTemplate` — what Artizen
/// needs to make quotes/invoices look like the artisan's own documents).
abstract class BrandingRepository {
  Future<BrandingProfile> getProfile();
  Future<Company> updateCompany(CompanyUpdateInput input);
  Future<BrandProfile> updateBrandProfile(BrandProfileUpdateInput input);

  /// Uploads a logo image (multipart, `png`/`jpeg`) and returns the stored
  /// path the backend now reports as `brand.logoPath`.
  Future<String> uploadLogo({required String filename, required List<int> bytes});

  /// Removes the stored logo image (e.g. a wrongly detected one at import).
  Future<void> deleteLogo();

  /// Uploads a signature image (multipart, `png`/`jpeg`) and returns the
  /// stored path the backend now reports as `brand.signaturePath`.
  Future<String> uploadSignature({required String filename, required List<int> bytes});

  /// Removes the stored signature image.
  Future<void> deleteSignature();

  /// Uploads a stamp image (multipart, `png`/`jpeg`) and returns the stored
  /// path the backend now reports as `brand.stampPath`.
  Future<String> uploadStamp({required String filename, required List<int> bytes});

  /// Removes the stored stamp image.
  Future<void> deleteStamp();

  /// Fetches the raw bytes of a brand asset (logo/signature/stamp) with the
  /// auth header applied, so `Image.memory` can render it. Returns `null`
  /// when the asset is absent (the backend answers 404).
  Future<Uint8List?> fetchAsset(BrandAssetKind kind);
}
