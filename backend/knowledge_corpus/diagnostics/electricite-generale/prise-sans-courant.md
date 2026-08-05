# Prise sans courant

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `prise-sans-courant` |
| Titre | Prise sans courant |
| Profession | `metier:electricite-generale` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:appareillage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Une (ou plusieurs) prise(s) **sans courant**. `[C]`

## Causes probables
1. Disjoncteur/différentiel du circuit déclenché. `[C]`
2. Connexion desserrée (borne, dominos, boro). `[C]`
3. Prise ou circuit défectueux. `[C]` → [remplacer-prise-courant](../../professions/electricite-generale/cards/remplacer-prise-courant.md)

## Démarche
- Vérifier le tableau, tester la prise, contrôler la **continuité** hors tension. `[C]` → [mesurer-continuite-circuit](../../professions/electricite-generale/cards/mesurer-continuite-circuit.md)

## Cadre
- **Normes** : installations électriques BT **NF C 15-100** ; opérations/consignation **NF C 18-510** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [remplacer-prise-courant](../../professions/electricite-generale/cards/remplacer-prise-courant.md).
- **Tags** : `metier:electricite-generale famille:electricite sous-famille:appareillage probleme:pas-de-courant cluster:diagnostic cluster:depannage cluster:circuits-prises type:diagnostic securite:electrique`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
