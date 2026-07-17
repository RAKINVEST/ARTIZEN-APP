import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/decimal_input.dart';
import '../../../core/widgets/async_value_view.dart';
import '../data/catalog_models.dart';
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
        onRetry: () => ref.read(categoriesNotifierProvider.notifier).refresh(),
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
  late final _unit = TextEditingController(text: widget.initial?.unit ?? 'unité');
  late final _unitPriceHt = TextEditingController(text: widget.initial?.unitPriceHt);
  late final _vatRate = TextEditingController(text: widget.initial?.vatRate ?? '20.00');
  late final _duration = TextEditingController(
    text: widget.initial?.estimatedDurationMinutes?.toString(),
  );
  late String _categoryId = widget.initial?.categoryId ?? widget.categories.first.id;
  late ItemType _itemType = widget.initial?.itemType ?? ItemType.service;
  bool _saving = false;

  @override
  void dispose() {
    for (final controller in [_designation, _code, _description, _unit, _unitPriceHt, _vatRate, _duration]) {
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
      unit: _unit.text.trim(),
      // Normalized, not just trimmed: the backend's Decimal rejects the
      // comma a French keyboard produces.
      unitPriceHt: DecimalInput.normalize(_unitPriceHt.text),
      vatRate: DecimalInput.normalize(_vatRate.text),
      estimatedDurationMinutes: _duration.text.trim().isEmpty ? null : int.tryParse(_duration.text.trim()),
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
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          DropdownButtonFormField<String>(
            initialValue: _categoryId,
            decoration: const InputDecoration(labelText: 'Catégorie *'),
            items: widget.categories
                .map((category) => DropdownMenuItem(value: category.id, child: Text(category.name)))
                .toList(),
            onChanged: (value) => setState(() => _categoryId = value!),
          ),
          const SizedBox(height: 12),
          SegmentedButton<ItemType>(
            segments: const [
              ButtonSegment(value: ItemType.service, label: Text('Prestation'), icon: Icon(Icons.build_outlined)),
              ButtonSegment(value: ItemType.product, label: Text('Fourniture'), icon: Icon(Icons.inventory_2_outlined)),
            ],
            selected: {_itemType},
            onSelectionChanged: (selection) => setState(() => _itemType = selection.first),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _designation,
            decoration: const InputDecoration(labelText: 'Désignation *'),
            validator: (value) => (value == null || value.trim().isEmpty) ? 'Requis' : null,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _code,
            decoration: const InputDecoration(labelText: 'Code (optionnel)'),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _description,
            decoration: const InputDecoration(labelText: 'Description'),
            maxLines: 2,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _unit,
                  decoration: const InputDecoration(labelText: 'Unité *'),
                  validator: (value) => (value == null || value.trim().isEmpty) ? 'Requis' : null,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextFormField(
                  controller: _duration,
                  decoration: const InputDecoration(labelText: 'Durée estimée (min)'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _unitPriceHt,
                  decoration: const InputDecoration(labelText: 'Prix unitaire HT *', suffixText: '€'),
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
                  validator: _validateVatRate,
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

  String? _validateDecimal(String? value) => DecimalInput.validate(value);

  String? _validateVatRate(String? value) {
    final error = DecimalInput.validate(value);
    if (error != null) return error;
    // Mirrors the backend's `le=100` bound, so an impossible rate is caught
    // on the field instead of coming back as an opaque 422.
    if (double.parse(DecimalInput.normalize(value!)) > 100) {
      return 'La TVA ne peut pas dépasser 100 %';
    }
    return null;
  }
}
