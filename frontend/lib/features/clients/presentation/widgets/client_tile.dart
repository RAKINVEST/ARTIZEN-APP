import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_components.dart';
import '../../../../core/widgets/app_surfaces.dart';
import '../../data/client_model.dart';

/// A client row and its quick actions, sitting right next to the client's
/// details: create a quote (blue), edit (orange), or delete (red). The list is
/// a place to act, not just to read. On a wide row the actions sit inline; on a
/// narrow one they drop below and split the width.
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
    final subtitleParts = [client.phone, client.email]
        .whereType<String>()
        .where((s) => s.isNotEmpty);

    final info = Row(
      children: [
        const AccentIconChip(
          icon: Icons.person_outline,
          accent: ArtizenAccents.violet,
          size: 46,
        ),
        const SizedBox(width: ArtizenSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                client.displayName,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  color: ArtizenColors.textPrimary,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              if (subtitleParts.isNotEmpty)
                Text(
                  subtitleParts.join(' · '),
                  style: const TextStyle(
                    color: ArtizenColors.textSecondary,
                    fontSize: 13,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
            ],
          ),
        ),
      ],
    );

    return AppCard(
      padding: const EdgeInsets.all(12),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final wide = constraints.maxWidth >= 640;
          if (wide) {
            return Row(
              children: [
                Expanded(child: info),
                const SizedBox(width: ArtizenSpacing.sm),
                _action('Créer un devis', Icons.description_outlined,
                    ArtizenGradients.create, onCreateQuote),
                const SizedBox(width: 8),
                _action('Modifier', Icons.edit_outlined,
                    ArtizenGradients.edit, onEdit),
                const SizedBox(width: 8),
                _action('Supprimer', Icons.delete_outline,
                    ArtizenGradients.delete, onDelete),
              ],
            );
          }
          return Column(
            children: [
              info,
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _action('Créer un devis', Icons.description_outlined,
                        ArtizenGradients.create, onCreateQuote),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _action('Modifier', Icons.edit_outlined,
                        ArtizenGradients.edit, onEdit),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _action('Supprimer', Icons.delete_outline,
                        ArtizenGradients.delete, onDelete),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _action(
    String label,
    IconData icon,
    List<Color> gradient,
    VoidCallback onPressed,
  ) {
    return GradientButton(
      gradient: gradient,
      label: label,
      icon: icon,
      onPressed: onPressed,
      height: 42,
      compact: true,
    );
  }
}
