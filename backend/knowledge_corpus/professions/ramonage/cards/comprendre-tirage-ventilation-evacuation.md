# Comprendre le tirage, la ventilation et l'évacuation

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `comprendre-tirage-ventilation-evacuation` |
| Titre | Comprendre le tirage, la ventilation et l'évacuation |
| Profession | `metier:ramonage` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:fumisterie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## Cadrage
- **Objectif** : comprendre le **tirage**, l'apport d'**air comburant** (ventilation) et l'**évacuation des fumées** — clés de la sécurité CO. `[B]`
- **Résumé** : comprendre que la combustion exige un **apport d'air** (ventilation/amenée d'air comburant) et une **évacuation** correcte des fumées par **tirage** (dépression du conduit) ; un conduit sous-dimensionné, obstrué, mal isolé ou une **ventilation ins-suffisante** (VMC, logement étanche) provoque **refoulement** et **monoxyde de carbone** ; le **dimensionnement** (**NF EN 13384**) et l'équilibre air/évacuation sont vitaux. `[A]` ⟦dimensionnement/tirage selon NF EN 13384 à confirmer⟧

## Réalisation
- **Étapes** :
  1. **Apport d'air comburant** (ventilation) suffisant. `[A]`
  2. **Tirage** (dépression) correct ; conduit non obstrué. `[A]` → [mauvais-tirage-refoulement](../../../diagnostics/ramonage/mauvais-tirage-refoulement.md)
  3. **Évacuation des fumées** dimensionnée (NF EN 13384). `[B]`
  4. Refoulement → **danger CO** (intoxication). `[A]`
- **Points critiques** : équilibre **air / évacuation** ; tirage correct ; **CO** = danger mortel ; dimensionnement (NF EN 13384).
- **Sécurité** : **monoxyde de carbone (CO)** ; refoulement ; — **Monoxyde de carbone (CO)** : un conduit obstrué/mal tiré = **intoxication mortelle** — alerter en cas de symptômes (maux de tête, appareil qui refoule), contrôler le **tirage** et la **ventilation** de l'air comburant. **Feu de conduit** (**bistre** enflammé) : températures extrêmes, propagation — prévention par ramonage régulier ; ne jamais laisser un conduit encrassé. **Travail en hauteur** (toiture, souche) : échelle/échafaudage/harnais, fragilité de la couverture (l'accès en toiture relève aussi du **Couvreur**). **Poussières de suie** (cancérogènes) : aspiration/masque, protection ; bâchage intérieur. **Appareils à combustion** : le **raccordement** d'un poêle/insert/chaudière (gaz notamment) relève du **Chauffagiste** — non traité ici. **Amiante** (anciens conduits, joints, tresses) : diagnostic ; retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : évacuation des produits de combustion / fumisterie **DTU 24.1** ; âtrerie (cheminées/foyers) **DTU 24.2** ; conduits métalliques **NF EN 1856**, dimensionnement / tirage **NF EN 13384**, obligation de ramonage et **certificat** (**Règlement sanitaire départemental**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Diagnostic tirage** : `cite-diagnostic` → [mauvais-tirage-refoulement](../../../diagnostics/ramonage/mauvais-tirage-refoulement.md)

## Relations & tags
- **Tags** : `metier:ramonage famille:specialises sous-famille:fumisterie intervention:comprendre cluster:tirage cluster:ventilation cluster:evacuation-fumees complexite:avancee type:principe securite:monoxyde`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
