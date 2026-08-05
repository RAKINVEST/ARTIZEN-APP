# Consignation d'eau

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `consignation-eau` |
| Titre | Consignation d'eau |
| Profession | `metier:plomberie` |
| Famille | `famille:fluides` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## But
- Supprimer la pression / l'eau avant intervention. `[B]`

## Étapes
1. Fermer la vanne d'arrêt concernée. `[B]`
2. Ouvrir un point bas pour **purger**. `[B]`
3. Vérifier **l'absence de pression** avant démontage. `[B]`

> Pour un équipement **électrique** (ex. chauffe-eau), la **consignation électrique** est un geste distinct (hors tension) — ⟦selon habilitation⟧. `[A]`

## Cadre
- **Normes** : installation sanitaire — **DTU 60.1** `[B]` ⟦référence exacte à confirmer par le validateur⟧. `respecte-norme`
- **Relations** : `cite-carte` → [entretenir-chauffe-eau-electrique](../../professions/plomberie/cards/entretenir-chauffe-eau-electrique.md).
- **Tags** : `metier:plomberie famille:fluides type:procedure cluster:securite intervention:consigner`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | consolidation au standard Factory (Brouillon) |
