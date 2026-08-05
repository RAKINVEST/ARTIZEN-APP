# Poser regards et ventilation du réseau

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `poser-regards-ventilation` |
| Titre | Poser regards et ventilation du réseau |
| Profession | `metier:assainissement` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:assainissement` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : poser les **regards** de visite et la **ventilation** (primaire/secondaire) du réseau d'assainissement. `[C]`
- **Résumé** : poser les regards aux points de visite (jonctions, changements), assurer la **ventilation primaire** (colonne prolongée en toiture, hors d'air) et, si nécessaire, la **ventilation secondaire** (évent) pour éviter le désiphonnage et évacuer les gaz ; cette ventilation est celle du **réseau d'égout** (distincte de la VMC). `[C]` ⟦dimensions/positions selon DTU 60.11 à confirmer⟧

## Réalisation
- **Étapes** :
  1. Poser **regards** de visite (jonctions/changements). `[C]`
  2. **Ventilation primaire** : colonne prolongée **en toiture** (hors d'air). `[C]`
  3. **Ventilation secondaire** (évent) si risque de désiphonnage. `[C]`
  4. Vérifier l'évacuation des **gaz** (odeurs/H₂S). `[C]` → [odeurs-assainissement](../../../diagnostics/assainissement/odeurs-assainissement.md)
- **Points critiques** : ventilation d'égout = anti-désiphonnage + évacuation des **gaz** (odeurs/H₂S) ; primaire en toiture ; ne pas confondre avec la VMC.
- **Sécurité** : H₂S (gaz) ; hauteur (sortie toiture) ; biologique. **Espace confiné** (regard, poste de relevage, fosse) : **danger mortel** — **gaz toxiques (H₂S)**, **manque d'oxygène**, risque d'explosion → **jamais de descente sans procédure** (détection d'atmosphère, **ventilation forcée**, **surveillant** extérieur, harnais/treuil, autorisation) — opération **réservée à des intervenants formés/équipés**. **Risque biologique / contamination** (eaux usées) : EPI, hygiène, vaccination. **Levage des tampons** (lourds/coincés) : outil adapté, écrasement/dos. **Fouilles** : blindage (effondrement). **Réseaux enterrés** (DICT). **Arrêt immédiat en cas de danger.** Opérations réglementées (ANC, espace confiné) **réservées aux professionnels qualifiés**.** `[A]`

## Cadre & suites
- **Normes** : assainissement non collectif **DTU 64.1** ; évacuation EU/EP **DTU 60.11** ; mise en œuvre/essais des collecteurs **NF EN 1610**, réglementation ANC (**arrêté du 7 sept. 2009**, contrôle **SPANC**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Réseaux** : `cite-carte` → [poser-reseau-eu-ep](poser-reseau-eu-ep.md)

## Relations & tags
- **Tags** : `metier:assainissement famille:gros-oeuvre sous-famille:assainissement intervention:poser cluster:regards cluster:ventilation-primaire cluster:ventilation-secondaire complexite:moyenne type:installation securite:confine`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
