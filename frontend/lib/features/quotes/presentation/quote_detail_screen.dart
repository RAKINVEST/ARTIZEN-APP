import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/currency.dart';
import '../../../core/widgets/async_value_view.dart';
import '../../clients/presentation/clients_providers.dart';
import 'quotes_providers.dart';
import 'widgets/quote_totals_card.dart';

class QuoteDetailScreen extends ConsumerWidget {
  const QuoteDetailScreen({required this.quoteId, super.key});

  final String quoteId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quoteAsync = ref.watch(quoteByIdProvider(quoteId));

    return Scaffold(
      appBar: AppBar(title: const Text('Devis')),
      body: AsyncValueView(
        value: quoteAsync,
        onRetry: () => ref.invalidate(quoteByIdProvider(quoteId)),
        builder: (context, quote) {
          final clientAsync = ref.watch(clientByIdProvider(quote.clientId));
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                child: ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.person_outline)),
                  title: clientAsync.when(
                    data: (client) => Text(client.displayName),
                    loading: () => const Text('Chargement du client...'),
                    error: (_, _) => const Text('Client indisponible'),
                  ),
                  subtitle: const Text('Client'),
                ),
              ),
              const SizedBox(height: 8),
              Card(
                child: Column(
                  children: [
                    for (final line in quote.lines)
                      ListTile(
                        title: Text(line.designation),
                        subtitle: Text('${line.quantity} ${line.unit} × ${CurrencyFormatter.format(line.unitPriceHt)} HT'),
                        trailing: Text(CurrencyFormatter.format(line.totalTtc)),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              QuoteTotalsCard(quote: quote),
            ],
          );
        },
      ),
    );
  }
}
