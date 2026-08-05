# Entretenir et hiverner une piscine

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `entretenir-hiverner-piscine` |
| Titre | Entretenir et hiverner une piscine |
| Profession | `metier:piscine` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:piscine` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : assurer l'**entretien** courant, la **maintenance** de la filtration et l'**hivernage** (actif/passif). `[C]`
- **Résumé** : nettoyer (ligne d'eau, fond, paniers), contrôler et équilibrer l'eau, entretenir la **filtration** (contre-lavage, cartouches), et selon la saison réaliser l'**hivernage** (actif : filtration ralentie ; passif : baisse du niveau, gizzmos, produit d'hivernage, couverture) puis la **remise en service** ; en rénovation ancienne, **diagnostic amiante**. `[C]`

## Réalisation
- **Étapes** :
  1. Nettoyer (ligne d'eau/fond/paniers) ; équilibrer l'eau. `[C]` → [eau-verte-trouble-filtration](../../../diagnostics/piscine/eau-verte-trouble-filtration.md)
  2. Entretenir la **filtration** (contre-lavage/cartouche). `[C]` → [filtration-pompe-defaut](../../../diagnostics/piscine/filtration-pompe-defaut.md)
  3. **Hivernage** (actif/passif) puis remise en service. `[C]`
  4. Rénovation ancienne → **diagnostic amiante**. `[C]`
- **Points critiques** : eau équilibrée ; filtration entretenue ; **hivernage** adapté (gel) ; **amiante** en rénovation ; sécurité maintenue.
- **Sécurité** : produits chimiques ; noyade (bassin ouvert) ; amiante (rénovation). **Risque de noyade** : une piscine/fouille en eau non protégée = **danger mortel** (enfants). Les **dispositifs de sécurité** (barrière, alarme, couverture, abri — **obligation légale**) doivent être opérationnels avant la mise en eau/service. **Fouille / terrassement** : effondrement des parois, engins → blindage/talutage (**interface** Terrassement). **Risques électriques** : eau + électricité = très dangereux ; le **raccordement électrique** (local technique, pompe, projecteurs), la **liaison équipotentielle** et les **volumes** (NF C 15-100 7-702) sont **réservés à un électricien** → voir Électricité. **Produits de traitement** (chlore, acides) : stockage/manipulation ; **ne jamais mélanger chlore et acide** (dégagement gazeux toxique) → interface Traitement de l'eau. **Local technique** confiné : ventilation. **Manutention** : coque polyester (grue), panneaux, margelles lourdes. **Amiante** (rénovation ancienne) : diagnostic ; retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : sécurité électrique des piscines (volumes 0/1/2, liaison équipotentielle) **NF C 15-100** (partie 7-702) ; structure béton du bassin (**interface** maçonnerie) **DTU 21** ; **sécurité des piscines** — barrières / alarmes / couvertures / abris **NF P 90-306 à 90-309** et **obligation légale** (Code de la construction), norme européenne **NF EN 16582** ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Kit** : `utilise-kit` → [kit-piscinier](../../../kits/piscine/kit-piscinier.md)

## Relations & tags
- **Tags** : `metier:piscine famille:specialises sous-famille:piscine intervention:entretenir intervention:controler cluster:entretien cluster:maintenance cluster:hivernage cluster:diagnostic complexite:moyenne type:entretien securite:produits-chimiques`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
