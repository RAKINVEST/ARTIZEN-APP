# Contrôle / maintenance d'une ITE

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controle-maintenance-ite` |
| Titre | Contrôle / maintenance d'une ITE |
| Profession | `metier:isolation-exterieure` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:isolation-exterieure` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Points à vérifier
- [ ] Finition saine (pas de **fissuration**/cloquage). `[C]`
- [ ] Absence de **décollement** (sonorité creuse). `[C]`
- [ ] **Soubassement** sans choc/perforation. `[C]`
- [ ] **Points singuliers** étanches (tableaux, appuis, débord). `[C]`
- [ ] Absence d'entrée d'eau / trace d'humidité. `[C]`
- [ ] **Entrées d'air** de ventilation non condamnées. `[C]`

> Accès **échafaudage** ; protections collectives + EPI ; météo favorable.

## Cadre
- **Normes** : systèmes **ETICS** relevant du **CPT 3035 (CSTB)** / **ETAG 004–EAD** et d'**Avis Techniques** ⟦cadre exact à confirmer⟧ ; support en maçonnerie **DTU 20.1** ; ITE ventilée à bardage rapporté bois **DTU 41.2** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `verifie` → [diagnostiquer-controler-ite](../../professions/isolation-exterieure/cards/diagnostiquer-controler-ite.md).
- **Tags** : `metier:isolation-exterieure famille:enveloppe sous-famille:isolation-exterieure type:checklist cluster:controle cluster:entretien cluster:points-singuliers securite:hauteur relation:ventilation`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
