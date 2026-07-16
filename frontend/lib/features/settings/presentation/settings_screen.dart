import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/api/api_config.dart';
import '../../auth/presentation/auth_providers.dart';

/// Minimal — the brief names this screen but doesn't ask for specific
/// settings. Shows what's useful for an MVP being tested by a real
/// artisan: which backend it's talking to, and a way to sign out.
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Paramètres')),
      body: ListView(
        children: [
          const ListTile(
            leading: Icon(Icons.dns_outlined),
            title: Text('Serveur'),
            subtitle: Text(ApiConfig.baseUrl),
          ),
          const ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('Version'),
            subtitle: Text('1.0.0 (MVP)'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.picture_as_pdf_outlined),
            title: const Text('Importer un ancien devis'),
            subtitle: const Text("Configure automatiquement votre modèle à partir d'un PDF"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/template-import'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Se déconnecter'),
            onTap: () async {
              await ref.read(authNotifierProvider.notifier).logout();
              if (context.mounted) context.go('/login');
            },
          ),
        ],
      ),
    );
  }
}
