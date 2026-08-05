# Principe du nettoyage de bâtiment

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `principe-nettoyage` |
| Titre | Principe du nettoyage de bâtiment |
| Profession | `metier:nettoyage` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:nettoyage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : comprendre le nettoyage professionnel du bâtiment (fin de chantier, courant, technique) et ses frontières. `[C]`
- **Résumé** : le nettoyage professionnel remet un ouvrage **propre et livrable** : **nettoyage de fin de chantier** (dépoussiérage, retrait des résidus, déchets), **nettoyage courant** et **entretien technique**, avec **protection des matériaux**, **contrôle qualité** et gestion des **déchets** ; le nettoyeur **nettoie** sans se substituer aux métiers : la pose/remise en état des vitrages (Vitrier), des sols (Solier/Carreleur) et des peintures reste leur domaine ; les **produits** sont présentés (jamais de dosage/mélange). `[C]` ⟦périmètre selon prestation à confirmer⟧

## Réalisation
- **Étapes** *(organisation / contrôle — aucun dosage, mélange ni protocole d'usage de produits décrit)* :
  1. **Organiser** le nettoyage de fin de chantier. `[C]` → [organiser-nettoyage-fin-chantier](organiser-nettoyage-fin-chantier.md)
  2. **Dépoussiérer / nettoyer** (courant). `[C]` → [depoussierer-nettoyer-courant](depoussierer-nettoyer-courant.md)
  3. **Protéger les matériaux** ; **contrôle qualité**. `[C]` → [proteger-materiaux-surfaces](proteger-materiaux-surfaces.md)
  4. **Produits** = présentation (FDS/CLP, jamais de mélange). `[A]` → [comprendre-produits-facades](comprendre-produits-facades.md)
- **Points critiques** : propre/livrable ; **protection des matériaux** ; produits = **présentation** (jamais mélangés) ; déchets triés ; frontières (vitrier/solier/peintre).
- **Sécurité** : produits chimiques (jamais mélanger) ; poussières ; hauteur. **Produits d'entretien** : certains sont **dangereux** (irritants/corrosifs) — **ne jamais mélanger** de produits (ex. eau de Javel/chlore + acide = **dégagement gazeux toxique**), respecter les **fiches de données de sécurité (FDS)** et l'étiquetage **CLP**, ventiler, porter les EPI ; **ce Livre ne donne aucun dosage, mélange ni protocole d'usage** (présentation uniquement). **Poussières de chantier** (béton, bois, **silice**) : aspiration/masque ; **amiante possible** en rénovation → diagnostic, retrait réservé à une **entreprise certifiée** (jamais ici). **Travail en hauteur** (vitrages, façades) : nacelle/harnais — le nettoyage de façade est **présenté** ; le vitrage / la pose relèvent du **Vitrier**. **Sols glissants** (nettoyage humide) : balisage. **Déchets de chantier** : tri et filière réglementée. **Électricité + eau** (autolaveuses/monobrosses) : prudence. **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : nettoyage des **vitrages** (**interface** vitrerie) **DTU 39** ; nettoyage / protection des **sols** carrelés (**interface**) **DTU 52.2** ; gestion des **déchets de chantier** (Code de l'environnement, tri / bordereau), **fiches de données de sécurité (FDS)** et étiquetage **CLP** des produits ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Contrôle qualité / documentation** : `cite-carte` → [controler-qualite-documenter](controler-qualite-documenter.md)

## Relations & tags
- **Tags** : `metier:nettoyage famille:specialises sous-famille:nettoyage intervention:comprendre cluster:fin-de-chantier cluster:nettoyage-courant cluster:organisation type:principe securite:produits-chimiques relation:vitrerie relation:diagnostic`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
