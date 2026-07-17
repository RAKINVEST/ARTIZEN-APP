import 'package:artizen/features/branding/data/branding_models.dart';
import 'package:artizen/features/branding/domain/branding_repository.dart';
import 'package:artizen/features/catalog/data/catalog_models.dart';
import 'package:artizen/features/catalog/domain/catalog_repository.dart';
import 'package:artizen/features/clients/data/client_model.dart';
import 'package:artizen/features/clients/domain/clients_repository.dart';
import 'package:artizen/features/quote_assistant/data/quote_suggestion_models.dart';
import 'package:artizen/features/quote_assistant/domain/quote_assistant_repository.dart';
import 'package:artizen/features/quotes/data/quote_models.dart';
import 'package:artizen/features/quotes/domain/quotes_repository.dart';
import 'package:artizen/features/template_import/data/template_import_models.dart';
import 'package:artizen/features/template_import/domain/template_import_repository.dart';

/// In-memory stand-ins for the three business repositories, shared by every
/// test that needs to boot the app or a notifier without touching the
/// network (see `ClientsRepository`, `CatalogRepository`,
/// `QuotesRepository` for the contracts these implement).
class FakeClientsRepository implements ClientsRepository {
  FakeClientsRepository(this._clients);

  final List<Client> _clients;

  @override
  Future<List<Client>> list({required String companyId, String? query}) async {
    if (query == null || query.isEmpty) return _clients;
    final lower = query.toLowerCase();
    return _clients.where((client) => client.lastName.toLowerCase().contains(lower)).toList();
  }

  @override
  Future<Client> get(String id) async => _clients.firstWhere((client) => client.id == id);

  @override
  Future<Client> create(ClientInput input, {required String companyId}) async {
    throw UnimplementedError();
  }

  @override
  Future<Client> update(String id, ClientInput input) async {
    throw UnimplementedError();
  }

  @override
  Future<void> delete(String id) async {
    _clients.removeWhere((client) => client.id == id);
  }
}

class FakeCatalogRepository implements CatalogRepository {
  FakeCatalogRepository(this._categories, this._items);

  final List<CatalogCategory> _categories;
  final List<CatalogItem> _items;

  @override
  Future<List<CatalogCategory>> listCategories({required String companyId}) async => _categories;

  @override
  Future<CatalogCategory> createCategory(
    CatalogCategoryInput input, {
    required String companyId,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<List<CatalogItem>> listItems({required String companyId, bool activeOnly = false}) async {
    return activeOnly ? _items.where((item) => item.active).toList() : _items;
  }

  @override
  Future<CatalogItem> createItem(CatalogItemInput input, {required String companyId}) async {
    throw UnimplementedError();
  }

  @override
  Future<CatalogItem> updateItem(String id, CatalogItemInput input) async {
    throw UnimplementedError();
  }

  @override
  Future<CatalogItem> deactivateItem(String id) async {
    throw UnimplementedError();
  }

  @override
  Future<CatalogItem> reactivateItem(String id) async {
    throw UnimplementedError();
  }
}

class FakeQuotesRepository implements QuotesRepository {
  FakeQuotesRepository(this._quotes);

  final List<Quote> _quotes;

  @override
  Future<List<Quote>> list({required String companyId}) async => _quotes;

  @override
  Future<Quote> get(String id) async => _quotes.firstWhere((quote) => quote.id == id);

  @override
  Future<Quote> create({
    required String companyId,
    required String clientId,
    required List<QuoteLineInput> lines,
  }) async {
    throw UnimplementedError();
  }
}

class FakeQuoteAssistantRepository implements QuoteAssistantRepository {
  FakeQuoteAssistantRepository(this._suggestion);

  final QuoteSuggestion _suggestion;

  @override
  Future<QuoteSuggestion> suggest({
    required String companyId,
    required String description,
  }) async => _suggestion;
}

class FakeBrandingRepository implements BrandingRepository {
  FakeBrandingRepository(this._profile);

  final BrandingProfile _profile;

  @override
  Future<BrandingProfile> getProfile() async => _profile;

  @override
  Future<Company> updateCompany(CompanyUpdateInput input) async {
    throw UnimplementedError();
  }

  @override
  Future<BrandProfile> updateBrandProfile(BrandProfileUpdateInput input) async {
    throw UnimplementedError();
  }
}

class FakeTemplateImportRepository implements TemplateImportRepository {
  FakeTemplateImportRepository({
    required this.uploadResult,
    required this.processResult,
    required this.preview,
    required this.validateResult,
  });

  final DocumentAnalysisSummary uploadResult;
  final DocumentAnalysisSummary processResult;
  final TemplateImportPreview preview;
  final BrandingProfile validateResult;

  @override
  Future<DocumentAnalysisSummary> uploadQuotePdf({
    required String companyId,
    required String filename,
    required List<int> bytes,
  }) async => uploadResult;

  @override
  Future<DocumentAnalysisSummary> processAnalysis(String analysisId) async => processResult;

  @override
  Future<TemplateImportPreview> getPreview(String analysisId) async => preview;

  @override
  Future<BrandingProfile> validate(
    String analysisId,
    TemplateImportValidateInput input,
  ) async => validateResult;
}
