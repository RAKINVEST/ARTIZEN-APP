# Contrôle / maintenance maçonnerie

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controle-maintenance-maconnerie` |
| Titre | Contrôle / maintenance maçonnerie |
| Profession | `metier:maconnerie` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:maconnerie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Points à vérifier
- [ ] **Joints** sains (pas de dégarnissage). `[C]`
- [ ] Absence de **fissures** évolutives (témoins si doute). `[C]`
- [ ] Absence d'**humidité** / salpêtre en pied de mur. `[C]`
- [ ] **Linteaux / appuis** sains (pas de flèche/écrasement). `[C]`
- [ ] **Scellements / fixations** en place. `[C]`
- [ ] Pas de surcharge / modification non étudiée. `[C]`

> Doute **structurel** → étude ; danger → **étaiement/évacuation** ; poussières = **silice**.

## Cadre
- **Normes** : ouvrages en maçonnerie de petits éléments **DTU 20.1** ; cloisons en maçonnerie **DTU 20.13** ; chaînages / éléments en béton **DTU 21** ; calcul **Eurocode 6 (NF EN 1996)** ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `verifie` → [diagnostiquer-maconnerie](../../professions/maconnerie/cards/diagnostiquer-maconnerie.md).
- **Tags** : `metier:maconnerie famille:gros-oeuvre sous-famille:maconnerie type:checklist cluster:controle cluster:entretien cluster:joints securite:structure`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
