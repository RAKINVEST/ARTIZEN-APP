import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/async_value_view.dart';
import 'catalog_providers.dart';

/// "Quel est votre métier ?" — picking a trade installs a ready-made catalog
/// (categories + articles + units + VAT) so the artisan can quote straight
/// away, then personalize prices and references.
class TradePickerScreen extends ConsumerStatefulWidget {
  const TradePickerScreen({super.key});

  @override
  ConsumerState<TradePickerScreen> createState() => _TradePickerScreenState();
}

class _TradePickerScreenState extends ConsumerState<TradePickerScreen> {
  String? _installingSlug;

  Future<void> _install(String slug, String name) async {
    setState(() => _installingSlug = slug);
    try {
      final result = await ref.read(categoriesNotifierProvider.notifier).installTrade(slug);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Catalogue $name installé : '
            '${result.categoriesCreated} catégories, ${result.itemsCreated} articles.',
          ),
        ),
      );
      if (context.canPop()) context.pop();
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Échec de l'installation : $error")),
        );
      }
    } finally {
      if (mounted) setState(() => _installingSlug = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final trades = ref.watch(tradesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Quel est votre métier ?')),
      body: AsyncValueView(
        value: trades,
        onRetry: () => ref.invalidate(tradesProvider),
        builder: (context, list) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              'Choisissez votre métier : Artizen installe automatiquement les '
              'catégories, les articles, les unités et la TVA correspondantes. '
              'Vous n’aurez plus qu’à saisir vos prix.',
              style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
            ),
            const SizedBox(height: 16),
            for (final trade in list)
              Card(
                child: ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.handyman_outlined)),
                  title: Text(trade.name, style: theme.textTheme.titleMedium),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(trade.description),
                      const SizedBox(height: 2),
                      Text(
                        '${trade.categoryCount} catégories · ${trade.itemCount} articles',
                        style: theme.textTheme.labelSmall
                            ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                  isThreeLine: true,
                  trailing: _installingSlug == trade.slug
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.download_outlined),
                  onTap: _installingSlug != null ? null : () => _install(trade.slug, trade.name),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
