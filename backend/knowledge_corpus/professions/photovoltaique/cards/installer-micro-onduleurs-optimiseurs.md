# Installer micro-onduleurs / optimiseurs

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `installer-micro-onduleurs-optimiseurs` |
| Titre | Installer micro-onduleurs / optimiseurs |
| Profession | `metier:photovoltaique` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:photovoltaique` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : installer des micro-onduleurs ou optimiseurs (MLPE) pour la conversion/optimisation au niveau module et la sécurité DC. `[C]`
- **Résumé** : poser des **micro-onduleurs** (conversion AC dès le module) ou des **optimiseurs** (par module, avec onduleur string), utiles en cas d'**ombrage** ou d'orientations multiples et pour la **sécurité** (coupure/arrêt au niveau module, réduction de la tension DC en cas d'urgence). `[C]` ⟦produit/compatibilité selon fabricant à confirmer⟧

## Réalisation
- **Étapes** :
  1. Choisir **micro-onduleur** (AC module) vs **optimiseur** (DC module). `[C]`
  2. Utile pour **ombrage** / orientations multiples. `[C]`
  3. Apporte la **sécurité au niveau module** (coupure/arrêt). `[B]`
  4. Intégrer au **monitoring** (par module). `[C]` → [monitorer-diagnostiquer-controler](monitorer-diagnostiquer-controler.md)
- **Points critiques** : adapté à l'ombrage/orientations ; **sécurité DC** (arrêt module) ; compatibilité système ; monitoring par module.
- **Sécurité** : arc/DC (réduit mais présent) ; toiture ; électrique. **Tension continue (DC) permanente** : dès qu'il y a de la lumière, les **modules produisent** — on **ne peut pas supprimer totalement la tension** côté panneaux/chaîne DC en plein jour (couper l'AC **ne suffit pas**). **Arc électrique DC** : un arc DC **s'auto-entretient** (contrairement à l'AC) — connectique de qualité, **jamais débrancher un connecteur DC en charge**. **Consignation adaptée** : côté AC consignable (habilité), côté DC **procédure spécifique** — habilitation **photovoltaïque (BP/BR)**. **Incendie** : risque spécifique (dispositif de coupure d'urgence, sécurité des intervenants/pompiers). **Travail en toiture** : **chute** (protections/EPI), **manutention** des modules (lourds, prise au vent), météo. **Arrêt immédiat en cas de danger.** Opérations réservées à un professionnel **qualifié/habilité (RGE QualiPV)**.** `[A]`

## Cadre & suites
- **Normes** : installations photovoltaïques raccordées au réseau **NF C 15-712-1** ; installation électrique BT (raccordement AC) **NF C 15-100** ; opérations / habilitation photovoltaïque (**NF C 18-510**, habilitation **BP/BR**) ; contrôle/mise en service **IEC 62446**, attestation **Consuel**, raccordement **Enedis**, label **RGE QualiPV** ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Chaînes DC** : `cite-carte` → [cabler-chaines-dc](cabler-chaines-dc.md)

## Relations & tags
- **Tags** : `metier:photovoltaique famille:electricite sous-famille:photovoltaique intervention:poser cluster:micro-onduleurs cluster:optimiseurs complexite:avancee type:installation securite:dc`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
