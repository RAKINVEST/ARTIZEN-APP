# Entretenir / reprendre une peinture

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `entretenir-reprendre-peinture` |
| Titre | Entretenir / reprendre une peinture |
| Profession | `metier:peinture` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:peinture` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : entretenir une peinture et réaliser des **reprises** (raccords, retouches) sans marque visible. `[C]`
- **Résumé** : nettoyer les surfaces (lessivage doux), diagnostiquer les défauts (usure, taches, cloquage), réaliser des **reprises** en respectant la même teinte/le même produit et en **dégrad ant** le raccord (limiter la reprise à un pan complet si la teinte a évolué), et planifier la réfection ; la peinture protège aussi le support. `[C]`

## Réalisation
- **Étapes** :
  1. Nettoyer (lessivage doux) ; diagnostiquer les défauts. `[C]` → [defaut-application-peinture](../../../diagnostics/peinture/defaut-application-peinture.md)
  2. **Reprises** : même teinte/produit ; dégrader le raccord. `[C]`
  3. Raccord visible → reprendre **un pan complet**. `[C]`
  4. Planifier la réfection (usure/support). `[C]` → [controle-maintenance-peinture](../../../checklists/peinture/controle-maintenance-peinture.md)
- **Points critiques** : raccord invisible (même produit/teinte ; pan complet si évolution) ; traiter la cause des défauts ; entretien préventif.
- **Sécurité** : COV (produits) ; poussières (préparation) ; hauteur. **Poussières de ponçage** (enduits/anciennes peintures) : masque adapté, ponçage à **aspiration**, ventilation. **COV et solvants** : privilégier la **phase aqueuse / faible COV**, **ventiler** pendant et après, EPI (masque solvants, gants) — risque respiratoire/neurotoxique. **Inflammabilité** : produits solvantés/aérosols **inflammables** → pas de flamme/source d'ignition ; **chiffons imprégnés = risque d'auto-échauffement** (stockage/immersion). **Travail en hauteur** (plafonds/cages) : échafaudage/plateforme, EPI. **Électricité** : avant de peindre à proximité des appareillages, **couper / déposer et protéger** prises/interrupteurs (ne pas peindre sous tension/sur bornes) — NF C 15-100. **Plomb en rénovation** : sur bâti ancien (avant 1949), **diagnostic plomb (CREP)** avant travaux ; en présence de plomb, **ne pas poncer à sec** (empoussièrement toxique) → **arrêt** ; traitement réservé à une **activité spécialisée** (jamais ici). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : travaux de peinture des bâtiments **DTU 59.1** ; électricité (dépose/protection des appareillages) **NF C 15-100** ; teneur en **COV** (**directive 2004/42/CE**, étiquetage émissions A+/A/B/C), diagnostic **plomb (CREP)** avant travaux (Code de la santé) et prévention (**INRS**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Kit** : `utilise-kit` → [kit-peintre](../../../kits/peinture/kit-peintre.md)

## Relations & tags
- **Tags** : `metier:peinture famille:finition sous-famille:peinture intervention:entretenir intervention:reparer cluster:reprises cluster:entretien cluster:maintenance complexite:moyenne type:entretien securite:cov`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
