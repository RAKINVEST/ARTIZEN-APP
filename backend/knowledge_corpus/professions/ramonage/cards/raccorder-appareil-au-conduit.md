# Raccorder un appareil au conduit de fumée

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `raccorder-appareil-au-conduit` |
| Titre | Raccorder un appareil au conduit de fumée |
| Profession | `metier:ramonage` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:fumisterie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : raccorder un **poêle/insert** au **conduit de fumée** (côté évacuation) — l'appareil et le gaz relèvent du Chauffagiste. `[C]`
- **Résumé** : poser le **conduit de raccordement** (tuyau émaillé/inox) entre l'appareil (**poêle**/**insert**) et le conduit de fumée, respecter les **distances de sécurité** aux matériaux combustibles, l'étanchéité et la pente, et l'**arrivée d'air** ; l'appareil lui-même, son **raccordement hydraulique/gaz** et sa mise en service (surtout **gaz**) relèvent du **Chauffagiste** — non traités ici (aucune opération réservée décrite pas à pas). `[C]` ⟦distances de sécurité selon appareil/DTU 24.2 à confirmer⟧

## Réalisation
- **Étapes** :
  1. Poser le **conduit de raccordement** (émaillé/inox). `[C]`
  2. Respecter les **distances de sécurité** (combustibles). `[A]`
  3. Assurer arrivée d'air / étanchéité. `[C]` → [comprendre-tirage-ventilation-evacuation](comprendre-tirage-ventilation-evacuation.md)
  4. **Appareil / gaz** = Chauffagiste (frontière). `[C]` → [entretenir-chaudiere](../../../professions/chauffage/cards/entretenir-chaudiere.md)
- **Points critiques** : **distances de sécurité** (combustibles) ; arrivée d'air ; étanchéité ; **appareil/gaz = Chauffagiste** (jamais ici).
- **Sécurité** : incendie (distances) ; CO ; — **Monoxyde de carbone (CO)** : un conduit obstrué/mal tiré = **intoxication mortelle** — alerter en cas de symptômes (maux de tête, appareil qui refoule), contrôler le **tirage** et la **ventilation** de l'air comburant. **Feu de conduit** (**bistre** enflammé) : températures extrêmes, propagation — prévention par ramonage régulier ; ne jamais laisser un conduit encrassé. **Travail en hauteur** (toiture, souche) : échelle/échafaudage/harnais, fragilité de la couverture (l'accès en toiture relève aussi du **Couvreur**). **Poussières de suie** (cancérogènes) : aspiration/masque, protection ; bâchage intérieur. **Appareils à combustion** : le **raccordement** d'un poêle/insert/chaudière (gaz notamment) relève du **Chauffagiste** — non traité ici. **Amiante** (anciens conduits, joints, tresses) : diagnostic ; retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : évacuation des produits de combustion / fumisterie **DTU 24.1** ; âtrerie (cheminées/foyers) **DTU 24.2** ; conduits métalliques **NF EN 1856**, dimensionnement / tirage **NF EN 13384**, obligation de ramonage et **certificat** (**Règlement sanitaire départemental**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Contrôle** : `cite-checklist` → [controle-entretien-ramonage](../../../checklists/ramonage/controle-entretien-ramonage.md)

## Relations & tags
- **Tags** : `metier:ramonage famille:specialises sous-famille:fumisterie intervention:realiser cluster:poeles-bois cluster:inserts complexite:moyenne type:installation securite:incendie relation:chauffage`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
