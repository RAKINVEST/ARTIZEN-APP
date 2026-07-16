import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/currency.dart';
import '../../../core/widgets/async_value_view.dart';
import 'quotes_providers.dart';

class QuotesListScreen extends ConsumerWidget {
  const QuotesListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quotes = ref.watch(quotesNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Devis'),
        actions: [
          IconButton(
            icon: const Icon(Icons.auto_awesome),
            tooltip: 'Copilote IA',
            onPressed: () => context.push('/quote-assistant'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/quotes/new'),
        child: const Icon(Icons.add),
      ),
      body: AsyncListView(
        value: quotes,
        emptyMessage: 'Aucun devis pour le moment.\nCréez votre premier devis avec le bouton +.',
        emptyIcon: Icons.description_outlined,
        onRetry: () => ref.read(quotesNotifierProvider.notifier).refresh(),
        itemBuilder: (context, items) => RefreshIndicator(
          onRefresh: () => ref.read(quotesNotifierProvider.notifier).refresh(),
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 8, bottom: 88),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final quote = items[index];
              return Card(
                child: ListTile(
                  onTap: () => context.push('/quotes/${quote.id}'),
                  leading: const CircleAvatar(child: Icon(Icons.description_outlined)),
                  title: Text('Devis · ${quote.lines.length} ligne(s)'),
                  subtitle: Text('Total TTC : ${CurrencyFormatter.format(quote.totalTtc)}'),
                  trailing: const Icon(Icons.chevron_right),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
