# Poser / remplacer une gouttière

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `poser-remplacer-gouttiere` |
| Titre | Poser / remplacer une gouttière |
| Profession | `metier:zinguerie` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:zinguerie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : poser ou remplacer une gouttière (pendante ou rampante) en assurant la **pente** et l'évacuation vers les descentes. `[C]`
- **Résumé** : déposer l'ancienne gouttière, poser les crochets à la **bonne pente**, façonner et raccorder les éléments, souder les jonctions et raccorder les descentes, puis contrôler l'écoulement. `[C]` ⟦pente/section selon surface à confirmer⟧

## Réalisation
- **Étapes** :
  1. Sécuriser l'accès (protections collectives, EPI). `[A]`
  2. Poser les **crochets** à la **pente** correcte (vers descentes). `[B]` ⟦pente à confirmer⟧
  3. Façonner/ajuster les éléments ; poser naissances et talons. `[C]`
  4. **Souder** les jonctions (zinc/cuivre) ; raccorder les descentes. `[C]` → [souder-zinc](souder-zinc.md)
  5. Contrôler l'**écoulement** (eau) et l'étanchéité. `[C]` → [gouttiere-fuite-debordement](../../../diagnostics/zinguerie/gouttiere-fuite-debordement.md)
- **Points critiques** : pente régulière ; dilatation (joints) ; évacuation dimensionnée ; compatibilité des métaux.
- **Sécurité** : hauteur ; coupure ; chalumeau (soudure). **Travail en **hauteur** : risque de **chute** — protections **collectives** (échafaudage/garde-corps) prioritaires, EPI antichute, **météo** (vent/gel/pluie) surveillée. **Manipulation des métaux** : risque de **coupure** (gants, arêtes vives). **Chalumeau / soudure** (brasure) : risque de **brûlure/incendie** — protection, **extincteur**, pas de flamme près de matériaux inflammables. **Arrêt immédiat en cas de danger.** Une intervention en toiture relève de **compétences adaptées**.** `[A]`

## Cadre & suites
- **Normes** : évacuation des eaux pluviales **DTU 40.5** ; couverture zinc **DTU 40.41** ; couverture cuivre **DTU 40.45** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Descentes EP** : `cite-carte` → [poser-descente-ep](poser-descente-ep.md)

## Relations & tags
- **Tags** : `metier:zinguerie equipement:gouttiere famille:enveloppe sous-famille:zinguerie intervention:poser intervention:remplacer cluster:gouttieres cluster:soudure complexite:moyenne type:installation securite:hauteur`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
