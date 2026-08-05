# Réaliser les bandes et le jointoiement

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `realiser-bandes-jointoiement` |
| Titre | Réaliser les bandes et le jointoiement |
| Profession | `metier:platrerie` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:platrerie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : traiter les **joints** entre plaques (bandes + **enduit de jointoiement**) pour une surface prête à peindre. `[C]`
- **Résumé** : appliquer l'**enduit** dans le joint, maroufler la **bande** (papier/fibre), passer les **passes** successives (enrobage/finition) en respectant le séchage, poncer finement (poussières), traiter les angles (bande armée) ; l'état de surface final conditionne la **peinture** (métier distinct). `[C]` ⟦nombre de passes/niveau de finition selon support à confirmer⟧

## Réalisation
- **Étapes** :
  1. Enduire le joint ; **maroufler la bande** (sans bulle). `[C]`
  2. Passes successives (enrobage/finition) ; respecter le **séchage**. `[C]`
  3. Poncer finement (**poussières** — aspiration/masque). `[C]`
  4. Angles : **bande armée**/cornières ; surface prête à peindre. `[C]`
- **Points critiques** : marouflage sans bulle ; séchage entre passes ; **niveau de finition** adapté (la peinture révèle les défauts) ; poussières de ponçage.
- **Sécurité** : **poussières** (ponçage) ; postures/TMS ; — (la **Peinture** suit — `relation:peinture`). **Poussières de plâtre** (découpe/ponçage des bandes) : masque, aspiration, ventilation. **Manutention des plaques** (lourdes/encombrantes) : lève-plaque, binôme, gestes — **TMS**. **Travail en hauteur** (plafonds suspendus) : échafaudage/plateforme, EPI. **Coupures** (cutter, plaques, rails métalliques — arêtes vives) : gants. **Électricité lors des percements** : repérer/consigner circuits et gaines **avant de percer/visser** (risque de percer un câble sous tension) — NF C 15-100. **Amiante en rénovation** : sur un bâti ancien, le **diagnostic amiante avant travaux est obligatoire** ; en présence d'amiante (anciens plâtres/colles/flocages), **arrêt** → le retrait est **réservé à une entreprise certifiée** (activité Désamiantage, **jamais réalisée ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : ouvrages en plaques de plâtre **DTU 25.41** ; doublages / habillages **DTU 25.42** ; plafonds suspendus **DTU 58.1** ; électricité (perc ements / boîtes) **NF C 15-100** ; en rénovation, diagnostic **amiante** avant travaux (Code de la santé) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Fissures de joint** : `traite-diagnostic` → [fissure-joint-platrerie](../../../diagnostics/platrerie/fissure-joint-platrerie.md)

## Relations & tags
- **Tags** : `metier:platrerie famille:finition sous-famille:platrerie intervention:realiser cluster:bandes cluster:enduits-de-jointoiement complexite:moyenne type:installation securite:poussieres relation:peinture`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
