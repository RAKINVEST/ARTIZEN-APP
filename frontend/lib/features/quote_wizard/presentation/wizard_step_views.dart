import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import 'wizard_step.dart';

/// Renders the body of a step. Shell version: mock content only, so we can
/// validate the flow before wiring each step to its API. Every step keeps a
/// single objective — the question at the top is the one decision to make.
class WizardStepView extends StatelessWidget {
  const WizardStepView({required this.step, super.key});

  final WizardStep step;

  @override
  Widget build(BuildContext context) {
    return _StepScaffold(
      step: step,
      child: switch (step) {
        WizardStep.client => const _ClientStep(),
        WizardStep.catalogue => const _CatalogueStep(),
        WizardStep.articles => const _ArticlesStep(),
        WizardStep.ajuster => const _AjusterStep(),
        WizardStep.recap => const _RecapStep(),
        WizardStep.creer => const _CreerStep(),
        WizardStep.envoyer => const _EnvoyerStep(),
      },
    );
  }
}

class _StepScaffold extends StatelessWidget {
  const _StepScaffold({required this.step, required this.child});

  final WizardStep step;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 720),
        child: ListView(
          padding: const EdgeInsets.all(ArtizenSpacing.md),
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: ArtizenColors.infoSurface,
                  child: Icon(step.icon, color: ArtizenColors.nightBlue),
                ),
                const SizedBox(width: ArtizenSpacing.sm),
                Expanded(
                  child: Text(
                    step.question,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ],
            ),
            const _MockBadge(),
            const SizedBox(height: ArtizenSpacing.md),
            child,
          ],
        ),
      ),
    );
  }
}

class _MockBadge extends StatelessWidget {
  const _MockBadge();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: ArtizenSpacing.xs),
      child: Row(
        children: [
          const Icon(Icons.science_outlined, size: 14, color: ArtizenColors.textSecondary),
          const SizedBox(width: 6),
          Text(
            'Aperçu — données simulées',
            style: Theme.of(context).textTheme.bodySmall
                ?.copyWith(color: ArtizenColors.textSecondary),
          ),
        ],
      ),
    );
  }
}

// --- Étape 1 : Client — pour qui ? -----------------------------------------

class _ClientStep extends StatelessWidget {
  const _ClientStep();

  @override
  Widget build(BuildContext context) {
    const clients = ['Martin Dubois', 'SCI Les Tilleuls', 'Boulangerie Petit'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const TextField(
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
            hintText: 'Rechercher un client',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: ArtizenSpacing.sm),
        for (var i = 0; i < clients.length; i++)
          Card(
            child: ListTile(
              leading: const CircleAvatar(child: Icon(Icons.person_outline)),
              title: Text(clients[i]),
              subtitle: const Text('Dernier devis : mai 2026'),
              trailing: i == 0 ? const Icon(Icons.check_circle, color: ArtizenColors.success) : null,
              selected: i == 0,
              onTap: () {},
            ),
          ),
        const SizedBox(height: ArtizenSpacing.sm),
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.person_add_outlined),
          label: const Text('Nouveau client'),
        ),
      ],
    );
  }
}

// --- Étape 2 : Catalogue — quel dossier ? ----------------------------------

class _CatalogueStep extends StatelessWidget {
  const _CatalogueStep();

  @override
  Widget build(BuildContext context) {
    const folders = <(String, IconData, int)>[
      ('Chauffe-eau', Icons.water_drop_outlined, 18),
      ('Robinetterie', Icons.plumbing_outlined, 17),
      ('Sanitaires', Icons.wc_outlined, 26),
      ('Chauffage', Icons.local_fire_department_outlined, 19),
      ('Évacuation', Icons.water_outlined, 21),
      ('Prestations', Icons.handyman_outlined, 12),
    ];
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 2.4,
      mainAxisSpacing: ArtizenSpacing.xs,
      crossAxisSpacing: ArtizenSpacing.xs,
      children: [
        for (final (name, icon, count) in folders)
          Card(
            child: InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(ArtizenSpacing.sm),
                child: Row(
                  children: [
                    Icon(icon, color: ArtizenColors.nightBlue),
                    const SizedBox(width: ArtizenSpacing.xs),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(name, overflow: TextOverflow.ellipsis),
                          Text('$count articles',
                              style: const TextStyle(
                                  color: ArtizenColors.textSecondary, fontSize: 12)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}

// --- Étape 3 : Articles — quoi ? -------------------------------------------

class _ArticlesStep extends StatelessWidget {
  const _ArticlesStep();

  @override
  Widget build(BuildContext context) {
    const articles = <(String, String, bool)>[
      ('Chauffe-eau électrique 200 L', '380,00 € HT', true),
      ('Groupe de sécurité', '14,00 € HT', true),
      ('Vase d\'expansion 8 L', '38,00 € HT', false),
      ('Pose d\'un chauffe-eau', '280,00 € HT', true),
      ('Déplacement zone 1', '35,00 € HT', false),
    ];
    return Column(
      children: [
        for (final (name, price, checked) in articles)
          Card(
            child: CheckboxListTile(
              value: checked,
              onChanged: (_) {},
              controlAffinity: ListTileControlAffinity.leading,
              title: Text(name),
              subtitle: Text(price),
            ),
          ),
        const SizedBox(height: ArtizenSpacing.xs),
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.add),
          label: const Text('Ajouter un article'),
        ),
      ],
    );
  }
}

// --- Étape 4 : Ajuster — quantités, prix, lignes libres --------------------

class _AjusterStep extends StatelessWidget {
  const _AjusterStep();

  @override
  Widget build(BuildContext context) {
    const lines = <(String, int, String)>[
      ('Chauffe-eau électrique 200 L', 1, '380,00 €'),
      ('Groupe de sécurité', 1, '14,00 €'),
      ('Pose d\'un chauffe-eau', 1, '280,00 €'),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final (name, qty, total) in lines)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(ArtizenSpacing.sm),
              child: Row(
                children: [
                  Expanded(child: Text(name)),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.remove_circle_outline)),
                  Text('$qty'),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.add_circle_outline)),
                  const SizedBox(width: ArtizenSpacing.sm),
                  Text(total, style: const TextStyle(fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ),
        const SizedBox(height: ArtizenSpacing.xs),
        Wrap(
          spacing: ArtizenSpacing.xs,
          children: [
            OutlinedButton.icon(
                onPressed: () {}, icon: const Icon(Icons.add), label: const Text('Ligne libre')),
            OutlinedButton.icon(
                onPressed: () {}, icon: const Icon(Icons.percent), label: const Text('Remise')),
          ],
        ),
      ],
    );
  }
}

// --- Étape 5 : Récapitulatif — vérifier les montants -----------------------

class _RecapStep extends StatelessWidget {
  const _RecapStep();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(ArtizenSpacing.md),
        child: Column(
          children: const [
            _RecapRow('Client', 'Martin Dubois'),
            _RecapRow('Lignes', '3 articles'),
            Divider(),
            _RecapRow('Total HT', '674,00 €'),
            _RecapRow('TVA (10 %)', '67,40 €'),
            Divider(),
            _RecapRow('Total TTC', '741,40 €', strong: true),
          ],
        ),
      ),
    );
  }
}

class _RecapRow extends StatelessWidget {
  const _RecapRow(this.label, this.value, {this.strong = false});

  final String label;
  final String value;
  final bool strong;

  @override
  Widget build(BuildContext context) {
    final style = strong
        ? const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: ArtizenColors.nightBlue)
        : const TextStyle();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(label, style: style), Text(value, style: style)],
      ),
    );
  }
}

// --- Étape 6 : Créer — le devis officiel -----------------------------------

class _CreerStep extends StatelessWidget {
  const _CreerStep();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Card(
          child: ListTile(
            leading: Icon(Icons.description_outlined, size: 40),
            title: Text('Devis prêt à être créé'),
            subtitle: Text('Un numéro officiel (DEV-2026-XXXX) lui sera attribué.'),
          ),
        ),
        const SizedBox(height: ArtizenSpacing.md),
        FilledButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.check_circle_outline),
          label: const Text('Créer le devis'),
          style: FilledButton.styleFrom(
            minimumSize: const Size.fromHeight(52),
            backgroundColor: ArtizenColors.gold,
            foregroundColor: ArtizenColors.onGold,
          ),
        ),
      ],
    );
  }
}

// --- Étape 7 : Envoyer — au client -----------------------------------------

class _EnvoyerStep extends StatelessWidget {
  const _EnvoyerStep();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Card(
          child: ListTile(
            leading: Icon(Icons.picture_as_pdf_outlined),
            title: Text('DEV-2026-0042.pdf'),
            subtitle: Text('Devis joint automatiquement'),
          ),
        ),
        const SizedBox(height: ArtizenSpacing.sm),
        TextFormField(
          initialValue: 'martin.dubois@email.fr',
          decoration: const InputDecoration(
            labelText: 'À',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: ArtizenSpacing.sm),
        const TextField(
          maxLines: 4,
          decoration: InputDecoration(
            labelText: 'Message',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: ArtizenSpacing.md),
        FilledButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.send),
          label: const Text('Envoyer au client'),
          style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(52)),
        ),
      ],
    );
  }
}
