# Poser un grillage souple ou rigide

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `poser-grillage-souple-rigide` |
| Titre | Poser un grillage souple ou rigide |
| Profession | `metier:cloture` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:cloture` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : poser un **grillage souple** (rouleau tendu) ou **rigide** (panneaux soudés) entre poteaux. `[C]`
- **Résumé** : pour le **souple** : poser jambes de force, **fils de tension** et tendeurs, dérouler et **tendre** le grillage, agrafer aux fils ; pour le **rigide** : fixer les **panneaux soudés** aux poteaux (clips/plots) d'aplomb et alignés ; gérer les dénivelés (redans) ; une **grille ouvragée** ou un portail métallique relève de la **Métallerie**. `[C]` ⟦type/tension/entraxe selon grillage à confirmer⟧

## Réalisation
- **Étapes** :
  1. **Souple** : jambes de force, fils de tension, **tendre**. `[C]`
  2. **Rigide** : fixer les panneaux soudés (clips) alignés. `[C]`
  3. Gérer les dénivelés (redans). `[C]` → [cloture-corrodee-degradee](../../../diagnostics/cloture/cloture-corrodee-degradee.md)
  4. Grille/portail **métallique** = Métallerie (frontière). `[C]` → [poser-portail-grille-metallique](../../../professions/serrurerie-metallerie/cards/poser-portail-grille-metallique.md)
- **Points critiques** : grillage **bien tendu**/aligné ; dénivelés gérés ; frontière avec la métallerie (grille ouvragée) tenue.
- **Sécurité** : **fil sous tension** (fouet/coupures) ; manutention ; découpe. **Repérage des réseaux enterrés avant creusement** (**DT-DICT**) : une clôture = de nombreux **trous de poteaux** → ne pas percer un câble/tuyau (électrocution, gaz, eau). **Terrassements légers** : effondrement des petits trous, tarière/engins. **Scellements béton** : ciment (brûlures/irritations, EPI), charges. **Manutention** (poteaux, panneaux rigides, rouleaux de grillage, platines) : binôme/moyens — dos/écrasement. **Découpe / outils électroportatifs** : meuleuse/scie (projections, coupures) — disque adapté/capot, lunettes/gants. **Fil de grillage sous tension** : coupures, fouet du fil (écran facial). **Travail en bordure** (voie/talus) : signalisation/co-activité. **Amiante** (rénovation, anciens panneaux/plaques) : diagnostic ; retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : béton de scellement des poteaux (**interface**) **DTU 21** ; ouvrages métalliques / portillons (**interface** métallerie) **DTU 37.1** ; grillages **NF EN 10223**, protection anticorrosion **NF EN ISO 1461 / NF EN ISO 12944**, règles d'**urbanisme** (PLU : hauteur/aspect), **bornage** (Code civil, géomètre) et **DT-DICT** (réseaux) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Panneaux décoratifs / occultation** : `cite-carte` → [poser-cloture-panneaux-occultante](poser-cloture-panneaux-occultante.md)

## Relations & tags
- **Tags** : `metier:cloture famille:specialises sous-famille:cloture intervention:realiser cluster:grillage-souple cluster:grillage-rigide cluster:types-clotures complexite:moyenne type:installation securite:coupure relation:serrurerie-metallerie`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
