import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/async_value_view.dart';
import '../data/catalog_models.dart';
import '../domain/labor_duration.dart';
import '../domain/sale_unit.dart';
import 'catalog_providers.dart';

/// Used for both creation (`itemId == null`) and editing.
class ItemFormScreen extends ConsumerWidget {
  const ItemFormScreen({this.itemId, super.key});

  final String? itemId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(categoriesNotifierProvider);
    final initial = itemId == null ? null : ref.watch(itemByIdProvider(itemId!));

    return Scaffold(
      appBar: AppBar(title: Text(itemId == null ? 'Nouvel article' : 'Modifier l\'article')),
      body: AsyncValueView(
        value: categoriesAsync,
        builder: (context, categories) {
          if (categories.isEmpty) {
            return const Padding(
              padding: EdgeInsets.all(24),
              child: Center(
                child: Text(
                  'Créez d\'abord au moins une catégorie (onglet "Catégories") '
                  'avant d\'ajouter un article.',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          return _ItemForm(itemId: itemId, initial: initial, categories: categories);
        },
      ),
    );
  }
}

class _ItemForm extends ConsumerStatefulWidget {
  const _ItemForm({required this.itemId, required this.initial, required this.categories});

  final String? itemId;
  final CatalogItem? initial;
  final List<CatalogCategory> categories;

  @override
  ConsumerState<_ItemForm> createState() => _ItemFormState();
}

class _ItemFormState extends ConsumerState<_ItemForm> {
  final _formKey = GlobalKey<FormState>();
  late final _designation = TextEditingController(text: widget.initial?.designation);
  late final _code = TextEditingController(text: widget.initial?.code);
  late final _description = TextEditingController(text: widget.initial?.description);
  late String _unitCode = widget.initial?.unit ?? kSaleUnits.first.code;

  /// The standard choices, plus the item's own unit when it isn't one of
  /// them (a custom value, or a legacy "ml") — editing an article must never
  /// silently change how it's counted.
  late final List<SaleUnit> _unitChoices = [
    ...kSaleUnits,
    if (widget.initial != null && !kSaleUnits.any((u) => u.code == widget.initial!.unit))
      SaleUnit(widget.initial!.unit, saleUnitLabel(widget.initial!.unit)),
  ];

  late final _unitPriceHt = TextEditingController(text: widget.initial?.unitPriceHt);
  late final _vatRate = TextEditingController(text: widget.initial?.vatRate ?? '20.00');

  // Labour time (point #6): stored as minutes on the backend, entered here
  // as a value + a unit (min / h / j).
  late final LaborDuration _initialDuration =
      LaborDuration.fromMinutes(widget.initial?.estimatedDurationMinutes);
  late final _duration = TextEditingController(text: _initialDuration.value);
  late DurationUnit _durationUnit = _initialDuration.unit;

  late String _categoryId = widget.initial?.categoryId ?? widget.categories.first.id;
  late ItemType _itemType = widget.initial?.itemType ?? ItemType.service;
  bool _saving = false;

  @override
  void dispose() {
    for (final controller in [_designation, _code, _description, _unitPriceHt, _vatRate, _duration]) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    final input = CatalogItemInput(
      categoryId: _categoryId,
      code: _code.text.trim().isEmpty ? null : _code.text.trim(),
      designation: _designation.text.trim(),
      description: _description.text.trim().isEmpty ? null : _description.text.trim(),
      itemType: _itemType,
      unit: _unitCode,
      unitPriceHt: _unitPriceHt.text.trim().replaceAll(',', '.'),
      vatRate: _vatRate.text.trim().replaceAll(',', '.'),
      estimatedDurationMinutes: LaborDuration.toMinutes(_duration.text, _durationUnit),
    );
    try {
      if (widget.itemId == null) {
        await ref.read(itemsNotifierProvider.notifier).createItem(input);
      } else {
        await ref.read(itemsNotifierProvider.notifier).updateItem(widget.itemId!, input);
      }
      if (mounted) context.pop();
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Échec de l\'enregistrement : $error')),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Short reminder of what an "article" is (point #1).
          Text(
            'Un article est un produit ou une prestation utilisé dans vos devis.',
            style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.outline),
          ),
          const SizedBox(height: 16),
          // Category comes first (point #1), with a searchable selector so a
          // long list stays usable, and an inline explanation of what a
          // category is.
          DropdownMenu<String>(
            initialSelection: _categoryId,
            expandedInsets: EdgeInsets.zero,
            enableFilter: true,
            requestFocusOnTap: true,
            leadingIcon: const Icon(Icons.category_outlined),
            label: const Text('Catégorie *'),
            helperText: 'Regroupe des articles de même famille.',
            menuHeight: 320,
            dropdownMenuEntries: [
              for (final category in widget.categories)
                DropdownMenuEntry(value: category.id, label: category.name),
            ],
            onSelected: (value) {
              if (value != null) setState(() => _categoryId = value);
            },
          ),
          const SizedBox(height: 16),
          SegmentedButton<ItemType>(
            segments: const [
              ButtonSegment(value: ItemType.service, label: Text('Prestation'), icon: Icon(Icons.build_outlined)),
              ButtonSegment(value: ItemType.product, label: Text('Fourniture'), icon: Icon(Icons.inventory_2_outlined)),
            ],
            selected: {_itemType},
            onSelectionChanged: (selection) => setState(() => _itemType = selection.first),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _designation,
            decoration: const InputDecoration(
              labelText: 'Désignation *',
              hintText: 'Pompe à chaleur Atlantic 8 kW',
            ),
            validator: (value) => (value == null || value.trim().isEmpty) ? 'Requis' : null,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _code,
            decoration: const InputDecoration(
              labelText: 'Code (optionnel)',
              hintText: 'Réf. interne, ex. PAC-ATL-8',
            ),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _description,
            decoration: const InputDecoration(
              labelText: 'Description',
              hintText: 'Fourniture et pose avec mise en service.',
            ),
            maxLines: 2,
          ),
          const SizedBox(height: 12),
          // "Comment se compte cet article ?" replaces the old free-text
          // "Unité" field: the artisan states how they sell the thing, in
          // plain French, instead of typing jargon like "ml".
          DropdownButtonFormField<String>(
            initialValue: _unitCode,
            decoration: const InputDecoration(
              labelText: 'Comment se compte cet article ? *',
              helperText: 'Apparaîtra sur le devis : 3 m × 12,00 €',
            ),
            items: [
              for (final unit in _unitChoices)
                DropdownMenuItem(value: unit.code, child: Text(unit.label)),
            ],
            onChanged: (value) {
              if (value != null) setState(() => _unitCode = value);
            },
          ),
          const SizedBox(height: 12),
          _durationField(),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _unitPriceHt,
                  decoration: const InputDecoration(
                    labelText: 'Prix unitaire HT *',
                    hintText: '1 500',
                    suffixText: '€',
                  ),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  validator: _validateDecimal,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextFormField(
                  controller: _vatRate,
                  decoration: const InputDecoration(labelText: 'TVA *', suffixText: '%'),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  validator: _validateDecimal,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: _saving ? null : _save,
            child: _saving
                ? const SizedBox(height: 16, width: 16, child: CircularProgressIndicator(strokeWidth: 2))
                : Text(widget.itemId == null ? 'Créer l\'article' : 'Enregistrer'),
          ),
        ],
      ),
    );
  }

  /// Labour time as an estimate: a number plus a unit picker (min / h / j),
  /// converted to minutes on save. "Durée estimée en minutes uniquement" was
  /// the point-#6 complaint.
  Widget _durationField() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: TextFormField(
            controller: _duration,
            decoration: const InputDecoration(
              labelText: 'Durée estimée',
              hintText: 'ex. 2',
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            validator: (value) {
              if (value == null || value.trim().isEmpty) return null; // optional
              return LaborDuration.toMinutes(value, _durationUnit) == null ? 'Invalide' : null;
            },
          ),
        ),
        const SizedBox(width: 8),
        DropdownButton<DurationUnit>(
          value: _durationUnit,
          onChanged: (unit) {
            if (unit != null) setState(() => _durationUnit = unit);
          },
          items: const [
            DropdownMenuItem(value: DurationUnit.minutes, child: Text('min')),
            DropdownMenuItem(value: DurationUnit.hours, child: Text('h')),
            DropdownMenuItem(value: DurationUnit.days, child: Text('j')),
          ],
        ),
      ],
    );
  }

  String? _validateDecimal(String? value) {
    if (value == null || value.trim().isEmpty) return 'Requis';
    final parsed = double.tryParse(value.trim().replaceAll(',', '.'));
    if (parsed == null || parsed < 0) return 'Nombre invalide';
    return null;
  }
}
