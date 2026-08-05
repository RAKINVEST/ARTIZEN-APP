# Contrôler la qualité et documenter

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controler-qualite-documenter` |
| Titre | Contrôler la qualité et documenter |
| Profession | `metier:nettoyage` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:nettoyage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : réaliser le **contrôle qualité** / l'**inspection finale** et assurer la **gestion documentaire**. `[C]`
- **Résumé** : réaliser une **inspection finale** (surfaces, vitrages, sols, sanitaires, absence de résidus/traces, protections retirées), vérifier l'absence de **dégradation** des ouvrages, tracer le **contrôle qualité** et la **gestion documentaire** (plan de nettoyage, bordereaux de **déchets**, FDS des produits utilisés), puis remettre l'ouvrage propre ; signaler tout défaut relevant d'un autre corps d'état. `[C]` ⟦critères de réception à confirmer⟧

## Réalisation
- **Étapes** *(organisation / contrôle — aucun dosage, mélange ni protocole d'usage de produits décrit)* :
  1. **Inspection finale** (surfaces/vitrages/sols/sanitaires). `[C]` → [controle-qualite-reception-nettoyage](../../../checklists/nettoyage/controle-qualite-reception-nettoyage.md)
  2. Vérifier l'absence de **dégradation** ; protections retirées. `[C]`
  3. **Documenter** (plan, bordereaux déchets, FDS). `[C]`
  4. Signaler défauts relevant d'un autre corps d'état. `[C]`
- **Points critiques** : inspection finale complète ; **aucune dégradation** ; traçabilité (déchets/FDS) ; défauts signalés.
- **Sécurité** : produits ; — ; — **Produits d'entretien** : certains sont **dangereux** (irritants/corrosifs) — **ne jamais mélanger** de produits (ex. eau de Javel/chlore + acide = **dégagement gazeux toxique**), respecter les **fiches de données de sécurité (FDS)** et l'étiquetage **CLP**, ventiler, porter les EPI ; **ce Livre ne donne aucun dosage, mélange ni protocole d'usage** (présentation uniquement). **Poussières de chantier** (béton, bois, **silice**) : aspiration/masque ; **amiante possible** en rénovation → diagnostic, retrait réservé à une **entreprise certifiée** (jamais ici). **Travail en hauteur** (vitrages, façades) : nacelle/harnais — le nettoyage de façade est **présenté** ; le vitrage / la pose relèvent du **Vitrier**. **Sols glissants** (nettoyage humide) : balisage. **Déchets de chantier** : tri et filière réglementée. **Électricité + eau** (autolaveuses/monobrosses) : prudence. **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : nettoyage des **vitrages** (**interface** vitrerie) **DTU 39** ; nettoyage / protection des **sols** carrelés (**interface**) **DTU 52.2** ; gestion des **déchets de chantier** (Code de l'environnement, tri / bordereau), **fiches de données de sécurité (FDS)** et étiquetage **CLP** des produits ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Kit** : `utilise-kit` → [kit-nettoyage-batiment](../../../kits/nettoyage/kit-nettoyage-batiment.md)

## Relations & tags
- **Tags** : `metier:nettoyage famille:specialises sous-famille:nettoyage intervention:controler cluster:controle-qualite cluster:inspection-finale cluster:documentation complexite:moyenne type:controle securite:produits-chimiques`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
