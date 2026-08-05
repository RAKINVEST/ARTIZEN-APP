# Assembler et souder un ouvrage forgé

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `assembler-souder-ouvrage` |
| Titre | Assembler et souder un ouvrage forgé |
| Profession | `metier:ferronnerie` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:ferronnerie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : assembler les éléments forgés par **soudage** et/ou **assemblages traditionnels** (rivets, colliers, tenons à chaud). `[C]`
- **Résumé** : positionner les éléments sur l'épure, assembler par **soudage** (MIG-MAG/TIG/arc) et/ou **assemblages traditionnels** (rivets, **colliers**, bagues, tenons/embrèvements à chaud), **meuler/ébaver** discrètement pour préserver l'aspect d'art, contrôler l'équerrage/la planéité ; le **soudage** impose un **permis de feu** et la protection incendie. `[C]` ⟦procédé/assemblages selon ouvrage à confirmer⟧

## Réalisation
- **Étapes** :
  1. Positionner sur l'épure ; pointer. `[C]`
  2. **Souder** (permis de feu) et/ou **riveter/collier**. `[A]` → [permis-feu-forge-reseaux-avant-travaux-ferronnerie](../../../procedures/ferronnerie/permis-feu-forge-reseaux-avant-travaux-ferronnerie.md)
  3. Meuler/ébaver discrètement (aspect d'art). `[C]`
  4. Contrôler équerrage/planéité. `[C]` → [element-forge-casse-descelle](../../../diagnostics/ferronnerie/element-forge-casse-descelle.md)
- **Points critiques** : assemblages solides et **esthétiques** (aspect d'art) ; **permis de feu** ; planéité/équerrage ; discrétion des soudures.
- **Sécurité** : **soudage/incendie** ; fumées métalliques ; brûlures. **Forge et chauffe** : métal porté au **rouge/blanc** (>1000 °C) → **brûlures graves**, incendie ; feu de forge maîtrisé, pinces, tabliers/gants cuir, écran, sol incombustible. **Soudage / meulage** : **risque incendie** (permis de feu, extincteur, combustibles éloignés), **projections** incandescentes, **fumées métalliques** (ventilation/aspiration, masque), **rayonnement** (écran, protection des tiers), électrisation. **EPI adaptés** : lunettes/écran, gants anti-chaleur/anti-coupure, protection auditive, chaussures. **Manutention des ouvrages lourds** (grilles, portails, rampes) : binôme/levage — écrasement/dos. **Travail en hauteur** à la pose (garde-corps, marquises, façade) : échafaudage/harnais. **Repérage des réseaux avant scellement/percement**. **Amiante / plomb** (revêtements anciens en restauration) : diagnostic ; retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : ouvrages métalliques (mise en œuvre, **interface** métallerie) **DTU 37.1** ; garde-corps **NF P01-012** ; exécution des structures acier **NF EN 1090**, qualification de soudage **NF EN ISO 9606**, protection anticorrosion **NF EN ISO 12944** ; motorisation éventuelle d'un portail (**interface** Électricité) **NF C 15-100** ⟦EN 1090 / EN ISO 9606 / ISO 12944 et versions exactes en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Protection / finitions** : `cite-carte` → [proteger-patiner-finir](proteger-patiner-finir.md)

## Relations & tags
- **Tags** : `metier:ferronnerie famille:specialises sous-famille:ferronnerie intervention:realiser cluster:soudage cluster:assemblage-traditionnel complexite:avancee type:fabrication securite:incendie relation:serrurerie-metallerie`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
