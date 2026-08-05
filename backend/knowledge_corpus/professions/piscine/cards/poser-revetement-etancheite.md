# Poser le revêtement et l'étanchéité du bassin

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `poser-revetement-etancheite` |
| Titre | Poser le revêtement et l'étanchéité du bassin |
| Profession | `metier:piscine` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:piscine` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : poser le **revêtement / étanchéité** du bassin (liner, PVC armé, enduit, carrelage) garantissant l'étanchéité. `[C]`
- **Résumé** : préparer le support (feutre/enduit de lissage), poser le **liner** ou souder le **PVC armé** (armé = plus durable), ou appliquer un **enduit** d'étanchéité, ou carreler (**interface** Carrelage) ; soigner les **raccords** aux pièces à sceller (brides d'étanchéité) car c'est là que fuient les bassins ; poser les margelles. `[C]` ⟦type de revêtement selon bassin à confirmer⟧

## Réalisation
- **Étapes** :
  1. Préparer le support (feutre/lissage). `[C]`
  2. Poser **liner** / souder **PVC armé** / **enduit**. `[C]`
  3. Soigner les **brides d'étanchéité** (pièces à sceller). `[B]` → [perte-eau-fuite-bassin](../../../diagnostics/piscine/perte-eau-fuite-bassin.md)
  4. **Margelles** (interface Carrelage). `[C]` → [poser-carrelage-colle](../../../professions/carrelage/cards/poser-carrelage-colle.md)
- **Points critiques** : **étanchéité aux pièces à sceller** (zone de fuite) ; support sain ; margelles = Carrelage ; type adapté au bassin.
- **Sécurité** : manutention (margelles) ; découpes ; — **Risque de noyade** : une piscine/fouille en eau non protégée = **danger mortel** (enfants). Les **dispositifs de sécurité** (barrière, alarme, couverture, abri — **obligation légale**) doivent être opérationnels avant la mise en eau/service. **Fouille / terrassement** : effondrement des parois, engins → blindage/talutage (**interface** Terrassement). **Risques électriques** : eau + électricité = très dangereux ; le **raccordement électrique** (local technique, pompe, projecteurs), la **liaison équipotentielle** et les **volumes** (NF C 15-100 7-702) sont **réservés à un électricien** → voir Électricité. **Produits de traitement** (chlore, acides) : stockage/manipulation ; **ne jamais mélanger chlore et acide** (dégagement gazeux toxique) → interface Traitement de l'eau. **Local technique** confiné : ventilation. **Manutention** : coque polyester (grue), panneaux, margelles lourdes. **Amiante** (rénovation ancienne) : diagnostic ; retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : sécurité électrique des piscines (volumes 0/1/2, liaison équipotentielle) **NF C 15-100** (partie 7-702) ; structure béton du bassin (**interface** maçonnerie) **DTU 21** ; **sécurité des piscines** — barrières / alarmes / couvertures / abris **NF P 90-306 à 90-309** et **obligation légale** (Code de la construction), norme européenne **NF EN 16582** ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Hydraulique / filtration** : `cite-carte` → [installer-hydraulique-filtration](installer-hydraulique-filtration.md)

## Relations & tags
- **Tags** : `metier:piscine famille:specialises sous-famille:piscine intervention:realiser cluster:revetement cluster:etancheite complexite:avancee type:installation securite:manutention relation:carrelage relation:etancheite`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
