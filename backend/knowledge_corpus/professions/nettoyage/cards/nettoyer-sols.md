# Nettoyer les sols selon le revêtement

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `nettoyer-sols` |
| Titre | Nettoyer les sols selon le revêtement |
| Profession | `metier:nettoyage` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:nettoyage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : nettoyer les **sols** en adaptant méthode et produit au **revêtement** (carrelage, PVC, parquet, béton) — sans l'abîmer. `[C]`
- **Résumé** : identifier le **revêtement** et adapter le nettoyage : **carrelage** (laitance de pose retirée par le carreleur ; entretien courant), **sols souples PVC/lino** (produits neutres, ni abrasif ni excès d'eau), **parquet** (sec/produit dédié), **béton** ; un produit ou une méthode inadaptée **raye/ternit/décolle** ; la remise en état technique (ponçage/cristallisation, réparation) relève du **Solier/Carreleur**. `[C]` ⟦produits/méthodes selon revêtement à confirmer⟧

## Réalisation
- **Étapes** *(organisation / contrôle — aucun dosage, mélange ni protocole d'usage de produits décrit)* :
  1. Identifier le **revêtement** ; choisir la méthode adaptée. `[C]` → [sol-glissant-encrasse](../../../diagnostics/nettoyage/sol-glissant-encrasse.md)
  2. **Sols souples** (PVC/lino) : entretien technique = **Solier**. `[C]` → [entretenir-reprendre-sol](../../../professions/revetements-sol/cards/entretenir-reprendre-sol.md)
  3. **Carrelage/joints** : entretien ; laitance = **Carreleur**. `[C]` → [principe-carrelage](../../../professions/carrelage/cards/principe-carrelage.md)
  4. Éviter produit/méthode **agressif** (rayures). `[A]` → [materiau-raye-abime-nettoyage](../../../diagnostics/nettoyage/materiau-raye-abime-nettoyage.md)
- **Points critiques** : méthode **adaptée au revêtement** ; pas d'excès d'eau/abrasif ; remise en état technique = Solier/Carreleur ; anti-glissance.
- **Sécurité** : sols glissants ; produits ; manutention (machines). **Produits d'entretien** : certains sont **dangereux** (irritants/corrosifs) — **ne jamais mélanger** de produits (ex. eau de Javel/chlore + acide = **dégagement gazeux toxique**), respecter les **fiches de données de sécurité (FDS)** et l'étiquetage **CLP**, ventiler, porter les EPI ; **ce Livre ne donne aucun dosage, mélange ni protocole d'usage** (présentation uniquement). **Poussières de chantier** (béton, bois, **silice**) : aspiration/masque ; **amiante possible** en rénovation → diagnostic, retrait réservé à une **entreprise certifiée** (jamais ici). **Travail en hauteur** (vitrages, façades) : nacelle/harnais — le nettoyage de façade est **présenté** ; le vitrage / la pose relèvent du **Vitrier**. **Sols glissants** (nettoyage humide) : balisage. **Déchets de chantier** : tri et filière réglementée. **Électricité + eau** (autolaveuses/monobrosses) : prudence. **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : nettoyage des **vitrages** (**interface** vitrerie) **DTU 39** ; nettoyage / protection des **sols** carrelés (**interface**) **DTU 52.2** ; gestion des **déchets de chantier** (Code de l'environnement, tri / bordereau), **fiches de données de sécurité (FDS)** et étiquetage **CLP** des produits ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Vitrages / sanitaires** : `cite-carte` → [nettoyer-vitrages-sanitaires](nettoyer-vitrages-sanitaires.md)

## Relations & tags
- **Tags** : `metier:nettoyage famille:specialises sous-famille:nettoyage intervention:realiser cluster:nettoyage-sols cluster:protection-materiaux complexite:moyenne type:entretien securite:produits-chimiques relation:revetements-sol relation:carrelage`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
