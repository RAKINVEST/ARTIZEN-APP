import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/decimal_input.dart';
import '../../../core/widgets/async_value_view.dart';
import '../../catalog/data/catalog_models.dart';
import '../../catalog/presentation/catalog_providers.dart';
import '../../clients/data/client_model.dart';
import '../../clients/presentation/clients_providers.dart';
import '../data/quote_models.dart';
import 'quotes_providers.dart';

/// Builds a quote: pick a client, add (catalog item, quantity) lines, then
/// submit. No amount is shown or computed while drafting — see
/// `QuoteDraftLine` — the totals only appear once the backend has computed
/// them, on the resulting quote's detail screen.
class QuoteFormScreen extends ConsumerWidget {
  const QuoteFormScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedClient = ref.watch(quoteDraftClientProvider);
    final draftLines = ref.watch(quoteDraftLinesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Nouveau devis')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Client', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Card(
            child: ListTile(
              leading: const Icon(Icons.person_outline),
              title: Text(selectedClient?.displayName ?? 'Sélectionner un client'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _pickClient(context, ref),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Lignes du devis', style: Theme.of(context).textTheme.titleMedium),
              TextButton.icon(
                onPressed: () => _addLine(context, ref),
                icon: const Icon(Icons.add),
                label: const Text('Ajouter un article'),
              ),
            ],
          ),
          if (draftLines.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Text('Aucune ligne. Ajoutez au moins un article du catalogue.'),
            )
          else
            for (var i = 0; i < draftLines.length; i++)
              Card(
                child: ListTile(
                  title: Text(draftLines[i].item.designation),
                  subtitle: Text('${draftLines[i].quantity} ${draftLines[i].item.unit}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => ref.read(quoteDraftLinesProvider.notifier).removeLineAt(i),
                  ),
                ),
              ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: (selectedClient == null || draftLines.isEmpty)
                ? null
                : () => _submit(context, ref, selectedClient, draftLines),
            child: const Text('Créer le devis'),
          ),
        ],
      ),
    );
  }

  Future<void> _pickClient(BuildContext context, WidgetRef ref) async {
    final client = await showModalBottomSheet<Client>(
      context: context,
      isScrollControlled: true,
      builder: (context) => const _ClientPickerSheet(),
    );
    if (client != null) {
      ref.read(quoteDraftClientProvider.notifier).state = client;
    }
  }

  Future<void> _addLine(BuildContext context, WidgetRef ref) async {
    final line = await showModalBottomSheet<QuoteDraftLine>(
      context: context,
      isScrollControlled: true,
      builder: (context) => const _ItemPickerSheet(),
    );
    if (line != null) {
      ref.read(quoteDraftLinesProvider.notifier).addLine(line.item, line.quantity);
    }
  }

  Future<void> _submit(
    BuildContext context,
    WidgetRef ref,
    Client client,
    List<QuoteDraftLine> lines,
  ) async {
    try {
      final quote = await ref.read(quotesNotifierProvider.notifier).createQuote(
            clientId: client.id,
            lines: lines
                .map((line) => QuoteLineInput(catalogItemId: line.item.id, quantity: line.quantity))
                .toList(),
          );
      ref.read(quoteDraftLinesProvider.notifier).clear();
      ref.read(quoteDraftClientProvider.notifier).state = null;
      if (context.mounted) {
        context.pushReplacement('/quotes/${quote.id}');
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Échec de la création du devis : $error')),
        );
      }
    }
  }
}

class _ClientPickerSheet extends ConsumerWidget {
  const _ClientPickerSheet();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clients = ref.watch(clientsNotifierProvider);
    return SafeArea(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        child: AsyncValueView(
          value: clients,
          onRetry: () => ref.read(clientsNotifierProvider.notifier).refresh(),
          builder: (context, items) => ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 16),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final client = items[index];
              return ListTile(
                title: Text(client.displayName),
                onTap: () => Navigator.of(context).pop(client),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _ItemPickerSheet extends ConsumerStatefulWidget {
  const _ItemPickerSheet();

  @override
  ConsumerState<_ItemPickerSheet> createState() => _ItemPickerSheetState();
}

class _ItemPickerSheetState extends ConsumerState<_ItemPickerSheet> {
  CatalogItem? _selected;
  final _quantityController = TextEditingController(text: '1');
  String? _quantityError;

  /// Validates and normalizes here rather than letting the raw text reach
  /// the draft: an invalid quantity used to travel all the way to
  /// `POST /quotes`, where it failed as a 422 on the *whole* quote —
  /// after the artisan had composed every line, and without saying which
  /// one was wrong.
  void _addSelectedItem() {
    final error = DecimalInput.validate(
      _quantityController.text,
      exclusiveMin: true,
    );
    if (error != null) {
      setState(() => _quantityError = error);
      return;
    }
    Navigator.of(context).pop(
      QuoteDraftLine(
        item: _selected!,
        quantity: DecimalInput.normalize(_quantityController.text),
      ),
    );
  }

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = ref.watch(itemsNotifierProvider);

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          child: Column(
            children: [
              Expanded(
                child: AsyncValueView(
                  value: items,
                  onRetry: () => ref.read(itemsNotifierProvider.notifier).refresh(),
                  builder: (context, list) {
                    final activeItems = list.where((item) => item.active).toList();
                    return ListView.builder(
                      itemCount: activeItems.length,
                      itemBuilder: (context, index) {
                        final item = activeItems[index];
                        final isSelected = _selected?.id == item.id;
                        return ListTile(
                          leading: Icon(
                            isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                          ),
                          title: Text(item.designation),
                          subtitle: Text('${item.unitPriceHt} € HT / ${item.unit}'),
                          selected: isSelected,
                          onTap: () => setState(() => _selected = item),
                        );
                      },
                    );
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _quantityController,
                      decoration: InputDecoration(
                        labelText: 'Quantité',
                        errorText: _quantityError,
                      ),
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      onChanged: (_) {
                        if (_quantityError != null) setState(() => _quantityError = null);
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  FilledButton(
                    onPressed: _selected == null ? null : _addSelectedItem,
                    child: const Text('Ajouter'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
