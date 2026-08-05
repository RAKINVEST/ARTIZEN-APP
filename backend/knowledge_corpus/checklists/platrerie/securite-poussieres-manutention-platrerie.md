# Sécurité — poussières, manutention & amiante (plâtrerie)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `securite-poussieres-manutention-platrerie` |
| Titre | Sécurité — poussières, manutention & amiante (plâtrerie) |
| Profession | `metier:platrerie` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## Points à vérifier
- [ ] **Poussières de ponçage** : masque adapté + aspiration + ventilation. `[A]`
- [ ] **Manutention des plaques** : lève-plaque/binôme ; **TMS**. `[A]`
- [ ] **Travail en hauteur** (plafonds) : échafaudage/plateforme + EPI. `[A]`
- [ ] **Coupures** (cutter/rails) : gants ; **percements** : repérer/consigner l'élec. `[A]`
- [ ] **Amiante** (rénovation) : diagnostic fait ; retrait = **entreprise certifiée** (jamais ici). `[A]`
- [ ] **Arrêt immédiat** en cas de danger. `[A]`

## Cadre
- **Normes** : ouvrages en plaques de plâtre **DTU 25.41** ; doublages / habillages **DTU 25.42** ; plafonds suspendus **DTU 58.1** ; électricité (perc ements / boîtes) **NF C 15-100** ; en rénovation, diagnostic **amiante** avant travaux (Code de la santé) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-procedure` → [diagnostic-amiante-avant-renovation](../../procedures/platrerie/diagnostic-amiante-avant-renovation.md).
- **Tags** : `metier:platrerie famille:finition sous-famille:securite type:checklist cluster:reglementation securite:poussieres securite:amiante`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
