# Phrase — normes & réglementation cuisine

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `normes-reglementation-cuisine` |
| Titre | Phrase — normes & réglementation cuisine |
| Profession | `metier:cuisine` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:cuisine` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Formulation (clusters « Normes » / « Réglementation »)
> « Nos cuisines sont posées selon les règles de l'art : meubles/caissons (menuiserie, **DTU 36.2**), avec des interfaces conformes — électricité (circuits spécialisés, **NF C 15-100**) et plomberie évier (**DTU 60.1**) réalisées par les corps d'état concernés, ventilation des appareils respectée. » `[C]` ⟦versions/exigences exactes à valider par un expert⟧

> **Interfaces réservées** : le **raccordement électrique** (Électricité), le **raccordement eau/évacuation** (Plomberie) et le **retrait d'amiante** (Désamiantage) ne sont **jamais réalisés en pose de cuisine** — renvoyés à leurs Livres. `[C]`

> **Frontières** : la cuisine s'appuie sur la **Menuiserie intérieure** (meubles/quincaillerie), la **Plomberie** (évier) et l'**Électricité** (électroménager) ; elle voisine l'**Agencement** (activité distincte, futur Livre). `[C]`

## Cadre
- **Normes** : meubles / caissons (menuiserie intérieure) **DTU 36.2** ; électricité de la cuisine (circuits spécialisés, **interface**) **NF C 15-100** ; plomberie évier / robinetterie (**interface**) **DTU 60.1** ; diagnostic **amiante** (ouvrages anciens) et **ventilation** des appareils ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [installer-quincaillerie-ferrures](../../professions/menuiserie-interieure/cards/installer-quincaillerie-ferrures.md).
- **Tags** : `metier:cuisine famille:finition type:phrase usage:normes cluster:normes cluster:reglementation relation:menuiserie-interieure relation:plomberie relation:electricite-generale relation:agencement relation:desamiantage`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
