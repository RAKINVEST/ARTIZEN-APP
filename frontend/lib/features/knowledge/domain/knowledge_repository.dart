import '../data/knowledge_model.dart';

/// The contract the presentation layer depends on. Read-side only: search and
/// read the corpus; it never writes.
abstract class KnowledgeRepository {
  /// `GET /knowledge/search` — multicriteria search over the corpus. Validated
  /// knowledge only unless [includeDrafts] is true.
  Future<KnowledgeSearchResult> search({
    required String q,
    String? metier,
    bool includeDrafts,
    int limit,
  });

  /// `GET /knowledge/{type}/{slug}` — one item plus its resolved relations.
  Future<KnowledgeDetail> detail(String type, String slug);
}
