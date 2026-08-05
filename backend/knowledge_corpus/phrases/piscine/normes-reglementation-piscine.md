# Phrase — normes & réglementation piscine

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `normes-reglementation-piscine` |
| Titre | Phrase — normes & réglementation piscine |
| Profession | `metier:piscine` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:piscine` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Formulation (clusters « Normes » / « Réglementation »)
> « Nos piscines respectent les règles de l'art : structure béton (**interface** maçonnerie, **DTU 21**), **sécurité électrique** des piscines (**NF C 15-100** partie 7-702, liaison équipotentielle) et **sécurité anti-noyade obligatoire** (barrière/alarme/couverture/abri, **NF P 90-306 à 90-309**). » `[C]` ⟦versions/exigences exactes à valider par un expert⟧

> **Interfaces réservées** : le **raccordement électrique** (→ Électricité), l'**alimentation en eau potable** (→ Plomberie) et le **retrait d'amiante** (→ Désamiantage) ne sont **jamais réalisés ici**. `[C]`

> **Frontières** : la piscine s'appuie sur le **Terrassement** (fouille), la **Maçonnerie** (béton), le **Carrelage** (margelles/revêtement) et le **Traitement de l'eau** (chimie) — Livres existants ; l'électricité relève de l'**Électricité**. `[C]`

## Cadre
- **Normes** : sécurité électrique des piscines (volumes 0/1/2, liaison équipotentielle) **NF C 15-100** (partie 7-702) ; structure béton du bassin (**interface** maçonnerie) **DTU 21** ; **sécurité des piscines** — barrières / alarmes / couvertures / abris **NF P 90-306 à 90-309** et **obligation légale** (Code de la construction), norme européenne **NF EN 16582** ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [principe-traitement-eau](../../professions/traitement-eau/cards/principe-traitement-eau.md).
- **Tags** : `metier:piscine famille:specialises type:phrase usage:normes cluster:normes cluster:reglementation relation:terrassement relation:maconnerie relation:carrelage relation:traitement-eau relation:electricite-generale relation:desamiantage`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
