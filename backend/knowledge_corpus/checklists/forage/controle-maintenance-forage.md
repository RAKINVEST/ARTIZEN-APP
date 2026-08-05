# Contrôle / maintenance forage & puits

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controle-maintenance-forage` |
| Titre | Contrôle / maintenance forage & puits |
| Profession | `metier:forage` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:forage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Points à vérifier
- [ ] **Tête / protection sanitaire** étanche (capot, cimentation surface). `[C]`
- [ ] **Débit / rabattement** stables (pas de baisse anormale). `[C]`
- [ ] **Pompe** : fonctionnement, immersion, protection électrique. `[C]`
- [ ] **Qualité de l'eau** : analyse à jour (usage alimentaire). `[A]`
- [ ] **Crépine** non colmatée ; désinfection après travaux. `[C]`
- [ ] Ouvrage **protégé** (pas de risque de chute). `[C]`

> **Espace confiné** : contrôle depuis la surface ; jamais de descente sans procédure.

## Cadre
- **Normes** : puits traditionnel maçonné (margelle/cuvelage) **DTU 20.1** ; alimentation électrique des pompes immergées **NF C 15-100** ; forage d'eau selon les règles de l'art (**NF X10-999**), réglementation (**Code de l'environnement** — loi sur l'eau, déclaration en mairie) et qualité de l'eau (**arrêté du 11 janvier 2007**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `verifie` → [entretenir-controler-forage](../../professions/forage/cards/entretenir-controler-forage.md).
- **Tags** : `metier:forage famille:gros-oeuvre sous-famille:forage type:checklist cluster:controle cluster:protection-sanitaire cluster:entretien securite:nappe`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
