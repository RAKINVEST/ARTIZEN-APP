# Descente EP bouchée

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `descente-ep-bouchee` |
| Titre | Descente EP bouchée |
| Profession | `metier:zinguerie` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:zinguerie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Eau qui **déborde** à la naissance ; descente qui ne s'écoule pas. `[C]`

## Causes probables
1. **Bouchon** (feuilles, mousses, nid). `[C]`
2. Coude/raccord obstrué ou déformé. `[C]`
3. Réseau au sol bouché. `[C]` → [deboucher-evacuation-sanitaire](../../professions/plomberie/cards/deboucher-evacuation-sanitaire.md)

## Résolution
- Déboucher (furet/rinçage), poser crapaudine, contrôler l'écoulement. `[C]` → [controle-evacuation-ep](../../procedures/zinguerie/controle-evacuation-ep.md)

## Cadre
- **Normes** : évacuation des eaux pluviales **DTU 40.5** ; couverture zinc **DTU 40.41** ; couverture cuivre **DTU 40.45** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [poser-descente-ep](../../professions/zinguerie/cards/poser-descente-ep.md).
- **Tags** : `metier:zinguerie equipement:descente famille:enveloppe sous-famille:zinguerie probleme:obstruction cluster:diagnostic cluster:descentes-ep type:diagnostic securite:hauteur relation:plomberie`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
