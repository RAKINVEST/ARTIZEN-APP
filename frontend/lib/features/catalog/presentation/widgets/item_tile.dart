import 'package:flutter/material.dart';

import '../../../../core/utils/currency.dart';
import '../../data/catalog_models.dart';

class ItemTile extends StatelessWidget {
  const ItemTile({
    required this.item,
    required this.onTap,
    required this.onDeactivate,
    required this.onReactivate,
    super.key,
  });

  final CatalogItem item;
  final VoidCallback onTap;
  final VoidCallback onDeactivate;
  final VoidCallback onReactivate;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          child: Icon(item.itemType == ItemType.service ? Icons.build_outlined : Icons.inventory_2_outlined),
        ),
        title: Text(item.designation),
        subtitle: Text(
          '${CurrencyFormatter.format(item.unitPriceHt)} HT / ${item.unit}'
          '${item.active ? '' : ' · désactivé'}',
          style: item.active ? null : TextStyle(color: theme.colorScheme.outline),
        ),
        // A deactivated item used to have no action at all here, which made
        // deactivating a one-way door: the item stayed listed, greyed out,
        // and unusable forever. The way back has to live where the way out
        // is.
        trailing: item.active
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
      ),
    );
  }
}
