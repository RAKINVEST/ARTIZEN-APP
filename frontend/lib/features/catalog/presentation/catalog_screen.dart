import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/async_value_view.dart';
import '../../../shared/widgets/confirm_dialog.dart';
import '../../../shared/widgets/search_field.dart';
import '../data/catalog_models.dart';
import '../domain/catalog_tree.dart';
import 'catalog_providers.dart';
import 'widgets/add_category_dialog.dart';
import 'widgets/item_tile.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Catalogue'),
          // Categories first: the artisan organizes families before filling
          // them with articles.
          bottom: const TabBar(
            tabs: [Tab(text: 'Catégories'), Tab(text: 'Articles')],
          ),
        ),
        body: const TabBarView(
          children: [_CategoriesTab(), _ItemsTab()],
        ),
      ),
    );
  }
}

Future<void> _confirmDeactivate(BuildContext context, WidgetRef ref, CatalogItem item) async {
  final confirmed = await showConfirmDialog(
    context,
    title: 'Désactiver cet article ?',
    message: '"${item.designation}" ne pourra plus être ajouté à un nouveau devis. '
        'Les devis existants ne sont pas modifiés.',
    confirmLabel: 'Désactiver',
  );
  if (confirmed) {
    await ref.read(itemsNotifierProvider.notifier).deactivateItem(item.id);
  }
}

/// Shown when the company has no catalog yet: the fastest way out is to
/// install a ready-made trade pack rather than typing everything by hand.
class _EmptyCatalogPrompt extends StatelessWidget {
  const _EmptyCatalogPrompt();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.handyman_outlined, size: 48, color: theme.colorScheme.primary),
            const SizedBox(height: 16),
            Text('Votre catalogue est vide', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(
              'Choisissez votre métier : Artizen installe les catégories et les '
              'articles courants. Vous n’aurez plus qu’à saisir vos prix.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: () => context.push('/catalog/trades'),
              icon: const Icon(Icons.download_outlined),
              label: const Text('Choisir mon métier'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ItemsTab extends ConsumerStatefulWidget {
  const _ItemsTab();

  @override
  ConsumerState<_ItemsTab> createState() => _ItemsTabState();
}

class _ItemsTabState extends ConsumerState<_ItemsTab> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final itemsAsync = ref.watch(itemsNotifierProvider);
    final categories = ref.watch(categoriesNotifierProvider).valueOrNull ?? const <CatalogCategory>[];

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/catalog/items/new'),
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          SearchField(
            hintText: 'Rechercher : chauff, PER, robinet…',
            onChanged: (query) => setState(() => _query = query),
          ),
          Expanded(
            child: AsyncValueView(
              value: itemsAsync,
              onRetry: () => ref.read(itemsNotifierProvider.notifier).refresh(),
              builder: (context, items) {
                final query = _query.trim();

                // Search short-circuits the folders entirely: the artisan
                // types and gets articles, wherever they live.
                if (query.isNotEmpty) {
                  final hits = searchCatalogItems(categories, items, query);
                  if (hits.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Text('Aucun article ne correspond à « $query ».'),
                      ),
                    );
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.only(top: 8, bottom: 88),
                    itemCount: hits.length,
                    itemBuilder: (context, index) => _SearchHitTile(hit: hits[index]),
                  );
                }

                if (items.isEmpty && categories.isEmpty) return const _EmptyCatalogPrompt();

                final tree = buildCatalogTree(categories, items);
                if (tree.isEmpty) return const _EmptyCatalogPrompt();

                return RefreshIndicator(
                  onRefresh: () => ref.read(itemsNotifierProvider.notifier).refresh(),
                  child: ListView(
                    padding: const EdgeInsets.only(top: 8, bottom: 88),
                    children: [
                      for (final node in tree) _CategoryNodeTile(node: node, depth: 0),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// One folder in the tree: sub-folders first, then the articles filed
/// directly under it.
class _CategoryNodeTile extends ConsumerWidget {
  const _CategoryNodeTile({required this.node, required this.depth});

  final CatalogNode node;
  final int depth;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isRoot = depth == 0;

    return Padding(
      padding: EdgeInsets.only(left: depth == 0 ? 0 : 8),
      child: ExpansionTile(
        initiallyExpanded: isRoot,
        shape: const Border(),
        collapsedShape: const Border(),
        leading: Icon(
          isRoot ? Icons.folder : Icons.folder_open_outlined,
          color: theme.colorScheme.primary,
        ),
        title: Text(
          node.category.name,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: isRoot ? FontWeight.w700 : FontWeight.w600,
          ),
        ),
        subtitle: Text(
          '${node.totalItemCount} article${node.totalItemCount > 1 ? 's' : ''}',
          style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
        ),
        children: [
          for (final child in node.children) _CategoryNodeTile(node: child, depth: depth + 1),
          for (final item in node.items)
            ItemTile(
              item: item,
              onTap: () => context.push('/catalog/items/${item.id}/edit'),
              onDeactivate: () => _confirmDeactivate(context, ref, item),
            ),
        ],
      ),
    );
  }
}

/// A search result: the article plus the folder path it came from.
class _SearchHitTile extends ConsumerWidget {
  const _SearchHitTile({required this.hit});

  final CatalogSearchHit hit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 8),
          child: Text(
            hit.categoryPath,
            style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.primary),
          ),
        ),
        ItemTile(
          item: hit.item,
          onTap: () => context.push('/catalog/items/${hit.item.id}/edit'),
          onDeactivate: () => _confirmDeactivate(context, ref, hit.item),
        ),
      ],
    );
  }
}

class _CategoriesTab extends ConsumerWidget {
  const _CategoriesTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(categoriesNotifierProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final input = await showAddCategoryDialog(context);
          if (input != null) {
            await ref.read(categoriesNotifierProvider.notifier).createCategory(input);
          }
        },
        child: const Icon(Icons.add),
      ),
      body: AsyncValueView(
        value: categoriesAsync,
        onRetry: () => ref.read(categoriesNotifierProvider.notifier).refresh(),
        builder: (context, categories) {
          if (categories.isEmpty) return const _EmptyCatalogPrompt();
          final tree = buildCatalogTree(categories, const []);
          return RefreshIndicator(
            onRefresh: () => ref.read(categoriesNotifierProvider.notifier).refresh(),
            child: ListView(
              padding: const EdgeInsets.only(top: 8, bottom: 88),
              children: [
                for (final node in tree) ..._categoryRows(context, node, 0),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Flattens the tree into indented rows — a category list, not a picker,
  /// so plain rows read better here than nested expanders.
  List<Widget> _categoryRows(BuildContext context, CatalogNode node, int depth) {
    final theme = Theme.of(context);
    return [
      Padding(
        padding: EdgeInsets.only(left: 16.0 * depth),
        child: Card(
          child: ListTile(
            leading: Icon(
              depth == 0 ? Icons.folder : Icons.folder_open_outlined,
              color: theme.colorScheme.primary,
            ),
            title: Text(node.category.name),
            subtitle: node.category.description == null ? null : Text(node.category.description!),
          ),
        ),
      ),
      for (final child in node.children) ..._categoryRows(context, child, depth + 1),
    ];
  }
}
