import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/web_file_input.dart';
import '../../../core/widgets/app_components.dart';
import '../data/extracted_quote.dart';
import 'quote_extraction_providers.dart';

/// ARTIZEN V2 — "Importer un ancien devis". Upload -> analyse -> extraction ->
/// **devis entièrement modifiable**, reconstruit à partir du PDF. Aucune donnée
/// de démonstration : chaque champ est celui lu sur le document (ou vide), et la
/// barre du bas rappelle honnêtement ce qui a pu, ou non, être relu.
class QuoteImportScreen extends ConsumerWidget {
  const QuoteImportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(quoteImportNotifierProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Importer un ancien devis')),
      body: switch (state) {
        QuoteImportIdle() => _Idle(onPick: () => _pickFile(ref)),
        QuoteImportUploading() => const _Progress('Import du fichier…'),
        QuoteImportAnalyzing() => const _Progress('Analyse du document…'),
        QuoteImportExtracting() => const _Progress('Reconstruction de votre devis…'),
        QuoteImportReady(:final quote) => _Editor(quote: quote),
        QuoteImportFailed(:final message) => _Failed(
          message: message,
          onRetry: () => ref.read(quoteImportNotifierProvider.notifier).reset(),
        ),
      },
    );
  }

  Future<void> _pickFile(WidgetRef ref) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      withData: true,
    );
    removeLingeringFileInputs();
    final file = result?.files.single;
    if (file == null || file.bytes == null) return;
    await ref
        .read(quoteImportNotifierProvider.notifier)
        .importFile(filename: file.name, bytes: file.bytes!);
  }
}

class _Idle extends StatelessWidget {
  const _Idle({required this.onPick});
  final VoidCallback onPick;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.picture_as_pdf_outlined,
              size: 56,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 16),
            const Text(
              "Importez un ancien devis PDF : ARTIZEN le relit et le "
              "reconstruit — client, lignes, montants, identité — pour que vous "
              "puissiez le reprendre et le modifier directement.",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            AppPrimaryButton(
              label: 'Choisir un fichier PDF',
              icon: Icons.upload_file,
              onPressed: onPick,
            ),
          ],
        ),
      ),
    );
  }
}

class _Progress extends StatelessWidget {
  const _Progress(this.message);
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
          Text(message),
        ],
      ),
    );
  }
}

class _Failed extends StatelessWidget {
  const _Failed({required this.message, required this.onRetry});
  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 48, color: theme.colorScheme.error),
            const SizedBox(height: 12),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            FilledButton.tonal(onPressed: onRetry, child: const Text('Réessayer')),
          ],
        ),
      ),
    );
  }
}

/// The reconstructed, editable devis. Every field is seeded from the extraction
/// (empty when the PDF did not state it) and freely editable — this is the
/// artisan taking their old quote back into their hands.
class _Editor extends StatefulWidget {
  const _Editor({required this.quote});
  final ExtractedQuote quote;

  @override
  State<_Editor> createState() => _EditorState();
}

class _EditorState extends State<_Editor> {
  late final TextEditingController _number;
  late final TextEditingController _issuedOn;
  late final TextEditingController _clientName;
  late final TextEditingController _clientAddress;
  late final List<_LineControllers> _lines;

  @override
  void initState() {
    super.initState();
    final q = widget.quote;
    _number = TextEditingController(text: q.number ?? '');
    _issuedOn = TextEditingController(text: q.dates.issuedOn ?? '');
    _clientName = TextEditingController(text: q.client.name ?? '');
    _clientAddress = TextEditingController(
      text: q.client.address.lines.join('\n'),
    );
    _lines = [
      for (final line in q.lines.where((l) => !l.sectionHeader))
        _LineControllers(line),
    ];
  }

  @override
  void dispose() {
    _number.dispose();
    _issuedOn.dispose();
    _clientName.dispose();
    _clientAddress.dispose();
    for (final l in _lines) {
      l.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final q = widget.quote;
    final lowConfidence = q.extractionConfidence < 0.6;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      children: [
        if (lowConfidence)
          Card(
            color: theme.colorScheme.secondaryContainer,
            child: const Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                "Certaines informations n'ont pas pu être relues avec certitude — "
                "vérifiez et complétez les champs ci-dessous.",
              ),
            ),
          ),
        const SizedBox(height: 8),
        Text('Devis', style: theme.textTheme.titleMedium),
        const SizedBox(height: 8),
        AppTextField(label: 'Numéro', controller: _number),
        const SizedBox(height: 12),
        AppTextField(label: "Date d'émission", controller: _issuedOn),
        const SizedBox(height: 24),
        Text('Client', style: theme.textTheme.titleMedium),
        const SizedBox(height: 8),
        AppTextField(label: 'Nom', controller: _clientName),
        const SizedBox(height: 12),
        AppTextField(
          label: 'Adresse',
          controller: _clientAddress,
          maxLines: 2,
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Text('Lignes', style: theme.textTheme.titleMedium),
            const Spacer(),
            Text('${_lines.length}', style: theme.textTheme.bodyMedium),
          ],
        ),
        const SizedBox(height: 8),
        for (var i = 0; i < _lines.length; i++) ...[
          _LineEditor(controllers: _lines[i]),
          const SizedBox(height: 12),
        ],
        const SizedBox(height: 8),
        _TotalsView(totals: q.totals),
      ],
    );
  }
}

class _LineControllers {
  _LineControllers(ExtractedLine line)
    : designation = TextEditingController(text: line.designation ?? ''),
      quantity = TextEditingController(text: line.quantity ?? ''),
      unit = TextEditingController(text: line.unit ?? ''),
      unitPrice = TextEditingController(text: line.unitPriceHt ?? ''),
      total = TextEditingController(text: line.totalHt ?? '');

  final TextEditingController designation;
  final TextEditingController quantity;
  final TextEditingController unit;
  final TextEditingController unitPrice;
  final TextEditingController total;

  void dispose() {
    designation.dispose();
    quantity.dispose();
    unit.dispose();
    unitPrice.dispose();
    total.dispose();
  }
}

class _LineEditor extends StatelessWidget {
  const _LineEditor({required this.controllers});
  final _LineControllers controllers;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            AppTextField(label: 'Désignation', controller: controllers.designation),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(child: AppTextField(label: 'Qté', controller: controllers.quantity)),
                const SizedBox(width: 8),
                Expanded(child: AppTextField(label: 'Unité', controller: controllers.unit)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(child: AppTextField(label: 'P.U. HT', controller: controllers.unitPrice)),
                const SizedBox(width: 8),
                Expanded(child: AppTextField(label: 'Total HT', controller: controllers.total)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TotalsView extends StatelessWidget {
  const _TotalsView({required this.totals});
  final ExtractedTotals totals;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Widget row(String label, String? value) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: theme.textTheme.bodyMedium),
          Text(value ?? '—', style: theme.textTheme.titleSmall),
        ],
      ),
    );
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            row('Total HT', totals.totalHt),
            row('TVA', totals.totalVat),
            row('Total TTC', totals.totalTtc),
          ],
        ),
      ),
    );
  }
}
