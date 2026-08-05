# Phrase — normes & réglementation agencement

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `normes-reglementation-agencement` |
| Titre | Phrase — normes & réglementation agencement |
| Profession | `metier:agencement` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:agencement` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Formulation (clusters « Normes » / « Réglementation »)
> « Nos agencements sur mesure respectent les règles de l'art : menuiserie intérieure/meubles bois (**DTU 36.2**, **DTU 36.1**), la **stabilité des meubles de rangement** (**EN 14749**) avec **fixation anti-basculement**, et des réservations électriques conformes (**NF C 15-100**, éclairage intégré). » `[C]` ⟦versions/exigences exactes à valider par un expert⟧

> **Interfaces réservées** : le **raccordement électrique** (éclairage intégré → Électricité), le **raccordement plomberie** (→ Plomberie) et le **retrait d'amiante** (→ Désamiantage) ne sont **jamais réalisés en agencement**. `[C]`

> **Frontières** : l'agencement s'appuie sur la **Menuiserie intérieure** (meubles/quincaillerie), la **Cuisine** en est une spécialité, la **Peinture** finit les boiseries ; l'éclairage relève de l'**Électricité** (Livres existants). `[C]`

## Cadre
- **Normes** : menuiseries intérieures / meubles en bois **DTU 36.2**, **DTU 36.1** ; électricité (éclairage intégré / percement, **interface**) **NF C 15-100** ; stabilité des meubles de rangement (**EN 14749**), anti-basculement et diagnostic **amiante** (ouvrages anciens) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [installer-quincaillerie-ferrures](../../professions/menuiserie-interieure/cards/installer-quincaillerie-ferrures.md).
- **Tags** : `metier:agencement famille:finition type:phrase usage:normes cluster:normes cluster:reglementation relation:menuiserie-interieure relation:cuisine relation:peinture relation:electricite-generale relation:desamiantage`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
