# Démolition partielle d'un élément porteur

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `demolir-partiel-porteur-etaiement` |
| Titre | Démolition partielle d'un élément porteur |
| Profession | `metier:demolition` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:demolition` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : démolir partiellement un élément **porteur** — opération **structurelle** relevant d'une étude et d'un étaiement. `[C]`
- **Résumé** : après **étude structurelle**, mettre en œuvre l'**étaiement** de reprise de charge, démolir dans l'ordre prescrit, poser les éléments de reprise (linteau/poutre) puis retirer l'étaiement progressivement ; opération **réservée à des compétences adaptées**. `[C]` ⟦dimensionnement par un bureau d'études à confirmer⟧

## Réalisation
- **Étapes** :
  1. **Étude structurelle** (charges, reprise). `[A]` ⟦requise⟧
  2. Mettre en œuvre l'**étaiement** de reprise. `[A]` → [ordre-demolition-etaiement](../../../procedures/demolition/ordre-demolition-etaiement.md)
  3. Démolir dans l'ordre ; poser la **reprise** (linteau/poutre). `[B]` → [realiser-ouverture-linteau](../../../professions/maconnerie/cards/realiser-ouverture-linteau.md)
  4. Retirer l'étaiement **progressivement** après reprise. `[B]`
- **Points critiques** : opération **structurelle** → étude + étaiement obligatoires ; jamais improviser une dépose de porteur.
- **Sécurité** : **effondrement** ; étaiement ; manutention ; engins. **Stabilité de l'ouvrage** : toute démolition partielle/sélective d'un élément porteur engage la structure — **diagnostic + étaiement préalables** (risque d'**effondrement**), démolir dans le bon ordre (haut vers bas, non-porteur avant porteur). **Amiante / plomb** : **diagnostic avant travaux obligatoire** ; en présence d'amiante, opération **réservée à une entreprise certifiée** — **jamais** en démolition courante. **Consignation des réseaux** (élec/gaz/eau) avant dépose. **Poussières (silice)**, **bruit**, **vibrations**, **projections**, **chute d'objets**, **hauteur**, **manutention/levage/engins** : EPI, **balisage**, périmètre. **Arrêt immédiat en cas de danger.** Opérations lourdes/réglementées **réservées aux entreprises qualifiées**.** `[A]`

## Cadre & suites
- **Normes** : démolition/reprise d'ouvrages en maçonnerie **DTU 20.1** et en béton **DTU 21** ; diagnostics réglementaires avant travaux (**PEMD** déchets, **amiante**, **plomb/CREP**) et **Code du travail** (étaiement/protection) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Désordre en cours** : `traite-diagnostic` → [risque-effondrement-demolition](../../../diagnostics/demolition/risque-effondrement-demolition.md)

## Relations & tags
- **Tags** : `metier:demolition famille:gros-oeuvre sous-famille:demolition intervention:realiser cluster:demolition-partielle cluster:demolition-selective complexite:expert type:realisation securite:effondrement relation:maconnerie`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
