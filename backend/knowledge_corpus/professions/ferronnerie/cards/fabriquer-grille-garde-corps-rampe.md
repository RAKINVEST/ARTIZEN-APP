# Fabriquer une grille / un garde-corps / une rampe forgés

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `fabriquer-grille-garde-corps-rampe` |
| Titre | Fabriquer une grille / un garde-corps / une rampe forgés |
| Profession | `metier:ferronnerie` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:ferronnerie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## Cadrage
- **Objectif** : fabriquer des ouvrages d'art courants : **grilles**, **garde-corps** et **rampes** forgés, alliant décor et sécurité. `[B]`
- **Résumé** : assembler les éléments forgés en **grille de défense/clôture**, **garde-corps** ou **rampe d'escalier**, en respectant les contraintes de sécurité (garde-corps : hauteur de protection, écartement, effort en main courante — **NF P01-012**) sans trahir le dessin ; un garde-corps **courant** (non ornemental) relève plutôt de la **Métallerie**. `[B]` ⟦hauteurs/écarts/effort NF P01-012 à confirmer⟧

## Réalisation
- **Étapes** :
  1. Assembler grille / garde-corps / rampe (épure). `[C]`
  2. Respecter sécurité garde-corps (hauteur/écart/effort). `[A]`
  3. Garde-corps **courant** = Métallerie (frontière). `[C]` → [poser-garde-corps-escalier](../../../professions/serrurerie-metallerie/cards/poser-garde-corps-escalier.md)
  4. Préparer à la protection/finition. `[C]` → [proteger-patiner-finir](proteger-patiner-finir.md)
- **Points critiques** : **sécurité garde-corps** (NF P01-012) + esthétique ; écartements maîtrisés ; frontière avec la métallerie courante.
- **Sécurité** : manutention lourde ; soudage ; hauteur (pose). **Forge et chauffe** : métal porté au **rouge/blanc** (>1000 °C) → **brûlures graves**, incendie ; feu de forge maîtrisé, pinces, tabliers/gants cuir, écran, sol incombustible. **Soudage / meulage** : **risque incendie** (permis de feu, extincteur, combustibles éloignés), **projections** incandescentes, **fumées métalliques** (ventilation/aspiration, masque), **rayonnement** (écran, protection des tiers), électrisation. **EPI adaptés** : lunettes/écran, gants anti-chaleur/anti-coupure, protection auditive, chaussures. **Manutention des ouvrages lourds** (grilles, portails, rampes) : binôme/levage — écrasement/dos. **Travail en hauteur** à la pose (garde-corps, marquises, façade) : échafaudage/harnais. **Repérage des réseaux avant scellement/percement**. **Amiante / plomb** (revêtements anciens en restauration) : diagnostic ; retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : ouvrages métalliques (mise en œuvre, **interface** métallerie) **DTU 37.1** ; garde-corps **NF P01-012** ; exécution des structures acier **NF EN 1090**, qualification de soudage **NF EN ISO 9606**, protection anticorrosion **NF EN ISO 12944** ; motorisation éventuelle d'un portail (**interface** Électricité) **NF C 15-100** ⟦EN 1090 / EN ISO 9606 / ISO 12944 et versions exactes en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Portail / marquise** : `cite-carte` → [fabriquer-portail-marquise-decoratif](fabriquer-portail-marquise-decoratif.md)

## Relations & tags
- **Tags** : `metier:ferronnerie famille:specialises sous-famille:ferronnerie intervention:realiser cluster:grilles cluster:garde-corps cluster:rampes complexite:avancee type:fabrication securite:manutention relation:serrurerie-metallerie`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
