import 'package:flutter/material.dart';

/// The seven steps of the guided quote assistant — **one step, one decision**.
///
/// "Accueil" from the first sketch is the entry point (the "Nouveau devis"
/// button), not a step. A "Récapitulatif" is inserted before creation so the
/// artisan checks the amounts before the quote becomes an official document.
///
/// This is the shell: each step shows mock content. The order and identity are
/// what we validate first; the API wiring comes step by step afterwards.
enum WizardStep {
  client('Client', Icons.person_outline, 'Pour quel client faites-vous ce devis ?'),
  catalogue('Catalogue', Icons.folder_outlined,
      'Dans quel dossier de votre catalogue piochez-vous ?'),
  articles('Articles', Icons.checklist_outlined,
      'Quels articles et prestations mettez-vous au devis ?'),
  ajuster('Ajuster', Icons.tune_outlined,
      'Quantités, prix, lignes libres — ajustez ce qui doit l\'être.'),
  recap('Récap', Icons.receipt_long_outlined, 'Vérifiez les montants avant de créer.'),
  creer('Créer', Icons.description_outlined, 'Créez le devis officiel.'),
  envoyer('Envoyer', Icons.send_outlined, 'Envoyez le devis à votre client.');

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
