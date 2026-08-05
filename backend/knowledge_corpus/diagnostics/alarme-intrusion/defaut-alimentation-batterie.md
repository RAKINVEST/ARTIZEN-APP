# Défaut d'alimentation / batterie de secours

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `defaut-alimentation-batterie` |
| Titre | Défaut d'alimentation / batterie de secours |
| Profession | `metier:alarme-intrusion` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:alarme-intrusion` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Défaut **secteur**/batterie signalé, système qui s'arrête en coupure, piles radio faibles. `[C]`

## Causes probables
1. **Batterie de secours** en fin de vie (autonomie nulle). `[C]` → [essayer-maintenir-alarme](../../professions/alarme-intrusion/cards/essayer-maintenir-alarme.md)
2. **Alimentation secteur** absente/défaillante. `[C]` → [controler-tableau-electrique](../../professions/electricite-generale/cards/controler-tableau-electrique.md)
3. **Piles** des éléments radio épuisées. `[C]`

## Résolution
- Remplacer batterie/piles, vérifier l'alimentation (habilité côté secteur), tester la **continuité** en coupure. `[C]`

## Cadre
- **Normes** : alimentation électrique de la centrale **NF C 15-100** ; consignation à l'intervention **NF C 18-510** ; systèmes d'alarme intrusion **EN 50131** (grades), règles **APSAD** (R81/R82) / certification **NF&A2P** (**CNPP**), données **RGPD** et cybersécurité (**ANSSI**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [essayer-maintenir-alarme](../../professions/alarme-intrusion/cards/essayer-maintenir-alarme.md).
- **Tags** : `metier:alarme-intrusion famille:electricite sous-famille:alarme-intrusion probleme:alimentation cluster:centrales-d-alarme cluster:diagnostic type:diagnostic securite:electrique relation:electricite-generale`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
