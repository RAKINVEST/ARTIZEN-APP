import 'package:flutter/material.dart';
import '../../../core/navigation/section_nav_arrows.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/async_value_view.dart';
import '../../../core/widgets/paged_list_view.dart';
import '../../../shared/widgets/confirm_dialog.dart';
import '../../../shared/widgets/debounced_search_field.dart';
import '../data/catalog_models.dart';
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
          leading: const SectionNavArrows(current: '/catalog'),
          leadingWidth: 96,
          title: const Text('Catalogue'),
          bottom: const TabBar(
            // The AppBar is night-blue; without explicit colours Material 3
            // paints the *selected* label in colorScheme.primary (also
            // night-blue) — invisible — and the rest a faint grey. Gold on
            // blue for the active tab, bright white for the other, both bigger
            // and bolder so the two sections read at a glance.
            labelColor: ArtizenColors.gold,
            unselectedLabelColor: Colors.white,
            indicatorColor: ArtizenColors.gold,
            indicatorWeight: 3,
            labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            unselectedLabelStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            tabs: [
              Tab(text: 'Catégories'),
              Tab(text: 'Articles'),
            ],
          ),
        ),
        body: const TabBarView(children: [_CategoriesTab(), _ItemsTab()]),
      ),
    );
  }
}

class _ItemsTab extends ConsumerWidget {
  const _ItemsTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(itemsNotifierProvider);
    final notifier = ref.read(itemsNotifierProvider.notifier);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/catalog/items/new'),
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          DebouncedSearchField(
            hintText: 'Rechercher un article (désignation, code)',
            initialValue: notifier.searchQuery,
            onChanged: notifier.search,
          ),
          Expanded(
            child: PagedListView(
              value: items,
              emptyMessage:
                  'Aucun article pour le moment.\nAjoutez votre premier article avec le bouton +.',
              emptyIcon: Icons.inventory_2_outlined,
              onRetry: notifier.refresh,
              onRefresh: notifier.refresh,
              onLoadMore: notifier.loadMore,
              itemBuilder: (context, item) => ItemTile(
                item: item,
                onTap: () => context.push('/catalog/items/${item.id}/edit'),
                onDeactivate: () async {
                  final confirmed = await showConfirmDialog(
                    context,
                    title: 'Désactiver cet article ?',
                    message:
                        '"${item.designation}" ne pourra plus être ajouté à un nouveau devis. '
                        'Les devis existants ne sont pas modifiés.',
                    confirmLabel: 'Désactiver',
                  );
                  if (confirmed) {
                    await notifier.deactivateItem(item.id);
                  }
                },
                // No confirmation dialog, unlike deactivating: putting an
                // item back is harmless and reversible, and a prompt would
                // only stand between the artisan and undoing a mis-tap.
                onReactivate: () => notifier.reactivateItem(item.id),
                onToggleFavorite: () =>
                    notifier.setFavorite(item.id, favorite: !item.isFavorite),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// The catalogue browsed **by trade**: each imported métier is a collapsible
/// group, opening to its folders; opening a folder drills into its articles.
/// Turns a flat list of a hundred-plus folders into a handful of trades. A
/// search field at the top filters that tree by métier or dossier name — like
/// the Articles tab, but client-side: `by-trade` returns the whole tree, so
/// there is never a truncated page to filter wrongly.
class _CategoriesTab extends ConsumerStatefulWidget {
  const _CategoriesTab();

  @override
  ConsumerState<_CategoriesTab> createState() => _CategoriesTabState();
}

class _CategoriesTabState extends ConsumerState<_CategoriesTab> {
  String _query = '';

  /// A métier whose name matches keeps all its folders; otherwise only the
  /// folders whose name matches are kept, and a métier with neither is dropped.
  List<(TradeGroup, List<TradeCategory>)> _filter(
    List<TradeGroup> groups,
    String query,
  ) {
    if (query.isEmpty) {
      return [for (final group in groups) (group, group.categories)];
    }
    final result = <(TradeGroup, List<TradeCategory>)>[];
    for (final group in groups) {
      if (group.label.toLowerCase().contains(query)) {
        result.add((group, group.categories));
      } else {
        final folders = group.categories
            .where((category) => category.name.toLowerCase().contains(query))
            .toList();
        if (folders.isNotEmpty) result.add((group, folders));
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final groups = ref.watch(catalogByTradeProvider);
    final query = _query.trim().toLowerCase();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final input = await showAddCategoryDialog(context);
          if (input != null) {
            await ref
                .read(categoriesNotifierProvider.notifier)
                .createCategory(input);
          }
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          DebouncedSearchField(
            hintText: 'Rechercher un métier ou un dossier',
            onChanged: (value) => setState(() => _query = value),
          ),
          Expanded(
            child: AsyncListView<TradeGroup>(
              value: groups,
              emptyIcon: Icons.category_outlined,
              emptyMessage:
                  'Aucun dossier pour le moment.\n'
                  'Activez un métier (Tableau de bord → Mes métiers), '
                  'ou créez une catégorie avec le bouton +.',
              onRetry: () =>
                  ref.read(catalogByTradeProvider.notifier).refresh(),
              itemBuilder: (context, list) {
                final filtered = _filter(list, query);
                if (query.isNotEmpty && filtered.isEmpty) {
                  return _NoCategoryMatch(query: _query.trim());
                }
                return RefreshIndicator(
                  onRefresh: () =>
                      ref.read(catalogByTradeProvider.notifier).refresh(),
                  child: ListView.builder(
                    padding: const EdgeInsets.only(top: 8, bottom: 88),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final (group, folders) = filtered[index];
                      return _TradeGroupTile(
                        // Key includes the query so a search recreates the tile
                        // in its expanded state — results are visible at once.
                        key: ValueKey('${group.label}|$query'),
                        label: group.label,
                        categories: folders,
                        initiallyExpanded: query.isNotEmpty,
                      );
                    },
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

/// One trade (métier), collapsible: its folders sit under it, and opening a
/// folder drills into its articles.
class _TradeGroupTile extends StatelessWidget {
  const _TradeGroupTile({
    required this.label,
    required this.categories,
    this.initiallyExpanded = false,
    super.key,
  });

  final String label;
  final List<TradeCategory> categories;
  final bool initiallyExpanded;

  @override
  Widget build(BuildContext context) {
    final folders = categories.length;
    return Card(
      child: ExpansionTile(
        initiallyExpanded: initiallyExpanded,
        leading: const CircleAvatar(child: Icon(Icons.handyman_outlined)),
        title: Text(
          label,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          '$folders dossier${folders > 1 ? 's' : ''}',
          style: const TextStyle(
            fontSize: 14,
            color: ArtizenColors.textSecondary,
          ),
        ),
        childrenPadding: const EdgeInsets.only(bottom: ArtizenSpacing.xs),
        children: [
          for (final category in categories)
            ListTile(
              contentPadding: const EdgeInsets.only(left: 28, right: 12),
              leading: const Icon(Icons.folder_outlined),
              title: Text(category.name, style: const TextStyle(fontSize: 16)),
              trailing: Text(
                '${category.itemCount}',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: () => context.push(
                '/catalog/categories/${category.id}/items',
                extra: category.name,
              ),
            ),
        ],
      ),
    );
  }
}

/// Shown when a search matches no métier and no dossier — tells the artisan
/// their query came back empty rather than leaving a blank tab.
class _NoCategoryMatch extends StatelessWidget {
  const _NoCategoryMatch({required this.query});

  final String query;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(ArtizenSpacing.lg),
      children: [
        const SizedBox(height: 40),
        const Icon(
          Icons.search_off_outlined,
          size: 40,
          color: ArtizenColors.textSecondary,
        ),
        const SizedBox(height: 12),
        Text(
          'Aucun métier ni dossier ne correspond à « $query ».',
          textAlign: TextAlign.center,
          style: const TextStyle(color: ArtizenColors.textSecondary),
        ),
      ],
    );
  }
}
