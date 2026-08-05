# Plan de travail dégradé / joint infiltré

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `plan-travail-degrade-joint` |
| Titre | Plan de travail dégradé / joint infiltré |
| Profession | `metier:cuisine` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:cuisine` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Plan **gonflé** (stratifié), joint évier/crédence **fissuré/moisi**, infiltration sous l'évier. `[C]`

## Causes probables
1. **Joint d'étanchéité** (évier/crédence) dégradé → infiltration. `[C]` → [poser-plan-travail](../../professions/cuisine/cards/poser-plan-travail.md)
2. **Chant** de découpe non protégé (stratifié gonfle à l'eau). `[C]`
3. Fuite à l'évier (→ **Plomberie**). `[C]` → [poser-mitigeur-evier](../../professions/plomberie/cards/poser-mitigeur-evier.md)

## Résolution
- Refaire les **joints souples**, protéger les chants, traiter la fuite (Plomberie) ; remplacer la zone gonflée. `[C]`

## Cadre
- **Normes** : meubles / caissons (menuiserie intérieure) **DTU 36.2** ; électricité de la cuisine (circuits spécialisés, **interface**) **NF C 15-100** ; plomberie évier / robinetterie (**interface**) **DTU 60.1** ; diagnostic **amiante** (ouvrages anciens) et **ventilation** des appareils ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [poser-plan-travail](../../professions/cuisine/cards/poser-plan-travail.md).
- **Tags** : `metier:cuisine famille:finition sous-famille:cuisine probleme:etancheite cluster:plans-de-travail cluster:diagnostic type:diagnostic securite:manutention relation:plomberie`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
