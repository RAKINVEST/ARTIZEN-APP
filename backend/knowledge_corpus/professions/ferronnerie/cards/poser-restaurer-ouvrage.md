# Poser et restaurer un ouvrage de ferronnerie

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `poser-restaurer-ouvrage` |
| Titre | Poser et restaurer un ouvrage de ferronnerie |
| Profession | `metier:ferronnerie` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:ferronnerie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : poser un ouvrage forgé sur site et **restaurer** un ouvrage ancien (patrimoine) — hauteur, manutention, amiante/plomb. `[C]`
- **Résumé** : poser l'ouvrage (grille, garde-corps, portail, rampe) par **scellement**/fixations adaptées au support, d'aplomb et de niveau, souvent **en hauteur** ; en **restauration**, déposer/relever l'existant, réparer les éléments forgés dans le respect de l'ouvrage, et **diagnostiquer amiante/plomb** des revêtements anciens avant décapage/chauffe ; repérer les réseaux avant scellement. `[C]` ⟦fixations/support et état patrimonial à confirmer⟧

## Réalisation
- **Étapes** :
  1. Sceller/fixer l'ouvrage (support ; **réseaux** repérés). `[A]`
  2. Poser d'aplomb/niveau (souvent **en hauteur**). `[C]`
  3. **Restauration** : relever/réparer dans le respect de l'ouvrage. `[C]` → [element-forge-casse-descelle](../../../diagnostics/ferronnerie/element-forge-casse-descelle.md)
  4. **Amiante/plomb** (revêtements anciens) → diagnostic. `[A]`
- **Points critiques** : scellement adapté (réseaux) ; aplomb/niveau ; respect de l'ouvrage d'origine ; **amiante/plomb** en restauration.
- **Sécurité** : **hauteur** ; manutention lourde ; amiante/plomb (restauration). **Forge et chauffe** : métal porté au **rouge/blanc** (>1000 °C) → **brûlures graves**, incendie ; feu de forge maîtrisé, pinces, tabliers/gants cuir, écran, sol incombustible. **Soudage / meulage** : **risque incendie** (permis de feu, extincteur, combustibles éloignés), **projections** incandescentes, **fumées métalliques** (ventilation/aspiration, masque), **rayonnement** (écran, protection des tiers), électrisation. **EPI adaptés** : lunettes/écran, gants anti-chaleur/anti-coupure, protection auditive, chaussures. **Manutention des ouvrages lourds** (grilles, portails, rampes) : binôme/levage — écrasement/dos. **Travail en hauteur** à la pose (garde-corps, marquises, façade) : échafaudage/harnais. **Repérage des réseaux avant scellement/percement**. **Amiante / plomb** (revêtements anciens en restauration) : diagnostic ; retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : ouvrages métalliques (mise en œuvre, **interface** métallerie) **DTU 37.1** ; garde-corps **NF P01-012** ; exécution des structures acier **NF EN 1090**, qualification de soudage **NF EN ISO 9606**, protection anticorrosion **NF EN ISO 12944** ; motorisation éventuelle d'un portail (**interface** Électricité) **NF C 15-100** ⟦EN 1090 / EN ISO 9606 / ISO 12944 et versions exactes en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Kit** : `utilise-kit` → [kit-ferronnier](../../../kits/ferronnerie/kit-ferronnier.md)

## Relations & tags
- **Tags** : `metier:ferronnerie famille:specialises sous-famille:ferronnerie intervention:realiser intervention:reparer cluster:pose cluster:restauration complexite:avancee type:installation securite:hauteur`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
