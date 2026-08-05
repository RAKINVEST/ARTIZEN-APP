# Mettre en eau et traiter l'eau (interface)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `mettre-en-eau-traiter` |
| Titre | Mettre en eau et traiter l'eau (interface) |
| Profession | `metier:piscine` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:piscine` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : **mettre en eau** le bassin et équilibrer le **traitement** (pH, désinfection) — l'eau potable est une **interface**. `[C]`
- **Résumé** : remplir le bassin (alimentation en eau potable = **interface** Plomberie), mettre la **filtration** en service, équilibrer le **pH** puis la **désinfection** (chlore, brome, sel/électrolyse) et contrôler la limpidité ; la chimie de l'eau rejoint le **Traitement de l'eau** ; **ne jamais mélanger** chlore et acide (gaz toxique). `[C]` ⟦paramètres/produits selon bassin à confirmer⟧

## Réalisation
- **Étapes** :
  1. Remplir (eau potable = **interface** Plomberie). `[C]`
  2. Mettre la **filtration** en service. `[C]` → [installer-hydraulique-filtration](installer-hydraulique-filtration.md)
  3. Équilibrer **pH** puis **désinfection** (interface). `[C]` → [principe-traitement-eau](../../../professions/traitement-eau/cards/principe-traitement-eau.md)
  4. Contrôler la limpidité. `[C]` → [eau-verte-trouble-filtration](../../../diagnostics/piscine/eau-verte-trouble-filtration.md)
- **Points critiques** : pH avant désinfection ; **produits jamais mélangés** (chlore+acide) ; eau potable = interface ; chimie = Traitement de l'eau.
- **Sécurité** : **produits chimiques** (chlore/acide) ; — ; — **Risque de noyade** : une piscine/fouille en eau non protégée = **danger mortel** (enfants). Les **dispositifs de sécurité** (barrière, alarme, couverture, abri — **obligation légale**) doivent être opérationnels avant la mise en eau/service. **Fouille / terrassement** : effondrement des parois, engins → blindage/talutage (**interface** Terrassement). **Risques électriques** : eau + électricité = très dangereux ; le **raccordement électrique** (local technique, pompe, projecteurs), la **liaison équipotentielle** et les **volumes** (NF C 15-100 7-702) sont **réservés à un électricien** → voir Électricité. **Produits de traitement** (chlore, acides) : stockage/manipulation ; **ne jamais mélanger chlore et acide** (dégagement gazeux toxique) → interface Traitement de l'eau. **Local technique** confiné : ventilation. **Manutention** : coque polyester (grue), panneaux, margelles lourdes. **Amiante** (rénovation ancienne) : diagnostic ; retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : sécurité électrique des piscines (volumes 0/1/2, liaison équipotentielle) **NF C 15-100** (partie 7-702) ; structure béton du bassin (**interface** maçonnerie) **DTU 21** ; **sécurité des piscines** — barrières / alarmes / couvertures / abris **NF P 90-306 à 90-309** et **obligation légale** (Code de la construction), norme européenne **NF EN 16582** ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Entretien / hivernage** : `cite-carte` → [entretenir-hiverner-piscine](entretenir-hiverner-piscine.md)

## Relations & tags
- **Tags** : `metier:piscine famille:specialises sous-famille:piscine intervention:realiser cluster:mise-en-eau cluster:traitement complexite:moyenne type:installation securite:produits-chimiques relation:traitement-eau relation:plomberie`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
