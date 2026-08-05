# Entretenir une zinguerie

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `entretenir-zinguerie` |
| Titre | Entretenir une zinguerie |
| Profession | `metier:zinguerie` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:zinguerie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : entretenir goutières, chéneaux et descentes (nettoyage, contrôle) pour éviter débordements et corrosion. `[C]`
- **Résumé** : nettoyer les évacuations (feuilles/mousses), contrôler fixations, pentes et corrosion, vérifier crapaudines et l'écoulement. `[C]`

## Réalisation
- **Étapes** :
  1. Sécuriser l'accès (protections, EPI). `[A]`
  2. **Nettoyer** goutières/chéneaux (feuilles, mousses). `[C]`
  3. Contrôler fixations, pentes, **corrosion** et crapaudines. `[C]` → [corrosion-perforation-zinguerie](../../../diagnostics/zinguerie/corrosion-perforation-zinguerie.md)
  4. Vérifier l'écoulement des descentes. `[C]` → [controle-evacuation-ep](../../../procedures/zinguerie/controle-evacuation-ep.md)
- **Points critiques** : nettoyage avant saison des pluies ; crapaudines ; détecter la corrosion tôt.
- **Sécurité** : hauteur ; coupure ; déplacements en toiture sécurisés. **Travail en **hauteur** : risque de **chute** — protections **collectives** (échafaudage/garde-corps) prioritaires, EPI antichute, **météo** (vent/gel/pluie) surveillée. **Manipulation des métaux** : risque de **coupure** (gants, arêtes vives). **Chalumeau / soudure** (brasure) : risque de **brûlure/incendie** — protection, **extincteur**, pas de flamme près de matériaux inflammables. **Arrêt immédiat en cas de danger.** Une intervention en toiture relève de **compétences adaptées**.** `[A]`

## Cadre & suites
- **Normes** : évacuation des eaux pluviales **DTU 40.5** ; couverture zinc **DTU 40.41** ; couverture cuivre **DTU 40.45** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Kit** : `utilise-kit` → [kit-zingueur](../../../kits/zinguerie/kit-zingueur.md)

## Relations & tags
- **Tags** : `metier:zinguerie equipement:gouttiere famille:enveloppe sous-famille:zinguerie intervention:entretenir cluster:entretien cluster:maintenance cluster:gouttieres complexite:simple type:entretien securite:hauteur`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
