# Condensation / moisissure liée à l'isolation

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `condensation-moisissure-isolation` |
| Titre | Condensation / moisissure liée à l'isolation |
| Profession | `metier:isolation` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:isolation` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- **Condensation**, taches noires (**moisissures**), odeur d'humidité sur parois isolées. `[C]`

> Ne **jamais** isoler/recouvrir sur support humide ou moisi : traiter la cause d'abord. `[B]`

## Causes probables
1. **Pare/frein-vapeur** absent, discontinu ou mal placé. `[C]` → [poser-pare-vapeur](../../professions/isolation/cards/poser-pare-vapeur.md)
2. **Ventilation insuffisante** (air trop humide). `[C]` → [entretenir-vmc-simple-flux](../../professions/ventilation/cards/entretenir-vmc-simple-flux.md)
3. Pont thermique créant un point froid. `[C]`

## Résolution
- Rétablir gestion de la vapeur + **ventilation**, traiter le point froid, puis reprendre l'isolation. `[C]`

## Cadre
- **Normes** : isolation des combles par soufflage **DTU 45.10** ; isolation thermique de combles **DTU 45.11** ; doublage / plaques de plâtre (isolation intérieure) **DTU 25.41** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [poser-pare-vapeur](../../professions/isolation/cards/poser-pare-vapeur.md).
- **Tags** : `metier:isolation famille:enveloppe sous-famille:isolation probleme:condensation probleme:moisissure cluster:diagnostic cluster:pare-vapeur type:diagnostic securite:respiratoire relation:ventilation relation:etancheite`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
