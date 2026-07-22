import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/async_value_view.dart';
import '../../../shared/widgets/confirm_dialog.dart';
import '../data/catalog_models.dart';
import '../data/catalog_repository_impl.dart';
import 'catalog_providers.dart';
import 'widgets/item_tile.dart';

/// The articles of one folder — reached by opening a folder in the by-trade
/// "Catégories" view. Same article tile as the Articles tab (toolbox, edit,
/// deactivate), so acting on an article here behaves exactly as elsewhere.
class CategoryItemsScreen extends ConsumerWidget {
  const CategoryItemsScreen({
    required this.categoryId,
    required this.categoryName,
    super.key,
  });

  final String categoryId;
  final String categoryName;

  /// Run a repository change, then refresh this folder's list and the other
  /// catalogue views it touches, so every screen stays consistent.
  Future<void> _mutate(WidgetRef ref, Future<void> Function() action) async {
    await action();
    ref.invalidate(categoryItemsProvider(categoryId));
    ref.invalidate(itemsNotifierProvider);
    ref.invalidate(favoriteItemsProvider);
    ref.invalidate(catalogByTradeProvider);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(categoryItemsProvider(categoryId));
    final repository = ref.read(catalogRepositoryProvider);

    return Scaffold(
      appBar: AppBar(title: Text(categoryName)),
      body: AsyncListView<CatalogItem>(
        value: items,
        emptyIcon: Icons.inventory_2_outlined,
        emptyMessage: 'Ce dossier ne contient aucun article.',
        onRetry: () => ref.invalidate(categoryItemsProvider(categoryId)),
        itemBuilder: (context, list) => ListView.builder(
          padding: const EdgeInsets.only(top: 8, bottom: 24),
          itemCount: list.length,
          itemBuilder: (context, index) {
            final item = list[index];
            return ItemTile(
              item: item,
              onTap: () => context.push('/catalog/items/${item.id}/edit'),
              onToggleFavorite: () =>
                  _mutate(ref, () => repository.setFavorite(item.id, favorite: !item.isFavorite)),
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
                  await _mutate(ref, () => repository.deactivateItem(item.id));
                }
              },
              onReactivate: () => _mutate(ref, () => repository.reactivateItem(item.id)),
            );
          },
        ),
      ),
    );
  }
}
