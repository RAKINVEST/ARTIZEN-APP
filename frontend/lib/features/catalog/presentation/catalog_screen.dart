import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/async_value_view.dart';
import '../../../core/widgets/paged_list_view.dart';
import '../../../shared/widgets/confirm_dialog.dart';
import '../../../shared/widgets/debounced_search_field.dart';
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
          bottom: const TabBar(
            tabs: [Tab(text: 'Articles'), Tab(text: 'Catégories')],
          ),
        ),
        body: const TabBarView(
          children: [_ItemsTab(), _CategoriesTab()],
        ),
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
              emptyMessage: 'Aucun article pour le moment.\nAjoutez votre premier article avec le bouton +.',
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoriesTab extends ConsumerWidget {
  const _CategoriesTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesNotifierProvider);

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
      body: AsyncListView(
        value: categories,
        emptyMessage: 'Aucune catégorie pour le moment.\nCréez-en une avec le bouton +.',
        emptyIcon: Icons.category_outlined,
        onRetry: () => ref.read(categoriesNotifierProvider.notifier).refresh(),
        itemBuilder: (context, list) => RefreshIndicator(
          onRefresh: () => ref.read(categoriesNotifierProvider.notifier).refresh(),
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 8, bottom: 88),
            itemCount: list.length,
            itemBuilder: (context, index) {
              final category = list[index];
              return Card(
                child: ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.category_outlined)),
                  title: Text(category.name),
                  subtitle: category.description == null ? null : Text(category.description!),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
