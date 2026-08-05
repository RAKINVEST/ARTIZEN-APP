# Protéger les matériaux et surfaces

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `proteger-materiaux-surfaces` |
| Titre | Protéger les matériaux et surfaces |
| Profession | `metier:nettoyage` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:nettoyage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : **protéger** les matériaux et surfaces finis pendant/après le chantier pour éviter dégâts et retouches. `[C]`
- **Résumé** : mettre en place les **protections** (films, cartons, plaques, adhésifs **non agressifs**) sur les ouvrages finis (sols, plans, sanitaires, menuiseries, surfaces **peintes**) pendant les phases salissantes, choisir un produit/méthode compatible avec chaque **support** (un produit inadapté dégrade), et retirer les protections sans laisser de traces/colle ; une surface peinte abîmée relève du **Peintre**. `[C]` ⟦protections/compatibilité selon supports à confirmer⟧

## Réalisation
- **Étapes** *(organisation / contrôle — aucun dosage, mélange ni protocole d'usage de produits décrit)* :
  1. Poser des **protections** adaptées (films/cartons/plaques). `[C]`
  2. Adhésifs **non agressifs** (pas de traces/arrachement). `[A]`
  3. Compatibilité produit/**support** (pas de dégradation). `[A]`
  4. Surface **peinte** abîmée = Peintre (frontière). `[C]` → [entretenir-reprendre-peinture](../../../professions/peinture/cards/entretenir-reprendre-peinture.md)
- **Points critiques** : ouvrages finis protégés ; adhésifs non agressifs ; compatibilité support ; reprise peinture = Peintre.
- **Sécurité** : produits ; manutention ; — **Produits d'entretien** : certains sont **dangereux** (irritants/corrosifs) — **ne jamais mélanger** de produits (ex. eau de Javel/chlore + acide = **dégagement gazeux toxique**), respecter les **fiches de données de sécurité (FDS)** et l'étiquetage **CLP**, ventiler, porter les EPI ; **ce Livre ne donne aucun dosage, mélange ni protocole d'usage** (présentation uniquement). **Poussières de chantier** (béton, bois, **silice**) : aspiration/masque ; **amiante possible** en rénovation → diagnostic, retrait réservé à une **entreprise certifiée** (jamais ici). **Travail en hauteur** (vitrages, façades) : nacelle/harnais — le nettoyage de façade est **présenté** ; le vitrage / la pose relèvent du **Vitrier**. **Sols glissants** (nettoyage humide) : balisage. **Déchets de chantier** : tri et filière réglementée. **Électricité + eau** (autolaveuses/monobrosses) : prudence. **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : nettoyage des **vitrages** (**interface** vitrerie) **DTU 39** ; nettoyage / protection des **sols** carrelés (**interface**) **DTU 52.2** ; gestion des **déchets de chantier** (Code de l'environnement, tri / bordereau), **fiches de données de sécurité (FDS)** et étiquetage **CLP** des produits ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Contrôle qualité** : `cite-carte` → [controler-qualite-documenter](controler-qualite-documenter.md)

## Relations & tags
- **Tags** : `metier:nettoyage famille:specialises sous-famille:nettoyage intervention:realiser cluster:protection-materiaux complexite:moyenne type:organisation securite:produits-chimiques relation:peinture`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
