import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_components.dart';
import '../../../../shared/widgets/confirm_dialog.dart';
import '../../data/branding_models.dart';
import '../branding_providers.dart';

/// The "Signature & tampon" area of "Mon entreprise": import, preview, replace
/// and remove the two brand images that appear on emitted quotes. Reuses the
/// same multipart-upload mechanism as the logo/template import — every action
/// (import / delete) is applied immediately, independently of the company
/// form's "Enregistrer".
class BrandAssetsSection extends ConsumerWidget {
  const BrandAssetsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brand = ref.watch(brandingProfileNotifierProvider).valueOrNull?.brand;
    return Column(
      children: [
        const AppInfoCard(
          icon: Icons.info_outline,
          title: 'Appliqués immédiatement',
          description:
              "L'import et la suppression d'une signature ou d'un tampon sont enregistrés "
              'aussitôt — ils ne dépendent pas du bouton « Enregistrer » ci-dessus.',
        ),
        const SizedBox(height: ArtizenSpacing.sm),
        _BrandAssetTile(
          kind: BrandAssetKind.signature,
          title: 'Signature',
          emptyLabel: 'Aucune signature importée',
          hasAsset: brand?.signaturePath != null,
        ),
        const SizedBox(height: ArtizenSpacing.sm),
        _BrandAssetTile(
          kind: BrandAssetKind.stamp,
          title: 'Tampon',
          emptyLabel: 'Aucun tampon importé',
          hasAsset: brand?.stampPath != null,
        ),
      ],
    );
  }
}

class _BrandAssetTile extends ConsumerStatefulWidget {
  const _BrandAssetTile({
    required this.kind,
    required this.title,
    required this.emptyLabel,
    required this.hasAsset,
  });

  final BrandAssetKind kind;
  final String title;
  final String emptyLabel;
  final bool hasAsset;

  @override
  ConsumerState<_BrandAssetTile> createState() => _BrandAssetTileState();
}

class _BrandAssetTileState extends ConsumerState<_BrandAssetTile> {
  /// Guards against a double import/delete while one is in flight.
  bool _busy = false;

  BrandingProfileNotifier get _notifier =>
      ref.read(brandingProfileNotifierProvider.notifier);

  Future<void> _import() async {
    if (_busy) return;
    // Restrict to the image types the backend accepts; `withData` gives the
    // bytes on every platform (web included), like the template PDF import.
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: const ['png', 'jpg', 'jpeg'],
      withData: true,
    );
    final file = result?.files.single;
    if (file == null || file.bytes == null) return;

    setState(() => _busy = true);
    try {
      switch (widget.kind) {
        case BrandAssetKind.signature:
          await _notifier.uploadSignature(filename: file.name, bytes: file.bytes!);
        case BrandAssetKind.stamp:
          await _notifier.uploadStamp(filename: file.name, bytes: file.bytes!);
        case BrandAssetKind.logo:
          break; // Not managed from this section.
      }
      _toast('${widget.title} importé$_e');
    } catch (error) {
      _toast('Import impossible : $error');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _delete() async {
    if (_busy) return;
    final confirmed = await showConfirmDialog(
      context,
      title: 'Supprimer ${widget.title.toLowerCase()} ?',
      message: '${widget.title} sera retiré$_e de vos devis. '
          'Vous pourrez en importer un nouveau à tout moment.',
      confirmLabel: 'Supprimer',
    );
    if (!confirmed) return;

    setState(() => _busy = true);
    try {
      switch (widget.kind) {
        case BrandAssetKind.signature:
          await _notifier.deleteSignature();
        case BrandAssetKind.stamp:
          await _notifier.deleteStamp();
        case BrandAssetKind.logo:
          break;
      }
      _toast('${widget.title} supprimé$_e');
    } catch (error) {
      _toast('Suppression impossible : $error');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  /// "Signature" is feminine, "Tampon" masculine — agrees the past participle.
  String get _e => widget.kind == BrandAssetKind.signature ? 'e' : '';

  void _toast(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(ArtizenSpacing.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  widget.kind == BrandAssetKind.signature
                      ? Icons.draw_outlined
                      : Icons.approval_outlined,
                  color: ArtizenColors.nightBlue,
                ),
                const SizedBox(width: ArtizenSpacing.xs),
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: ArtizenColors.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: ArtizenSpacing.sm),
            if (widget.hasAsset)
              _AssetPreview(kind: widget.kind)
            else
              _EmptyPreview(label: widget.emptyLabel),
            const SizedBox(height: ArtizenSpacing.sm),
            if (widget.hasAsset)
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _busy ? null : _import,
                      icon: const Icon(Icons.refresh, size: 18),
                      label: const Text('Remplacer'),
                    ),
                  ),
                  const SizedBox(width: ArtizenSpacing.xs),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _busy ? null : _delete,
                      icon: const Icon(Icons.delete_outline, size: 18),
                      label: const Text('Supprimer'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: ArtizenColors.error,
                        side: const BorderSide(color: ArtizenColors.error),
                      ),
                    ),
                  ),
                ],
              )
            else
              OutlinedButton.icon(
                onPressed: _busy ? null : _import,
                icon: const Icon(Icons.upload_file, size: 18),
                label: Text('Importer ${widget.title.toLowerCase()}'),
              ),
            if (_busy) ...[
              const SizedBox(height: ArtizenSpacing.xs),
              const LinearProgressIndicator(),
            ],
          ],
        ),
      ),
    );
  }
}

/// Fetches and shows the stored image (auth-protected bytes → `Image.memory`).
class _AssetPreview extends ConsumerWidget {
  const _AssetPreview({required this.kind});

  final BrandAssetKind kind;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asset = ref.watch(brandAssetProvider(kind));
    return Container(
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
        color: ArtizenColors.infoSurface,
        borderRadius: BorderRadius.circular(ArtizenRadii.card),
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(ArtizenSpacing.xs),
      child: asset.when(
        loading: () => const SizedBox(
          height: 24,
          width: 24,
          child: CircularProgressIndicator(strokeWidth: 2.2),
        ),
        error: (_, _) => const Text(
          'Aperçu indisponible',
          style: TextStyle(color: ArtizenColors.textSecondary),
        ),
        data: (bytes) => bytes == null
            ? const Text(
                'Aperçu indisponible',
                style: TextStyle(color: ArtizenColors.textSecondary),
              )
            : Image.memory(bytes, fit: BoxFit.contain),
      ),
    );
  }
}

class _EmptyPreview extends StatelessWidget {
  const _EmptyPreview({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
        color: ArtizenColors.infoSurface,
        borderRadius: BorderRadius.circular(ArtizenRadii.card),
        border: Border.all(color: ArtizenColors.border),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.image_outlined, color: ArtizenColors.placeholder),
          const SizedBox(height: ArtizenSpacing.xs),
          Text(label, style: const TextStyle(color: ArtizenColors.textSecondary)),
        ],
      ),
    );
  }
}
