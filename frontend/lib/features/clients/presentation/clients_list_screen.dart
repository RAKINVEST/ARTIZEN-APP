import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/async_value_view.dart';
import '../../../shared/widgets/confirm_dialog.dart';
import '../../../shared/widgets/search_field.dart';
import '../data/client_model.dart';
import 'clients_providers.dart';
import 'widgets/client_tile.dart';

class ClientsListScreen extends ConsumerWidget {
  const ClientsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clients = ref.watch(clientsNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Clients')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/clients/new'),
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          SearchField(
            hintText: 'Rechercher un client (nom, société, téléphone, email)',
            onChanged: (query) => ref.read(clientsNotifierProvider.notifier).search(query),
          ),
          Expanded(
            child: AsyncListView<Client>(
              value: clients,
              emptyMessage: 'Aucun client pour le moment.\nAjoutez votre premier client avec le bouton +.',
              emptyIcon: Icons.people_outline,
              onRetry: () => ref.read(clientsNotifierProvider.notifier).refresh(),
              itemBuilder: (context, items) => RefreshIndicator(
                onRefresh: () => ref.read(clientsNotifierProvider.notifier).refresh(),
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 8, bottom: 88),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final client = items[index];
                    return ClientTile(
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
                          await ref.read(clientsNotifierProvider.notifier).deleteClient(client.id);
                        }
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
