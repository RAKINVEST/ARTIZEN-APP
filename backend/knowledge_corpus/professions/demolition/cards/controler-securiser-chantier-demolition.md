# Contrôler / sécuriser un chantier de démolition

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controler-securiser-chantier-demolition` |
| Titre | Contrôler / sécuriser un chantier de démolition |
| Profession | `metier:demolition` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : organiser la sécurité d'un chantier de démolition (balisage, périmètre, protections, EPI). `[C]`
- **Résumé** : délimiter et **baliser** le périmètre, protéger l'entourage (chute d'objets), organiser la circulation des engins, confirmer la **consignation des réseaux** et l'étaiement, et équiper les intervenants (EPI adaptés : poussières, bruit). `[C]`

## Réalisation
- **Étapes** :
  1. **Baliser** le périmètre ; protéger l'entourage (chute d'objets). `[A]`
  2. Confirmer **consignation réseaux** + **étaiement**. `[A]` → [ordre-demolition-etaiement](../../../procedures/demolition/ordre-demolition-etaiement.md)
  3. Organiser **circulation engins** / zones de levage. `[A]`
  4. EPI adaptés (poussières/silice, bruit, antichute). `[A]`
- **Points critiques** : périmètre balisé ; réseaux consignés ; étaiement en place ; EPI ; arrêt immédiat en cas de danger.
- **Sécurité** : chute d'objets ; engins/circulation ; poussières ; bruit. **Stabilité de l'ouvrage** : toute démolition partielle/sélective d'un élément porteur engage la structure — **diagnostic + étaiement préalables** (risque d'**effondrement**), démolir dans le bon ordre (haut vers bas, non-porteur avant porteur). **Amiante / plomb** : **diagnostic avant travaux obligatoire** ; en présence d'amiante, opération **réservée à une entreprise certifiée** — **jamais** en démolition courante. **Consignation des réseaux** (élec/gaz/eau) avant dépose. **Poussières (silice)**, **bruit**, **vibrations**, **projections**, **chute d'objets**, **hauteur**, **manutention/levage/engins** : EPI, **balisage**, périmètre. **Arrêt immédiat en cas de danger.** Opérations lourdes/réglementées **réservées aux entreprises qualifiées**.** `[A]`

## Cadre & suites
- **Normes** : démolition/reprise d'ouvrages en maçonnerie **DTU 20.1** et en béton **DTU 21** ; diagnostics réglementaires avant travaux (**PEMD** déchets, **amiante**, **plomb/CREP**) et **Code du travail** (étaiement/protection) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Contrôle avant** : `a-checklist` → [controle-avant-demolition](../../../checklists/demolition/controle-avant-demolition.md)

## Relations & tags
- **Tags** : `metier:demolition famille:gros-oeuvre sous-famille:securite intervention:controler cluster:controle cluster:securite complexite:moyenne type:controle securite:effondrement`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
