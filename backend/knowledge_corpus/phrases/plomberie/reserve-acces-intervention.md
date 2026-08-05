# Phrase — réserve d'accès à l'intervention

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `reserve-acces-intervention` |
| Titre | Phrase — réserve d'accès à l'intervention |
| Profession | `metier:plomberie` |
| Famille | `famille:fluides` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **D** |

## Formulation
> ⟦Exemple : « L'intervention suppose un accès dégagé et sécurisé à l'ouvrage ; à défaut, un délai/coût supplémentaire peut s'appliquer. » — formulation à valider.⟧ `[D]`

## Cadre
- **Normes** : installation sanitaire — **DTU 60.1** `[B]` ⟦référence exacte à confirmer par le validateur⟧. `respecte-norme`
- **Relations** : `cite-checklist` → [securite-avant-intervention](../../checklists/plomberie/securite-avant-intervention.md).
- **Tags** : `metier:plomberie famille:fluides type:phrase usage:reserve cluster:securite`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | consolidation au standard Factory (Brouillon) |
