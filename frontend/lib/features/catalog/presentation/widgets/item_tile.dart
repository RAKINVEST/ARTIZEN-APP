import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/currency.dart';
import '../../../../core/widgets/app_surfaces.dart';
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
    final isService = item.itemType == ItemType.service;
    final accent = !item.active
        ? ArtizenAccents.slate
        : (isService ? ArtizenAccents.violet : ArtizenAccents.blue);

    return AppCard(
      onTap: onTap,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          AccentIconChip(
            icon: isService ? Icons.build_outlined : Icons.inventory_2_outlined,
            accent: accent,
            size: 46,
          ),
          const SizedBox(width: ArtizenSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  item.designation,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: item.active
                        ? ArtizenColors.textPrimary
                        : ArtizenColors.textSecondary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${CurrencyFormatter.format(item.unitPriceHt)} HT / ${item.unit}'
                  '${item.active ? '' : ' · désactivé'}',
                  style: item.active
                      ? const TextStyle(
                          fontSize: 14,
                          color: ArtizenColors.textSecondary,
                        )
                      : TextStyle(fontSize: 14, color: theme.colorScheme.outline),
                ),
              ],
            ),
          ),
          // "Ma caisse à outils": the toolbox the artisan fills with the
          // articles he reaches for again and again — filled + gold when in.
          IconButton(
            icon: Icon(
              item.isFavorite
                  ? Icons.home_repair_service
                  : Icons.home_repair_service_outlined,
              color: item.isFavorite ? ArtizenColors.gold : null,
            ),
            tooltip: item.isFavorite
                ? 'Retirer de ma caisse à outils'
                : 'Ajouter à ma caisse à outils',
            onPressed: onToggleFavorite,
          ),
          // A deactivated item keeps a way back where the way out was: a
          // one-way "deactivate" would strand it greyed-out forever.
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
    );
  }
}
