# Concevoir et tracer un ouvrage d'art

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `concevoir-tracer-ouvrage-art` |
| Titre | Concevoir et tracer un ouvrage d'art |
| Profession | `metier:ferronnerie` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:ferronnerie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : concevoir le **dessin** d'un ouvrage forgé (motifs, style) et réaliser l'**épure** grandeur nature. `[C]`
- **Résumé** : étudier le **style** (époque, motifs : volutes, feuilles, rinceaux) et l'usage, dessiner l'ouvrage, relever les cotes du site, puis tracer l'**épure** (gabarit grandeur nature) qui guidera la forge et l'assemblage ; en restauration, relever fidèlement l'existant pour respecter l'ouvrage d'origine (garde-corps : hauteurs/écarts NF P01-012). `[C]` ⟦style/cotes selon commande et existant à confirmer⟧

## Réalisation
- **Étapes** :
  1. Étudier style/motifs/usage ; dessiner. `[C]`
  2. Relever les cotes du site (et l'existant en restauration). `[C]` → [poser-restaurer-ouvrage](poser-restaurer-ouvrage.md)
  3. Tracer l'**épure** (gabarit grandeur nature). `[C]` → [forger-faconner-elements](forger-faconner-elements.md)
  4. Vérifier contraintes (garde-corps : hauteurs/écarts). `[A]`
- **Points critiques** : épure fidèle au dessin ; cotes site justes ; contraintes réglementaires (garde-corps) ; respect de l'existant (restauration).
- **Sécurité** : — ; manutention (relevé) ; — **Forge et chauffe** : métal porté au **rouge/blanc** (>1000 °C) → **brûlures graves**, incendie ; feu de forge maîtrisé, pinces, tabliers/gants cuir, écran, sol incombustible. **Soudage / meulage** : **risque incendie** (permis de feu, extincteur, combustibles éloignés), **projections** incandescentes, **fumées métalliques** (ventilation/aspiration, masque), **rayonnement** (écran, protection des tiers), électrisation. **EPI adaptés** : lunettes/écran, gants anti-chaleur/anti-coupure, protection auditive, chaussures. **Manutention des ouvrages lourds** (grilles, portails, rampes) : binôme/levage — écrasement/dos. **Travail en hauteur** à la pose (garde-corps, marquises, façade) : échafaudage/harnais. **Repérage des réseaux avant scellement/percement**. **Amiante / plomb** (revêtements anciens en restauration) : diagnostic ; retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : ouvrages métalliques (mise en œuvre, **interface** métallerie) **DTU 37.1** ; garde-corps **NF P01-012** ; exécution des structures acier **NF EN 1090**, qualification de soudage **NF EN ISO 9606**, protection anticorrosion **NF EN ISO 12944** ; motorisation éventuelle d'un portail (**interface** Électricité) **NF C 15-100** ⟦EN 1090 / EN ISO 9606 / ISO 12944 et versions exactes en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Fabrication (grille/garde-corps)** : `cite-carte` → [fabriquer-grille-garde-corps-rampe](fabriquer-grille-garde-corps-rampe.md)

## Relations & tags
- **Tags** : `metier:ferronnerie famille:specialises sous-famille:ferronnerie intervention:comprendre cluster:conception cluster:trace complexite:moyenne type:conception securite:manutention`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
