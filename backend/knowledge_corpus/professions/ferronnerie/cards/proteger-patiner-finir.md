# Protéger et patiner (finitions d'art)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `proteger-patiner-finir` |
| Titre | Protéger et patiner (finitions d'art) |
| Profession | `metier:ferronnerie` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:ferronnerie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : assurer la **protection anticorrosion** et les **finitions d'art** (patine, cire, brunissage, peinture ferronnerie). `[C]`
- **Résumé** : préparer le subjectile (décaper/brosser/dégraisser), appliquer une **protection anticorrosion** (apprêt/galva à froid, système NF EN ISO 12944) puis la **finition d'art** : peinture ferronnerie, **patine**, effets (vieilli, brunissage), cire de protection ; en extérieur, soigner les **rétentions d'eau** et la reprise des soudures (points de corrosion). `[C]` ⟦système/patine selon exposition et rendu à confirmer⟧

## Réalisation
- **Étapes** :
  1. Préparer (décapage/brossage/dégraissage). `[C]`
  2. **Anticorrosion** (apprêt/galva à froid). `[C]` → [ouvrage-forge-corrode](../../../diagnostics/ferronnerie/ouvrage-forge-corrode.md)
  3. **Finition d'art** (patine/peinture/cire). `[C]` → [finition-patine-degradee](../../../diagnostics/ferronnerie/finition-patine-degradee.md)
  4. Soigner rétentions d'eau / reprise soudures. `[C]`
- **Points critiques** : **protection durable** (points de corrosion/soudures) ; finition d'art homogène ; adaptée à l'exposition.
- **Sécurité** : produits (solvants/décapants) ; poussières (décapage) ; ventilation. **Forge et chauffe** : métal porté au **rouge/blanc** (>1000 °C) → **brûlures graves**, incendie ; feu de forge maîtrisé, pinces, tabliers/gants cuir, écran, sol incombustible. **Soudage / meulage** : **risque incendie** (permis de feu, extincteur, combustibles éloignés), **projections** incandescentes, **fumées métalliques** (ventilation/aspiration, masque), **rayonnement** (écran, protection des tiers), électrisation. **EPI adaptés** : lunettes/écran, gants anti-chaleur/anti-coupure, protection auditive, chaussures. **Manutention des ouvrages lourds** (grilles, portails, rampes) : binôme/levage — écrasement/dos. **Travail en hauteur** à la pose (garde-corps, marquises, façade) : échafaudage/harnais. **Repérage des réseaux avant scellement/percement**. **Amiante / plomb** (revêtements anciens en restauration) : diagnostic ; retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : ouvrages métalliques (mise en œuvre, **interface** métallerie) **DTU 37.1** ; garde-corps **NF P01-012** ; exécution des structures acier **NF EN 1090**, qualification de soudage **NF EN ISO 9606**, protection anticorrosion **NF EN ISO 12944** ; motorisation éventuelle d'un portail (**interface** Électricité) **NF C 15-100** ⟦EN 1090 / EN ISO 9606 / ISO 12944 et versions exactes en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Pose** : `cite-carte` → [poser-restaurer-ouvrage](poser-restaurer-ouvrage.md)

## Relations & tags
- **Tags** : `metier:ferronnerie famille:specialises sous-famille:ferronnerie intervention:realiser cluster:anticorrosion cluster:finitions complexite:moyenne type:finition securite:produits-chimiques`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
