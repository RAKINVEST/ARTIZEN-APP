import 'package:flutter/material.dart';
import '../../../core/navigation/section_nav_arrows.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/api/api_config.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/app_surfaces.dart';
import '../../../shared/widgets/confirm_dialog.dart';
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
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        leading: const SectionNavArrows(current: '/settings'),
        leadingWidth: 96,
        title: const Text('Paramètres'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          const _SectionLabel('Entreprise'),
          _SettingsGroup(
            children: [
              // The one place to configure the whole company identity (legal,
              // contact, VAT regime, insurance, payment terms) from inside the
              // app — no longer only via a PDF import.
              _SettingsTile(
                icon: Icons.business_outlined,
                accent: ArtizenAccents.blue,
                title: 'Mon entreprise',
                subtitle:
                    'Identité légale, coordonnées, TVA, assurance, paiement',
                onTap: () => context.push('/company-profile'),
              ),
              // The toolbox: activities compose the catalog, qualifications add
              // their reserved packs (gas…). Configured once, applied everywhere.
              _SettingsTile(
                icon: Icons.handyman_outlined,
                accent: ArtizenAccents.violet,
                title: 'Mes métiers',
                subtitle:
                    'Composez votre catalogue selon vos activités et qualifications',
                onTap: () => context.push('/metiers'),
              ),
            ],
          ),
          const _SectionLabel('Modèle de devis'),
          _SettingsGroup(
            children: [
              // The active quote model — its identity and whether an imported
              // template is in use — so the artisan can see at a glance what
              // their PDFs carry, then preview or replace it.
              brandingAsync.when(
                data: (profile) => _ActiveModelTile(profile: profile),
                loading: () => const _SettingsTile(
                  icon: Icons.badge_outlined,
                  accent: ArtizenAccents.amber,
                  title: 'Modèle de devis',
                  subtitle: 'Chargement…',
                ),
                error: (_, _) => _SettingsTile(
                  icon: Icons.badge_outlined,
                  accent: ArtizenAccents.amber,
                  title: 'Modèle de devis',
                  subtitle: 'Identité indisponible',
                  trailing: TextButton(
                    onPressed: () => ref
                        .read(brandingProfileNotifierProvider.notifier)
                        .refresh(),
                    child: const Text('Réessayer'),
                  ),
                ),
              ),
              _SettingsTile(
                icon: Icons.visibility_outlined,
                accent: ArtizenAccents.cyan,
                title: 'Aperçu du rendu',
                subtitle: 'Voir un devis de démonstration avec votre identité',
                onTap: () => context.push('/branding/sample-preview'),
              ),
              _SettingsTile(
                icon: Icons.picture_as_pdf_outlined,
                accent: ArtizenAccents.green,
                title: 'Importer ou remplacer le modèle',
                subtitle: "Configure votre modèle à partir d'un ancien devis PDF",
                onTap: () => context.push('/template-import'),
              ),
            ],
          ),
          const _SectionLabel('Application'),
          _SettingsGroup(
            children: [
              _SettingsTile(
                icon: Icons.dns_outlined,
                accent: ArtizenAccents.slate,
                title: 'Serveur',
                subtitle: ApiConfig.baseUrl,
              ),
              const _SettingsTile(
                icon: Icons.info_outline,
                accent: ArtizenAccents.slate,
                title: 'Version',
                subtitle: '2.0.0',
              ),
            ],
          ),
          const SizedBox(height: ArtizenSpacing.sm),
          _SettingsGroup(
            children: [
              _SettingsTile(
                icon: Icons.logout,
                accent: ArtizenAccents.red,
                title: 'Se déconnecter',
                onTap: () async {
                  await ref.read(authNotifierProvider.notifier).logout();
                  if (context.mounted) context.go('/login');
                },
              ),
            ],
          ),
          const SizedBox(height: ArtizenSpacing.sm),
          // RGPD right to erasure — irreversible, so gated by a confirmation.
          _SettingsGroup(
            children: [
              _SettingsTile(
                icon: Icons.delete_forever_outlined,
                accent: ArtizenAccents.red,
                title: 'Supprimer mon compte',
                subtitle: 'Efface définitivement votre compte et toutes vos données',
                onTap: () async {
                  final confirmed = await showConfirmDialog(
                    context,
                    title: 'Supprimer votre compte ?',
                    message:
                        'Cette action est définitive. Votre compte et toutes vos '
                        'données (devis, clients, catalogue, identité) seront '
                        'supprimés sans possibilité de récupération.',
                    confirmLabel: 'Supprimer définitivement',
                  );
                  if (!confirmed || !context.mounted) return;
                  try {
                    await ref.read(authNotifierProvider.notifier).deleteAccount();
                    if (context.mounted) context.go('/login');
                  } catch (error) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Suppression impossible : $error')),
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// A white card grouping a section's rows, with hairline dividers between them.
class _SettingsGroup extends StatelessWidget {
  const _SettingsGroup({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        children: [
          for (var i = 0; i < children.length; i++) ...[
            if (i > 0) const Divider(height: 1, indent: 68, endIndent: 12),
            children[i],
          ],
        ],
      ),
    );
  }
}

/// A single settings row: a pastel icon chip, a title, an optional subtitle,
/// and either a chevron (when tappable) or a custom [trailing].
class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.accent,
    required this.title,
    this.subtitle,
    this.onTap,
    this.trailing,
  });

  final IconData icon;
  final ArtizenAccent accent;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      leading: AccentIconChip(icon: icon, accent: accent, size: 42),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: ArtizenColors.textPrimary,
        ),
      ),
      subtitle: subtitle == null ? null : Text(subtitle!),
      trailing:
          trailing ??
          (onTap == null
              ? null
              : const Icon(
                  Icons.chevron_right,
                  color: ArtizenColors.textSecondary,
                )),
      onTap: onTap,
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
      if (hasImportedTemplate)
        'Importé de « ${activeQuoteTemplates.first.name} »'
      else
        'Modèle par défaut',
      if (hasLogo) 'logo appliqué',
    ];

    return _SettingsTile(
      icon: Icons.badge_outlined,
      accent: ArtizenAccents.amber,
      title: identity ?? 'Modèle par défaut',
      subtitle: details.join(' · '),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 20, 16, 8),
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          color: kArtizenViolet,
          fontSize: 12,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}
