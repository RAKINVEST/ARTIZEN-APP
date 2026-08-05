# Traiter les points singuliers d'un bardage

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `traiter-points-singuliers-bardage` |
| Titre | Traiter les points singuliers d'un bardage |
| Profession | `metier:bardage` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:bardage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : traiter les points singuliers d'un bardage : angles, encadrements de baies, couronnement, soubassement, jonctions. `[C]`
- **Résumé** : réaliser les angles (profilés/coupes), les **encadrements de baies** (habillages), le **couronnement** (bavette/couvertine — interface zinguerie), le **soubassement** (départ ventilé, garde au sol) et les jonctions, sans rompre la ventilation ni l'étanchéité à l'eau. `[C]` ⟦profilés/accessoires selon système à confirmer⟧

## Réalisation
- **Étapes** :
  1. **Angles** (profilés d'angle / coupes d'onglet). `[C]`
  2. **Encadrements de baies** (habillages, appuis). `[C]`
  3. **Couronnement** (bavette/couvertine) — interface zinguerie. `[C]` → [realiser-solin-abergement](../../../professions/zinguerie/cards/realiser-solin-abergement.md)
  4. **Soubassement** : départ ventilé, garde au sol, grille anti-rongeurs. `[C]`
- **Points critiques** : ventilation conservée aux singularités ; évacuation de l'eau ; garde au sol du soubassement ; interface zinguerie (couronnement).
- **Sécurité** : hauteur ; découpe (poussières/silice) ; interfaces. **Travail en **hauteur** (façade) : risque de **chute** — **échafaudage** / protections **collectives** prioritaires, EPI antichute, **stabilité du support/ossature** vérifiée, **météo** (vent — prise au vent des éléments longs) surveillée. **Découpe** : poussières — **fibres-ciment = silice** (masque adapté/aspiration), bois (poussières), métal (**coupure**). **Manutention** des éléments longs. **Arrêt immédiat en cas de danger.** Une intervention en bardage relève de **compétences adaptées**.** `[A]`

## Cadre & suites
- **Normes** : revêtements extérieurs en bois (bardage) **DTU 41.2** ; support en maçonnerie **DTU 20.1** ; bardages composite/fibres-ciment/métallique/terre cuite sous **Avis Technique** ⟦à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Zinguerie (couronnement)** : `relation:zinguerie`

## Relations & tags
- **Tags** : `metier:bardage famille:enveloppe sous-famille:bardage intervention:realiser cluster:points-singuliers cluster:soubassement cluster:encadrements complexite:expert type:installation securite:hauteur relation:zinguerie`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
