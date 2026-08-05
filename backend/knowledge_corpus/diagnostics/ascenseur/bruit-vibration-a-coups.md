# Bruit / vibrations / à-coups en marche

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `bruit-vibration-a-coups` |
| Titre | Bruit / vibrations / à-coups en marche |
| Profession | `metier:ascenseur` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:ascenseur` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- **Bruit** anormal, **vibrations**, **à-coups**, arrêts imprécis, confort dégradé. `[C]`

## Causes probables (à confirmer par l'habilité)
1. **Guides** / galets (usure, alignement). `[C]` → [identifier-composants-gaine-cabine](../../professions/ascenseur/cards/identifier-composants-gaine-cabine.md)
2. **Câbles / poulies** (usure, tension). `[C]` → [comprendre-machinerie-motorisation](../../professions/ascenseur/cards/comprendre-machinerie-motorisation.md)
3. **Variateur** / réglage de la motorisation (précision d'arrêt). `[C]`

## Conduite à tenir
- Signaler à l'ascensoriste (contrat d'entretien) ; le diagnostic précis et le réglage sont **réservés**. `[C]`

## Cadre
- **Normes** : gaine (génie civil béton, **interface** maçonnerie) **DTU 21** ; alimentation électrique (**interface**) **NF C 15-100** ; sécurité des ascenseurs **NF EN 81-20 / NF EN 81-50**, accessibilité **NF EN 81-70**, amélioration de l'existant **NF EN 81-80** (SNEL), **Directive Ascenseurs 2014/33/UE** et réglementation d'entretien / contrôle technique (Code de la construction) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [comprendre-machinerie-motorisation](../../professions/ascenseur/cards/comprendre-machinerie-motorisation.md).
- **Tags** : `metier:ascenseur famille:specialises sous-famille:ascenseur probleme:confort cluster:cables-poulies cluster:diagnostic type:diagnostic securite:ecrasement`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
