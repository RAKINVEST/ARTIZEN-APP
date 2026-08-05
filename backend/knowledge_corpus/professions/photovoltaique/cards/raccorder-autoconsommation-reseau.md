# Raccorder (autoconsommation / réseau)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `raccorder-autoconsommation-reseau` |
| Titre | Raccorder (autoconsommation / réseau) |
| Profession | `metier:photovoltaique` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:photovoltaique` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : raccorder l'installation PV pour l'**autoconsommation** (avec/sans revente) — raccordement AC et démarches réservés. `[C]`
- **Résumé** : raccorder la sortie AC au **tableau** (protections dédiées), configurer l'**autoconsommation** (éventuel surplus revendu/injecté), et réaliser les **démarches** (déclaration, **Consuel**, convention **Enedis**) ; le raccordement électrique et la mise en service relèvent d'un **professionnel habilité/qualifié**. `[C]` ⟦démarches/contrat selon projet à confirmer⟧

## Réalisation
- **Étapes** :
  1. Raccorder l'**AC** au tableau (protections). `[A]` → [controler-tableau-electrique](../../../professions/electricite-generale/cards/controler-tableau-electrique.md)
  2. Configurer l'**autoconsommation** (surplus éventuel). `[C]`
  3. **Démarches** : déclaration, **Consuel**, **Enedis**. `[C]` ⟦à confirmer⟧
  4. Pilotage énergétique éventuel (**Domotique**). `[C]` → [creer-scenarios-pilotage](../../../professions/domotique/cards/creer-scenarios-pilotage.md)
- **Points critiques** : raccordement AC **réservé habilité** ; démarches réglementaires (Consuel/Enedis) ; protections dédiées.
- **Sécurité** : électrique (AC) ; découplage réseau ; DC amont. **Tension continue (DC) permanente** : dès qu'il y a de la lumière, les **modules produisent** — on **ne peut pas supprimer totalement la tension** côté panneaux/chaîne DC en plein jour (couper l'AC **ne suffit pas**). **Arc électrique DC** : un arc DC **s'auto-entretient** (contrairement à l'AC) — connectique de qualité, **jamais débrancher un connecteur DC en charge**. **Consignation adaptée** : côté AC consignable (habilité), côté DC **procédure spécifique** — habilitation **photovoltaïque (BP/BR)**. **Incendie** : risque spécifique (dispositif de coupure d'urgence, sécurité des intervenants/pompiers). **Travail en toiture** : **chute** (protections/EPI), **manutention** des modules (lourds, prise au vent), météo. **Arrêt immédiat en cas de danger.** Opérations réservées à un professionnel **qualifié/habilité (RGE QualiPV)**.** `[A]`

## Cadre & suites
- **Normes** : installations photovoltaïques raccordées au réseau **NF C 15-712-1** ; installation électrique BT (raccordement AC) **NF C 15-100** ; opérations / habilitation photovoltaïque (**NF C 18-510**, habilitation **BP/BR**) ; contrôle/mise en service **IEC 62446**, attestation **Consuel**, raccordement **Enedis**, label **RGE QualiPV** ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Stockage** : `cite-carte` → [installer-stockage-batterie](installer-stockage-batterie.md)

## Relations & tags
- **Tags** : `metier:photovoltaique famille:electricite sous-famille:photovoltaique intervention:realiser cluster:production-electrique cluster:autoconsommation complexite:expert type:realisation securite:electrique relation:electricite-generale relation:domotique`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
