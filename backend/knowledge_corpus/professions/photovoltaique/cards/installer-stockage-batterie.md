# Installer un stockage (batterie)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `installer-stockage-batterie` |
| Titre | Installer un stockage (batterie) |
| Profession | `metier:photovoltaique` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:photovoltaique` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : installer un **stockage** batterie associé au PV pour l'autoconsommation — sécurité DC/thermique renforcée. `[C]`
- **Résumé** : installer la **batterie** (souvent lithium) et son convertisseur/BMS selon la notice et la **NF C 15-712-3** (stockage), à un emplacement **ventilé/protégé** (risque **thermique/incendie**), avec protections DC dédiées et coupure ; opération réservée (haute tension DC / risque emballement). `[C]` ⟦technologie/emplacement/norme stockage à confirmer⟧

## Réalisation
- **Étapes** :
  1. Choisir/poser la **batterie** + BMS (emplacement ventilé). `[C]` ⟦à confirmer⟧
  2. Protections **DC** dédiées + coupure ; mise à la terre. `[A]`
  3. Risque **thermique/incendie** (emballement) : implantation/ventilation. `[A]`
  4. Intégrer au **monitoring**/pilotage. `[C]` → [monitorer-diagnostiquer-controler](monitorer-diagnostiquer-controler.md)
- **Points critiques** : sécurité **thermique/incendie** (batterie) ; protections DC ; emplacement ventilé ; opération réservée (haute tension DC).
- **Sécurité** : **incendie/emballement thermique** ; DC (haute tension) ; électrique. **Tension continue (DC) permanente** : dès qu'il y a de la lumière, les **modules produisent** — on **ne peut pas supprimer totalement la tension** côté panneaux/chaîne DC en plein jour (couper l'AC **ne suffit pas**). **Arc électrique DC** : un arc DC **s'auto-entretient** (contrairement à l'AC) — connectique de qualité, **jamais débrancher un connecteur DC en charge**. **Consignation adaptée** : côté AC consignable (habilité), côté DC **procédure spécifique** — habilitation **photovoltaïque (BP/BR)**. **Incendie** : risque spécifique (dispositif de coupure d'urgence, sécurité des intervenants/pompiers). **Travail en toiture** : **chute** (protections/EPI), **manutention** des modules (lourds, prise au vent), météo. **Arrêt immédiat en cas de danger.** Opérations réservées à un professionnel **qualifié/habilité (RGE QualiPV)**.** `[A]`

## Cadre & suites
- **Normes** : installations photovoltaïques raccordées au réseau **NF C 15-712-1** ; installation électrique BT (raccordement AC) **NF C 15-100** ; opérations / habilitation photovoltaïque (**NF C 18-510**, habilitation **BP/BR**) ; contrôle/mise en service **IEC 62446**, attestation **Consuel**, raccordement **Enedis**, label **RGE QualiPV** ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Monitoring** : `cite-carte` → [monitorer-diagnostiquer-controler](monitorer-diagnostiquer-controler.md)

## Relations & tags
- **Tags** : `metier:photovoltaique famille:electricite sous-famille:photovoltaique intervention:poser cluster:stockage-associe complexite:expert type:installation securite:incendie`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
