import 'dart:typed_data';

import 'package:artizen/features/branding/data/branding_models.dart';
import 'package:artizen/features/branding/domain/branding_repository.dart';
import 'package:artizen/features/catalog/data/catalog_models.dart';
import 'package:artizen/features/catalog/domain/catalog_repository.dart';
import 'package:artizen/features/clients/data/client_model.dart';
import 'package:artizen/features/clients/domain/clients_repository.dart';
import 'package:artizen/features/metiers/data/metiers_models.dart';
import 'package:artizen/features/metiers/domain/metiers_repository.dart';
import 'package:artizen/features/quote_assistant/data/quote_suggestion_models.dart';
import 'package:artizen/features/quote_assistant/domain/quote_assistant_repository.dart';
import 'package:artizen/features/quotes/data/quote_calculation.dart';
import 'package:artizen/features/quotes/data/quote_models.dart';
import 'package:artizen/features/quotes/data/quote_readiness.dart';
import 'package:artizen/features/quotes/domain/quotes_repository.dart';
import 'package:artizen/features/template_import/data/template_import_models.dart';
import 'package:artizen/features/template_import/domain/template_import_repository.dart';

/// In-memory stand-ins for the three business repositories, shared by every
/// test that needs to boot the app or a notifier without touching the
/// network (see `ClientsRepository`, `CatalogRepository`,
/// `QuotesRepository` for the contracts these implement).
/// Applies the offset/limit paging the real backend does, so notifier tests
/// can exercise "load more" against a fake exactly as against the server.
List<T> _paginate<T>(List<T> rows, int? offset, int? limit) {
  var result = rows;
  if (offset != null && offset > 0) {
    result = offset >= result.length ? <T>[] : result.sublist(offset);
  }
  if (limit != null && limit < result.length) {
    result = result.sublist(0, limit);
  }
  return result;
}

class FakeClientsRepository implements ClientsRepository {
  FakeClientsRepository(this._clients, {this.createResult});

  final List<Client> _clients;

  /// When set, [create] adds and returns this client instead of throwing —
  /// lets a test exercise the real inline-creation flow (form → save →
  /// auto-select) end to end.
  final Client? createResult;

  @override
  Future<List<Client>> list({
    required String companyId,
    String? query,
    int? offset,
    int? limit,
  }) async {
    var rows = _clients;
    if (query != null && query.isNotEmpty) {
      final lower = query.toLowerCase();
      rows = rows
          .where((client) => client.lastName.toLowerCase().contains(lower))
          .toList();
    }
    return _paginate(rows, offset, limit);
  }

  @override
  Future<Client> get(String id) async =>
      _clients.firstWhere((client) => client.id == id);

  @override
  Future<Client> create(ClientInput input, {required String companyId}) async {
    if (createResult == null) throw UnimplementedError();
    _clients.add(createResult!);
    return createResult!;
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
  FakeCatalogRepository(
    this._categories,
    this._items, {
    this.tradeGroups = const [],
  });

  final List<CatalogCategory> _categories;
  final List<CatalogItem> _items;
  final List<TradeGroup> tradeGroups;

  @override
  Future<List<CatalogCategory>> listCategories({
    required String companyId,
  }) async => _categories;

  @override
  Future<List<CategoryOverview>> listCategoryOverviews() async => [
    for (final category in _categories)
      CategoryOverview(
        id: category.id,
        name: category.name,
        itemCount: _items
            .where((item) => item.categoryId == category.id)
            .length,
        sampleDesignations: _items
            .where((item) => item.categoryId == category.id)
            .take(3)
            .map((item) => item.designation)
            .toList(),
      ),
  ];

  @override
  Future<List<TradeGroup>> listCatalogByTrade() async => tradeGroups;

  @override
  Future<CatalogCategory> createCategory(
    CatalogCategoryInput input, {
    required String companyId,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<List<CatalogItem>> listItems({
    required String companyId,
    bool activeOnly = false,
    bool favoriteOnly = false,
    String? categoryId,
    String? query,
    int? offset,
    int? limit,
  }) async {
    var rows = activeOnly
        ? _items.where((item) => item.active).toList()
        : _items;
    if (favoriteOnly) {
      rows = rows.where((item) => item.isFavorite).toList();
    }
    if (categoryId != null) {
      rows = rows.where((item) => item.categoryId == categoryId).toList();
    }
    if (query != null && query.isNotEmpty) {
      final lower = query.toLowerCase();
      rows = rows.where((item) {
        return item.designation.toLowerCase().contains(lower) ||
            (item.code?.toLowerCase().contains(lower) ?? false);
      }).toList();
    }
    return _paginate(rows, offset, limit);
  }

  @override
  Future<CatalogItem> createItem(
    CatalogItemInput input, {
    required String companyId,
  }) async {
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

  @override
  Future<CatalogItem> setFavorite(String id, {required bool favorite}) async {
    final index = _items.indexWhere((item) => item.id == id);
    _items[index] = _items[index].copyWith(isFavorite: favorite);
    return _items[index];
  }
}

class FakeQuotesRepository implements QuotesRepository {
  FakeQuotesRepository(this._quotes, {this.readinessResult, this.createResult});

  final List<Quote> _quotes;

  /// Defaults to "ready" so screens that don't care about readiness (e.g. the
  /// boot/widget test) aren't blocked; a test can inject a not-ready verdict.
  final QuoteReadiness? readinessResult;

  /// When set, [create] adds and returns this quote instead of throwing — lets
  /// the wizard's creation ceremony be exercised end to end.
  final Quote? createResult;

  @override
  Future<List<Quote>> list({
    required String companyId,
    List<QuoteStatus>? statuses,
    String? clientId,
    int? offset,
    int? limit,
  }) async {
    var rows = _quotes;
    if (statuses != null && statuses.isNotEmpty) {
      rows = rows.where((quote) => statuses.contains(quote.status)).toList();
    }
    if (clientId != null) {
      rows = rows.where((quote) => quote.clientId == clientId).toList();
    }
    return _paginate(rows, offset, limit);
  }

  @override
  Future<Quote> get(String id) async =>
      _quotes.firstWhere((quote) => quote.id == id);

  @override
  Future<Quote> create({
    required String companyId,
    required String clientId,
    required List<QuoteLineInput> lines,
  }) async {
    if (createResult == null) throw UnimplementedError();
    _quotes.insert(0, createResult!);
    return createResult!;
  }

  @override
  Future<Quote> changeStatus(String id, QuoteStatus status) async {
    throw UnimplementedError();
  }

  @override
  Future<Quote> sendByEmail(String id) async {
    final index = _quotes.indexWhere((quote) => quote.id == id);
    if (index < 0) throw StateError('quote $id not found');
    final sent = _quotes[index].copyWith(status: QuoteStatus.sent);
    _quotes[index] = sent;
    return sent;
  }

  @override
  Future<Uint8List> downloadPdf(String id) async {
    throw UnimplementedError();
  }

  @override
  Future<Uint8List> downloadSamplePdf() async {
    throw UnimplementedError();
  }

  @override
  Future<void> delete(String id) async {
    throw UnimplementedError();
  }

  @override
  Future<Quote> duplicate(String id) async {
    throw UnimplementedError();
  }

  @override
  Future<QuoteReadiness> readiness(String id) async =>
      readinessResult ?? const QuoteReadiness(ready: true);

  /// Deterministic quantity-aware stub: each line totals its quantity and the
  /// grand total is their sum, so a wizard test can assert live recalculation
  /// reacts to a quantity change — without needing real catalog prices. (Two
  /// lines of quantity 1 still total "2", as before.)
  @override
  Future<QuoteCalculation> calculate({
    required List<QuoteLineInput> lines,
  }) async {
    num total = 0;
    final calcLines = <QuoteCalculationLine>[];
    for (final line in lines) {
      final quantity = num.tryParse(line.quantity) ?? 0;
      total += quantity;
      calcLines.add(
        QuoteCalculationLine(
          catalogItemId: line.catalogItemId,
          designation: 'Article ${line.catalogItemId}',
          unit: 'unité',
          quantity: line.quantity,
          unitPriceHt: '1',
          vatRate: '0',
          totalHt: '$quantity',
          totalVat: '0',
          totalTtc: '$quantity',
        ),
      );
    }
    return QuoteCalculation(
      totalHt: '$total',
      totalVat: '0',
      totalTtc: '$total',
      lines: calcLines,
    );
  }

  @override
  Future<Uint8List> previewDraftPdf({
    required String clientId,
    required List<QuoteLineInput> lines,
  }) async {
    // A minimal valid PDF header is enough for tests that only check bytes.
    return Uint8List.fromList('%PDF-1.4 preview'.codeUnits);
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

  @override
  Future<String> uploadSignature({
    required String filename,
    required List<int> bytes,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteSignature() async {
    throw UnimplementedError();
  }

  @override
  Future<String> uploadStamp({
    required String filename,
    required List<int> bytes,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteStamp() async {
    throw UnimplementedError();
  }

  @override
  Future<Uint8List?> fetchAsset(BrandAssetKind kind) async => null;
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
  Future<DocumentAnalysisSummary> processAnalysis(String analysisId) async =>
      processResult;

  @override
  Future<TemplateImportPreview> getPreview(String analysisId) async => preview;

  @override
  Future<BrandingProfile> validate(
    String analysisId,
    TemplateImportValidateInput input,
  ) async => validateResult;
}

/// In-memory metiers repository. Holds one mutable list of activities and one
/// of qualifications; import/remove flip a source's status the way the real
/// backend would, so notifier and widget tests can exercise the full cycle.
class FakeMetiersRepository implements MetiersRepository {
  FakeMetiersRepository({
    List<CatalogSource>? activities,
    List<CatalogSource>? qualifications,
  }) : _activities = [...?activities],
       _qualifications = [...?qualifications];

  final List<CatalogSource> _activities;
  final List<CatalogSource> _qualifications;

  @override
  Future<List<CatalogSource>> listActivities() async =>
      List.unmodifiable(_activities);

  @override
  Future<List<CatalogSource>> listQualifications() async =>
      List.unmodifiable(_qualifications);

  @override
  Future<CatalogImportResult> importActivity(String slug) =>
      _import(_activities, slug);

  @override
  Future<CatalogImportResult> importQualification(String slug) =>
      _import(_qualifications, slug);

  @override
  Future<void> removeActivity(String slug) => _remove(_activities, slug);

  @override
  Future<void> removeQualification(String slug) =>
      _remove(_qualifications, slug);

  Future<CatalogImportResult> _import(
    List<CatalogSource> list,
    String slug,
  ) async {
    final index = list.indexWhere((source) => source.slug == slug);
    final source = list[index];
    final added = source.status == CatalogSourceStatus.imported
        ? 0
        : source.itemCount;
    list[index] = source.copyWith(
      status: CatalogSourceStatus.imported,
      importedVersion: source.version,
      importedAt: DateTime(2026, 7, 20),
      updateItemCount: null,
      updateNotes: null,
    );
    return CatalogImportResult(
      slug: slug,
      label: source.label,
      categoriesCreated: source.packCount,
      itemsCreated: added,
      itemsSkipped: 0,
    );
  }

  Future<void> _remove(List<CatalogSource> list, String slug) async {
    final index = list.indexWhere((source) => source.slug == slug);
    list[index] = list[index].copyWith(
      status: CatalogSourceStatus.available,
      importedVersion: null,
      importedAt: null,
    );
  }
}
