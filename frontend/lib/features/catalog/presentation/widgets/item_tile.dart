import 'package:flutter/material.dart';

import '../../../../core/utils/currency.dart';
import '../../data/catalog_models.dart';

class ItemTile extends StatelessWidget {
  const ItemTile({
    required this.item,
    required this.onTap,
    required this.onDeactivate,
    super.key,
  });

  final CatalogItem item;
  final VoidCallback onTap;
  final VoidCallback onDeactivate;

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
        trailing: item.active
            ? IconButton(
                icon: const Icon(Icons.visibility_off_outlined),
                tooltip: 'Désactiver',
                onPressed: onDeactivate,
              )
            : null,
      ),
    );
  }
}
