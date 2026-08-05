# Principe de la pose de clôture

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `principe-cloture` |
| Titre | Principe de la pose de clôture |
| Profession | `metier:cloture` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:cloture` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : comprendre les types de clôtures et la chaîne de pose (implantation → scellement → remplissage → portillon), et distinguer la clôture de ses voisins. `[C]`
- **Résumé** : poser une clôture enchaîne : **implantation/relevé des limites**, **scellement des poteaux**, pose du **remplissage** (grillage souple/rigide, panneaux bois/alu/composite, occultation) et d'un éventuel **portillon non motorisé** ; un **mur** de clôture maçonné relève de la **Maçonnerie**, une **haie** du **Paysagisme**, un **portail métallique** de la **Métallerie**, une **motorisation** des **Automatismes** — activités distinctes. `[C]` ⟦type de clôture selon projet/PLU à confirmer⟧

## Réalisation
- **Étapes** :
  1. **Implanter / relever les limites** (bornage). `[C]` → [implanter-relever-limites](implanter-relever-limites.md)
  2. **Mur** de clôture maçonné = Maçonnerie (frontière). `[C]` → [monter-mur-cloison](../../../professions/maconnerie/cards/monter-mur-cloison.md)
  3. **Haie** végétale = Paysagisme (frontière). `[C]` → [planter-arbres-arbustes-vivaces](../../../professions/paysagisme/cards/planter-arbres-arbustes-vivaces.md)
  4. **Sceller les poteaux** puis poser le remplissage. `[C]` → [sceller-poteaux-ancrages](sceller-poteaux-ancrages.md)
- **Points critiques** : chaîne de pose maîtrisée ; **frontières** (mur/haie/portail/motorisation) ; **DICT** avant creusement ; PLU/bornage.
- **Sécurité** : réseaux (DICT) ; scellement béton ; manutention. **Repérage des réseaux enterrés avant creusement** (**DT-DICT**) : une clôture = de nombreux **trous de poteaux** → ne pas percer un câble/tuyau (électrocution, gaz, eau). **Terrassements légers** : effondrement des petits trous, tarière/engins. **Scellements béton** : ciment (brûlures/irritations, EPI), charges. **Manutention** (poteaux, panneaux rigides, rouleaux de grillage, platines) : binôme/moyens — dos/écrasement. **Découpe / outils électroportatifs** : meuleuse/scie (projections, coupures) — disque adapté/capot, lunettes/gants. **Fil de grillage sous tension** : coupures, fouet du fil (écran facial). **Travail en bordure** (voie/talus) : signalisation/co-activité. **Amiante** (rénovation, anciens panneaux/plaques) : diagnostic ; retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : béton de scellement des poteaux (**interface**) **DTU 21** ; ouvrages métalliques / portillons (**interface** métallerie) **DTU 37.1** ; grillages **NF EN 10223**, protection anticorrosion **NF EN ISO 1461 / NF EN ISO 12944**, règles d'**urbanisme** (PLU : hauteur/aspect), **bornage** (Code civil, géomètre) et **DT-DICT** (réseaux) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Entretien / diagnostic** : `cite-carte` → [entretenir-diagnostiquer-cloture](entretenir-diagnostiquer-cloture.md)

## Relations & tags
- **Tags** : `metier:cloture famille:specialises sous-famille:cloture intervention:comprendre cluster:types-clotures cluster:implantation type:principe securite:reseaux relation:maconnerie relation:paysagisme relation:automatismes-portails relation:serrurerie-metallerie`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
