import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/currency.dart';
import '../../../core/utils/decimal_input.dart';
import '../../../core/widgets/app_components.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/error_state.dart';
import '../../../core/widgets/loading_state.dart';
import '../../../shared/widgets/debounced_search_field.dart';
import '../../catalog/data/catalog_models.dart';
import '../../catalog/presentation/catalog_providers.dart';
import '../../clients/data/client_model.dart';
import '../../clients/presentation/clients_providers.dart';
import '../data/quote_models.dart';
import 'quotes_providers.dart';

/// **DÉPRÉCIÉ (V1).** Remplacé comme flux principal par le wizard guidé
/// (`features/quote_wizard`, route `/assistant`). Conservé et encore atteint
/// **uniquement** par le copilote IA (`quote_assistant_screen`), qui pré-remplit
/// `quoteDraftLinesProvider` avant de pousser cet écran ; à retirer en V1.1 une
/// fois le pont IA → wizard construit. Ne plus câbler de nouveau lien ici.
///
/// Builds a quote: pick a client, add (catalog item, quantity) lines, then
/// submit. No amount is shown or computed while drafting — see
/// `QuoteDraftLine` — the totals only appear once the backend has computed
/// them, on the resulting quote's detail screen.
class QuoteFormScreen extends ConsumerStatefulWidget {
  const QuoteFormScreen({super.key});

  @override
  ConsumerState<QuoteFormScreen> createState() => _QuoteFormScreenState();
}

class _QuoteFormScreenState extends ConsumerState<QuoteFormScreen> {
  /// Anti-double-submit: a double-tap on "Créer le devis" used to fire two
  /// `POST /quotes`, creating two quotes. This guard, plus the button's
  /// loading state, makes the second tap a no-op.
  bool _saving = false;

  @override
  Widget build(BuildContext context) {
    final selectedClient = ref.watch(quoteDraftClientProvider);
    final draftLines = ref.watch(quoteDraftLinesProvider);
    final canSubmit =
        selectedClient != null && draftLines.isNotEmpty && !_saving;

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
              title: Text(
                selectedClient?.displayName ?? 'Sélectionner un client',
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: _saving ? null : () => _pickClient(context),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Lignes du devis',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              TextButton.icon(
                onPressed: _saving ? null : () => _addLine(context),
                icon: const Icon(Icons.add),
                label: const Text('Ajouter un article'),
              ),
            ],
          ),
          if (draftLines.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Text(
                'Aucune ligne. Ajoutez au moins un article du catalogue.',
              ),
            )
          else
            for (var i = 0; i < draftLines.length; i++)
              Card(
                child: ListTile(
                  title: Text(draftLines[i].item.designation),
                  subtitle: Text(
                    '${CurrencyFormatter.formatQuantity(draftLines[i].quantity)} '
                    '${draftLines[i].item.unit} · '
                    '${CurrencyFormatter.format(draftLines[i].item.unitPriceHt)} HT',
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: _saving
                        ? null
                        : () => ref
                              .read(quoteDraftLinesProvider.notifier)
                              .removeLineAt(i),
                  ),
                ),
              ),
          const SizedBox(height: 24),
          AppPrimaryButton(
            label: 'Créer le devis',
            icon: Icons.check_circle_outline,
            loading: _saving,
            onPressed: canSubmit
                ? () => _submit(selectedClient, draftLines)
                : null,
          ),
        ],
      ),
    );
  }

  Future<void> _pickClient(BuildContext context) async {
    final client = await showModalBottomSheet<Client>(
      context: context,
      isScrollControlled: true,
      builder: (context) => const _ClientPickerSheet(),
    );
    if (client != null) {
      ref.read(quoteDraftClientProvider.notifier).state = client;
    }
  }

  Future<void> _addLine(BuildContext context) async {
    final line = await showModalBottomSheet<QuoteDraftLine>(
      context: context,
      isScrollControlled: true,
      builder: (context) => const _ItemPickerSheet(),
    );
    if (line != null) {
      ref
          .read(quoteDraftLinesProvider.notifier)
          .addLine(line.item, line.quantity);
    }
  }

  Future<void> _submit(Client client, List<QuoteDraftLine> lines) async {
    if (_saving) return;
    setState(() => _saving = true);
    try {
      final quote = await ref
          .read(quotesNotifierProvider.notifier)
          .createQuote(
            clientId: client.id,
            // Quantities are already comma-normalized at the picker (see
            // `_ItemPickerSheet`), so the payload is backend-ready here.
            lines: lines
                .map(
                  (line) => QuoteLineInput(
                    catalogItemId: line.item.id,
                    quantity: line.quantity,
                  ),
                )
                .toList(),
          );
      ref.read(quoteDraftLinesProvider.notifier).clear();
      ref.read(quoteDraftClientProvider.notifier).state = null;
      if (mounted) {
        context.pushReplacement('/quotes/${quote.id}');
      }
    } catch (error) {
      if (mounted) {
        setState(() => _saving = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Échec de la création du devis : $error')),
        );
      }
    }
  }
}

/// Client picker with server search — an artisan with hundreds of clients
/// finds one by typing, instead of scrolling a truncated first page.
class _ClientPickerSheet extends ConsumerStatefulWidget {
  const _ClientPickerSheet();

  @override
  ConsumerState<_ClientPickerSheet> createState() => _ClientPickerSheetState();
}

class _ClientPickerSheetState extends ConsumerState<_ClientPickerSheet> {
  @override
  Widget build(BuildContext context) {
    final clients = ref.watch(clientSearchProvider);
    final notifier = ref.read(clientSearchProvider.notifier);

    return SafeArea(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        child: Column(
          children: [
            const SizedBox(height: 8),
            Text(
              'Choisir un client',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            DebouncedSearchField(
              hintText: 'Rechercher un client (nom, société…)',
              isLoading: clients.isLoading,
              onChanged: notifier.search,
            ),
            Expanded(
              child: clients.when(
                skipLoadingOnReload: true,
                skipLoadingOnRefresh: true,
                data: (items) => items.isEmpty
                    ? const EmptyState(
                        message:
                            'Aucun client ne correspond.\nAffinez votre recherche '
                            'ou créez le client depuis l\'onglet Clients.',
                        icon: Icons.person_search_outlined,
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final client = items[index];
                          return ListTile(
                            leading: const Icon(Icons.person_outline),
                            title: Text(client.displayName),
                            subtitle: _clientSubtitle(client),
                            onTap: () => Navigator.of(context).pop(client),
                          );
                        },
                      ),
                loading: () => const LoadingState(),
                error: (error, _) => ErrorState(
                  error: error,
                  onRetry: () => ref.invalidate(clientSearchProvider),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget? _clientSubtitle(Client client) {
    final parts = [
      client.phone,
      client.email,
    ].whereType<String>().where((s) => s.isNotEmpty);
    return parts.isEmpty ? null : Text(parts.join(' · '));
  }
}

/// Item picker with server search — active items only (deactivated ones are
/// never offered on a new quote), reachable past the first page by typing.
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
    final items = ref.watch(catalogItemSearchProvider);
    final notifier = ref.read(catalogItemSearchProvider.notifier);

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          child: Column(
            children: [
              const SizedBox(height: 8),
              Text(
                'Choisir un article',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              DebouncedSearchField(
                hintText: 'Rechercher un article (désignation, code)',
                isLoading: items.isLoading,
                onChanged: notifier.search,
              ),
              Expanded(
                child: items.when(
                  skipLoadingOnReload: true,
                  skipLoadingOnRefresh: true,
                  data: (list) => list.isEmpty
                      ? const EmptyState(
                          message:
                              'Aucun article actif ne correspond.\nAffinez votre '
                              'recherche ou ajoutez l\'article au catalogue.',
                          icon: Icons.search_off,
                        )
                      : ListView.builder(
                          itemCount: list.length,
                          itemBuilder: (context, index) {
                            final item = list[index];
                            final isSelected = _selected?.id == item.id;
                            return ListTile(
                              leading: Icon(
                                isSelected
                                    ? Icons.radio_button_checked
                                    : Icons.radio_button_unchecked,
                              ),
                              title: Text(item.designation),
                              subtitle: Text(
                                '${CurrencyFormatter.format(item.unitPriceHt)} HT / ${item.unit}',
                              ),
                              selected: isSelected,
                              onTap: () => setState(() => _selected = item),
                            );
                          },
                        ),
                  loading: () => const LoadingState(),
                  error: (error, _) => ErrorState(
                    error: error,
                    onRetry: () => ref.invalidate(catalogItemSearchProvider),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _quantityController,
                        decoration: InputDecoration(
                          labelText: 'Quantité',
                          errorText: _quantityError,
                        ),
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        onChanged: (_) {
                          if (_quantityError != null) {
                            setState(() => _quantityError = null);
                          }
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
