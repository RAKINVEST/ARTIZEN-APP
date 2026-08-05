# Remplacer un flexible d'alimentation

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Confiance : A normes/fabricant · B technique · C terrain · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `remplacer-flexible-alimentation` |
| Titre | Remplacer un flexible d'alimentation (EF/ECS) |
| Profession | `metier:plomberie` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:alimentation` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : Remplacer un flexible d'alimentation défectueux (fuite, corrosion, âge) sur robinet/WC/chauffe-eau. `[C]`
- **Résumé** : Couper l'eau, déposer le flexible usé, choisir un flexible de **longueur et raccords** adaptés, poser avec joints neufs, rouvrir et contrôler l'étanchéité. `[C]`
- **Pré-requis** : flexible neuf adapté (longueur, Ø raccords, norme sanitaire). `[B]`
- **Difficulté** : `simple` `[C]`
- **Temps moyen** : ~10–20 min `[C]` ⟦à confirmer⟧

## Ressources
- **Outillage** : `outil:manuel` (clés). `[C]`
- **Matériel** : flexible sanitaire adapté (`materiau:inox` tressé courant). `[B]`
- **Consommables** : joints fibre/EPDM neufs. `[C]`
- **Kit conseillé** : `utilise-kit` → [kit-robinetterie](../../../kits/plomberie/kit-robinetterie.md)

## Réalisation
- **Étapes** :
  1. Couper l'eau et purger la pression. `[B]`
  2. Déposer le flexible usé (retenir le robinet pour ne pas le vriller). `[C]`
  3. Choisir un flexible de **bonne longueur** (sans tension ni coude serré). `[B]`
  4. Poser avec **joints neufs** ; serrer sans excès (ne pas mater le joint). `[C]`
  5. Rouvrir progressivement ; contrôler l'étanchéité aux 2 raccords. `[C]`
- **Contrôles** : `a-checklist` → [controle-etancheite](../../../checklists/plomberie/controle-etancheite.md)
- **Points critiques** : longueur/rayon de courbure ; **ne pas vriller** ; compatibilité des raccords. `[C]`
- **Sécurité** : couper l'eau ; eau chaude résiduelle sur ECS. `[B]`

## Cadre & suites
- **Normes** : alimentation eau potable — **DTU 60.1** ; matériaux au **contact eau potable** (aptitude sanitaire) `[B]` ⟦référence exacte à confirmer⟧.
- **Garantie** : `cite-phrase` → [garantie-piece-main-oeuvre](../../../phrases/plomberie/garantie-piece-main-oeuvre.md)
- **Diagnostics liés** : `traite-diagnostic` → [fuite-sous-evier](../../../diagnostics/plomberie/fuite-sous-evier.md)

## Relations & tags
- **Relations** : `utilise-kit`, `a-checklist`, `traite-diagnostic`, `cite-phrase`.
- **Tags** : `metier:plomberie famille:fluides sous-famille:alimentation intervention:remplacer probleme:fuite probleme:usure materiau:inox piece:cuisine piece:salle-de-bain complexite:simple type:reparation`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-02 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
