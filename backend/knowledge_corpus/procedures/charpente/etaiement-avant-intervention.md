# Étaiement avant intervention structurelle

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `etaiement-avant-intervention` |
| Titre | Étaiement avant intervention structurelle |
| Profession | `metier:charpente` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## But
- Reprendre provisoirement les charges pour intervenir en sécurité sur un élément porteur. `[B]`

## Étapes (compétences structure requises)
1. **Évaluer les charges** et le schéma statique. `[B]` ⟦étude si doute⟧
2. Mettre en place l'**étaiement** (étais/madriers) sur appuis sains. `[B]`
3. Vérifier la reprise avant toute dépose/coupe. `[A]`
4. Retirer l'étaiement **progressivement** après intervention. `[B]`

> Un étaiement insuffisant = **risque d'effondrement**. Opération réservée à des compétences adaptées. `[A]`

## Cadre
- **Normes** : charpente et escaliers en bois **DTU 31.1** ; charpentes assemblées par connecteurs **DTU 31.3** ; calcul des structures bois **Eurocode 5 (NF EN 1995)** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [renforcer-panne-ferme](../../professions/charpente/cards/renforcer-panne-ferme.md).
- **Tags** : `metier:charpente famille:enveloppe sous-famille:securite intervention:etayer cluster:securite cluster:reparation type:procedure securite:structure securite:hauteur`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
