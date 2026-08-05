# Gouttière qui fuit / déborde

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `gouttiere-fuite-debordement` |
| Titre | Gouttière qui fuit / déborde |
| Profession | `metier:zinguerie` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:zinguerie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- **Fuite** à une jonction ou **débordement** de la gouttière. `[C]`

## Causes probables
1. **Bouchage** (feuilles) / crapaudine absente. `[C]` → [controle-evacuation-ep](../../procedures/zinguerie/controle-evacuation-ep.md)
2. **Pente** incorrecte / contre-pente. `[C]`
3. **Jonction/soudure** défaillante ou corrosion. `[C]` → [controler-reparer-chenaux](../../professions/zinguerie/cards/controler-reparer-chenaux.md)

## Résolution
- Nettoyer, corriger la pente, ressouder/remplacer l'élément. `[C]` → [poser-remplacer-gouttiere](../../professions/zinguerie/cards/poser-remplacer-gouttiere.md)

## Cadre
- **Normes** : évacuation des eaux pluviales **DTU 40.5** ; couverture zinc **DTU 40.41** ; couverture cuivre **DTU 40.45** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [poser-remplacer-gouttiere](../../professions/zinguerie/cards/poser-remplacer-gouttiere.md).
- **Tags** : `metier:zinguerie equipement:gouttiere famille:enveloppe sous-famille:zinguerie probleme:fuite probleme:debordement cluster:diagnostic cluster:gouttieres type:diagnostic securite:hauteur`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
