import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/currency.dart';
import '../../data/catalog_models.dart';

class ItemTile extends StatelessWidget {
  const ItemTile({
    required this.item,
    required this.onTap,
    required this.onDeactivate,
    required this.onReactivate,
    required this.onToggleFavorite,
    super.key,
  });

  final CatalogItem item;
  final VoidCallback onTap;
  final VoidCallback onDeactivate;
  final VoidCallback onReactivate;
  final VoidCallback onToggleFavorite;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          child: Icon(item.itemType == ItemType.service ? Icons.build_outlined : Icons.inventory_2_outlined),
        ),
        title: Text(
          item.designation,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          '${CurrencyFormatter.format(item.unitPriceHt)} HT / ${item.unit}'
          '${item.active ? '' : ' · désactivé'}',
          // Bigger and darker than the theme default: the price was too faint
          // and small to read at a glance (a recurring complaint).
          style: item.active
              ? const TextStyle(fontSize: 15, color: ArtizenColors.textPrimary)
              : TextStyle(fontSize: 15, color: theme.colorScheme.outline),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // "Ma caisse à outils": the toolbox the artisan fills with the
            // articles he reaches for again and again — filled + gold when in.
            IconButton(
              icon: Icon(
                item.isFavorite ? Icons.home_repair_service : Icons.home_repair_service_outlined,
                color: item.isFavorite ? ArtizenColors.gold : null,
              ),
              tooltip: item.isFavorite
                  ? 'Retirer de ma caisse à outils'
                  : 'Ajouter à ma caisse à outils',
              onPressed: onToggleFavorite,
            ),
            // A deactivated item used to have no action at all here, which made
            // deactivating a one-way door: the item stayed listed, greyed out,
            // and unusable forever. The way back has to live where the way out is.
            item.active
                ? IconButton(
                    icon: const Icon(Icons.visibility_off_outlined),
                    tooltip: 'Désactiver',
                    onPressed: onDeactivate,
                  )
                : IconButton(
                    icon: const Icon(Icons.restore_outlined),
                    tooltip: 'Réactiver',
                    onPressed: onReactivate,
                  ),
          ],
        ),
      ),
    );
  }
}
