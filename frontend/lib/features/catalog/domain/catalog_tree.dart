import '../../../core/utils/search_text.dart';
import '../data/catalog_models.dart';

/// One node of the catalog tree: a category, its sub-categories and the
/// articles filed directly under it.
///
///   📁 Plombier
///     📂 Tubes → Tube PER, Tube cuivre…
///     📂 Chauffe-eau → Ballon 200 L…
class CatalogNode {
  CatalogNode({
    required this.category,
    required this.children,
    required this.items,
  });

  final CatalogCategory category;
  final List<CatalogNode> children;
  final List<CatalogItem> items;

  /// Articles in this branch, including every descendant — used to show a
  /// count on a collapsed folder.
  int get totalItemCount =>
      items.length + children.fold(0, (sum, child) => sum + child.totalItemCount);
}

/// A search result: the matching article plus the folder path it lives in
/// ("Plombier › Tubes"), so the artisan sees *where* it comes from without
/// ever opening a folder.
class CatalogSearchHit {
  const CatalogSearchHit({required this.item, required this.categoryPath});

  final CatalogItem item;
  final String categoryPath;
}

/// Builds the category tree from the flat lists the API returns.
///
/// Children are ordered by `sortOrder` first (the order the trade pack was
/// authored in — Tubes before Chauffe-eau), then alphabetically as a
/// tiebreaker. Categories whose parent is missing are treated as roots so a
/// partial fetch can never hide articles.
List<CatalogNode> buildCatalogTree(
  List<CatalogCategory> categories,
  List<CatalogItem> items,
) {
  final byId = {for (final category in categories) category.id: category};
  final childrenByParent = <String?, List<CatalogCategory>>{};
  for (final category in categories) {
    final parentId =
        (category.parentId != null && byId.containsKey(category.parentId)) ? category.parentId : null;
    childrenByParent.putIfAbsent(parentId, () => []).add(category);
  }

  final itemsByCategory = <String, List<CatalogItem>>{};
  for (final item in items) {
    itemsByCategory.putIfAbsent(item.categoryId, () => []).add(item);
  }
  for (final list in itemsByCategory.values) {
    list.sort((a, b) => a.designation.toLowerCase().compareTo(b.designation.toLowerCase()));
  }

  int compare(CatalogCategory a, CatalogCategory b) {
    final byOrder = a.sortOrder.compareTo(b.sortOrder);
    return byOrder != 0 ? byOrder : a.name.toLowerCase().compareTo(b.name.toLowerCase());
  }

  List<CatalogNode> build(String? parentId) {
    final children = [...?childrenByParent[parentId]]..sort(compare);
    return [
      for (final category in children)
        CatalogNode(
          category: category,
          children: build(category.id),
          items: itemsByCategory[category.id] ?? const [],
        ),
    ];
  }

  return build(null);
}

/// Flat, instant search across the whole catalog.
///
/// An article matches when the query appears in its designation, its code,
/// **or any folder above it** — so typing `chauff` surfaces everything under
/// *Chauffe-eau* and *Chauffage*, and typing `PER` lands straight on the
/// tube. Matching is accent- and case-insensitive.
List<CatalogSearchHit> searchCatalogItems(
  List<CatalogCategory> categories,
  List<CatalogItem> items,
  String query,
) {
  final normalizedQuery = normalizeForSearch(query.trim());
  if (normalizedQuery.isEmpty) return const [];

  final byId = {for (final category in categories) category.id: category};

  String pathOf(String categoryId) {
    final parts = <String>[];
    var current = byId[categoryId];
    final guard = <String>{};
    while (current != null && guard.add(current.id)) {
      parts.insert(0, current.name);
      final parentId = current.parentId;
      current = parentId == null ? null : byId[parentId];
    }
    return parts.join(' › ');
  }

  final hits = <CatalogSearchHit>[];
  for (final item in items) {
    final path = pathOf(item.categoryId);
    final matches = matchesQuery(item.designation, normalizedQuery) ||
        (item.code != null && matchesQuery(item.code!, normalizedQuery)) ||
        matchesQuery(path, normalizedQuery);
    if (matches) {
      hits.add(CatalogSearchHit(item: item, categoryPath: path));
    }
  }
  hits.sort((a, b) => a.item.designation.toLowerCase().compareTo(b.item.designation.toLowerCase()));
  return hits;
}
