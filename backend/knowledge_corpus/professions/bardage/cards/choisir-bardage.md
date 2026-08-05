# Choisir un matériau de bardage

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `choisir-bardage` |
| Titre | Choisir un matériau de bardage |
| Profession | `metier:bardage` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:bardage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : choisir le matériau de bardage (bois, composite, fibres-ciment, métallique, PVC, terre cuite) selon l'exposition, l'entretien et la réglementation. `[C]`
- **Résumé** : comparer les familles selon la **durabilité/exposition**, l'entretien, l'aspect, le **feu** (règles selon hauteur) et le coût ; vérifier l'Avis Technique/DTU applicable et la compatibilité avec l'ossature/fixations. `[C]` ⟦classe d'emploi/feu selon matériau à confirmer⟧

## Réalisation
- **Étapes** :
  1. **Bois** (classe d'emploi, grisaillement, entretien). `[C]` → [poser-bardage-bois](poser-bardage-bois.md)
  2. **Fibres-ciment / composite** (peu d'entretien, découpe=silice). `[C]` → [poser-bardage-fibres-ciment](poser-bardage-fibres-ciment.md)
  3. **Métallique / terre cuite / PVC** : selon aspect et AT. `[C]` ⟦à confirmer⟧
  4. Vérifier **feu** (hauteur), ventilation, fixations compatibles. `[C]`
- **Points critiques** : **classe d'emploi** (bois) adaptée à l'exposition ; règles **incendie** selon hauteur ; compatibilité matériau/ossature/fixation.
- **Sécurité** : manutention/découpe (poussières, **silice** fibres-ciment) ; stockage. **Travail en **hauteur** (façade) : risque de **chute** — **échafaudage** / protections **collectives** prioritaires, EPI antichute, **stabilité du support/ossature** vérifiée, **météo** (vent — prise au vent des éléments longs) surveillée. **Découpe** : poussières — **fibres-ciment = silice** (masque adapté/aspiration), bois (poussières), métal (**coupure**). **Manutention** des éléments longs. **Arrêt immédiat en cas de danger.** Une intervention en bardage relève de **compétences adaptées**.** `[A]`

## Cadre & suites
- **Normes** : revêtements extérieurs en bois (bardage) **DTU 41.2** ; support en maçonnerie **DTU 20.1** ; bardages composite/fibres-ciment/métallique/terre cuite sous **Avis Technique** ⟦à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Isolation support** : `cite-carte` → [principe-isolation](../../../professions/isolation/cards/principe-isolation.md)

## Relations & tags
- **Tags** : `metier:bardage famille:enveloppe sous-famille:bardage intervention:choisir cluster:bardage-bois cluster:bardage-composite cluster:bardage-metallique cluster:bardage-pvc complexite:moyenne type:reference securite:respiratoire relation:isolation`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
