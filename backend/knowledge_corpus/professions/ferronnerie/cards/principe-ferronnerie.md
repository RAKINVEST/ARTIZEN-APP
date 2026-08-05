# Principe de la ferronnerie d'art

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `principe-ferronnerie` |
| Titre | Principe de la ferronnerie d'art |
| Profession | `metier:ferronnerie` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:ferronnerie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : définir la **ferronnerie d'art** (travail du métal forgé à des fins ornementales) et la distinguer strictement de la serrurerie / métallerie courante. `[C]`
- **Résumé** : la ferronnerie d'art **conçoit, forge et assemble** des ouvrages métalliques **ornementaux** (grilles, garde-corps, rampes, portails décoratifs, marquises, éléments forgés) par la **forge à chaud** et des techniques traditionnelles ; elle se distingue de la **serrurerie / métallerie courante** (ouvrages fonctionnels, verrouillage) — même si elles partagent soudage et anticorrosion. Motorisation, vitrage et contrôle d'accès d'un ouvrage sont des **métiers distincts** (interfaces). `[C]` ⟦style/matériaux selon projet à confirmer⟧

## Réalisation
- **Étapes** :
  1. **Distinction** : métallerie **courante** ≠ ferronnerie d'**art**. `[C]` → [principe-serrurerie-metallerie](../../../professions/serrurerie-metallerie/cards/principe-serrurerie-metallerie.md)
  2. **Concevoir / tracer** l'ouvrage d'art. `[C]` → [concevoir-tracer-ouvrage-art](concevoir-tracer-ouvrage-art.md)
  3. **Forger** les éléments (chauffe/martelage). `[C]` → [forger-faconner-elements](forger-faconner-elements.md)
  4. **Protéger / patiner** (finitions d'art). `[C]` → [proteger-patiner-finir](proteger-patiner-finir.md)
- **Points critiques** : **art forgé** (≠ métallerie courante) ; forge/chauffe ; soudage/incendie ; motorisation/vitrage/contrôle d'accès = interfaces.
- **Sécurité** : forge/brûlures ; soudage/incendie ; manutention lourde. **Forge et chauffe** : métal porté au **rouge/blanc** (>1000 °C) → **brûlures graves**, incendie ; feu de forge maîtrisé, pinces, tabliers/gants cuir, écran, sol incombustible. **Soudage / meulage** : **risque incendie** (permis de feu, extincteur, combustibles éloignés), **projections** incandescentes, **fumées métalliques** (ventilation/aspiration, masque), **rayonnement** (écran, protection des tiers), électrisation. **EPI adaptés** : lunettes/écran, gants anti-chaleur/anti-coupure, protection auditive, chaussures. **Manutention des ouvrages lourds** (grilles, portails, rampes) : binôme/levage — écrasement/dos. **Travail en hauteur** à la pose (garde-corps, marquises, façade) : échafaudage/harnais. **Repérage des réseaux avant scellement/percement**. **Amiante / plomb** (revêtements anciens en restauration) : diagnostic ; retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : ouvrages métalliques (mise en œuvre, **interface** métallerie) **DTU 37.1** ; garde-corps **NF P01-012** ; exécution des structures acier **NF EN 1090**, qualification de soudage **NF EN ISO 9606**, protection anticorrosion **NF EN ISO 12944** ; motorisation éventuelle d'un portail (**interface** Électricité) **NF C 15-100** ⟦EN 1090 / EN ISO 9606 / ISO 12944 et versions exactes en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Pose / restauration** : `cite-carte` → [poser-restaurer-ouvrage](poser-restaurer-ouvrage.md)

## Relations & tags
- **Tags** : `metier:ferronnerie famille:specialises sous-famille:ferronnerie intervention:comprendre cluster:forge cluster:elements-forges type:principe securite:brulure relation:serrurerie-metallerie`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
