import 'package:flutter/material.dart';

/// The seven steps of the guided quote assistant — **one step, one decision**.
///
/// "Accueil" from the first sketch is the entry point (the "Nouveau devis"
/// button), not a step. A "Récapitulatif" is inserted before creation so the
/// artisan checks the amounts before the quote becomes an official document,
/// and a final "Terminé" step confirms the created quote (number + PDF).
///
/// Every step is wired to the backend: the assistant reads and creates through
/// real endpoints and never computes an amount itself (décision 3).
enum WizardStep {
  client('Client', Icons.person_outline, 'Pour quel client faites-vous ce devis ?'),
  dossier('Dossier', Icons.folder_outlined,
      'Dans quel dossier de votre catalogue piochez-vous ?'),
  articles('Articles', Icons.checklist_outlined,
      'Quels articles et prestations mettez-vous au devis ?'),
  personnaliser('Personnaliser', Icons.tune_outlined,
      'Quantités, prix, lignes libres — personnalisez le devis.'),
  recap('Récap', Icons.receipt_long_outlined, 'Vérifiez les montants avant de créer.'),
  creer('Créer', Icons.description_outlined, 'Créez le devis officiel.'),
  confirmation('Terminé', Icons.verified_outlined, 'Votre devis est créé.');

  const WizardStep(this.label, this.icon, this.question);

  /// Short label shown in the progress bar.
  final String label;

  /// Icon used in the progress bar and step header.
  final IconData icon;

  /// The single decision this step asks — shown big at the top of the step.
  final String question;

  int get number => index + 1;
  bool get isFirst => index == 0;
  bool get isLast => index == WizardStep.values.length - 1;
}
