# Entretenir et diagnostiquer un conduit

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `entretenir-diagnostiquer-conduit` |
| Titre | Entretenir et diagnostiquer un conduit |
| Profession | `metier:ramonage` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:ramonage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : assurer l'**entretien périodique** et le diagnostic d'un conduit (vacuité, état, tirage, sécurité). `[C]`
- **Résumé** : programmer l'**entretien périodique** (ramonage réglementaire, souvent 1–2 fois/an selon combustible), contrôler la **vacuité**, l'état du conduit et des joints, le **tirage** et la **ventilation**, l'absence de **bistre**/refoulement, et établir la traçabilité (**certificat**) ; en rénovation, les **anciens conduits/joints** peuvent contenir de l'**amiante** → diagnostic. `[C]`

## Réalisation
- **Étapes** :
  1. Programmer le **ramonage** périodique (réglementaire). `[A]` → [controle-entretien-ramonage](../../../checklists/ramonage/controle-entretien-ramonage.md)
  2. Contrôler vacuité/état/**tirage**. `[C]` → [mauvais-tirage-refoulement](../../../diagnostics/ramonage/mauvais-tirage-refoulement.md)
  3. Vérifier l'absence de **bistre**/refoulement. `[C]` → [conduit-encrasse-bistre](../../../diagnostics/ramonage/conduit-encrasse-bistre.md)
  4. Rénovation : anciens conduits → **amiante**. `[C]`
- **Points critiques** : périodicité réglementaire ; vacuité/tirage OK ; certificat/traçabilité ; **amiante** (rénovation) vérifié.
- **Sécurité** : CO ; suie ; amiante (rénovation). **Monoxyde de carbone (CO)** : un conduit obstrué/mal tiré = **intoxication mortelle** — alerter en cas de symptômes (maux de tête, appareil qui refoule), contrôler le **tirage** et la **ventilation** de l'air comburant. **Feu de conduit** (**bistre** enflammé) : températures extrêmes, propagation — prévention par ramonage régulier ; ne jamais laisser un conduit encrassé. **Travail en hauteur** (toiture, souche) : échelle/échafaudage/harnais, fragilité de la couverture (l'accès en toiture relève aussi du **Couvreur**). **Poussières de suie** (cancérogènes) : aspiration/masque, protection ; bâchage intérieur. **Appareils à combustion** : le **raccordement** d'un poêle/insert/chaudière (gaz notamment) relève du **Chauffagiste** — non traité ici. **Amiante** (anciens conduits, joints, tresses) : diagnostic ; retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : évacuation des produits de combustion / fumisterie **DTU 24.1** ; âtrerie (cheminées/foyers) **DTU 24.2** ; conduits métalliques **NF EN 1856**, dimensionnement / tirage **NF EN 13384**, obligation de ramonage et **certificat** (**Règlement sanitaire départemental**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Kit** : `utilise-kit` → [kit-ramoneur-fumiste](../../../kits/ramonage/kit-ramoneur-fumiste.md)

## Relations & tags
- **Tags** : `metier:ramonage famille:specialises sous-famille:ramonage intervention:entretenir intervention:controler cluster:entretien-periodique cluster:diagnostic complexite:moyenne type:entretien securite:monoxyde`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
