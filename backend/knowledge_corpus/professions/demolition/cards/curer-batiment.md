# Curer un bâtiment (dépose du second œuvre)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `curer-batiment` |
| Titre | Curer un bâtiment (dépose du second œuvre) |
| Profession | `metier:demolition` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:demolition` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : curer un bâtiment : déposer le second œuvre (revêtements, cloisons non porteuses, équipements) avant la démolition ou la rénovation. `[C]`
- **Résumé** : après diagnostics et consignation, déposer sélectivement le second œuvre (menuiseries, cloisons non porteuses, revêtements, équipements) en **triant** les matériaux, sans toucher à la structure ; tout matériau **amianté** arrête le curage (entreprise certifiée). `[C]` ⟦selon repérages à confirmer⟧

## Réalisation
- **Étapes** :
  1. Vérifier diagnostics + **consignation** faits. `[A]` → [realiser-diagnostic-prealable](realiser-diagnostic-prealable.md)
  2. Déposer le second œuvre (non structurel) en **triant**. `[C]` → [trier-evacuer-dechets](trier-evacuer-dechets.md)
  3. Matériau **suspect amiante/plomb** → **arrêt**. `[A]` → [presence-amiante-plomb-suspecte](../../../diagnostics/demolition/presence-amiante-plomb-suspecte.md)
  4. Ne pas toucher à la **structure** (porteur). `[C]`
- **Points critiques** : distinguer second œuvre / **structure** ; tri à la source ; arrêt immédiat si matériau suspect (amiante).
- **Sécurité** : amiante/plomb (matériaux) ; poussières ; manutention ; chute d'objets. **Stabilité de l'ouvrage** : toute démolition partielle/sélective d'un élément porteur engage la structure — **diagnostic + étaiement préalables** (risque d'**effondrement**), démolir dans le bon ordre (haut vers bas, non-porteur avant porteur). **Amiante / plomb** : **diagnostic avant travaux obligatoire** ; en présence d'amiante, opération **réservée à une entreprise certifiée** — **jamais** en démolition courante. **Consignation des réseaux** (élec/gaz/eau) avant dépose. **Poussières (silice)**, **bruit**, **vibrations**, **projections**, **chute d'objets**, **hauteur**, **manutention/levage/engins** : EPI, **balisage**, périmètre. **Arrêt immédiat en cas de danger.** Opérations lourdes/réglementées **réservées aux entreprises qualifiées**.** `[A]`

## Cadre & suites
- **Normes** : démolition/reprise d'ouvrages en maçonnerie **DTU 20.1** et en béton **DTU 21** ; diagnostics réglementaires avant travaux (**PEMD** déchets, **amiante**, **plomb/CREP**) et **Code du travail** (étaiement/protection) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Démolition non-porteur** : `cite-carte` → [demolir-cloison-non-porteur](demolir-cloison-non-porteur.md)

## Relations & tags
- **Tags** : `metier:demolition famille:gros-oeuvre sous-famille:demolition intervention:realiser cluster:curage cluster:deconstruction cluster:tri-des-dechets complexite:moyenne type:realisation securite:amiante relation:desamiantage`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
