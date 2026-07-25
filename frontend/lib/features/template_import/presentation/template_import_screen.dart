import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:printing/printing.dart';

import '../../../core/utils/web_file_input.dart';
import '../../../core/widgets/app_components.dart';
import '../../../core/widgets/async_value_view.dart';
import '../data/template_import_models.dart';
import 'recognition_sequence.dart';
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

    // The artisan already saw their devis à leur image in the preview, so
    // confirming just saves it — no second reveal needed. Return where they
    // came from with a confirmation, and reset so a later import starts fresh.
    ref.listen(templateImportNotifierProvider, (previous, next) {
      if (next is TemplateImportDone) {
        final messenger = ScaffoldMessenger.of(context);
        ref.read(templateImportNotifierProvider.notifier).reset();
        if (context.canPop()) context.pop();
        messenger.showSnackBar(
          const SnackBar(
            content: Text(
              'Votre modèle est enregistré — vos devis porteront votre identité.',
            ),
          ),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Importer un ancien devis')),
      body: _buildBody(context, ref, state),
    );
  }

  Widget _buildBody(
    BuildContext context,
    WidgetRef ref,
    TemplateImportState state,
  ) {
    return switch (state) {
      TemplateImportIdle() => _IdleView(onPick: () => _pickFile(ref)),
      TemplateImportUploading() => const _StatusView(
        message: 'Import du fichier en cours...',
      ),
      TemplateImportAnalyzing() => const _StatusView(
        message: 'Analyse du document en cours...',
      ),
      TemplateImportPreviewReady(:final preview) => _PreviewReadyView(
        preview: preview,
      ),
      TemplateImportValidating(:final preview) => _PreviewReadyView(
        preview: preview,
        submitting: true,
      ),
      TemplateImportDone() => _DoneView(
        onFinish: () =>
            ref.read(templateImportNotifierProvider.notifier).reset(),
      ),
      TemplateImportFailed(:final message, :final preview) =>
        preview != null
            ? _PreviewReadyView(preview: preview, errorMessage: message)
            : _FatalErrorView(
                message: message,
                onRetry: () =>
                    ref.read(templateImportNotifierProvider.notifier).reset(),
              ),
    };
  }

  Future<void> _pickFile(WidgetRef ref) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      withData: true,
    );
    // file_picker leaves an invisible <input> in the DOM on web that swallows
    // every click afterwards — remove it before we render the next screen.
    removeLingeringFileInputs();
    final file = result?.files.single;
    if (file == null || file.bytes == null) return;

    await ref
        .read(templateImportNotifierProvider.notifier)
        .importFile(filename: file.name, bytes: file.bytes!);
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
            Icon(
              Icons.picture_as_pdf_outlined,
              size: 56,
              color: Theme.of(context).colorScheme.primary,
            ),
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
            Icon(
              Icons.check_circle,
              size: 56,
              color: theme.colorScheme.primary,
            ),
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
            AppPrimaryButton(
              label: 'Terminer',
              icon: Icons.check_circle_outline,
              onPressed: onFinish,
            ),
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
            FilledButton.tonal(
              onPressed: onRetry,
              child: const Text('Réessayer'),
            ),
          ],
        ),
      ),
    );
  }
}

/// After analysis: show the artisan their devis à leur image first, and let
/// them confirm from there ("montrer plutôt qu'expliquer"). Only those who want
/// to correct a value flip to the editable form. A single StatefulWidget holds
/// that toggle so the same instance survives the submitting / error rebuilds.
class _PreviewReadyView extends StatefulWidget {
  const _PreviewReadyView({
    required this.preview,
    this.submitting = false,
    this.errorMessage,
  });

  final TemplateImportPreview preview;
  final bool submitting;
  final String? errorMessage;

  @override
  State<_PreviewReadyView> createState() => _PreviewReadyViewState();
}

class _PreviewReadyViewState extends State<_PreviewReadyView> {
  bool _seenRecognition = false;
  bool _editing = false;

  @override
  Widget build(BuildContext context) {
    // First, the recognition story — the moment ARTIZEN recognises the company
    // (Décision 8). Played once, then it leads into the devis à leur image.
    if (!_seenRecognition) {
      return RecognitionSequence(
        preview: widget.preview,
        onContinue: () => setState(() => _seenRecognition = true),
      );
    }
    if (_editing) {
      return _PreviewForm(
        preview: widget.preview,
        submitting: widget.submitting,
        errorMessage: widget.errorMessage,
        onCancel: () => setState(() => _editing = false),
      );
    }
    return _ProposedPreview(
      preview: widget.preview,
      submitting: widget.submitting,
      errorMessage: widget.errorMessage,
      onAdjust: () => setState(() => _editing = true),
    );
  }
}

/// The "aperçu du rendu": the demo quote drawn with the detected identity,
/// shown before anything is saved. One tap confirms — and the values applied on
/// "je garde" are the exact ones this preview was rendered from (see
/// [proposedInputFromPreview]), so what the artisan validates is what they saw.
class _ProposedPreview extends ConsumerWidget {
  const _ProposedPreview({
    required this.preview,
    required this.onAdjust,
    this.submitting = false,
    this.errorMessage,
  });

  final TemplateImportPreview preview;
  final VoidCallback onAdjust;
  final bool submitting;
  final String? errorMessage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final pdf = ref.watch(proposedSamplePdfProvider(preview));

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          if (errorMessage != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Card(
                color: theme.colorScheme.errorContainer,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    errorMessage!,
                    style: TextStyle(color: theme.colorScheme.onErrorContainer),
                  ),
                ),
              ),
            ),
          Expanded(
            child: AsyncValueView<Uint8List>(
              value: pdf,
              onRetry: () => ref.invalidate(proposedSamplePdfProvider(preview)),
              // A fresh copy each build: on web the printing plugin detaches the
              // PDF's ArrayBuffer when it hands it to its worker, and re-posting
              // a detached buffer throws — same guard as PdfPreviewScaffold.
              builder: (context, bytes) => PdfPreview(
                build: (_) => Uint8List.fromList(bytes),
                canChangePageFormat: false,
                canChangeOrientation: false,
                canDebug: false,
                pdfFileName: 'apercu-modele.pdf',
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Material(
        elevation: 8,
        color: theme.colorScheme.surface,
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: AppPrimaryButton(
                    label: "C'est bien moi — je garde ce modèle",
                    icon: Icons.check_circle_outline,
                    loading: submitting,
                    onPressed: () => ref
                        .read(templateImportNotifierProvider.notifier)
                        .validate(proposedInputFromPreview(preview)),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: submitting ? null : onAdjust,
                    icon: const Icon(Icons.tune),
                    label: const Text('Ajuster les informations'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// The "Ajuster les informations" step, reached from the preview for the
/// artisan who wants to correct a value: every field defaults to the detected
/// value, falling back to the company's current one, so they always see
/// *something* sensible to keep or edit rather than a blank form — never
/// invents a value that wasn't either detected or already on file.
class _PreviewForm extends ConsumerStatefulWidget {
  const _PreviewForm({
    required this.preview,
    this.submitting = false,
    this.errorMessage,
    this.onCancel,
  });

  final TemplateImportPreview preview;
  final bool submitting;
  final String? errorMessage;

  /// Where "Retour" goes. When the form is opened from the preview via
  /// "Ajuster", this returns there; when null it cancels the whole import.
  final VoidCallback? onCancel;

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

    _legalName = TextEditingController(
      text: detection.companyName ?? company.legalName ?? '',
    );
    _siret = TextEditingController(
      text: detection.siret ?? company.siret ?? '',
    );
    _vatNumber = TextEditingController(
      text: detection.vatNumber ?? company.vatNumber ?? '',
    );
    _phone = TextEditingController(
      text: detection.phone ?? company.phone ?? '',
    );
    _email = TextEditingController(
      text: detection.email ?? company.email ?? '',
    );
    _website = TextEditingController(
      text: detection.website ?? company.website ?? '',
    );
    _address = TextEditingController(
      text: detection.address ?? company.addressLine ?? '',
    );
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
      _legalName,
      _siret,
      _vatNumber,
      _phone,
      _email,
      _website,
      _address,
      _primaryColor,
      _secondaryColor,
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

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
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
              Text(
                'Confiance de détection : $confidencePercent %',
                style: theme.textTheme.titleSmall,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _DetectionChip(label: 'Logo', detected: detection.logoDetected),
              _DetectionChip(
                label: 'En-tête',
                detected: detection.headerDetected,
              ),
              _DetectionChip(
                label: 'Pied de page',
                detected: detection.footerDetected,
              ),
              _DetectionChip(
                label: 'Tableau',
                detected: detection.tableDetected,
              ),
              _DetectionChip(
                label: 'Mentions légales',
                detected: detection.legalNoticeDetected,
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            "Informations de l'entreprise",
            style: theme.textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          AppTextField(label: 'Raison sociale', controller: _legalName),
          const SizedBox(height: 12),
          AppTextField(label: 'SIRET', controller: _siret),
          const SizedBox(height: 12),
          AppTextField(label: 'N° TVA', controller: _vatNumber),
          const SizedBox(height: 12),
          AppTextField(
            label: 'Téléphone',
            controller: _phone,
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 12),
          AppTextField(
            label: 'Email',
            controller: _email,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 12),
          AppTextField(label: 'Site web', controller: _website),
          const SizedBox(height: 12),
          AppTextField(label: 'Adresse', controller: _address),
          const SizedBox(height: 24),
          Text('Identité visuelle', style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          AppTextField(
            label: 'Couleur principale (hex)',
            controller: _primaryColor,
          ),
          const SizedBox(height: 12),
          AppTextField(
            label: 'Couleur secondaire (hex)',
            controller: _secondaryColor,
          ),
          const SizedBox(height: 8),
        ],
      ),
      // The action bar lives in the Scaffold's dedicated bottom slot, not as a
      // Column sibling of the scroll view. As a sibling on Flutter web the
      // scrollable's hit-test region overlapped it, so only the top strip of
      // BOTH buttons received taps; the bottomNavigationBar slot is laid out
      // separately by the Scaffold and stays reliably tappable end to end.
      bottomNavigationBar: Material(
        elevation: 8,
        color: theme.colorScheme.surface,
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: widget.submitting
                        ? null
                        : (widget.onCancel ??
                              () => ref
                                  .read(templateImportNotifierProvider.notifier)
                                  .reset()),
                    child: Text(widget.onCancel != null ? 'Retour' : 'Annuler'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: AppPrimaryButton(
                    label: 'Enregistrer ce modèle',
                    icon: Icons.check_circle_outline,
                    loading: widget.submitting,
                    onPressed: _submit,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submit() {
    String? orNull(TextEditingController controller) {
      final value = controller.text.trim();
      return value.isEmpty ? null : value;
    }

    ref
        .read(templateImportNotifierProvider.notifier)
        .validate(
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
