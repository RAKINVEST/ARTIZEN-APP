# Installer l'hydraulique et la filtration

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `installer-hydraulique-filtration` |
| Titre | Installer l'hydraulique et la filtration |
| Profession | `metier:piscine` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:piscine` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : installer le **circuit hydraulique** (skimmers, buses, bonde) et la **filtration** au **local technique** (pompe, filtre). `[C]`
- **Résumé** : raccorder les **skimmers/buses/bonde de fond** en PVC pression jusqu'au **local technique**, poser **pompe** et **filtre** (sable/cartouche), réaliser la **liaison équipotentielle** de tous les éléments métalliques (sécurité électrique) ; le **raccordement électrique** de la pompe/des projecteurs est **réservé à un électricien** (interface Électricité), non traité ici. `[C]` ⟦dimensionnement/débit selon bassin à confirmer⟧

## Réalisation
- **Étapes** :
  1. Raccorder skimmers/buses/bonde (PVC pression). `[C]`
  2. Poser **pompe** + **filtre** au local technique. `[C]` → [filtration-pompe-defaut](../../../diagnostics/piscine/filtration-pompe-defaut.md)
  3. **Liaison équipotentielle** (métalliques) — sécurité. `[A]` → [controler-mise-a-la-terre](../../../professions/electricite-generale/cards/controler-mise-a-la-terre.md)
  4. **Raccordement électrique** pompe/projecteurs = **Électricité** (réservé). `[A]`
- **Points critiques** : étanchéité des collages PVC ; **liaison équipotentielle** ; débit/filtration dimensionnés ; **électricité = interface**.
- **Sécurité** : électrique (eau+élec, interface) ; local confiné (ventilation) ; — **Risque de noyade** : une piscine/fouille en eau non protégée = **danger mortel** (enfants). Les **dispositifs de sécurité** (barrière, alarme, couverture, abri — **obligation légale**) doivent être opérationnels avant la mise en eau/service. **Fouille / terrassement** : effondrement des parois, engins → blindage/talutage (**interface** Terrassement). **Risques électriques** : eau + électricité = très dangereux ; le **raccordement électrique** (local technique, pompe, projecteurs), la **liaison équipotentielle** et les **volumes** (NF C 15-100 7-702) sont **réservés à un électricien** → voir Électricité. **Produits de traitement** (chlore, acides) : stockage/manipulation ; **ne jamais mélanger chlore et acide** (dégagement gazeux toxique) → interface Traitement de l'eau. **Local technique** confiné : ventilation. **Manutention** : coque polyester (grue), panneaux, margelles lourdes. **Amiante** (rénovation ancienne) : diagnostic ; retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : sécurité électrique des piscines (volumes 0/1/2, liaison équipotentielle) **NF C 15-100** (partie 7-702) ; structure béton du bassin (**interface** maçonnerie) **DTU 21** ; **sécurité des piscines** — barrières / alarmes / couvertures / abris **NF P 90-306 à 90-309** et **obligation légale** (Code de la construction), norme européenne **NF EN 16582** ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Mise en eau / traitement** : `cite-carte` → [mettre-en-eau-traiter](mettre-en-eau-traiter.md)

## Relations & tags
- **Tags** : `metier:piscine famille:specialises sous-famille:piscine intervention:realiser cluster:hydraulique cluster:filtration cluster:local-technique complexite:avancee type:installation securite:electrique relation:electricite-generale`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
