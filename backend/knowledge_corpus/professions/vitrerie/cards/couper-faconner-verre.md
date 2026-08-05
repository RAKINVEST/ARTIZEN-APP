# Couper et façonner le verre

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `couper-faconner-verre` |
| Titre | Couper et façonner le verre |
| Profession | `metier:vitrerie` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:vitrerie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : débiter le verre (coupe droite/forme) et **façonner** les bords — uniquement pour du **verre non trempé**. `[C]`
- **Résumé** : tracer et **couper** au coupe-verre (rou-lette), rompre proprement, puis **façonner** les bords (ébavurage, joint plat/arrisé/poli) pour supprimer les arêtes coupantes et les amorces de casse ; **un verre trempé ne se coupe pas** (il éclate) — il doit être commandé aux cotes, trempé après façonnage. `[C]` ⟦procédé selon type de verre à confirmer⟧

## Réalisation
- **Étapes** :
  1. Tracer ; **couper** (coupe-verre) et rompre net. `[C]`
  2. **Façonner** les bords (ébavurage/joint). `[C]`
  3. **Verre trempé** : jamais coupé → commander aux cotes. `[A]` → [prendre-cotes-choisir-vitrage](prendre-cotes-choisir-vitrage.md)
  4. Contrôler dimensions/bords avant pose. `[C]` → [poser-remplacer-vitrage](poser-remplacer-vitrage.md)
- **Points critiques** : coupe nette (pas d'amorce de casse) ; **bords façonnés** (arêtes non coupantes) ; trempé = jamais recoupé.
- **Sécurité** : **coupures** (arêtes vives) ; éclats ; — **Risque majeur de casse et de coupures** : le verre casse net et coupe profondément (artères) → **gants anti-coupure**, manches longues, chaussures ; évacuer immédiatement les éclats. **Manutention des vitrages lourds** : **ventouses** adaptées, binôme/levage, ne jamais porter seul un grand vitrage ; **stockage / transport** sur chevalets (vitrage **debout**, jamais à plat), calé et sanglé. **Travail en hauteur** (vitrines, verrières, façades) : échafaudage/nacelle/harnais. **Verre de sécurité selon l'usage** : **trempé** (casse en petits morceaux) ou **feuilleté** (retient les éclats) obligatoire en allège / porte / garde-corps / toiture — ne pas poser un verre inadapté. **Repérage des réseaux** avant perçage/scellement. **Amiante** (mastics/joints anciens) : diagnostic ; retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : travaux de **vitrerie-miroiterie** **DTU 39** ; menuiseries métalliques recevant le vitrage (**interface**) **DTU 37.1** ; verre de sécurité trempé / feuilleté (**NF EN 12150 / NF EN 14449 / ISO 12543**), vitrage isolant **NF EN 1279**, résistance au choc **NF EN 12600**, garde-corps **NF P01-012** ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Miroiterie** : `cite-carte` → [poser-miroir-credence-verre](poser-miroir-credence-verre.md)

## Relations & tags
- **Tags** : `metier:vitrerie famille:specialises sous-famille:vitrerie intervention:realiser cluster:decoupe cluster:faconnage complexite:avancee type:fabrication securite:coupure`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
