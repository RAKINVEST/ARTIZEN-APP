# Contrôle / maintenance peinture

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controle-maintenance-peinture` |
| Titre | Contrôle / maintenance peinture |
| Profession | `metier:peinture` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:peinture` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Points à vérifier
- [ ] **Support** préparé (sec/sain/dépoussiéré) avant application. `[C]`
- [ ] **Impression** adaptée (adhérence/taches isolées). `[C]`
- [ ] **Finition** : couches/aspect uniformes ; pas de reprise visible. `[C]`
- [ ] **Appareillages** déposés/protégés ; élec sécurisée. `[A]`
- [ ] **Ventilation** (COV) pendant/après ; produits faible COV. `[A]`
- [ ] Rénovation : **plomb (CREP)** vérifié ; pas de ponçage à sec. `[A]`

> Poussières de ponçage = **masque/aspiration** ; hauteur = **EPI**.

## Cadre
- **Normes** : travaux de peinture des bâtiments **DTU 59.1** ; électricité (dépose/protection des appareillages) **NF C 15-100** ; teneur en **COV** (**directive 2004/42/CE**, étiquetage émissions A+/A/B/C), diagnostic **plomb (CREP)** avant travaux (Code de la santé) et prévention (**INRS**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `verifie` → [entretenir-reprendre-peinture](../../professions/peinture/cards/entretenir-reprendre-peinture.md).
- **Tags** : `metier:peinture famille:finition sous-famille:peinture type:checklist cluster:entretien cluster:maintenance securite:cov`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
