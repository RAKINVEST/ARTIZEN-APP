import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/utils/currency.dart';
import '../../../core/utils/decimal_input.dart';
import '../../../core/widgets/app_components.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/error_state.dart';
import '../../../core/widgets/loading_state.dart';
import '../../../shared/providers/current_company_provider.dart';
import '../../../shared/widgets/debounced_search_field.dart';
import '../../catalog/data/catalog_models.dart';
import '../../catalog/data/catalog_repository_impl.dart';
import '../../catalog/presentation/catalog_providers.dart';
import '../../quote_wizard/presentation/quote_draft_provider.dart';
import '../data/quote_suggestion_models.dart';
import 'quote_assistant_providers.dart';

/// "Copilote IA" (Étape 9, anciennement "Assistant IA") : description
/// libre -> lignes de catalogue suggérées -> (modifiables, complétables
/// manuellement) -> remise au **wizard guidé** de création de devis.
///
/// Cet écran ne crée jamais de devis et ne calcule jamais de montant :
/// il ne fait qu'appeler `POST /quote-assistant/suggest` pour obtenir
/// une *proposition*. "Créer le devis" **amorce le brouillon du wizard**
/// (`seedWizardFromCatalogItems`) avec les lignes acceptées puis navigue
/// vers `/assistant` : l'artisan choisit le client, vérifie, puis crée —
/// la création reste `POST /quotes`, via le pipeline existant. Le copilote
/// alimente le même brouillon que le wizard ; il n'en ouvre pas un second.
class QuoteAssistantScreen extends ConsumerStatefulWidget {
  const QuoteAssistantScreen({super.key});

  @override
  ConsumerState<QuoteAssistantScreen> createState() => _QuoteAssistantScreenState();
}

class _QuoteAssistantScreenState extends ConsumerState<QuoteAssistantScreen> {
  final _descriptionController = TextEditingController();
  bool _creatingQuote = false;

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final suggestionState = ref.watch(quoteAssistantNotifierProvider);
    final acceptedItems = ref.watch(acceptedSuggestionItemsProvider);
    final isAnalyzing = suggestionState.isLoading;

    return Scaffold(
      appBar: AppBar(title: const Text('Copilote IA')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Décrivez les travaux à réaliser', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          TextField(
            controller: _descriptionController,
            maxLines: 4,
            enabled: !isAnalyzing,
            decoration: const InputDecoration(
              hintText: "Ex : Remplacement d'un chauffe-eau Atlantic 200 litres avec groupe de "
                  "sécurité et deux heures de main-d'œuvre.",
            ),
          ),
          const SizedBox(height: 12),
          AppPrimaryButton(
            label: isAnalyzing ? 'Analyse en cours...' : 'Analyser',
            icon: Icons.auto_awesome,
            loading: isAnalyzing,
            onPressed: _analyze,
          ),
          const SizedBox(height: 24),
          suggestionState.when(
            data: (suggestion) => suggestion == null
                ? const SizedBox.shrink()
                : _SuggestionResult(
                    suggestion: suggestion,
                    acceptedItems: acceptedItems,
                    creatingQuote: _creatingQuote,
                    onRemove: (index) =>
                        ref.read(acceptedSuggestionItemsProvider.notifier).removeAt(index),
                    onQuantityChanged: (index, value) => ref
                        .read(acceptedSuggestionItemsProvider.notifier)
                        .updateQuantity(index, value),
                    onAddItem: _addManualItem,
                    onCreateQuote: _createQuote,
                  ),
            loading: () => const Padding(
              padding: EdgeInsets.symmetric(vertical: 32),
              child: LoadingState(),
            ),
            error: (error, _) => ErrorState(error: error, onRetry: _analyze),
          ),
        ],
      ),
    );
  }

  Future<void> _analyze() async {
    final description = _descriptionController.text.trim();
    if (description.isEmpty) return;
    await ref.read(quoteAssistantNotifierProvider.notifier).analyze(description);
  }

  /// Étape 9 : "ajout manuel d'un article" — lets the user complete the
  /// AI's proposal with an article it missed, just like picking one in the
  /// wizard's "Catalogue" step, without waiting for another analysis.
  Future<void> _addManualItem() async {
    final line = await showModalBottomSheet<_ManualItemSelection>(
      context: context,
      isScrollControlled: true,
      builder: (context) => const _ManualItemPickerSheet(),
    );
    if (line == null) return;

    ref.read(acceptedSuggestionItemsProvider.notifier).addItem(
          QuoteSuggestionItem(
            catalogItemId: line.item.id,
            designation: line.item.designation,
            quantity: line.quantity,
            reason: 'Ajouté manuellement',
          ),
        );
  }

  Future<void> _createQuote() async {
    final accepted = ref.read(acceptedSuggestionItemsProvider);
    if (accepted.isEmpty) return;

    setState(() => _creatingQuote = true);
    try {
      final companyId = await ref.read(currentCompanyIdProvider.future);
      final activeItems = await ref
          .read(catalogRepositoryProvider)
          .listItems(companyId: companyId, activeOnly: true);
      final itemsById = {for (final item in activeItems) item.id: item};

      // Build the wizard draft from the accepted suggestions. Quantities are
      // inferred by the AI (Invariant #1's one numeric value) and carried as
      // strings; parse to the num the draft holds, defaulting to 1 if a
      // suggestion ever arrives unparseable.
      final draftLines = <({CatalogItem item, num quantity})>[];
      for (final suggested in accepted) {
        final item = itemsById[suggested.catalogItemId];
        if (item != null) {
          draftLines.add(
            (item: item, quantity: num.tryParse(suggested.quantity) ?? 1),
          );
        }
      }
      seedWizardFromCatalogItems(ref, draftLines);

      ref.read(quoteAssistantNotifierProvider.notifier).clear();
      _descriptionController.clear();

      // The copilote has filled the brouillon; the guided wizard takes over
      // (choisir le client → vérifier → créer). Same draft, one create path.
      if (mounted) context.push('/assistant');
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Échec de la préparation du devis : $error')),
        );
      }
    } finally {
      if (mounted) setState(() => _creatingQuote = false);
    }
  }
}

/// Étape 9 : distinguishes "faible confiance" / "forte confiance" as
/// separate, visually distinct UX states rather than a single plain
/// percentage — the brief explicitly asks for both to be recognizable
/// at a glance.
enum _ConfidenceLevel { low, medium, high }

_ConfidenceLevel _confidenceLevelOf(double confidence) {
  if (confidence >= 0.7) return _ConfidenceLevel.high;
  if (confidence >= 0.4) return _ConfidenceLevel.medium;
  return _ConfidenceLevel.low;
}

class _SuggestionResult extends StatelessWidget {
  const _SuggestionResult({
    required this.suggestion,
    required this.acceptedItems,
    required this.creatingQuote,
    required this.onRemove,
    required this.onQuantityChanged,
    required this.onAddItem,
    required this.onCreateQuote,
  });

  final QuoteSuggestion suggestion;
  final List<QuoteSuggestionItem> acceptedItems;
  final bool creatingQuote;
  final void Function(int index) onRemove;
  final void Function(int index, String value) onQuantityChanged;
  final VoidCallback onAddItem;
  final VoidCallback onCreateQuote;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final confidencePercent = (suggestion.confidence * 100).round();
    final level = _confidenceLevelOf(suggestion.confidence);
    // ARTIZEN status tokens, not M3 seed containers: high = accepted green,
    // medium = pending amber, low = refused red — the same palette the status
    // pills use, so "confiance" reads on the same colour language.
    final (Color background, Color foreground, IconData icon, String label) = switch (level) {
      _ConfidenceLevel.high => (
          ArtizenColors.statusAcceptedBg,
          ArtizenColors.statusAcceptedFg,
          Icons.verified_outlined,
          'Confiance forte',
        ),
      _ConfidenceLevel.medium => (
          ArtizenColors.statusPendingBg,
          ArtizenColors.statusPendingFg,
          Icons.info_outline,
          'Confiance modérée',
        ),
      _ConfidenceLevel.low => (
          ArtizenColors.statusRefusedBg,
          ArtizenColors.statusRefusedFg,
          Icons.warning_amber_outlined,
          'Confiance faible — vérifiez les suggestions',
        ),
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(ArtizenRadii.card),
          ),
          child: Row(
            children: [
              Icon(icon, color: foreground),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '$label ($confidencePercent %)',
                  style: theme.textTheme.titleSmall?.copyWith(color: foreground),
                ),
              ),
            ],
          ),
        ),
        if (suggestion.comment.isNotEmpty) ...[
          const SizedBox(height: 8),
          Text(suggestion.comment, style: theme.textTheme.bodySmall),
        ],
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Articles proposés', style: theme.textTheme.titleMedium),
            TextButton.icon(
              onPressed: onAddItem,
              icon: const Icon(Icons.add),
              label: const Text('Ajouter un article'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (acceptedItems.isEmpty)
          const EmptyState(
            message: 'Aucun article du catalogue ne correspond à cette description.\n'
                "Essayez de la reformuler, ou ajoutez un article manuellement.",
            icon: Icons.search_off,
          )
        else
          for (var i = 0; i < acceptedItems.length; i++)
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(acceptedItems[i].designation, style: theme.textTheme.bodyLarge),
                          if (acceptedItems[i].reason.isNotEmpty)
                            Text(
                              acceptedItems[i].reason,
                              style: theme.textTheme.bodySmall
                                  ?.copyWith(color: theme.colorScheme.outline),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 72,
                      child: TextFormField(
                        key: ValueKey('quantity-$i-${acceptedItems[i].catalogItemId}'),
                        initialValue: acceptedItems[i].quantity,
                        textAlign: TextAlign.center,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        decoration: const InputDecoration(isDense: true, labelText: 'Qté'),
                        onChanged: (value) => onQuantityChanged(i, value),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => onRemove(i),
                    ),
                  ],
                ),
              ),
            ),
        const SizedBox(height: 16),
        AppPrimaryButton(
          label: creatingQuote ? 'Préparation...' : 'Créer le devis',
          icon: Icons.check_circle_outline,
          loading: creatingQuote,
          onPressed: acceptedItems.isEmpty ? null : onCreateQuote,
        ),
      ],
    );
  }
}

class _ManualItemSelection {
  const _ManualItemSelection({required this.item, required this.quantity});

  final CatalogItem item;
  final String quantity;
}

/// Picker for "ajout manuel d'un article" — deliberately its own small
/// widget rather than reusing the wizard's article picker: that one is a
/// step embedded in the wizard flow, not a standalone, exportable sheet,
/// and duplicating this little picker is simpler than making it shared
/// infrastructure for two callers.
class _ManualItemPickerSheet extends ConsumerStatefulWidget {
  const _ManualItemPickerSheet();

  @override
  ConsumerState<_ManualItemPickerSheet> createState() => _ManualItemPickerSheetState();
}

class _ManualItemPickerSheetState extends ConsumerState<_ManualItemPickerSheet> {
  CatalogItem? _selected;
  final _quantityController = TextEditingController(text: '1');
  String? _quantityError;

  /// The quantity guard: a comma or a third decimal must be caught on the
  /// field, not as a 422 on the finished quote.
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
      _ManualItemSelection(
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
    // Server search, active items only — like the wizard's article picker,
    // so a large catalogue stays reachable by typing.
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
              Text('Ajouter un article', style: Theme.of(context).textTheme.titleMedium),
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
                          message: 'Aucun article actif ne correspond.\nAffinez votre '
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
