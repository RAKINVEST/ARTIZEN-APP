import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/async_value_view.dart';
import '../../../shared/widgets/confirm_dialog.dart';
import '../data/metiers_models.dart';
import 'metiers_providers.dart';

/// "Mes métiers" — the artisan composes his catalog from his activities and
/// qualifications. Each card answers, in five seconds: what is it, is it
/// active, what does it bring, what can I do about it.
class MetiersScreen extends ConsumerWidget {
  const MetiersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activities = ref.watch(activitiesNotifierProvider);
    final qualifications = ref.watch(qualificationsNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Mes métiers')),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(activitiesNotifierProvider.notifier).refresh();
          await ref.read(qualificationsNotifierProvider.notifier).refresh();
        },
        child: ListView(
          padding: const EdgeInsets.only(bottom: ArtizenSpacing.lg),
          children: [
            const _Intro(),
            const _SectionLabel('Mes métiers'),
            _SourceList(
              value: activities,
              onRetry: () => ref.read(activitiesNotifierProvider.notifier).refresh(),
              onImport: (slug) => ref.read(activitiesNotifierProvider.notifier).import(slug),
              onRemove: (slug) => ref.read(activitiesNotifierProvider.notifier).remove(slug),
            ),
            const _SectionLabel('Mes qualifications'),
            _SourceList(
              value: qualifications,
              onRetry: () => ref.read(qualificationsNotifierProvider.notifier).refresh(),
              onImport: (slug) => ref.read(qualificationsNotifierProvider.notifier).import(slug),
              onRemove: (slug) => ref.read(qualificationsNotifierProvider.notifier).remove(slug),
            ),
          ],
        ),
      ),
    );
  }
}

class _Intro extends StatelessWidget {
  const _Intro();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(
        ArtizenSpacing.sm, ArtizenSpacing.sm, ArtizenSpacing.sm, 0),
      child: Text(
        "Activez vos activités : votre catalogue se remplit tout seul. "
        "Vos prix et vos ajouts restent toujours à vous — mettre à jour "
        "n'écrase jamais ce que vous avez modifié.",
        style: TextStyle(color: ArtizenColors.textSecondary),
      ),
    );
  }
}

class _SourceList extends StatelessWidget {
  const _SourceList({
    required this.value,
    required this.onRetry,
    required this.onImport,
    required this.onRemove,
  });

  final AsyncValue<List<CatalogSource>> value;
  final VoidCallback onRetry;
  final Future<CatalogImportResult> Function(String slug) onImport;
  final Future<void> Function(String slug) onRemove;

  @override
  Widget build(BuildContext context) {
    return AsyncValueView<List<CatalogSource>>(
      value: value,
      onRetry: onRetry,
      builder: (context, sources) => Column(
        children: [
          for (final source in sources)
            _SourceCard(
              source: source,
              onImport: () => onImport(source.slug),
              onRemove: () => onRemove(source.slug),
            ),
        ],
      ),
    );
  }
}

class _SourceCard extends StatefulWidget {
  const _SourceCard({
    required this.source,
    required this.onImport,
    required this.onRemove,
  });

  final CatalogSource source;
  final Future<CatalogImportResult> Function() onImport;
  final Future<void> Function() onRemove;

  @override
  State<_SourceCard> createState() => _SourceCardState();
}

class _SourceCardState extends State<_SourceCard> {
  bool _busy = false;

  CatalogSource get source => widget.source;

  Future<void> _import() async {
    setState(() => _busy = true);
    try {
      final result = await widget.onImport();
      if (!mounted) return;
      final added = result.itemsCreated;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            added == 0
                ? '${source.label} : déjà à jour.'
                : '${source.label} : $added article${added > 1 ? 's' : ''} ajouté${added > 1 ? 's' : ''}.',
          ),
        ),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Échec de l\'import de ${source.label}.')),
      );
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _remove() async {
    final confirmed = await showConfirmDialog(
      context,
      title: 'Retirer ${source.label} ?',
      message:
          "Vos articles ne sont PAS supprimés : votre catalogue reste intact. "
          "Cela retire seulement ${source.label} de vos activités.",
      confirmLabel: 'Retirer',
    );
    if (!confirmed) return;
    setState(() => _busy = true);
    try {
      await widget.onRemove();
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(ArtizenSpacing.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Qu'est-ce que c'est ? + 2. Est-ce actif ?
            Row(
              children: [
                Expanded(
                  child: Text(
                    source.label,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                _StatusChip(status: source.status),
              ],
            ),
            if (source.description != null) ...[
              const SizedBox(height: 4),
              Text(
                source.description!,
                style: const TextStyle(color: ArtizenColors.textSecondary),
              ),
            ],
            const SizedBox(height: ArtizenSpacing.xs),
            // 3. Qu'est-ce que ça apporte ?
            _Brings(source: source),
            // Nouveautés de la mise à jour disponible.
            if (source.status == CatalogSourceStatus.updateAvailable) _UpdateNotes(source: source),
            // "Dernière mise à jour" pour une activité importée.
            if (source.importedAt != null && source.status == CatalogSourceStatus.imported)
              Padding(
                padding: const EdgeInsets.only(top: ArtizenSpacing.xs),
                child: Text(
                  'Version ${source.importedVersion} · importée le ${_formatDate(source.importedAt!)}',
                  style: Theme.of(context).textTheme.bodySmall
                      ?.copyWith(color: ArtizenColors.textSecondary),
                ),
              ),
            const SizedBox(height: ArtizenSpacing.xs),
            // 4. Que puis-je faire ?
            _Actions(
              source: source,
              busy: _busy,
              onImport: _import,
              onRemove: _remove,
              onSeeContent: () => _showContent(context, source),
            ),
          ],
        ),
      ),
    );
  }
}

class _Brings extends StatelessWidget {
  const _Brings({required this.source});

  final CatalogSource source;

  @override
  Widget build(BuildContext context) {
    final parts = <String>[
      '${source.packCount} dossier${source.packCount > 1 ? 's' : ''}',
      '${source.productCount} article${source.productCount > 1 ? 's' : ''}',
      '${source.prestationCount} prestation${source.prestationCount > 1 ? 's' : ''}',
    ];
    return Text(
      parts.join(' · '),
      style: Theme.of(context).textTheme.bodyMedium
          ?.copyWith(color: ArtizenColors.textPrimary),
    );
  }
}

class _UpdateNotes extends StatelessWidget {
  const _UpdateNotes({required this.source});

  final CatalogSource source;

  @override
  Widget build(BuildContext context) {
    final count = source.updateItemCount ?? 0;
    final notes = source.updateNotes ?? const <String>[];
    return Container(
      margin: const EdgeInsets.only(top: ArtizenSpacing.xs),
      padding: const EdgeInsets.all(ArtizenSpacing.xs),
      decoration: BoxDecoration(
        color: ArtizenColors.infoSurface,
        borderRadius: BorderRadius.circular(ArtizenRadii.field),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            count > 0 ? 'Nouveautés (+$count article${count > 1 ? 's' : ''})' : 'Nouveautés',
            style: Theme.of(context).textTheme.labelMedium
                ?.copyWith(color: ArtizenColors.info, fontWeight: FontWeight.w600),
          ),
          for (final note in notes)
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text('• $note',
                  style: const TextStyle(color: ArtizenColors.textSecondary)),
            ),
        ],
      ),
    );
  }
}

class _Actions extends StatelessWidget {
  const _Actions({
    required this.source,
    required this.busy,
    required this.onImport,
    required this.onRemove,
    required this.onSeeContent,
  });

  final CatalogSource source;
  final bool busy;
  final VoidCallback onImport;
  final VoidCallback onRemove;
  final VoidCallback onSeeContent;

  @override
  Widget build(BuildContext context) {
    final imported = source.status != CatalogSourceStatus.available;
    final needsUpdate = source.status == CatalogSourceStatus.updateAvailable;

    // The app's global button theme makes buttons full-width
    // (Size.fromHeight), which demands an infinite width inside a Row and
    // breaks layout. In this action bar the buttons must size to their
    // content, so override the minimum size to drop the imposed width while
    // keeping a comfortable tap height.
    final inRowButton = FilledButton.styleFrom(minimumSize: const Size(0, 44));

    final Widget primary;
    if (busy) {
      primary = const Padding(
        padding: EdgeInsets.symmetric(horizontal: ArtizenSpacing.sm, vertical: 6),
        child: SizedBox(
          height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2)),
      );
    } else if (!imported) {
      primary = FilledButton.icon(
        onPressed: onImport,
        style: inRowButton,
        icon: const Icon(Icons.download_outlined),
        label: const Text('Importer'),
      );
    } else if (needsUpdate) {
      final count = source.updateItemCount ?? 0;
      primary = FilledButton.icon(
        onPressed: onImport,
        style: inRowButton,
        icon: const Icon(Icons.system_update_alt_outlined),
        label: Text(count > 0 ? 'Mettre à jour (+$count)' : 'Mettre à jour'),
      );
    } else {
      primary = const SizedBox.shrink();
    }

    return Row(
      children: [
        primary,
        if (imported)
          TextButton.icon(
            onPressed: busy ? null : onSeeContent,
            icon: const Icon(Icons.list_alt_outlined, size: 18),
            label: const Text('Voir le contenu'),
          ),
        const Spacer(),
        if (imported)
          TextButton(
            onPressed: busy ? null : onRemove,
            style: TextButton.styleFrom(foregroundColor: ArtizenColors.textSecondary),
            child: const Text('Retirer'),
          )
        else
          TextButton.icon(
            onPressed: busy ? null : onSeeContent,
            icon: const Icon(Icons.list_alt_outlined, size: 18),
            label: const Text('Voir le contenu'),
          ),
      ],
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});

  final CatalogSourceStatus status;

  @override
  Widget build(BuildContext context) {
    final (String label, Color fg, Color bg) = switch (status) {
      CatalogSourceStatus.available => (
          'Disponible',
          ArtizenColors.textSecondary,
          ArtizenColors.surfaceLight,
        ),
      CatalogSourceStatus.imported => (
          'Importé',
          ArtizenColors.success,
          ArtizenColors.statusAcceptedBg,
        ),
      CatalogSourceStatus.updateAvailable => (
          'Mise à jour',
          ArtizenColors.onGold,
          ArtizenColors.gold,
        ),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(ArtizenRadii.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (status == CatalogSourceStatus.imported)
            Padding(
              padding: const EdgeInsets.only(right: 4),
              child: Icon(Icons.check, size: 14, color: fg),
            ),
          Text(
            label,
            style: TextStyle(color: fg, fontWeight: FontWeight.w600, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

String _formatDate(DateTime date) {
  const months = [
    'janvier', 'février', 'mars', 'avril', 'mai', 'juin', 'juillet',
    'août', 'septembre', 'octobre', 'novembre', 'décembre',
  ];
  final local = date.toLocal();
  return '${local.day} ${months[local.month - 1]} ${local.year}';
}

/// "Voir le contenu" — a read-only glance at the folders, so the artisan knows
/// what an activity covers before or after importing it. No editing.
Future<void> _showContent(BuildContext context, CatalogSource source) {
  return showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(source.label),
      content: SizedBox(
        width: double.maxFinite,
        child: source.packs.isEmpty
            ? const Text('Aucun dossier.')
            : ListView(
                shrinkWrap: true,
                children: [
                  for (final pack in source.packs)
                    ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.folder_outlined),
                      title: Text(pack.name),
                      trailing: Text('${pack.itemCount}'),
                    ),
                ],
              ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Fermer')),
      ],
    ),
  );
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 4),
      child: Text(
        text.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              letterSpacing: 0.8,
            ),
      ),
    );
  }
}
