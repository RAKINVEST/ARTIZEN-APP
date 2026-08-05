# Principe de la démolition (curage, sélective, déconstruction)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `principe-demolition` |
| Titre | Principe de la démolition (curage, sélective, déconstruction) |
| Profession | `metier:demolition` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:demolition` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : comprendre les modes de démolition (intérieure, partielle, sélective, curage, déconstruction) et leurs préalables obligatoires. `[C]`
- **Résumé** : la démolition va du **curage** (dépose du second œuvre) à la **déconstruction sélective** (tri des matériaux) et à la démolition **partielle/porteuse** ; **manuelle** ou **mécanique** ; elle exige des **diagnostics préalables obligatoires** (PEMD, amiante, plomb, structure) et un ordre sécurisé. `[C]` ⟦méthode selon ouvrage et diagnostics à confirmer⟧

## Réalisation
- **Étapes** :
  1. **Diagnostics préalables** obligatoires (PEMD/amiante/plomb/structure). `[A]` → [realiser-diagnostic-prealable](realiser-diagnostic-prealable.md)
  2. **Curage** (dépose second œuvre) puis démolition sélective. `[C]` → [curer-batiment](curer-batiment.md)
  3. Démolition **non-porteur** puis **porteur** (étaiement). `[C]` → [demolir-partiel-porteur-etaiement](demolir-partiel-porteur-etaiement.md)
  4. **Tri / évacuation** des déchets (filières). `[C]` → [trier-evacuer-dechets](trier-evacuer-dechets.md)
- **Points critiques** : **diagnostics avant tout** (amiante/plomb/PEMD) ; ordre sécurisé (haut→bas, non-porteur→porteur) ; étaiement des porteurs.
- **Sécurité** : effondrement ; amiante/plomb ; poussières/silice ; chute d'objets. **Stabilité de l'ouvrage** : toute démolition partielle/sélective d'un élément porteur engage la structure — **diagnostic + étaiement préalables** (risque d'**effondrement**), démolir dans le bon ordre (haut vers bas, non-porteur avant porteur). **Amiante / plomb** : **diagnostic avant travaux obligatoire** ; en présence d'amiante, opération **réservée à une entreprise certifiée** — **jamais** en démolition courante. **Consignation des réseaux** (élec/gaz/eau) avant dépose. **Poussières (silice)**, **bruit**, **vibrations**, **projections**, **chute d'objets**, **hauteur**, **manutention/levage/engins** : EPI, **balisage**, périmètre. **Arrêt immédiat en cas de danger.** Opérations lourdes/réglementées **réservées aux entreprises qualifiées**.** `[A]`

## Cadre & suites
- **Normes** : démolition/reprise d'ouvrages en maçonnerie **DTU 20.1** et en béton **DTU 21** ; diagnostics réglementaires avant travaux (**PEMD** déchets, **amiante**, **plomb/CREP**) et **Code du travail** (étaiement/protection) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Ordre & étaiement** : `cite-procedure` → [ordre-demolition-etaiement](../../../procedures/demolition/ordre-demolition-etaiement.md)

## Relations & tags
- **Tags** : `metier:demolition famille:gros-oeuvre sous-famille:demolition intervention:comprendre cluster:curage cluster:demolition-selective cluster:deconstruction cluster:demolition-manuelle cluster:demolition-mecanique type:principe securite:effondrement relation:desamiantage`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
