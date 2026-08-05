# Contrôle / maintenance revêtement de sol

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controle-maintenance-sol` |
| Titre | Contrôle / maintenance revêtement de sol |
| Profession | `metier:revetements-sol` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:revetements-sol` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Points à vérifier
- [ ] **Support** préparé (plan/sec/cohésif) + primaire/ragréage. `[C]`
- [ ] **Collage** correct (pas de cloque) ; **joints soudés** (local classant). `[C]`
- [ ] Flottant : **jeux de dilatation** périphériques respectés. `[C]`
- [ ] **UPEC** adapté au trafic ; entretien conforme. `[C]`
- [ ] Sols techniques : dalles stables/accessibles ; élec sécurisée. `[C]`
- [ ] Rénovation : **amiante** (anciennes dalles/colles) vérifié. `[A]`

> COV/colles = **ventilation** ; manutention = **binôme** ; genoux = **genouillères**.

## Cadre
- **Normes** : revêtements de sol PVC collés **DTU 53.2** ; revêtements textiles / moquettes **DTU 53.1** ; pose flottante des sols stratifiés **DTU 51.11** (interface) ; électricité (avant découpe/percement, sols techniques) **NF C 15-100** ; classement **UPEC**, étiquetage **COV** et diagnostic **amiante** (anciennes dalles/colles) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `verifie` → [entretenir-reprendre-sol](../../professions/revetements-sol/cards/entretenir-reprendre-sol.md).
- **Tags** : `metier:revetements-sol famille:finition sous-famille:revetements-sol type:checklist cluster:entretien cluster:maintenance securite:cov`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
