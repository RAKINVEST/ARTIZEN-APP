# Identifier les conduits et appareils

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `identifier-conduits-appareils` |
| Titre | Identifier les conduits et appareils |
| Profession | `metier:ramonage` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:ramonage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : identifier le type de **conduit** (maçonné, métallique, tubé) et l'**appareil** desservi (poêle, insert, cheminée, chaudière). `[C]`
- **Résumé** : reconnaître le **conduit** (**maçonné** — ouvrage de Maçonnerie, **métallique**, ou **tubé**), sa section, son état et sa compatibilité avec l'**appareil** desservi (**poêle à bois**, **insert**, **cheminée** ouverte, **chaudière** — combustible et température) ; un conduit doit être **adapté** à l'appareil (désignation, classe de température/résistance au feu de cheminée) ; sinon, **tubage/mise en conformité**. `[C]` ⟦compatibilité conduit/appareil selon DTU 24.1 à confirmer⟧

## Réalisation
- **Étapes** :
  1. Identifier le **conduit** (maçonné/métallique/tubé). `[C]`
  2. **Conduit maçonné** = ouvrage de **Maçonnerie** (frontière). `[C]` → [principe-maconnerie](../../../professions/maconnerie/cards/principe-maconnerie.md)
  3. Identifier l'**appareil** (poêle/insert/cheminée/chaudière). `[C]`
  4. Vérifier la **compatibilité** conduit/appareil. `[A]` → [tuber-mettre-en-conformite-conduit](tuber-mettre-en-conformite-conduit.md)
- **Points critiques** : conduit **adapté** à l'appareil (désignation) ; état/section ; **conduit maçonné = Maçon** ; sinon tubage.
- **Sécurité** : hauteur (inspection toit) ; suie ; CO. **Monoxyde de carbone (CO)** : un conduit obstrué/mal tiré = **intoxication mortelle** — alerter en cas de symptômes (maux de tête, appareil qui refoule), contrôler le **tirage** et la **ventilation** de l'air comburant. **Feu de conduit** (**bistre** enflammé) : températures extrêmes, propagation — prévention par ramonage régulier ; ne jamais laisser un conduit encrassé. **Travail en hauteur** (toiture, souche) : échelle/échafaudage/harnais, fragilité de la couverture (l'accès en toiture relève aussi du **Couvreur**). **Poussières de suie** (cancérogènes) : aspiration/masque, protection ; bâchage intérieur. **Appareils à combustion** : le **raccordement** d'un poêle/insert/chaudière (gaz notamment) relève du **Chauffagiste** — non traité ici. **Amiante** (anciens conduits, joints, tresses) : diagnostic ; retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : évacuation des produits de combustion / fumisterie **DTU 24.1** ; âtrerie (cheminées/foyers) **DTU 24.2** ; conduits métalliques **NF EN 1856**, dimensionnement / tirage **NF EN 13384**, obligation de ramonage et **certificat** (**Règlement sanitaire départemental**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Ramonage** : `cite-carte` → [ramoner-conduit-controle-visuel](ramoner-conduit-controle-visuel.md)

## Relations & tags
- **Tags** : `metier:ramonage famille:specialises sous-famille:ramonage intervention:comprendre cluster:conduits-maconnes cluster:conduits-metalliques cluster:appareils complexite:moyenne type:principe securite:monoxyde relation:maconnerie`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
