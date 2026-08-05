# Principe de la construction de piscine

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `principe-piscine` |
| Titre | Principe de la construction de piscine |
| Profession | `metier:piscine` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:piscine` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : comprendre les types de bassins (béton, coque polyester, panneaux) et la chaîne de construction/pose d'une piscine. `[C]`
- **Résumé** : construire une piscine enchaîne : **implantation/terrassement** (fouille), **structure** du bassin (béton, **coque** polyester, **panneaux**), **revêtement/étanchéité** (liner/PVC armé/enduit), **hydraulique** (skimmers, buses, filtration, local technique), **sécurité obligatoire** (barrière/alarme/couverture/abri) puis **mise en eau/traitement** ; les raccordements électriques et l'eau potable sont des **interfaces**. `[C]` ⟦type/dimensions selon projet à confirmer⟧

## Réalisation
- **Étapes** :
  1. **Terrasser / implanter** le bassin. `[C]` → [terrasser-implanter-bassin](terrasser-implanter-bassin.md)
  2. **Structure** (béton/coque/panneaux). `[C]` → [realiser-structure-bassin](realiser-structure-bassin.md)
  3. **Revêtement/étanchéité** ; margelles (**interface** Carrelage). `[C]` → [poser-carrelage-colle](../../../professions/carrelage/cards/poser-carrelage-colle.md)
  4. **Sécurité obligatoire** avant mise en eau. `[A]` → [securiser-piscine-dispositifs](securiser-piscine-dispositifs.md)
- **Points critiques** : chaîne de métier maîtrisée ; **sécurité (noyade) légale** ; raccordements élec/eau = **interfaces** ; margelles = Carrelage.
- **Sécurité** : noyade (bassin ouvert) ; terrassement ; électricité (interface). **Risque de noyade** : une piscine/fouille en eau non protégée = **danger mortel** (enfants). Les **dispositifs de sécurité** (barrière, alarme, couverture, abri — **obligation légale**) doivent être opérationnels avant la mise en eau/service. **Fouille / terrassement** : effondrement des parois, engins → blindage/talutage (**interface** Terrassement). **Risques électriques** : eau + électricité = très dangereux ; le **raccordement électrique** (local technique, pompe, projecteurs), la **liaison équipotentielle** et les **volumes** (NF C 15-100 7-702) sont **réservés à un électricien** → voir Électricité. **Produits de traitement** (chlore, acides) : stockage/manipulation ; **ne jamais mélanger chlore et acide** (dégagement gazeux toxique) → interface Traitement de l'eau. **Local technique** confiné : ventilation. **Manutention** : coque polyester (grue), panneaux, margelles lourdes. **Amiante** (rénovation ancienne) : diagnostic ; retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : sécurité électrique des piscines (volumes 0/1/2, liaison équipotentielle) **NF C 15-100** (partie 7-702) ; structure béton du bassin (**interface** maçonnerie) **DTU 21** ; **sécurité des piscines** — barrières / alarmes / couvertures / abris **NF P 90-306 à 90-309** et **obligation légale** (Code de la construction), norme européenne **NF EN 16582** ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Diagnostic / entretien** : `cite-carte` → [entretenir-hiverner-piscine](entretenir-hiverner-piscine.md)

## Relations & tags
- **Tags** : `metier:piscine famille:specialises sous-famille:piscine intervention:comprendre cluster:types-de-bassins cluster:structure cluster:hydraulique type:principe securite:noyade relation:carrelage`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
