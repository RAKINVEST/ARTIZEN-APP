# Principe de la zinguerie (évacuation EP et ouvrages métalliques)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `principe-zinguerie` |
| Titre | Principe de la zinguerie (évacuation EP et ouvrages métalliques) |
| Profession | `metier:zinguerie` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:zinguerie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : comprendre le rôle de la zinguerie : évacuation des eaux pluviales et étanchéité des points singuliers de toiture, en **zinc, cuivre ou aluminium**. `[C]`
- **Résumé** : la zinguerie assure l'évacuation des eaux (goutières, descentes, chéneaux) et l'étanchéité des **points singuliers** (noues, rives, solins, abergements, entourages de cheminée), par **façonnage** et **soudure** des métaux. `[C]` ⟦choix matériau/épaisseur selon ouvrage à confirmer⟧

## Réalisation
- **Étapes** :
  1. **Évacuation EP** : goutières, descentes, chéneaux. `[C]` → [poser-remplacer-gouttiere](poser-remplacer-gouttiere.md)
  2. **Points singuliers** : noues, rives, solins, abergements. `[C]` → [realiser-solin-abergement](realiser-solin-abergement.md)
  3. **Métaux** : zinc, cuivre, aluminium (compatibilités galvaniques). `[C]`
  4. **Façonnage + soudure** (brasure) des éléments. `[C]` → [souder-zinc](souder-zinc.md)
- **Points critiques** : **compatibilité galvanique** des métaux ; pentes d'évacuation ; dilatation des métaux.
- **Sécurité** : toiture (hauteur) ; métaux (coupure) ; soudure (chalumeau). **Travail en **hauteur** : risque de **chute** — protections **collectives** (échafaudage/garde-corps) prioritaires, EPI antichute, **météo** (vent/gel/pluie) surveillée. **Manipulation des métaux** : risque de **coupure** (gants, arêtes vives). **Chalumeau / soudure** (brasure) : risque de **brûlure/incendie** — protection, **extincteur**, pas de flamme près de matériaux inflammables. **Arrêt immédiat en cas de danger.** Une intervention en toiture relève de **compétences adaptées**.** `[A]`

## Cadre & suites
- **Normes** : évacuation des eaux pluviales **DTU 40.5** ; couverture zinc **DTU 40.41** ; couverture cuivre **DTU 40.45** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Charpente (support)** : `cite-carte` → [inspecter-charpente](../../../professions/charpente/cards/inspecter-charpente.md)

## Relations & tags
- **Tags** : `metier:zinguerie equipement:gouttiere equipement:zinc famille:enveloppe sous-famille:zinguerie intervention:comprendre cluster:zinc cluster:cuivre cluster:aluminium cluster:faconnage cluster:soudure type:principe securite:hauteur relation:couverture relation:charpente`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
