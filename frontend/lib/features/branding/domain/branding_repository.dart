import '../data/branding_models.dart';

/// The contract the presentation layer depends on for the company's
/// identity (`Company`/`BrandProfile`/`DocumentTemplate` — what Artizen
/// needs to make quotes/invoices look like the artisan's own documents).
abstract class BrandingRepository {
  Future<BrandingProfile> getProfile();
  Future<Company> updateCompany(CompanyUpdateInput input);
  Future<BrandProfile> updateBrandProfile(BrandProfileUpdateInput input);
}
