import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../data/client_model.dart';

/// A client row and its quick actions, sitting right next to the client's
/// details: create a quote (green), edit (orange), or delete (blue). The list
/// is a place to act, not just to read.
class ClientTile extends StatelessWidget {
  const ClientTile({
    required this.client,
    required this.onCreateQuote,
    required this.onEdit,
    required this.onDelete,
    super.key,
  });

  final Client client;
  final VoidCallback onCreateQuote;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final subtitleParts =
        [client.phone, client.email].whereType<String>().where((s) => s.isNotEmpty);
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          ArtizenSpacing.sm,
          ArtizenSpacing.xs,
          ArtizenSpacing.sm,
          ArtizenSpacing.xs,
        ),
        child: Row(
          children: [
            const CircleAvatar(child: Icon(Icons.person_outline)),
            const SizedBox(width: ArtizenSpacing.sm),
            // Loose (not Expanded): sizes to the client's info and no more, so
            // the actions sit right beside it instead of at the far edge.
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    client.displayName,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (subtitleParts.isNotEmpty)
                    Text(
                      subtitleParts.join(' · '),
                      style: const TextStyle(color: ArtizenColors.textSecondary, fontSize: 13),
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
            const SizedBox(width: ArtizenSpacing.md),
            _ActionButton(
              label: 'Créer un devis',
              icon: Icons.description_outlined,
              background: ArtizenColors.success, // vert
              foreground: Colors.white,
              onPressed: onCreateQuote,
            ),
            const SizedBox(width: ArtizenSpacing.xs),
            _ActionButton(
              label: 'Modifier',
              icon: Icons.edit_outlined,
              background: ArtizenColors.warning, // orange
              foreground: ArtizenColors.nightBlue,
              onPressed: onEdit,
            ),
            const SizedBox(width: ArtizenSpacing.xs),
            _ActionButton(
              label: 'Supprimer',
              icon: Icons.delete_outline,
              background: ArtizenColors.blueSecondary, // bleu
              foreground: Colors.white,
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}

/// A coloured, labelled action. The global button theme forces full width
/// (Size.fromHeight), which would demand an infinite width inside the row —
/// each button here sizes to its content instead.
class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.label,
    required this.icon,
    required this.background,
    required this.foreground,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final Color background;
  final Color foreground;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      style: FilledButton.styleFrom(
        backgroundColor: background,
        foregroundColor: foreground,
        minimumSize: const Size(0, 40),
      ),
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      label: Text(label),
    );
  }
}
