# Trier et évacuer les déchets / gravats

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `trier-evacuer-dechets` |
| Titre | Trier et évacuer les déchets / gravats |
| Profession | `metier:demolition` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:demolition` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : trier les déchets de démolition à la source et évacuer les gravats vers les filières agréées (PEMD). `[C]`
- **Résumé** : trier les matériaux par nature (inertes, bois, métaux, plâtre, DND/DD) selon le **PEMD**, isoler tout déchet **dangereux** (amiante = filière spécifique, entreprise certifiée), et évacuer vers les **exutoires agréés** avec traçabilité (bordereaux). `[C]` ⟦filières/bordereaux selon réglementation à confirmer⟧

## Réalisation
- **Étapes** :
  1. **Trier à la source** par nature (inertes/bois/métaux/plâtre). `[C]`
  2. Isoler les **déchets dangereux** (amiante → filière spécifique). `[A]`
  3. Évacuer vers **exutoires agréés** ; traçabilité (bordereaux). `[C]` ⟦à confirmer⟧
  4. Évacuation/déblai en interface **terrassement**. `[C]` → [principe-terrassement](../../../professions/terrassement/cards/principe-terrassement.md)
- **Points critiques** : tri à la source (valorisation) ; déchets dangereux isolés ; filières agréées + traçabilité (PEMD).
- **Sécurité** : manutention/levage ; poussières ; engins ; déchets dangereux. **Stabilité de l'ouvrage** : toute démolition partielle/sélective d'un élément porteur engage la structure — **diagnostic + étaiement préalables** (risque d'**effondrement**), démolir dans le bon ordre (haut vers bas, non-porteur avant porteur). **Amiante / plomb** : **diagnostic avant travaux obligatoire** ; en présence d'amiante, opération **réservée à une entreprise certifiée** — **jamais** en démolition courante. **Consignation des réseaux** (élec/gaz/eau) avant dépose. **Poussières (silice)**, **bruit**, **vibrations**, **projections**, **chute d'objets**, **hauteur**, **manutention/levage/engins** : EPI, **balisage**, périmètre. **Arrêt immédiat en cas de danger.** Opérations lourdes/réglementées **réservées aux entreprises qualifiées**.** `[A]`

## Cadre & suites
- **Normes** : démolition/reprise d'ouvrages en maçonnerie **DTU 20.1** et en béton **DTU 21** ; diagnostics réglementaires avant travaux (**PEMD** déchets, **amiante**, **plomb/CREP**) et **Code du travail** (étaiement/protection) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Réglementation** : `cite-phrase` → [normes-reglementation-demolition](../../../phrases/demolition/normes-reglementation-demolition.md)

## Relations & tags
- **Tags** : `metier:demolition famille:gros-oeuvre sous-famille:demolition intervention:realiser cluster:tri-des-dechets cluster:evacuation-gravats complexite:moyenne type:realisation securite:manutention relation:terrassement`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
