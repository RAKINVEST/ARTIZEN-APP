# Étaiement avant ouverture / reprise en sous-œuvre

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `etaiement-avant-ouverture` |
| Titre | Étaiement avant ouverture / reprise en sous-œuvre |
| Profession | `metier:maconnerie` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## But
- Reprendre provisoirement les charges avant d'ouvrir/reprendre un mur porteur. `[B]`

## Étapes (compétences structure requises)
1. **Étude** préalable (charges, schéma statique, dimensionnement). `[A]` ⟦requise⟧
2. Mettre en place l'**étaiement** (étais/madriers) sur appuis sains. `[B]`
3. Vérifier la reprise **avant** toute ouverture. `[A]`
4. Ouvrir/reprendre ; poser linteau ; retirer l'étaiement **progressivement**. `[B]`

> Un étaiement insuffisant = **risque d'effondrement**. Opération réservée à des compétences adaptées. `[A]`

## Cadre
- **Normes** : ouvrages en maçonnerie de petits éléments **DTU 20.1** ; cloisons en maçonnerie **DTU 20.13** ; chaînages / éléments en béton **DTU 21** ; calcul **Eurocode 6 (NF EN 1996)** ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [realiser-ouverture-linteau](../../professions/maconnerie/cards/realiser-ouverture-linteau.md).
- **Tags** : `metier:maconnerie famille:gros-oeuvre sous-famille:securite intervention:etayer cluster:ouvertures cluster:reprises cluster:securite type:procedure securite:structure relation:demolition`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
