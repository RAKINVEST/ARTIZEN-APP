# Kit peintre

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `kit-peintre` |
| Titre | Kit peintre |
| Profession | `metier:peinture` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:peinture` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Composition conseillée
- Rouleaux/brosses/pinceaux, bac, **ponceuse à aspiration**, cales/abrasifs. `[C]`
- Enduits (rebouchage/finition), **impression**/fixateur, adhésifs de masquage, bâches. `[C]`
- **Primaire antirouille** (métaux), sous-couche bois. `[C]`
- **EPI** : masque **poussières** + **solvants/COV**, gants, antichute (hauteur) ; FFP + arrêt si **plomb** (→ spécialisé). `[A]`

## Cadre
- **Normes** : travaux de peinture des bâtiments **DTU 59.1** ; électricité (dépose/protection des appareillages) **NF C 15-100** ; teneur en **COV** (**directive 2004/42/CE**, étiquetage émissions A+/A/B/C), diagnostic **plomb (CREP)** avant travaux (Code de la santé) et prévention (**INRS**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `utilise-kit` → [preparer-support-peinture](../../professions/peinture/cards/preparer-support-peinture.md).
- **Tags** : `metier:peinture famille:finition sous-famille:peinture type:kit cluster:preparation-des-supports cluster:poncage equipement:ponceuse-aspiration`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
