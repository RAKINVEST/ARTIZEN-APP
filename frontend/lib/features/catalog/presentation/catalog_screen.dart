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
/// Turns a flat list of a hundred-plus folders into a handful of trades.
class _CategoriesTab extends ConsumerWidget {
  const _CategoriesTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groups = ref.watch(catalogByTradeProvider);

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
      body: AsyncListView<TradeGroup>(
        value: groups,
        emptyIcon: Icons.category_outlined,
        emptyMessage:
            'Aucun dossier pour le moment.\n'
            'Activez un métier (Tableau de bord → Mes métiers), '
            'ou créez une catégorie avec le bouton +.',
        onRetry: () => ref.read(catalogByTradeProvider.notifier).refresh(),
        itemBuilder: (context, list) => RefreshIndicator(
          onRefresh: () => ref.read(catalogByTradeProvider.notifier).refresh(),
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 8, bottom: 88),
            itemCount: list.length,
            itemBuilder: (context, index) =>
                _TradeGroupTile(group: list[index]),
          ),
        ),
      ),
    );
  }
}

/// One trade (métier), collapsible: its folders sit under it, and opening a
/// folder drills into its articles.
class _TradeGroupTile extends StatelessWidget {
  const _TradeGroupTile({required this.group});

  final TradeGroup group;

  @override
  Widget build(BuildContext context) {
    final folders = group.categories.length;
    return Card(
      child: ExpansionTile(
        leading: const CircleAvatar(child: Icon(Icons.handyman_outlined)),
        title: Text(
          group.label,
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
          for (final category in group.categories)
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
