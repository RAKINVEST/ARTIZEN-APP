# Installer un onduleur

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `installer-onduleur` |
| Titre | Installer un onduleur |
| Profession | `metier:photovoltaique` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:photovoltaique` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : installer l'onduleur (string/central) convertissant le DC en AC, avec ses protections. `[C]`
- **Résumé** : poser l'onduleur à un emplacement **ventilé/accessible** (éviter la chaleur), raccorder l'entrée **DC** (via sectionneur) et la sortie **AC** vers les protections/le tableau, respecter le **dimensionnement** (puissance/tension) et la fonction de **découplage réseau** ; le raccordement AC relève d'un **électricien habilité**. `[C]` ⟦dimensionnement/emplacement selon projet à confirmer⟧

## Réalisation
- **Étapes** :
  1. Poser l'onduleur (emplacement **ventilé/accessible**). `[C]`
  2. Raccorder **DC** (sectionneur) → onduleur → **AC**. `[A]`
  3. Protections AC + **découplage réseau** ; raccordement = **habilité**. `[A]` → [controler-tableau-electrique](../../../professions/electricite-generale/cards/controler-tableau-electrique.md)
  4. Vérifier le **dimensionnement** (ratio DC/AC, tensions). `[B]` ⟦à confirmer⟧
- **Points critiques** : dimensionnement (tension/puissance) ; découplage réseau ; ventilation ; raccordement AC **réservé habilité**.
- **Sécurité** : arc DC (entrée) ; électrique (AC) ; chaleur (onduleur). **Tension continue (DC) permanente** : dès qu'il y a de la lumière, les **modules produisent** — on **ne peut pas supprimer totalement la tension** côté panneaux/chaîne DC en plein jour (couper l'AC **ne suffit pas**). **Arc électrique DC** : un arc DC **s'auto-entretient** (contrairement à l'AC) — connectique de qualité, **jamais débrancher un connecteur DC en charge**. **Consignation adaptée** : côté AC consignable (habilité), côté DC **procédure spécifique** — habilitation **photovoltaïque (BP/BR)**. **Incendie** : risque spécifique (dispositif de coupure d'urgence, sécurité des intervenants/pompiers). **Travail en toiture** : **chute** (protections/EPI), **manutention** des modules (lourds, prise au vent), météo. **Arrêt immédiat en cas de danger.** Opérations réservées à un professionnel **qualifié/habilité (RGE QualiPV)**.** `[A]`

## Cadre & suites
- **Normes** : installations photovoltaïques raccordées au réseau **NF C 15-712-1** ; installation électrique BT (raccordement AC) **NF C 15-100** ; opérations / habilitation photovoltaïque (**NF C 18-510**, habilitation **BP/BR**) ; contrôle/mise en service **IEC 62446**, attestation **Consuel**, raccordement **Enedis**, label **RGE QualiPV** ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Micro-onduleurs / optimiseurs** : `cite-carte` → [installer-micro-onduleurs-optimiseurs](installer-micro-onduleurs-optimiseurs.md)

## Relations & tags
- **Tags** : `metier:photovoltaique famille:electricite sous-famille:photovoltaique intervention:poser cluster:onduleurs complexite:expert type:installation securite:electrique relation:electricite-generale`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
