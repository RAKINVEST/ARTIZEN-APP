# Terrasser et implanter le bassin

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `terrasser-implanter-bassin` |
| Titre | Terrasser et implanter le bassin |
| Profession | `metier:piscine` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:piscine` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : implanter et **terrasser** la fouille du bassin (dimensions, réseaux, sécurité de la fouille). `[C]`
- **Résumé** : implanter le bassin (recul, réglementation, expositions), réaliser la **DICT** et le repérage des réseaux, puis la **fouille** aux dimensions (avec sur-largeur de travail), en sécurisant les **parois** (blindage/talutage) et en gérant les eaux ; le terrassement détaillé relève du **Terrassement** (interface). `[C]` ⟦implantation/recul selon règlement local à confirmer⟧

## Réalisation
- **Étapes** :
  1. Implanter (recul, expositions) ; **DICT / réseaux**. `[A]` → [terrasser-reseaux-dict](../../../professions/terrassement/cards/terrasser-reseaux-dict.md)
  2. Réaliser la **fouille** aux dimensions (sur-largeur). `[C]`
  3. **Sécuriser les parois** (blindage/talutage). `[A]` → [blinder-securiser-fouille](../../../professions/terrassement/cards/blinder-securiser-fouille.md)
  4. Gérer les eaux ; préparer le fond. `[C]` → [realiser-structure-bassin](realiser-structure-bassin.md)
- **Points critiques** : **DICT/réseaux** avant fouille ; **fouille sécurisée** (effondrement) ; dimensions/recul ; gestion des eaux.
- **Sécurité** : **effondrement de fouille** ; engins ; électricité (réseaux). **Risque de noyade** : une piscine/fouille en eau non protégée = **danger mortel** (enfants). Les **dispositifs de sécurité** (barrière, alarme, couverture, abri — **obligation légale**) doivent être opérationnels avant la mise en eau/service. **Fouille / terrassement** : effondrement des parois, engins → blindage/talutage (**interface** Terrassement). **Risques électriques** : eau + électricité = très dangereux ; le **raccordement électrique** (local technique, pompe, projecteurs), la **liaison équipotentielle** et les **volumes** (NF C 15-100 7-702) sont **réservés à un électricien** → voir Électricité. **Produits de traitement** (chlore, acides) : stockage/manipulation ; **ne jamais mélanger chlore et acide** (dégagement gazeux toxique) → interface Traitement de l'eau. **Local technique** confiné : ventilation. **Manutention** : coque polyester (grue), panneaux, margelles lourdes. **Amiante** (rénovation ancienne) : diagnostic ; retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : sécurité électrique des piscines (volumes 0/1/2, liaison équipotentielle) **NF C 15-100** (partie 7-702) ; structure béton du bassin (**interface** maçonnerie) **DTU 21** ; **sécurité des piscines** — barrières / alarmes / couvertures / abris **NF P 90-306 à 90-309** et **obligation légale** (Code de la construction), norme européenne **NF EN 16582** ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Interface Terrassement** : `renvoie-vers` → [principe-terrassement](../../../professions/terrassement/cards/principe-terrassement.md)

## Relations & tags
- **Tags** : `metier:piscine famille:specialises sous-famille:piscine intervention:realiser cluster:terrassement cluster:implantation complexite:avancee type:installation securite:effondrement relation:terrassement`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
