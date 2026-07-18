import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/api/api_config.dart';
import '../../auth/presentation/auth_providers.dart';
import '../../branding/data/branding_models.dart';
import '../../branding/presentation/branding_providers.dart';

/// The artisan's own screen: their quote model (identity + colours + logo),
/// a way to preview and replace it, the server it talks to, and sign-out.
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brandingAsync = ref.watch(brandingProfileNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Paramètres')),
      body: ListView(
        children: [
          const _SectionLabel('Modèle de devis'),
          // The active quote model — its identity and whether an imported
          // template is in use — so the artisan can see at a glance what
          // their PDFs carry, then preview or replace it.
          brandingAsync.when(
            data: (profile) => _ActiveModelTile(profile: profile),
            loading: () => const ListTile(
              leading: Icon(Icons.badge_outlined),
              title: Text('Modèle de devis'),
              subtitle: Text('Chargement…'),
            ),
            error: (_, _) => ListTile(
              leading: const Icon(Icons.badge_outlined),
              title: const Text('Modèle de devis'),
              subtitle: const Text('Identité indisponible'),
              trailing: TextButton(
                onPressed: () => ref.read(brandingProfileNotifierProvider.notifier).refresh(),
                child: const Text('Réessayer'),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.visibility_outlined),
            title: const Text('Aperçu du rendu'),
            subtitle: const Text('Voir un devis de démonstration avec votre identité'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/branding/sample-preview'),
          ),
          ListTile(
            leading: const Icon(Icons.picture_as_pdf_outlined),
            title: const Text('Importer ou remplacer le modèle'),
            subtitle: const Text("Configure votre modèle à partir d'un ancien devis PDF"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/template-import'),
          ),
          const Divider(),
          const _SectionLabel('Application'),
          const ListTile(
            leading: Icon(Icons.dns_outlined),
            title: Text('Serveur'),
            subtitle: Text(ApiConfig.baseUrl),
          ),
          const ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('Version'),
            subtitle: Text('2.0.0'),
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

class _ActiveModelTile extends StatelessWidget {
  const _ActiveModelTile({required this.profile});

  final BrandingProfile profile;

  @override
  Widget build(BuildContext context) {
    final identity = profile.company.legalName ?? profile.company.name;
    final activeQuoteTemplates = profile.templates
        .where((t) => t.type == TemplateType.quote && t.isActive)
        .toList();
    final hasImportedTemplate = activeQuoteTemplates.isNotEmpty;
    final hasLogo = profile.brand.logoPath != null;

    final details = <String>[
      if (hasImportedTemplate) 'Importé de « ${activeQuoteTemplates.first.name} »' else 'Modèle par défaut',
      if (hasLogo) 'logo appliqué',
    ];

    return ListTile(
      leading: const Icon(Icons.badge_outlined),
      title: Text(identity ?? 'Modèle par défaut'),
      subtitle: Text(details.join(' · ')),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
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
