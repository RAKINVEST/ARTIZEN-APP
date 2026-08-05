# Défaut d'application (reprises, coulures)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `defaut-application-peinture` |
| Titre | Défaut d'application (reprises, coulures) |
| Profession | `metier:peinture` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:peinture` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- **Traces de reprise**, coulures, différences de **brillance**, traînées de rouleau. `[C]`

## Causes probables
1. **Reprises** (pas 'humide sur humide') / séchage trop rapide. `[C]` → [peindre-murs-plafonds](../../professions/peinture/cards/peindre-murs-plafonds.md)
2. **Dilution / charge** de rouleau inadaptées ; couche trop épaisse (coulures). `[C]`
3. **Support** absorbant irrégulier (pas d'impression). `[C]` → [appliquer-impression](../../professions/peinture/cards/appliquer-impression.md)

## Résolution
- Poncer le défaut, uniformiser le fond (impression), reprendre **un pan complet** en humide sur humide. `[C]`

## Cadre
- **Normes** : travaux de peinture des bâtiments **DTU 59.1** ; électricité (dépose/protection des appareillages) **NF C 15-100** ; teneur en **COV** (**directive 2004/42/CE**, étiquetage émissions A+/A/B/C), diagnostic **plomb (CREP)** avant travaux (Code de la santé) et prévention (**INRS**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [entretenir-reprendre-peinture](../../professions/peinture/cards/entretenir-reprendre-peinture.md).
- **Tags** : `metier:peinture famille:finition sous-famille:peinture probleme:application cluster:peintures-murs-et-plafonds cluster:diagnostics type:diagnostic securite:cov`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
