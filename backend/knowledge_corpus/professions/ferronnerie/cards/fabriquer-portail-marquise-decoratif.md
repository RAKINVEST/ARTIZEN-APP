# Fabriquer un portail décoratif / une marquise

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `fabriquer-portail-marquise-decoratif` |
| Titre | Fabriquer un portail décoratif / une marquise |
| Profession | `metier:ferronnerie` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:ferronnerie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : fabriquer de grands ouvrages d'art : **portail décoratif**, **marquise**, verrière ornementale ; motorisation/vitrage = **interfaces**. `[C]`
- **Résumé** : concevoir et forger un **portail décoratif** (vantaux, remplissage ornemental) ou une **marquise/verrière** ornementale, en prévoyant la **structure** et les fixations ; la **motorisation** relève des **Automatismes de portails**, le **vitrage** de la **Vitrerie**, un éventuel **contrôle d'accès** de son métier — le ferronnier fournit l'**ouvrage forgé**, jamais ces équipements. `[C]` ⟦dimensions/remplissage selon projet à confirmer⟧

## Réalisation
- **Étapes** :
  1. Forger/assembler le **portail** ou la **marquise**. `[C]`
  2. Prévoir l'éventuelle **motorisation** = Automatismes (interface). `[C]` → [principe-automatismes-portails](../../../professions/automatismes-portails/cards/principe-automatismes-portails.md)
  3. Prévoir le **vitrage** (marquise) = Vitrerie (interface). `[C]` → [poser-remplacer-vitrage](../../../professions/vitrerie/cards/poser-remplacer-vitrage.md)
  4. Contrôle d'accès éventuel = métier distinct. `[C]` → [poser-organe-verrouillage](../../../professions/controle-acces/cards/poser-organe-verrouillage.md)
- **Points critiques** : ouvrage forgé (art) maîtrisé ; **motorisation/vitrage/contrôle d'accès = interfaces** (jamais absorbés) ; structure/fixations.
- **Sécurité** : manutention (portail lourd) ; soudage ; hauteur (marquise). **Forge et chauffe** : métal porté au **rouge/blanc** (>1000 °C) → **brûlures graves**, incendie ; feu de forge maîtrisé, pinces, tabliers/gants cuir, écran, sol incombustible. **Soudage / meulage** : **risque incendie** (permis de feu, extincteur, combustibles éloignés), **projections** incandescentes, **fumées métalliques** (ventilation/aspiration, masque), **rayonnement** (écran, protection des tiers), électrisation. **EPI adaptés** : lunettes/écran, gants anti-chaleur/anti-coupure, protection auditive, chaussures. **Manutention des ouvrages lourds** (grilles, portails, rampes) : binôme/levage — écrasement/dos. **Travail en hauteur** à la pose (garde-corps, marquises, façade) : échafaudage/harnais. **Repérage des réseaux avant scellement/percement**. **Amiante / plomb** (revêtements anciens en restauration) : diagnostic ; retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : ouvrages métalliques (mise en œuvre, **interface** métallerie) **DTU 37.1** ; garde-corps **NF P01-012** ; exécution des structures acier **NF EN 1090**, qualification de soudage **NF EN ISO 9606**, protection anticorrosion **NF EN ISO 12944** ; motorisation éventuelle d'un portail (**interface** Électricité) **NF C 15-100** ⟦EN 1090 / EN ISO 9606 / ISO 12944 et versions exactes en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Pose sur site** : `cite-carte` → [poser-restaurer-ouvrage](poser-restaurer-ouvrage.md)

## Relations & tags
- **Tags** : `metier:ferronnerie famille:specialises sous-famille:ferronnerie intervention:realiser cluster:portails-decoratifs cluster:marquises complexite:avancee type:fabrication securite:manutention relation:automatismes-portails relation:vitrerie relation:controle-acces`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
