# Principe du ramonage / de la fumisterie

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `principe-ramonage` |
| Titre | Principe du ramonage / de la fumisterie |
| Profession | `metier:ramonage` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:ramonage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : comprendre le rôle du ramoneur-fumiste : entretien et conformité des **conduits de fumée**, distinct de l'appareil de chauffage. `[C]`
- **Résumé** : le ramoneur **entretient** et contrôle les **conduits de fumée** (ramonage mécanique, contrôle visuel, **certificat**) et le fumiste **installe/met en conformité** les conduits (**tubage**, raccordement au conduit) desservant poêles, inserts, cheminées et chaudières ; l'**appareil** lui-même et son raccordement (gaz/chauffage) relèvent du **Chauffagiste**, la **souche** en toiture du **Couvreur**, le **conduit maçonné** du **Maçon** — métiers distincts. `[C]` ⟦périmètre selon prestation à confirmer⟧

## Réalisation
- **Étapes** :
  1. **Identifier** conduits/appareils desservis. `[C]` → [identifier-conduits-appareils](identifier-conduits-appareils.md)
  2. **Ramoner** + contrôle visuel (**certificat**). `[C]` → [ramoner-conduit-controle-visuel](ramoner-conduit-controle-visuel.md)
  3. **Tirage / ventilation** (sécurité CO). `[A]` → [comprendre-tirage-ventilation-evacuation](comprendre-tirage-ventilation-evacuation.md)
  4. **Appareil / chaudière** = Chauffagiste (frontière). `[C]` → [entretenir-chaudiere](../../../professions/chauffage/cards/entretenir-chaudiere.md)
- **Points critiques** : **conduit ≠ appareil** (Chauffagiste) ; sécurité **CO** ; certificat ; **frontières** (couvreur/maçon/diagnostiqueur).
- **Sécurité** : monoxyde de carbone (CO) ; feu de conduit ; hauteur (toiture). **Monoxyde de carbone (CO)** : un conduit obstrué/mal tiré = **intoxication mortelle** — alerter en cas de symptômes (maux de tête, appareil qui refoule), contrôler le **tirage** et la **ventilation** de l'air comburant. **Feu de conduit** (**bistre** enflammé) : températures extrêmes, propagation — prévention par ramonage régulier ; ne jamais laisser un conduit encrassé. **Travail en hauteur** (toiture, souche) : échelle/échafaudage/harnais, fragilité de la couverture (l'accès en toiture relève aussi du **Couvreur**). **Poussières de suie** (cancérogènes) : aspiration/masque, protection ; bâchage intérieur. **Appareils à combustion** : le **raccordement** d'un poêle/insert/chaudière (gaz notamment) relève du **Chauffagiste** — non traité ici. **Amiante** (anciens conduits, joints, tresses) : diagnostic ; retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : évacuation des produits de combustion / fumisterie **DTU 24.1** ; âtrerie (cheminées/foyers) **DTU 24.2** ; conduits métalliques **NF EN 1856**, dimensionnement / tirage **NF EN 13384**, obligation de ramonage et **certificat** (**Règlement sanitaire départemental**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Entretien / diagnostic** : `cite-carte` → [entretenir-diagnostiquer-conduit](entretenir-diagnostiquer-conduit.md)

## Relations & tags
- **Tags** : `metier:ramonage famille:specialises sous-famille:ramonage intervention:comprendre cluster:conduits-de-fumee cluster:evacuation-fumees cluster:certificat type:principe securite:monoxyde relation:chauffage relation:diagnostic`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
