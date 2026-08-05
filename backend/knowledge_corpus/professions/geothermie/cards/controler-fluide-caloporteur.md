# Contrôler le fluide caloporteur (eau glycolée)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controler-fluide-caloporteur` |
| Titre | Contrôler le fluide caloporteur (eau glycolée) |
| Profession | `metier:geothermie` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:captage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : contrôler le fluide caloporteur du circuit de captage : **taux d'antigel**, pression, qualité. `[C]`
- **Résumé** : mesurer la concentration d'antigel (protection contre le gel du captage), la pression et l'aspect du fluide, faire l'appoint si nécessaire avec un produit compatible. `[C]` ⟦taux/produit selon installation à confirmer⟧

## Réalisation
- **Étapes** :
  1. Mesurer la **concentration d'antigel** (protection gel). `[C]` ⟦seuil à confirmer⟧
  2. Contrôler la **pression** du circuit de captage. `[C]`
  3. Vérifier l'aspect (absence de boue/oxydation). `[C]`
  4. Appoint avec produit **compatible** ; consigner. `[C]` → [remplissage-boucle-captage](../../../procedures/geothermie/remplissage-boucle-captage.md)
- **Points critiques** : antigel adapté (protection gel du captage) ; **compatibilité** produit/matériaux ; environnement (rejet interdit).
- **Sécurité** : produit chimique (EPI, FDS) ; environnement (pas de rejet) ; pression. **Le **forage/captage vertical** relève d'un **foreur qualifié** (réglementation GMI / déclaration) ; la partie **PAC** (circuit frigorifique) est réservée à un **frigoriste attesté F-Gaz** ; le **raccordement électrique** à un intervenant **habilité**.** `[A]`

## Cadre & suites
- **Normes** : installation électrique **NF C 15-100** ; réglementation **géothermie de minime importance (GMI)** ; dimensionnement **NF EN 15450** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Procédure** : `cite-procedure` → [remplissage-boucle-captage](../../../procedures/geothermie/remplissage-boucle-captage.md)

## Relations & tags
- **Tags** : `metier:geothermie equipement:caloporteur famille:fluides sous-famille:captage intervention:controler cluster:fluide-caloporteur cluster:captage cluster:controle complexite:moyenne type:controle`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
