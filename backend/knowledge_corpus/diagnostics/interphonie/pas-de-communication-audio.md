# Pas de communication audio

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `pas-de-communication-audio` |
| Titre | Pas de communication audio |
| Profession | `metier:interphonie` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:interphonie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- **Pas de son** (aucune communication) entre platine et moniteur/combiné. `[C]`

## Causes probables
1. **Câblage bus 2 fils** (polarité/longueur/dérivation) ou IP. `[C]` → [cabler-bus-2-fils](../../professions/interphonie/cards/cabler-bus-2-fils.md)
2. **Alimentation** absente/insuffisante. `[C]` → [installer-moniteur-combine](../../professions/interphonie/cards/installer-moniteur-combine.md)
3. **Adressage** / configuration incorrects (collectif). `[C]`

## Résolution
- Vérifier câblage/alimentation/adressage, tester ; côté alimentation → **habilité**. `[C]`

## Cadre
- **Normes** : alimentation des équipements **NF C 15-100** ; consignation à l'intervention **NF C 18-510** ; systèmes d'interphonie de bâtiment **EN 62820**, communication **SIP** (IP), données/images (**RGPD**, **CNIL**) et cybersécurité (**ANSSI**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [essayer-maintenir-interphonie](../../professions/interphonie/cards/essayer-maintenir-interphonie.md).
- **Tags** : `metier:interphonie famille:electricite sous-famille:interphonie probleme:audio cluster:bus-2-fils cluster:diagnostic type:diagnostic securite:coexistence`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
