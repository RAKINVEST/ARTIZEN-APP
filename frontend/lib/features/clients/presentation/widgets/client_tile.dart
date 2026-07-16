import 'package:flutter/material.dart';

import '../../data/client_model.dart';

class ClientTile extends StatelessWidget {
  const ClientTile({
    required this.client,
    required this.onTap,
    required this.onDelete,
    super.key,
  });

  final Client client;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final subtitleParts = [client.phone, client.email].whereType<String>().where((s) => s.isNotEmpty);
    return Card(
      child: ListTile(
        onTap: onTap,
        leading: const CircleAvatar(child: Icon(Icons.person_outline)),
        title: Text(client.displayName),
        subtitle: subtitleParts.isEmpty ? null : Text(subtitleParts.join(' · ')),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline),
          tooltip: 'Supprimer',
          onPressed: onDelete,
        ),
      ),
    );
  }
}
