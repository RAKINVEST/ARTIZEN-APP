# Entretenir / diagnostiquer une clôture

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `entretenir-diagnostiquer-cloture` |
| Titre | Entretenir / diagnostiquer une clôture |
| Profession | `metier:cloture` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:cloture` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : entretenir une clôture et diagnostiquer les défauts (poteau descellé, corrosion, portillon). `[C]`
- **Résumé** : contrôler l'**aplomb** des poteaux et l'état des scellements, la **tension** du grillage/l'état des panneaux, la **corrosion** (reprise), le réglage du **portillon**, et resserrer/remplacer les fixations ; en rénovation d'anciennes clôtures, les **panneaux/plaques anciens** peuvent contenir de l'**amiante** → diagnostic. `[C]`

## Réalisation
- **Étapes** :
  1. Vérifier **aplomb/scellement** des poteaux. `[C]` → [poteau-descelle-penche](../../../diagnostics/cloture/poteau-descelle-penche.md)
  2. Contrôler tension/panneaux ; reprendre la **corrosion**. `[C]` → [cloture-corrodee-degradee](../../../diagnostics/cloture/cloture-corrodee-degradee.md)
  3. Régler le **portillon** ; resserrer les fixations. `[C]` → [portillon-ferme-mal](../../../diagnostics/cloture/portillon-ferme-mal.md)
  4. Rénovation : panneaux anciens → **diagnostic amiante**. `[C]`
- **Points critiques** : poteaux d'aplomb/scellés ; corrosion traitée ; portillon réglé ; **amiante** (rénovation) vérifié.
- **Sécurité** : manutention ; coupures (fil/tôle) ; amiante (rénovation). **Repérage des réseaux enterrés avant creusement** (**DT-DICT**) : une clôture = de nombreux **trous de poteaux** → ne pas percer un câble/tuyau (électrocution, gaz, eau). **Terrassements légers** : effondrement des petits trous, tarière/engins. **Scellements béton** : ciment (brûlures/irritations, EPI), charges. **Manutention** (poteaux, panneaux rigides, rouleaux de grillage, platines) : binôme/moyens — dos/écrasement. **Découpe / outils électroportatifs** : meuleuse/scie (projections, coupures) — disque adapté/capot, lunettes/gants. **Fil de grillage sous tension** : coupures, fouet du fil (écran facial). **Travail en bordure** (voie/talus) : signalisation/co-activité. **Amiante** (rénovation, anciens panneaux/plaques) : diagnostic ; retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : béton de scellement des poteaux (**interface**) **DTU 21** ; ouvrages métalliques / portillons (**interface** métallerie) **DTU 37.1** ; grillages **NF EN 10223**, protection anticorrosion **NF EN ISO 1461 / NF EN ISO 12944**, règles d'**urbanisme** (PLU : hauteur/aspect), **bornage** (Code civil, géomètre) et **DT-DICT** (réseaux) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Kit** : `utilise-kit` → [kit-poseur-cloture](../../../kits/cloture/kit-poseur-cloture.md)

## Relations & tags
- **Tags** : `metier:cloture famille:specialises sous-famille:cloture intervention:entretenir intervention:controler cluster:entretien cluster:maintenance cluster:diagnostic complexite:moyenne type:entretien securite:manutention`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
