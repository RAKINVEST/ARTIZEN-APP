import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/app_components.dart';
import '../data/template_import_models.dart';
import 'template_import_providers.dart';

/// "Importer un ancien devis PDF" (Étape 8): upload -> analyse ->
/// détection -> aperçu (modifiable) -> validation -> le PDF importé
/// devient le modèle de devis actif de l'entreprise.
///
/// Every network call this screen triggers already existed before this
/// screen did (`/document-analysis/upload`, `/process`) or is the two
/// thin endpoints Étape 8 added on top (`/template-import/.../preview`,
/// `/validate`) — this screen only sequences them and lets the user
/// review/edit the detected values in between.
class TemplateImportScreen extends ConsumerWidget {
  const TemplateImportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(templateImportNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Importer un ancien devis')),
      body: _buildBody(context, ref, state),
    );
  }

  Widget _buildBody(BuildContext context, WidgetRef ref, TemplateImportState state) {
    return switch (state) {
      TemplateImportIdle() => _IdleView(onPick: () => _pickFile(ref)),
      TemplateImportUploading() => const _StatusView(message: 'Import du fichier en cours...'),
      TemplateImportAnalyzing() => const _StatusView(message: 'Analyse du document en cours...'),
      TemplateImportPreviewReady(:final preview) => _PreviewForm(preview: preview),
      TemplateImportValidating(:final preview) =>
        _PreviewForm(preview: preview, submitting: true),
      TemplateImportDone() => _DoneView(
          onFinish: () => ref.read(templateImportNotifierProvider.notifier).reset(),
        ),
      TemplateImportFailed(:final message, :final preview) => preview != null
          ? _PreviewForm(preview: preview, errorMessage: message)
          : _FatalErrorView(
              message: message,
              onRetry: () => ref.read(templateImportNotifierProvider.notifier).reset(),
            ),
    };
  }

  Future<void> _pickFile(WidgetRef ref) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      withData: true,
    );
    final file = result?.files.single;
    if (file == null || file.bytes == null) return;

    await ref.read(templateImportNotifierProvider.notifier).importFile(
          filename: file.name,
          bytes: file.bytes!,
        );
  }
}

class _IdleView extends StatelessWidget {
  const _IdleView({required this.onPick});

  final VoidCallback onPick;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.picture_as_pdf_outlined, size: 56, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 16),
            const Text(
              "Importez un ancien devis au format PDF : Artizen l'analyse "
              "automatiquement (logo, couleurs, coordonnées) pour préparer "
              "votre modèle de devis.",
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

class _StatusView extends StatelessWidget {
  const _StatusView({required this.message});

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

class _DoneView extends StatelessWidget {
  const _DoneView({required this.onFinish});

  final VoidCallback onFinish;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle, size: 56, color: theme.colorScheme.primary),
            const SizedBox(height: 16),
            const Text(
              'Modèle de devis mis à jour. Tous les futurs devis utiliseront ce modèle.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            // Let the artisan immediately see their identity applied on a
            // demo quote, without having to create a real one first.
            OutlinedButton.icon(
              onPressed: () => context.push('/branding/sample-preview'),
              icon: const Icon(Icons.visibility_outlined),
              label: const Text('Aperçu du rendu'),
            ),
            const SizedBox(height: 8),
            AppPrimaryButton(label: 'Terminer', icon: Icons.check_circle_outline, onPressed: onFinish),
          ],
        ),
      ),
    );
  }
}

class _FatalErrorView extends StatelessWidget {
  const _FatalErrorView({required this.message, required this.onRetry});

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

/// The "Prévisualisation" + "Validation" steps: every field defaults to
/// the detected value, falling back to the company's current value, so
/// the user always sees *something* sensible to keep or edit rather
/// than a blank form — never invents a value that wasn't either
/// detected or already on file.
class _PreviewForm extends ConsumerStatefulWidget {
  const _PreviewForm({required this.preview, this.submitting = false, this.errorMessage});

  final TemplateImportPreview preview;
  final bool submitting;
  final String? errorMessage;

  @override
  ConsumerState<_PreviewForm> createState() => _PreviewFormState();
}

class _PreviewFormState extends ConsumerState<_PreviewForm> {
  late final TextEditingController _legalName;
  late final TextEditingController _siret;
  late final TextEditingController _vatNumber;
  late final TextEditingController _phone;
  late final TextEditingController _email;
  late final TextEditingController _website;
  late final TextEditingController _address;
  late final TextEditingController _primaryColor;
  late final TextEditingController _secondaryColor;

  @override
  void initState() {
    super.initState();
    final detection = widget.preview.detection;
    final company = widget.preview.currentCompany;
    final brand = widget.preview.currentBrand;
    final colors = detection.dominantColors;

    _legalName = TextEditingController(text: detection.companyName ?? company.legalName ?? '');
    _siret = TextEditingController(text: detection.siret ?? company.siret ?? '');
    _vatNumber = TextEditingController(text: detection.vatNumber ?? company.vatNumber ?? '');
    _phone = TextEditingController(text: detection.phone ?? company.phone ?? '');
    _email = TextEditingController(text: detection.email ?? company.email ?? '');
    _website = TextEditingController(text: detection.website ?? company.website ?? '');
    _address = TextEditingController(text: detection.address ?? company.addressLine ?? '');
    _primaryColor = TextEditingController(
      text: colors.isNotEmpty ? colors[0] : (brand.primaryColor ?? ''),
    );
    _secondaryColor = TextEditingController(
      text: colors.length > 1 ? colors[1] : (brand.secondaryColor ?? ''),
    );
  }

  @override
  void dispose() {
    for (final controller in [
      _legalName, _siret, _vatNumber, _phone, _email, _website, _address,
      _primaryColor, _secondaryColor,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final detection = widget.preview.detection;
    final confidencePercent = (detection.confidenceScore * 100).round();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        if (widget.errorMessage != null) ...[
          Card(
            color: theme.colorScheme.errorContainer,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                widget.errorMessage!,
                style: TextStyle(color: theme.colorScheme.onErrorContainer),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
        Row(
          children: [
            Icon(Icons.insights_outlined, color: theme.colorScheme.primary),
            const SizedBox(width: 8),
            Text('Confiance de détection : $confidencePercent %', style: theme.textTheme.titleSmall),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _DetectionChip(label: 'Logo', detected: detection.logoDetected),
            _DetectionChip(label: 'En-tête', detected: detection.headerDetected),
            _DetectionChip(label: 'Pied de page', detected: detection.footerDetected),
            _DetectionChip(label: 'Tableau', detected: detection.tableDetected),
            _DetectionChip(label: 'Mentions légales', detected: detection.legalNoticeDetected),
          ],
        ),
        const SizedBox(height: 24),
        Text("Informations de l'entreprise", style: theme.textTheme.titleMedium),
        const SizedBox(height: 8),
        TextField(
          controller: _legalName,
          decoration: const InputDecoration(labelText: 'Raison sociale'),
        ),
        const SizedBox(height: 8),
        TextField(controller: _siret, decoration: const InputDecoration(labelText: 'SIRET')),
        const SizedBox(height: 8),
        TextField(controller: _vatNumber, decoration: const InputDecoration(labelText: 'N° TVA')),
        const SizedBox(height: 8),
        TextField(controller: _phone, decoration: const InputDecoration(labelText: 'Téléphone')),
        const SizedBox(height: 8),
        TextField(controller: _email, decoration: const InputDecoration(labelText: 'Email')),
        const SizedBox(height: 8),
        TextField(controller: _website, decoration: const InputDecoration(labelText: 'Site web')),
        const SizedBox(height: 8),
        TextField(controller: _address, decoration: const InputDecoration(labelText: 'Adresse')),
        const SizedBox(height: 24),
        Text('Identité visuelle', style: theme.textTheme.titleMedium),
        const SizedBox(height: 8),
        TextField(
          controller: _primaryColor,
          decoration: const InputDecoration(labelText: 'Couleur principale (hex)'),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _secondaryColor,
          decoration: const InputDecoration(labelText: 'Couleur secondaire (hex)'),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: widget.submitting
                    ? null
                    : () => ref.read(templateImportNotifierProvider.notifier).reset(),
                child: const Text('Annuler'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: AppPrimaryButton(
                label: 'Valider ce modèle',
                icon: Icons.check_circle_outline,
                loading: widget.submitting,
                onPressed: _submit,
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _submit() {
    String? orNull(TextEditingController controller) {
      final value = controller.text.trim();
      return value.isEmpty ? null : value;
    }

    ref.read(templateImportNotifierProvider.notifier).validate(
          TemplateImportValidateInput(
            legalName: orNull(_legalName),
            siret: orNull(_siret),
            vatNumber: orNull(_vatNumber),
            phone: orNull(_phone),
            email: orNull(_email),
            website: orNull(_website),
            addressLine: orNull(_address),
            primaryColor: orNull(_primaryColor),
            secondaryColor: orNull(_secondaryColor),
          ),
        );
  }
}

class _DetectionChip extends StatelessWidget {
  const _DetectionChip({required this.label, required this.detected});

  final String label;
  final bool detected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Chip(
      avatar: Icon(
        detected ? Icons.check_circle : Icons.radio_button_unchecked,
        size: 18,
        color: detected ? theme.colorScheme.primary : theme.colorScheme.outline,
      ),
      label: Text(label),
    );
  }
}
