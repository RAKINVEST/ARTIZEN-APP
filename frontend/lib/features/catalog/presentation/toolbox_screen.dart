import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/utils/currency.dart';
import '../../../core/widgets/async_value_view.dart';
import '../data/catalog_models.dart';
import 'catalog_providers.dart';

/// "Ma caisse à outils" — the articles the artisan reaches for again and again,
/// gathered from the catalogue (the 🧰 on each article). A curated shortlist,
/// not the whole catalogue: quick to scan, quick to reuse.
class ToolboxScreen extends ConsumerWidget {
  const ToolboxScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoriteItemsProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Ma caisse à outils')),
      body: AsyncListView<CatalogItem>(
        value: favorites,
        emptyIcon: Icons.home_repair_service_outlined,
        emptyMessage:
            "Ta caisse à outils est vide.\n"
            "Ajoute tes articles habituels depuis le Catalogue, avec l'icône 🧰.",
        onRetry: () => ref.read(favoriteItemsProvider.notifier).refresh(),
        itemBuilder: (context, items) => RefreshIndicator(
          onRefresh: () => ref.read(favoriteItemsProvider.notifier).refresh(),
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 8, bottom: 24),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Card(
                child: ListTile(
                  onTap: () => context.push('/catalog/items/${item.id}/edit'),
                  leading: CircleAvatar(
                    child: Icon(
                      item.itemType == ItemType.service
                          ? Icons.build_outlined
                          : Icons.inventory_2_outlined,
                    ),
                  ),
                  title: Text(item.designation),
                  subtitle: Text(
                    '${CurrencyFormatter.format(item.unitPriceHt)} HT / ${item.unit}',
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.home_repair_service, color: ArtizenColors.gold),
                    tooltip: 'Retirer de ma caisse à outils',
                    onPressed: () =>
                        ref.read(favoriteItemsProvider.notifier).removeFromToolbox(item.id),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
