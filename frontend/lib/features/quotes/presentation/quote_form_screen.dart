import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/currency.dart';
import '../../../core/widgets/async_value_view.dart';
import '../../catalog/data/catalog_models.dart';
import '../../catalog/presentation/catalog_providers.dart';
import '../../clients/data/client_model.dart';
import '../../clients/presentation/clients_providers.dart';
import '../data/quote_models.dart';
import '../domain/quote_preview_calculator.dart';
// `quotes_providers` re-exports `QuoteDraftLine`, so it's imported here too.
import 'quotes_providers.dart';

/// Builds a quote: pick a client, add catalog-item lines, adjust each
/// line's quantity, then submit.
///
/// Unlike the first version, the draft now shows a **live preview** of
/// every amount — each line's total and the running quote total
/// (HT / TVA / TTC) — recomputed on every quantity change via
/// [QuotePreviewCalculator]. The preview mirrors the backend's rules
/// exactly, but the created quote's persisted amounts still come from the
/// backend response (see `quote_detail_screen.dart`).
class QuoteFormScreen extends ConsumerWidget {
  const QuoteFormScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedClient = ref.watch(quoteDraftClientProvider);
    final draftLines = ref.watch(quoteDraftLinesProvider);
    final theme = Theme.of(context);

    final canSubmit = selectedClient != null &&
        draftLines.isNotEmpty &&
        draftLines.every((line) => _isValidQuantity(line.quantity));

    return Scaffold(
      appBar: AppBar(title: const Text('Nouveau devis')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Client', style: theme.textTheme.titleMedium),
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
              Text('Lignes du devis', style: theme.textTheme.titleMedium),
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
              _DraftLineCard(
                key: ValueKey('line-${draftLines[i].item.id}-$i'),
                line: draftLines[i],
                onQuantityChanged: (value) =>
                    ref.read(quoteDraftLinesProvider.notifier).updateQuantityAt(i, value),
                onRemove: () => ref.read(quoteDraftLinesProvider.notifier).removeLineAt(i),
              ),
          if (draftLines.isNotEmpty) ...[
            const SizedBox(height: 8),
            _DraftTotalsCard(lines: draftLines),
          ],
          const SizedBox(height: 24),
          FilledButton(
            onPressed:
                canSubmit ? () => _submit(context, ref, selectedClient, draftLines) : null,
            child: const Text('Créer le devis'),
          ),
        ],
      ),
    );
  }

  static bool _isValidQuantity(String raw) {
    final hundredths = QuotePreviewCalculator.parseHundredths(raw);
    // Backend requires quantity > 0 (QuoteLineCreate: Field(gt=0)).
    return hundredths != null && hundredths > 0;
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
    final item = await showModalBottomSheet<CatalogItem>(
      context: context,
      isScrollControlled: true,
      builder: (context) => const _ItemPickerSheet(),
    );
    if (item != null) {
      // Added with quantity 1 and edited inline afterwards — the quantity
      // is no longer captured behind a keyboard inside the picker (which
      // previously hid the confirm button, so nothing got added at all).
      ref.read(quoteDraftLinesProvider.notifier).addLine(item, '1');
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
                .map((line) => QuoteLineInput(
                      catalogItemId: line.item.id,
                      quantity: line.quantity.trim().replaceAll(',', '.'),
                    ))
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

/// One editable draft line: item designation + unit price, an inline
/// quantity field, and the live line total.
class _DraftLineCard extends StatelessWidget {
  const _DraftLineCard({
    required this.line,
    required this.onQuantityChanged,
    required this.onRemove,
    super.key,
  });

  final QuoteDraftLine line;
  final ValueChanged<String> onQuantityChanged;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final preview = QuotePreviewCalculator.lineForItem(line.item, line.quantity);
    final lineTotal = preview == null
        ? '—'
        : CurrencyFormatter.format(
            QuotePreviewCalculator.centsToAmountString(preview.totalTtcCents),
          );

    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(line.item.designation, style: theme.textTheme.bodyLarge),
                      const SizedBox(height: 2),
                      Text(
                        '${CurrencyFormatter.format(line.item.unitPriceHt)} HT / ${line.item.unit}'
                        ' · TVA ${line.item.vatRate} %',
                        style:
                            theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.outline),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  tooltip: 'Retirer',
                  onPressed: onRemove,
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                SizedBox(
                  width: 110,
                  child: TextFormField(
                    initialValue: line.quantity,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      isDense: true,
                      labelText: 'Quantité',
                      suffixText: line.item.unit,
                    ),
                    onChanged: onQuantityChanged,
                  ),
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Total TTC', style: theme.textTheme.labelSmall),
                    Text(
                      lineTotal,
                      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Live preview of the quote totals, recomputed from the current draft
/// lines on every rebuild.
class _DraftTotalsCard extends StatelessWidget {
  const _DraftTotalsCard({required this.lines});

  final List<QuoteDraftLine> lines;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final totals = QuotePreviewCalculator.totals(lines);

    String fmt(int cents) =>
        CurrencyFormatter.format(QuotePreviewCalculator.centsToAmountString(cents));

    return Card(
      color: theme.colorScheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _TotalRow(label: 'Total HT', amount: fmt(totals.totalHtCents)),
            _TotalRow(label: 'TVA', amount: fmt(totals.totalVatCents)),
            const Divider(),
            _TotalRow(
              label: 'Total TTC',
              amount: fmt(totals.totalTtcCents),
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class _TotalRow extends StatelessWidget {
  const _TotalRow({required this.label, required this.amount, this.style});

  final String label;
  final String amount;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style),
          Text(amount, style: style),
        ],
      ),
    );
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

/// Item picker: tapping an item adds it to the quote immediately (quantity
/// is set afterwards, inline in the form). A search field on top makes
/// finding an article in a large catalog a matter of seconds.
class _ItemPickerSheet extends ConsumerStatefulWidget {
  const _ItemPickerSheet();

  @override
  ConsumerState<_ItemPickerSheet> createState() => _ItemPickerSheetState();
}

class _ItemPickerSheetState extends ConsumerState<_ItemPickerSheet> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final items = ref.watch(itemsNotifierProvider);

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.75,
          child: Column(
            children: [
              const SizedBox(height: 12),
              Text('Choisir un article', style: Theme.of(context).textTheme.titleMedium),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
                child: TextField(
                  autofocus: true,
                  decoration: const InputDecoration(
                    hintText: 'Rechercher (désignation, code)',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                  onChanged: (value) => setState(() => _query = value),
                ),
              ),
              Expanded(
                child: AsyncValueView(
                  value: items,
                  builder: (context, list) {
                    final activeItems = list.where((item) => item.active).toList();
                    final filtered = _filter(activeItems);
                    if (filtered.isEmpty) {
                      return const Center(child: Text('Aucun article ne correspond.'));
                    }
                    return ListView.builder(
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        final item = filtered[index];
                        return ListTile(
                          leading: Icon(
                            item.itemType == ItemType.service
                                ? Icons.build_outlined
                                : Icons.inventory_2_outlined,
                          ),
                          title: Text(item.designation),
                          subtitle: Text('${item.unitPriceHt} € HT / ${item.unit}'),
                          trailing: const Icon(Icons.add),
                          onTap: () => Navigator.of(context).pop(item),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<CatalogItem> _filter(List<CatalogItem> items) {
    final query = _query.trim().toLowerCase();
    if (query.isEmpty) return items;
    return items.where((item) {
      return item.designation.toLowerCase().contains(query) ||
          (item.code?.toLowerCase().contains(query) ?? false);
    }).toList();
  }
}
