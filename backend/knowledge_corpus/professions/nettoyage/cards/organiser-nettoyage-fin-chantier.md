# Organiser le nettoyage de fin de chantier

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `organiser-nettoyage-fin-chantier` |
| Titre | Organiser le nettoyage de fin de chantier |
| Profession | `metier:nettoyage` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:nettoyage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : organiser le **nettoyage de fin de chantier** (séquence, dépoussiérage, retrait des résidus, déchets). `[C]`
- **Résumé** : planifier le nettoyage **après** les corps d'état : évacuer les **déchets de chantier** (tri/filière), **dépoussiérer du haut vers le bas**, retirer les **résidus** (laitance, colle, peinture, adhésifs) avec la méthode **adaptée au support** (sans l'abîmer), puis nettoyer sols et surfaces ; coordonner avec la **réception** ; en rénovation, **vigilance amiante/poussières**. `[C]` ⟦séquence/supports selon chantier à confirmer⟧

## Réalisation
- **Étapes** *(organisation / contrôle — aucun dosage, mélange ni protocole d'usage de produits décrit)* :
  1. Évacuer les **déchets** (tri/filière réglementée). `[A]`
  2. **Dépoussiérer du haut vers le bas**. `[C]` → [depoussierer-nettoyer-courant](depoussierer-nettoyer-courant.md)
  3. Retirer résidus **sans abîmer** le support. `[C]` → [materiau-raye-abime-nettoyage](../../../diagnostics/nettoyage/materiau-raye-abime-nettoyage.md)
  4. Rénovation → **amiante/poussières** (vigilance). `[A]`
- **Points critiques** : déchets triés ; **ordre haut→bas** ; résidus retirés sans dommage ; amiante en vigilance ; coordination réception.
- **Sécurité** : déchets ; poussières (amiante possible) ; produits. **Produits d'entretien** : certains sont **dangereux** (irritants/corrosifs) — **ne jamais mélanger** de produits (ex. eau de Javel/chlore + acide = **dégagement gazeux toxique**), respecter les **fiches de données de sécurité (FDS)** et l'étiquetage **CLP**, ventiler, porter les EPI ; **ce Livre ne donne aucun dosage, mélange ni protocole d'usage** (présentation uniquement). **Poussières de chantier** (béton, bois, **silice**) : aspiration/masque ; **amiante possible** en rénovation → diagnostic, retrait réservé à une **entreprise certifiée** (jamais ici). **Travail en hauteur** (vitrages, façades) : nacelle/harnais — le nettoyage de façade est **présenté** ; le vitrage / la pose relèvent du **Vitrier**. **Sols glissants** (nettoyage humide) : balisage. **Déchets de chantier** : tri et filière réglementée. **Électricité + eau** (autolaveuses/monobrosses) : prudence. **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : nettoyage des **vitrages** (**interface** vitrerie) **DTU 39** ; nettoyage / protection des **sols** carrelés (**interface**) **DTU 52.2** ; gestion des **déchets de chantier** (Code de l'environnement, tri / bordereau), **fiches de données de sécurité (FDS)** et étiquetage **CLP** des produits ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Nettoyage des sols** : `cite-carte` → [nettoyer-sols](nettoyer-sols.md)

## Relations & tags
- **Tags** : `metier:nettoyage famille:specialises sous-famille:nettoyage intervention:realiser cluster:fin-de-chantier cluster:depoussierage cluster:dechets-chantier complexite:moyenne type:organisation securite:produits-chimiques`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
