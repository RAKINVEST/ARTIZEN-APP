# Déperdition / pont thermique

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `deperdition-pont-thermique` |
| Titre | Déperdition / pont thermique |
| Profession | `metier:isolation` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:isolation` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- **Paroi froide**, sensation d'inconfort, factures élevées, condensation localisée. `[C]`

## Causes probables
1. **Pont thermique** (liaison plancher/refend, tableau de menuiserie). `[C]` → [traiter-ponts-thermiques](../../professions/isolation/cards/traiter-ponts-thermiques.md)
2. Isolation **insuffisante** ou discontinue. `[C]`
3. Défaut d'étanchéité à l'air. `[C]` → [poser-pare-vapeur](../../professions/isolation/cards/poser-pare-vapeur.md)

## Résolution
- Rétablir la **continuité** de l'isolation ; réduit d'autant le **besoin de chauffage**. `[C]` → [entretenir-chaudiere](../../professions/chauffage/cards/entretenir-chaudiere.md)

## Cadre
- **Normes** : isolation des combles par soufflage **DTU 45.10** ; isolation thermique de combles **DTU 45.11** ; doublage / plaques de plâtre (isolation intérieure) **DTU 25.41** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [traiter-ponts-thermiques](../../professions/isolation/cards/traiter-ponts-thermiques.md).
- **Tags** : `metier:isolation famille:enveloppe sous-famille:isolation probleme:deperdition probleme:pont-thermique cluster:ponts-thermiques cluster:diagnostic type:diagnostic securite:respiratoire relation:chauffage`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
