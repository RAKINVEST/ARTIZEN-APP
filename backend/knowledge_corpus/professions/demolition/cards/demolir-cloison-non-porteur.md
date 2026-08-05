# Démolir une cloison / élément non porteur

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `demolir-cloison-non-porteur` |
| Titre | Démolir une cloison / élément non porteur |
| Profession | `metier:demolition` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:demolition` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : démolir un élément **non porteur** (cloison, doublage) après avoir confirmé son caractère non structurel. `[C]`
- **Résumé** : confirmer (diagnostic structure) que l'élément est **non porteur**, vérifier l'absence de réseaux actifs, démolir manuellement/mécaniquement en protégeant l'entourage, et évacuer les gravats en triant. `[C]` ⟦confirmation non-porteur à confirmer⟧

## Réalisation
- **Étapes** :
  1. **Confirmer non-porteur** (diagnostic structure). `[A]` ⟦requis⟧
  2. Vérifier absence de **réseaux actifs** dans la cloison. `[A]` → [reseau-non-consigne](../../../diagnostics/demolition/reseau-non-consigne.md)
  3. Démolir (protection sol/murs voisins) ; limiter les **poussières**. `[C]`
  4. Évacuer/trier les gravats. `[C]` → [trier-evacuer-dechets](trier-evacuer-dechets.md)
- **Points critiques** : **certitude du non-porteur** avant démolition ; réseaux consignés ; poussières maîtrisées ; protection de l'entourage.
- **Sécurité** : poussières/silice ; réseaux ; chute d'objets ; bruit. **Stabilité de l'ouvrage** : toute démolition partielle/sélective d'un élément porteur engage la structure — **diagnostic + étaiement préalables** (risque d'**effondrement**), démolir dans le bon ordre (haut vers bas, non-porteur avant porteur). **Amiante / plomb** : **diagnostic avant travaux obligatoire** ; en présence d'amiante, opération **réservée à une entreprise certifiée** — **jamais** en démolition courante. **Consignation des réseaux** (élec/gaz/eau) avant dépose. **Poussières (silice)**, **bruit**, **vibrations**, **projections**, **chute d'objets**, **hauteur**, **manutention/levage/engins** : EPI, **balisage**, périmètre. **Arrêt immédiat en cas de danger.** Opérations lourdes/réglementées **réservées aux entreprises qualifiées**.** `[A]`

## Cadre & suites
- **Normes** : démolition/reprise d'ouvrages en maçonnerie **DTU 20.1** et en béton **DTU 21** ; diagnostics réglementaires avant travaux (**PEMD** déchets, **amiante**, **plomb/CREP**) et **Code du travail** (étaiement/protection) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Porteur (ne jamais improviser)** : `cite-carte` → [demolir-partiel-porteur-etaiement](demolir-partiel-porteur-etaiement.md)

## Relations & tags
- **Tags** : `metier:demolition famille:gros-oeuvre sous-famille:demolition intervention:realiser cluster:demolition-interieure cluster:demolition-partielle cluster:demolition-manuelle complexite:moyenne type:realisation securite:effondrement`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
