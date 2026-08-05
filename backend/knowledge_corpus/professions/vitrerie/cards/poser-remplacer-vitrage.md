# Poser / remplacer un vitrage

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `poser-remplacer-vitrage` |
| Titre | Poser / remplacer un vitrage |
| Profession | `metier:vitrerie` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:vitrerie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : poser ou **remplacer un vitrage** dans son châssis (calage, parclose, mastic/joint, étanchéité). `[C]`
- **Résumé** : déposer en sécurité le vitrage cassé (évacuation des éclats), préparer la **feuillure**, poser les **cales** (périphériques/d'assise selon règles de calage), poser le vitrage, **fixer** (parcloses) et **étancher** (mastic/joints) ; le **châssis** (métallique ou bois) relève de la Métallerie / Menuiserie — le vitrier n'intervient que sur le **vitrage** et son étanchéité. `[C]` ⟦calage/étanchéité selon DTU 39 à confirmer⟧

## Réalisation
- **Étapes** :
  1. Déposer le vitrage cassé ; évacuer les éclats. `[A]` → [vitrage-casse-fissure](../../../diagnostics/vitrerie/vitrage-casse-fissure.md)
  2. Préparer la feuillure ; poser les **cales** (calage). `[C]`
  3. Poser le vitrage ; **parcloses** ; **étanchéité** (mastic/joints). `[C]`
  4. Châssis **métallique** = Métallerie (interface). `[C]` → [fabriquer-ouvrage-metallique](../../../professions/serrurerie-metallerie/cards/fabriquer-ouvrage-metallique.md)
- **Points critiques** : **règles de calage** (DTU 39) ; étanchéité durable ; éclats évacués ; châssis = métier distinct.
- **Sécurité** : **coupures** (dépose) ; manutention ; hauteur. **Risque majeur de casse et de coupures** : le verre casse net et coupe profondément (artères) → **gants anti-coupure**, manches longues, chaussures ; évacuer immédiatement les éclats. **Manutention des vitrages lourds** : **ventouses** adaptées, binôme/levage, ne jamais porter seul un grand vitrage ; **stockage / transport** sur chevalets (vitrage **debout**, jamais à plat), calé et sanglé. **Travail en hauteur** (vitrines, verrières, façades) : échafaudage/nacelle/harnais. **Verre de sécurité selon l'usage** : **trempé** (casse en petits morceaux) ou **feuilleté** (retient les éclats) obligatoire en allège / porte / garde-corps / toiture — ne pas poser un verre inadapté. **Repérage des réseaux** avant perçage/scellement. **Amiante** (mastics/joints anciens) : diagnostic ; retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : travaux de **vitrerie-miroiterie** **DTU 39** ; menuiseries métalliques recevant le vitrage (**interface**) **DTU 37.1** ; verre de sécurité trempé / feuilleté (**NF EN 12150 / NF EN 14449 / ISO 12543**), vitrage isolant **NF EN 1279**, résistance au choc **NF EN 12600**, garde-corps **NF P01-012** ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Châssis bois** (interface) : `renvoie-vers` → [poser-bloc-porte](../../../professions/menuiserie-interieure/cards/poser-bloc-porte.md)

## Relations & tags
- **Tags** : `metier:vitrerie famille:specialises sous-famille:vitrerie intervention:realiser cluster:pose-vitrage cluster:remplacement complexite:avancee type:installation securite:coupure relation:serrurerie-metallerie relation:menuiserie-interieure`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
