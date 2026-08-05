# Contrôler / réparer un chéneau

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controler-reparer-chenaux` |
| Titre | Contrôler / réparer un chéneau |
| Profession | `metier:zinguerie` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:zinguerie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : contrôler et réparer un chéneau (encaissé) : étanchéité, écoulement, corrosion. `[C]`
- **Résumé** : contrôler l'étanchéité et l'écoulement, repérer corrosion/perforations, réparer (brasure/pièce) ou remplacer selon état, vérifier les évacuations. `[C]`

## Réalisation
- **Étapes** :
  1. Contrôler l'**écoulement** et repérer stagnations. `[C]`
  2. Rechercher **corrosion/perforations**. `[C]` → [corrosion-perforation-zinguerie](../../../diagnostics/zinguerie/corrosion-perforation-zinguerie.md)
  3. Réparer (**brasure**/pièce) ou remplacer selon état. `[C]` → [souder-zinc](souder-zinc.md)
  4. Vérifier moignons/trop-pleins et évacuations. `[C]`
- **Points critiques** : pente/trop-plein ; dilatation ; ne pas créer de contre-pente lors d'une réparation.
- **Sécurité** : hauteur ; chalumeau ; coupure. **Travail en **hauteur** : risque de **chute** — protections **collectives** (échafaudage/garde-corps) prioritaires, EPI antichute, **météo** (vent/gel/pluie) surveillée. **Manipulation des métaux** : risque de **coupure** (gants, arêtes vives). **Chalumeau / soudure** (brasure) : risque de **brûlure/incendie** — protection, **extincteur**, pas de flamme près de matériaux inflammables. **Arrêt immédiat en cas de danger.** Une intervention en toiture relève de **compétences adaptées**.** `[A]`

## Cadre & suites
- **Normes** : évacuation des eaux pluviales **DTU 40.5** ; couverture zinc **DTU 40.41** ; couverture cuivre **DTU 40.45** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Diagnostics liés** : `traite-diagnostic` → [corrosion-perforation-zinguerie](../../../diagnostics/zinguerie/corrosion-perforation-zinguerie.md)

## Relations & tags
- **Tags** : `metier:zinguerie equipement:cheneau famille:enveloppe sous-famille:zinguerie intervention:controler intervention:reparer cluster:cheneaux cluster:reparation cluster:controle complexite:avancee type:reparation securite:hauteur`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
