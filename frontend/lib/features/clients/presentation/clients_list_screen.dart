import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
      appBar: AppBar(title: const Text('Clients')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/clients/new'),
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          DebouncedSearchField(
            hintText: 'Rechercher un client (nom, société, téléphone, email)',
            initialValue: notifier.searchQuery,
            onChanged: notifier.search,
          ),
          Expanded(
            child: PagedListView(
              value: clients,
              emptyMessage: 'Aucun client pour le moment.\nAjoutez votre premier client avec le bouton +.',
              emptyIcon: Icons.people_outline,
              onRetry: notifier.refresh,
              onRefresh: notifier.refresh,
              onLoadMore: notifier.loadMore,
              itemBuilder: (context, client) => ClientTile(
                client: client,
                onTap: () => context.push('/clients/${client.id}/edit'),
                onDelete: () async {
                  final confirmed = await showConfirmDialog(
                    context,
                    title: 'Supprimer ce client ?',
                    message: '${client.displayName} sera définitivement supprimé.',
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
