import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/utils/decimal_input.dart';
import '../../../core/widgets/app_components.dart';
import '../../../core/widgets/async_value_view.dart';
import '../data/catalog_models.dart';
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
  // Unit is picked from a friendly list instead of typed. Stored as a plain
  // String code (see [SaleUnit]) — no backend/model/DB change.
  late String _unitCode = widget.initial?.unit ?? kSaleUnits.first.code;

  /// The standard units, plus the article's own unit when it's a legacy/seed
  /// value outside the list ("ml", "m³", "jour"…) — editing must never change
  /// how an existing article is counted.
  late final List<SaleUnit> _unitOptions = [
    ...kSaleUnits,
    if (widget.initial != null && !kSaleUnits.any((u) => u.code == widget.initial!.unit))
      SaleUnit(widget.initial!.unit, saleUnitLabel(widget.initial!.unit)),
  ];

  late final _unitPriceHt = TextEditingController(text: widget.initial?.unitPriceHt);
  late final _vatRate = TextEditingController(text: widget.initial?.vatRate ?? '20.00');
  late final _duration = TextEditingController(
    text: widget.initial?.estimatedDurationMinutes?.toString(),
  );
  late String _categoryId = _initialCategoryId();
  late ItemType _itemType = widget.initial?.itemType ?? ItemType.service;

  /// The article's own folder — or the first available one if that folder isn't
  /// in the loaded list. The category dropdown asserts unless its value matches
  /// exactly one item, so it must never be handed a value it can't find.
  String _initialCategoryId() {
    final own = widget.initial?.categoryId;
    final exists = widget.categories.any((category) => category.id == own);
    return exists ? own! : widget.categories.first.id;
  }
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
        padding: const EdgeInsets.all(ArtizenSpacing.sm),
        children: [
          const Text(
            'Catégorie *',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: ArtizenColors.textPrimary),
          ),
          const SizedBox(height: ArtizenSpacing.xs),
          DropdownButtonFormField<String>(
            initialValue: _categoryId,
            items: widget.categories
                .map((category) => DropdownMenuItem(value: category.id, child: Text(category.name)))
                .toList(),
            onChanged: (value) => setState(() => _categoryId = value!),
          ),
          const SizedBox(height: ArtizenSpacing.sm),
          SegmentedButton<ItemType>(
            segments: const [
              ButtonSegment(value: ItemType.service, label: Text('Prestation'), icon: Icon(Icons.build_outlined)),
              ButtonSegment(value: ItemType.product, label: Text('Fourniture'), icon: Icon(Icons.inventory_2_outlined)),
            ],
            selected: {_itemType},
            onSelectionChanged: (selection) => setState(() => _itemType = selection.first),
          ),
          const SizedBox(height: ArtizenSpacing.sm),
          AppTextField(
            label: 'Désignation *',
            controller: _designation,
            hintText: 'Nom de l\'article',
            icon: Icons.label_outline,
            textInputAction: TextInputAction.next,
            validator: (value) => (value == null || value.trim().isEmpty) ? 'Requis' : null,
          ),
          const SizedBox(height: ArtizenSpacing.sm),
          AppTextField(
            label: 'Code (optionnel)',
            controller: _code,
            hintText: 'Référence interne',
            icon: Icons.tag_outlined,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: ArtizenSpacing.sm),
          AppTextField(
            label: 'Description',
            controller: _description,
            hintText: 'Détail de la prestation ou fourniture',
            icon: Icons.notes_outlined,
            maxLines: 2,
          ),
          const SizedBox(height: ArtizenSpacing.sm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                // Free-text unit replaced by a friendly picker ("À la pièce",
                // "Au mètre"…). The stored value stays a plain String code.
                child: DropdownButtonFormField<String>(
                  initialValue: _unitCode,
                  isExpanded: true,
                  decoration: const InputDecoration(labelText: 'Unité *'),
                  items: [
                    for (final unit in _unitOptions)
                      DropdownMenuItem(value: unit.code, child: Text(unit.label)),
                  ],
                  onChanged: (value) => setState(() => _unitCode = value ?? _unitCode),
                ),
              ),
              const SizedBox(width: ArtizenSpacing.sm),
              Expanded(
                child: AppTextField(
                  label: 'Durée (min)',
                  controller: _duration,
                  hintText: 'Optionnel',
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
              ),
            ],
          ),
          const SizedBox(height: ArtizenSpacing.sm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: AppTextField(
                  label: 'Prix unitaire HT *',
                  controller: _unitPriceHt,
                  hintText: '0,00',
                  suffixText: '€',
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  validator: _validateDecimal,
                ),
              ),
              const SizedBox(width: ArtizenSpacing.sm),
              Expanded(
                child: AppTextField(
                  label: 'TVA *',
                  controller: _vatRate,
                  hintText: '20',
                  suffixText: '%',
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  validator: _validateVatRate,
                ),
              ),
            ],
          ),
          const SizedBox(height: ArtizenSpacing.md),
          AppPrimaryButton(
            label: widget.itemId == null ? 'Créer l\'article' : 'Enregistrer',
            icon: Icons.check_circle_outline,
            loading: _saving,
            onPressed: _save,
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
