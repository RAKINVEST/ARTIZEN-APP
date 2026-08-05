# Réaliser les diagnostics préalables à la démolition

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `realiser-diagnostic-prealable` |
| Titre | Réaliser les diagnostics préalables à la démolition |
| Profession | `metier:demolition` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:demolition` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : réunir les diagnostics réglementaires obligatoires avant toute démolition (structure, amiante, plomb, déchets, réseaux). `[C]`
- **Résumé** : faire réaliser/rassembler le **diagnostic amiante avant travaux**, le **plomb (CREP)**, le **PEMD** (produits-équipements-matériaux-déchets), l'analyse de **structure** (porteur ?) et la **consignation des réseaux** ; en présence d'amiante, l'opération est **réservée à une entreprise certifiée** (jamais traitée ici). `[C]` ⟦diagnostics par opérateurs certifiés à confirmer⟧

## Réalisation
- **Étapes** :
  1. **Amiante avant travaux** + **plomb (CREP)** : opérateurs certifiés. `[A]` ⟦obligatoire⟧
  2. **PEMD** (déchets) : identifier filières de tri. `[C]` → [trier-evacuer-dechets](trier-evacuer-dechets.md)
  3. Analyse **structure** (porteur ? étaiement). `[A]` → [realiser-ouverture-linteau](../../../professions/maconnerie/cards/realiser-ouverture-linteau.md)
  4. **Consignation des réseaux** (élec/gaz/eau) avant dépose. `[A]` → [controler-tableau-electrique](../../../professions/electricite-generale/cards/controler-tableau-electrique.md)
- **Points critiques** : **rien ne commence sans les diagnostics** ; amiante → entreprise certifiée (interface only) ; structure et réseaux traités avant.
- **Sécurité** : amiante/plomb ; électricité (consignation) ; structure. **Stabilité de l'ouvrage** : toute démolition partielle/sélective d'un élément porteur engage la structure — **diagnostic + étaiement préalables** (risque d'**effondrement**), démolir dans le bon ordre (haut vers bas, non-porteur avant porteur). **Amiante / plomb** : **diagnostic avant travaux obligatoire** ; en présence d'amiante, opération **réservée à une entreprise certifiée** — **jamais** en démolition courante. **Consignation des réseaux** (élec/gaz/eau) avant dépose. **Poussières (silice)**, **bruit**, **vibrations**, **projections**, **chute d'objets**, **hauteur**, **manutention/levage/engins** : EPI, **balisage**, périmètre. **Arrêt immédiat en cas de danger.** Opérations lourdes/réglementées **réservées aux entreprises qualifiées**.** `[A]`

## Cadre & suites
- **Normes** : démolition/reprise d'ouvrages en maçonnerie **DTU 20.1** et en béton **DTU 21** ; diagnostics réglementaires avant travaux (**PEMD** déchets, **amiante**, **plomb/CREP**) et **Code du travail** (étaiement/protection) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Amiante suspect** : `traite-diagnostic` → [presence-amiante-plomb-suspecte](../../../diagnostics/demolition/presence-amiante-plomb-suspecte.md)

## Relations & tags
- **Tags** : `metier:demolition famille:gros-oeuvre sous-famille:demolition intervention:diagnostiquer cluster:diagnostic-prealable cluster:reglementation complexite:avancee type:diagnostic securite:amiante relation:desamiantage relation:electricite-generale`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
