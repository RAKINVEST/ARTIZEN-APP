import 'package:flutter/material.dart';
import '../../../core/navigation/section_nav_arrows.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/app_components.dart';
import '../../../core/widgets/app_surfaces.dart';
import '../../../core/widgets/paged_list_view.dart';
import '../../../shared/widgets/confirm_dialog.dart';
import '../../../shared/widgets/debounced_search_field.dart';
import 'clients_providers.dart';
import 'widgets/client_tile.dart';

class ClientsListScreen extends ConsumerWidget {
  const ClientsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clients = ref.watch(clientsNotifierProvider);
    final notifier = ref.read(clientsNotifierProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        leading: const SectionNavArrows(current: '/clients'),
        leadingWidth: 96,
        title: const Text('Clients'),
      ),
      floatingActionButton: GradientFab(
        onPressed: () => context.push('/clients/new'),
        tooltip: 'Nouveau client',
      ),
      body: Column(
        children: [
          // A clear, labelled way to add a client — the primary action of this
          // screen, so it lives here (moved off the dashboard) and is visible
          // without hunting for the floating "+".
          Padding(
            padding: const EdgeInsets.fromLTRB(
              ArtizenSpacing.sm,
              ArtizenSpacing.xs,
              ArtizenSpacing.sm,
              ArtizenSpacing.xs,
            ),
            child: AppPrimaryButton(
              label: 'Ajouter un nouveau client',
              icon: Icons.person_add_alt_1,
              onPressed: () => context.push('/clients/new'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              ArtizenSpacing.sm,
              0,
              ArtizenSpacing.sm,
              ArtizenSpacing.xs,
            ),
            child: DebouncedSearchField(
              hintText: 'Rechercher un client (nom, société, téléphone, email)',
              initialValue: notifier.searchQuery,
              onChanged: notifier.search,
            ),
          ),
          Expanded(
            child: PagedListView(
              value: clients,
              emptyMessage:
                  'Aucun client pour le moment.\nAjoutez votre premier client avec le bouton +.',
              emptyIcon: Icons.people_outline,
              onRetry: notifier.refresh,
              onRefresh: notifier.refresh,
              onLoadMore: notifier.loadMore,
              itemBuilder: (context, client) => ClientTile(
                client: client,
                // Pre-fill the wizard with this client via the URL (a one-way
                // link — the clients feature never imports the wizard). The
                // wizard opens on the client step already filled.
                onCreateQuote: () => context.push(
                  '/assistant?clientId=${client.id}'
                  '&clientName=${Uri.encodeComponent(client.displayName)}',
                ),
                onEdit: () => context.push('/clients/${client.id}/edit'),
                onDelete: () async {
                  final confirmed = await showConfirmDialog(
                    context,
                    title: 'Supprimer ce client ?',
                    message:
                        '${client.displayName} sera définitivement supprimé.',
                    confirmLabel: 'Supprimer',
                  );
                  if (confirmed) {
                    await notifier.deleteClient(client.id);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
