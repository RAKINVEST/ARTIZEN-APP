# Sécurité — COV, poussières & plomb (peinture)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `securite-cov-plomb-peinture` |
| Titre | Sécurité — COV, poussières & plomb (peinture) |
| Profession | `metier:peinture` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## Points à vérifier
- [ ] **Poussières de ponçage** : masque adapté + aspiration + ventilation. `[A]`
- [ ] **COV / solvants** : produits faible COV, **ventilation** pendant/après, EPI. `[A]`
- [ ] **Inflammabilité** : pas de flamme ; **chiffons imprégnés** immergés (auto-échauffement). `[A]`
- [ ] **Travail en hauteur** : échafaudage/plateforme + EPI. `[A]`
- [ ] **Électricité** : appareillages déposés/protégés avant peinture. `[A]`
- [ ] **Plomb** (rénovation) : CREP ; pas de ponçage à sec ; retrait = **spécialisé** ; **arrêt** si danger. `[A]`

## Cadre
- **Normes** : travaux de peinture des bâtiments **DTU 59.1** ; électricité (dépose/protection des appareillages) **NF C 15-100** ; teneur en **COV** (**directive 2004/42/CE**, étiquetage émissions A+/A/B/C), diagnostic **plomb (CREP)** avant travaux (Code de la santé) et prévention (**INRS**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-procedure` → [diagnostic-plomb-cov-avant-travaux](../../procedures/peinture/diagnostic-plomb-cov-avant-travaux.md).
- **Tags** : `metier:peinture famille:finition sous-famille:securite type:checklist cluster:reglementation securite:cov securite:plomb`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
