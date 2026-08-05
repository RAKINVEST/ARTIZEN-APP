# Ramoner un conduit et contrôle visuel

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `ramoner-conduit-controle-visuel` |
| Titre | Ramoner un conduit et contrôle visuel |
| Profession | `metier:ramonage` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:ramonage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : **ramoner** mécaniquement un conduit, réaliser le **contrôle visuel** et remettre le **certificat**. `[C]`
- **Résumé** : protéger les abords (bâchage), **ramoner mécaniquement** le conduit (hérisson adapté au diamètre/matériau, du haut ou du bas), évacuer/aspirer la **suie**, réaliser un **contrôle visuel** (vacé éventuel) de la vacuité et de l'état, vérifier le **tirage**, puis établir le **certificat de ramonage** (obligation réglementaire) ; les **poussières de suie** sont cancérogènes (EPI). `[C]` ⟦périodicité/méthode selon règlement à confirmer⟧

## Réalisation
- **Étapes** :
  1. Protéger les abords (bâchage) ; EPI **suie**. `[A]`
  2. **Ramoner** (hérisson adapté) ; aspirer la suie. `[C]`
  3. **Contrôle visuel** (vacuité/état) + tirage. `[C]` → [mauvais-tirage-refoulement](../../../diagnostics/ramonage/mauvais-tirage-refoulement.md)
  4. Établir le **certificat de ramonage**. `[A]`
- **Points critiques** : vacuité assurée ; hérisson **adapté** (matériau) ; **certificat** établi ; EPI suie ; contrôle du tirage.
- **Sécurité** : **suie** (cancérogène) ; CO ; hauteur (accès toit). **Monoxyde de carbone (CO)** : un conduit obstrué/mal tiré = **intoxication mortelle** — alerter en cas de symptômes (maux de tête, appareil qui refoule), contrôler le **tirage** et la **ventilation** de l'air comburant. **Feu de conduit** (**bistre** enflammé) : températures extrêmes, propagation — prévention par ramonage régulier ; ne jamais laisser un conduit encrassé. **Travail en hauteur** (toiture, souche) : échelle/échafaudage/harnais, fragilité de la couverture (l'accès en toiture relève aussi du **Couvreur**). **Poussières de suie** (cancérogènes) : aspiration/masque, protection ; bâchage intérieur. **Appareils à combustion** : le **raccordement** d'un poêle/insert/chaudière (gaz notamment) relève du **Chauffagiste** — non traité ici. **Amiante** (anciens conduits, joints, tresses) : diagnostic ; retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : évacuation des produits de combustion / fumisterie **DTU 24.1** ; âtrerie (cheminées/foyers) **DTU 24.2** ; conduits métalliques **NF EN 1856**, dimensionnement / tirage **NF EN 13384**, obligation de ramonage et **certificat** (**Règlement sanitaire départemental**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Bistre / feu de conduit** : `cite-carte` → [traiter-bistre-prevenir-feu-conduit](traiter-bistre-prevenir-feu-conduit.md)

## Relations & tags
- **Tags** : `metier:ramonage famille:specialises sous-famille:ramonage intervention:entretenir cluster:controle-visuel cluster:suie cluster:certificat complexite:moyenne type:entretien securite:monoxyde`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
