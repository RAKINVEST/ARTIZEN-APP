# Poser une descente d'eaux pluviales

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `poser-descente-ep` |
| Titre | Poser une descente d'eaux pluviales |
| Profession | `metier:zinguerie` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:zinguerie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : poser une descente EP reliant la gouttière/chéneau au réseau d'évacuation au sol. `[C]`
- **Résumé** : raccorder à la naissance, poser les tuyaux et coudes fixés par colliers, raccorder au **désable/regard** au sol, contrôler l'écoulement. `[C]`

## Réalisation
- **Étapes** :
  1. Raccorder à la **naissance** de gouttière. `[C]`
  2. Poser tuyaux/coudes, fixés par **colliers** (dilatation). `[C]`
  3. Raccorder au réseau au sol (désableur/regard). `[C]` → [deboucher-evacuation-sanitaire](../../../professions/plomberie/cards/deboucher-evacuation-sanitaire.md)
  4. Contrôler l'écoulement et l'étanchéité des raccords. `[C]` → [descente-ep-bouchee](../../../diagnostics/zinguerie/descente-ep-bouchee.md)
- **Points critiques** : fixations respectant la **dilatation** ; raccordement au réseau conforme ; pas de contre-pente.
- **Sécurité** : hauteur ; coupure. **Travail en **hauteur** : risque de **chute** — protections **collectives** (échafaudage/garde-corps) prioritaires, EPI antichute, **météo** (vent/gel/pluie) surveillée. **Manipulation des métaux** : risque de **coupure** (gants, arêtes vives). **Chalumeau / soudure** (brasure) : risque de **brûlure/incendie** — protection, **extincteur**, pas de flamme près de matériaux inflammables. **Arrêt immédiat en cas de danger.** Une intervention en toiture relève de **compétences adaptées**.** `[A]`

## Cadre & suites
- **Normes** : évacuation des eaux pluviales **DTU 40.5** ; couverture zinc **DTU 40.41** ; couverture cuivre **DTU 40.45** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Contrôle** : `cite-procedure` → [controle-evacuation-ep](../../../procedures/zinguerie/controle-evacuation-ep.md)

## Relations & tags
- **Tags** : `metier:zinguerie equipement:descente famille:enveloppe sous-famille:zinguerie intervention:poser cluster:descentes-ep complexite:moyenne type:installation securite:hauteur relation:plomberie`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
