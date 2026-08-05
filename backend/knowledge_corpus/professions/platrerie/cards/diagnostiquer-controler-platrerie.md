# Diagnostiquer / contrôler une plâtrerie

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `diagnostiquer-controler-platrerie` |
| Titre | Diagnostiquer / contrôler une plâtrerie |
| Profession | `metier:platrerie` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:platrerie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : diagnostiquer les désordres (fissures de joints, humidité, fixation) et contrôler la planéité/finition. `[C]`
- **Résumé** : repérer les **fissures** (joints/angles), les traces d'**humidité** (plaque gonflée = fuite/condensation), la tenue des **fixations** (cloison qui bouge/sonne creux) et la **planéité**, qualifier la cause et orienter la reprise ; en rénovation, penser au **diagnostic amiante** préalable. `[C]`

## Réalisation
- **Étapes** :
  1. Repérer **fissures** de joints/angles. `[C]` → [fissure-joint-platrerie](../../../diagnostics/platrerie/fissure-joint-platrerie.md)
  2. Rechercher **humidité** (plaque gonflée/tachée). `[C]` → [plaque-degradee-humidite](../../../diagnostics/platrerie/plaque-degradee-humidite.md)
  3. Vérifier **fixations**/planéité (cloison qui bouge). `[C]` → [cloison-sonne-creux-fixation](../../../diagnostics/platrerie/cloison-sonne-creux-fixation.md)
  4. Rénovation : **diagnostic amiante** préalable. `[A]` → [diagnostic-amiante-avant-renovation](../../../procedures/platrerie/diagnostic-amiante-avant-renovation.md)
- **Points critiques** : distinguer fissure de finition / mouvement structurel ; traiter la cause d'humidité ; **amiante** en rénovation.
- **Sécurité** : poussières ; amiante (rénovation) ; hauteur. **Poussières de plâtre** (découpe/ponçage des bandes) : masque, aspiration, ventilation. **Manutention des plaques** (lourdes/encombrantes) : lève-plaque, binôme, gestes — **TMS**. **Travail en hauteur** (plafonds suspendus) : échafaudage/plateforme, EPI. **Coupures** (cutter, plaques, rails métalliques — arêtes vives) : gants. **Électricité lors des percements** : repérer/consigner circuits et gaines **avant de percer/visser** (risque de percer un câble sous tension) — NF C 15-100. **Amiante en rénovation** : sur un bâti ancien, le **diagnostic amiante avant travaux est obligatoire** ; en présence d'amiante (anciens plâtres/colles/flocages), **arrêt** → le retrait est **réservé à une entreprise certifiée** (activité Désamiantage, **jamais réalisée ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : ouvrages en plaques de plâtre **DTU 25.41** ; doublages / habillages **DTU 25.42** ; plafonds suspendus **DTU 58.1** ; électricité (perc ements / boîtes) **NF C 15-100** ; en rénovation, diagnostic **amiante** avant travaux (Code de la santé) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Contrôle** : `a-checklist` → [controle-maintenance-platrerie](../../../checklists/platrerie/controle-maintenance-platrerie.md)

## Relations & tags
- **Tags** : `metier:platrerie famille:finition sous-famille:platrerie intervention:diagnostiquer intervention:controler cluster:diagnostics cluster:reparations complexite:moyenne type:diagnostic securite:poussieres`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
