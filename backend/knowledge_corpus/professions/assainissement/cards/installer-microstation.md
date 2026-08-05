# Installer une microstation (ANC compact)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `installer-microstation` |
| Titre | Installer une microstation (ANC compact) |
| Profession | `metier:assainissement` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:assainissement` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : installer une microstation d'épuration (ANC compact agréé) en alternative à la filière fosse + épandage. `[C]`
- **Résumé** : poser la microstation **agréée** (numéro d'agrément) selon la notice du fabricant (assise, ancrage anti-flottement, alimentation électrique par un professionnel), raccorder l'entrée/sortie et la ventilation, et prévoir l'**entretien régulier** (vidange des boues) ; filière soumise à **contrôle SPANC**. `[C]` ⟦modèle/agrément/entretien selon fabricant à confirmer⟧

## Réalisation
- **Étapes** :
  1. Vérifier l'**agrément** et l'adéquation au projet (SPANC). `[A]` ⟦à confirmer⟧
  2. Poser (assise, **ancrage anti-flottement**), selon notice. `[C]`
  3. Raccorder entrée/sortie/ventilation ; **alimentation élec = pro**. `[C]`
  4. Planifier l'**entretien** (vidange des boues). `[C]` → [entretenir-vidanger-assainissement](entretenir-vidanger-assainissement.md)
- **Points critiques** : microstation **agréée** ; ancrage anti-flottement ; entretien régulier indispensable (sinon dysfonctionnement) ; SPANC.
- **Sécurité** : H₂S/espace confiné ; électricité (raccordement pro) ; biologique. **Espace confiné** (regard, poste de relevage, fosse) : **danger mortel** — **gaz toxiques (H₂S)**, **manque d'oxygène**, risque d'explosion → **jamais de descente sans procédure** (détection d'atmosphère, **ventilation forcée**, **surveillant** extérieur, harnais/treuil, autorisation) — opération **réservée à des intervenants formés/équipés**. **Risque biologique / contamination** (eaux usées) : EPI, hygiène, vaccination. **Levage des tampons** (lourds/coincés) : outil adapté, écrasement/dos. **Fouilles** : blindage (effondrement). **Réseaux enterrés** (DICT). **Arrêt immédiat en cas de danger.** Opérations réglementées (ANC, espace confiné) **réservées aux professionnels qualifiés**.** `[A]`

## Cadre & suites
- **Normes** : assainissement non collectif **DTU 64.1** ; évacuation EU/EP **DTU 60.11** ; mise en œuvre/essais des collecteurs **NF EN 1610**, réglementation ANC (**arrêté du 7 sept. 2009**, contrôle **SPANC**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Dysfonctionnement** : `traite-diagnostic` → [dysfonctionnement-anc](../../../diagnostics/assainissement/dysfonctionnement-anc.md)

## Relations & tags
- **Tags** : `metier:assainissement famille:gros-oeuvre sous-famille:assainissement intervention:poser cluster:microstations cluster:assainissement-non-collectif complexite:avancee type:installation securite:confine relation:electricite-generale`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
