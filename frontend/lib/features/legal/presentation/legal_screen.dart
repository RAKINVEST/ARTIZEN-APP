import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/config/support_config.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/app_components.dart';

/// A long-form legal document (mentions légales / CGU / confidentialité),
/// rendered from a [LegalDoc]. The three documents are declared below and
/// mounted at `/legal/*` as public routes, so a visitor (or a regulator) can
/// reach them by URL before signing up.
///
/// **Content is DRAFT** — sourced from `docs/legal/GABARITS-LEGAUX.md`, pending
/// legal validation and ARTIZEN's own company details (the `{…}` fields). The
/// screen and routes are final; publishing the validated text is a one-const
/// swap. The banner keeps the provisional status honest until then.
class LegalDocumentScreen extends ConsumerWidget {
  const LegalDocumentScreen({required this.doc, super.key});

  final LegalDoc doc;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // The contact address comes from the single backend source; substitute it
    // into the {email} placeholder (other {…} await the validated content).
    final email = ref.watch(supportEmailProvider).valueOrNull;
    final body = email == null ? doc.body : doc.body.replaceAll('{email}', email);
    return Scaffold(
      appBar: AppBar(title: Text(doc.title)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(ArtizenSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppInfoCard(
                icon: Icons.gavel_outlined,
                title: 'Document provisoire',
                description:
                    'La version définitive, validée juridiquement, sera publiée '
                    'avant l’ouverture commerciale.',
              ),
              const SizedBox(height: ArtizenSpacing.md),
              SelectableText(body),
              const SizedBox(height: ArtizenSpacing.lg),
            ],
          ),
        ),
      ),
    );
  }
}

/// A single legal document: a [title] shown in the app bar and a long-form
/// [body]. Kept intentionally plain (no markdown dependency) — legal text is
/// paragraphs, not rich formatting.
class LegalDoc {
  const LegalDoc(this.title, this.body);

  final String title;
  final String body;
}

// --- Draft content (see docs/legal/GABARITS-LEGAUX.md). `{…}` = à compléter. ---

const legalMentions = LegalDoc(
  'Mentions légales',
  'Éditeur : {Dénomination sociale}, {forme juridique} au capital de {montant} €, '
      'RCS {ville} {n° SIREN}, siège : {adresse}. TVA intracommunautaire : {n°}. '
      'Directeur de la publication : {nom}.\n\n'
      'Contact : {email} — {téléphone}.\n\n'
      'Hébergeur : {nom}, {adresse}, {téléphone}. Données hébergées en France / UE.\n\n'
      "Propriété intellectuelle : la marque, le logo, l'interface et le code "
      "d'ARTIZEN sont la propriété de l'éditeur. Les données saisies par "
      "l'utilisateur (clients, articles, devis) restent la propriété de "
      "l'utilisateur.",
);

const legalCgu = LegalDoc(
  "Conditions Générales d'Utilisation",
  "Article 1 — Objet. Les présentes CGU régissent l'accès et l'usage d'ARTIZEN, "
      "service de création de devis destiné aux artisans.\n\n"
      "Article 2 — Compte. L'accès nécessite un compte (email + mot de passe). "
      "L'utilisateur est responsable de la confidentialité de ses identifiants et "
      "des activités réalisées via son compte.\n\n"
      "Article 3 — Usage professionnel. ARTIZEN est réservé à un usage "
      "professionnel. L'utilisateur reste seul responsable du contenu de ses "
      "devis (prix, mentions, TVA, conformité). Les contrôles automatiques sont "
      "une aide, non une substitution à ses obligations légales.\n\n"
      "Article 4 — Disponibilité et bêta. Pendant la bêta, le service est fourni "
      "« en l'état ». Des sauvegardes sont réalisées ; l'utilisateur est invité à "
      "conserver ses documents importants.\n\n"
      "Article 5 — Obligations. Ne pas détourner le service, ne pas compromettre "
      "sa sécurité, ne pas y introduire de contenu illicite.\n\n"
      "Article 6 — Responsabilité. {À cadrer par le juriste.}\n\n"
      "Article 7 — Résiliation. L'utilisateur peut supprimer son compte à tout "
      "moment (Paramètres → Supprimer mon compte).\n\n"
      "Article 8 — Évolution. Les CGU peuvent être modifiées ; l'utilisateur en "
      "est informé.",
);

const legalConfidentialite = LegalDoc(
  'Politique de confidentialité',
  "Données collectées : compte (email, nom), identité d'entreprise (raison "
      "sociale, SIRET, coordonnées), et les clients et devis que vous saisissez.\n\n"
      "Finalités : fournir le service de création de devis, gérer votre compte, "
      "sécuriser l'accès.\n\n"
      "Base légale : exécution du contrat (fourniture du service) et intérêt "
      "légitime (sécurité).\n\n"
      "Hébergement : France / UE.\n\n"
      "Durée de conservation : {à définir — politique de rétention}. Vos données "
      "sont supprimées sur demande.\n\n"
      "Vos droits (RGPD) : accès, rectification, effacement, portabilité, "
      "opposition. L'effacement est immédiat via Paramètres → Supprimer mon "
      "compte, ou sur demande à {email}.\n\n"
      "Sous-traitants : hébergeur ({nom}), service d'envoi d'e-mails ({nom}). "
      "{à compléter}\n\n"
      "Contact : {email}.",
);
