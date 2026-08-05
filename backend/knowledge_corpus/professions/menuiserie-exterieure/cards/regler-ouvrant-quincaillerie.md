# Régler l'ouvrant et la quincaillerie

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `regler-ouvrant-quincaillerie` |
| Titre | Régler l'ouvrant et la quincaillerie |
| Profession | `metier:menuiserie-exterieure` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:menuiserie-exterieure` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : régler un ouvrant (aplomb, jeu, étanchéité de frappe) et sa quincaillerie (gonds, compas, crémone). `[C]`
- **Résumé** : diagnostiquer un ouvrant qui ferme mal, régler les **gonds/paumelles** (hauteur/latéral/pression), la **quincaillerie** (crémone, compas, gâches) et l'écrasement du **joint de frappe** pour rétablir étanchéité et manœuvre. `[C]` ⟦réglages selon ferrure/fabricant à confirmer⟧

## Réalisation
- **Étapes** :
  1. Diagnostiquer le défaut (frotte, ferme mal, prend l'air). `[C]` → [ouvrant-force-deregle](../../../diagnostics/menuiserie-exterieure/ouvrant-force-deregle.md)
  2. Régler **gonds/paumelles** (hauteur, latéral, **pression**). `[C]`
  3. Régler la **quincaillerie** (crémone, compas, gâches). `[C]`
  4. Vérifier l'écrasement du **joint de frappe** (étanchéité). `[C]`
- **Points critiques** : écrasement régulier du joint de frappe (étanchéité) ; jeux égaux ; ne pas forcer une ferrure grippée (lubrifier).
- **Sécurité** : pincement (doigts) ; ouvrant lourd ; hauteur. **Manutention** de menuiseries/**vitrages lourds** : risque d'écrasement / **coupure** (verre) — moyens de levage, gants anti-coupure, travail en binôme. **Travail en **hauteur** (baies d'étage, dépose) : protections collectives / EPI. **Produits** (mousse PU, mastics, solvants) : EPI / ventilation. **Motorisation de volet** : le **raccordement électrique** relève d'un professionnel (voir Électricité). **Stabilité** du support/de la baie vérifiée avant dépose. **Arrêt immédiat en cas de danger.** Une intervention relève de **compétences adaptées**.** `[A]`

## Cadre & suites
- **Normes** : mise en œuvre des fenêtres et portes extérieures **DTU 36.5** ; vitrerie-miroiterie **DTU 39** ; fermetures / volets **DTU 34.1** ; performance **classement AEV (Air-Eau-Vent)** ⟦à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Entretien** : `cite-carte` → [entretenir-controler-menuiserie](entretenir-controler-menuiserie.md)

## Relations & tags
- **Tags** : `metier:menuiserie-exterieure equipement:quincaillerie famille:enveloppe sous-famille:menuiserie-exterieure intervention:regler intervention:entretenir cluster:reglages cluster:quincaillerie cluster:ouvrants complexite:moyenne type:entretien securite:manutention`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
