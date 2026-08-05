# Principe du photovoltaïque (≠ solaire thermique)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `principe-photovoltaique` |
| Titre | Principe du photovoltaïque (≠ solaire thermique) |
| Profession | `metier:photovoltaique` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:photovoltaique` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : comprendre une installation PV : **modules → chaînes DC → onduleur → AC**, et la distinguer du solaire thermique. `[C]`
- **Résumé** : le photovoltaïque **produit de l'électricité** : les **modules** convertissent la lumière en **courant continu (DC)**, regroupé en **chaînes**, converti en **alternatif (AC)** par un **onduleur** (ou micro-onduleurs), pour l'**autoconsommation** et/ou la revente ; à **ne pas confondre avec le solaire thermique** (qui produit de la **chaleur**, pas de l'électricité). `[C]` ⟦puissance/architecture selon projet à confirmer⟧

## Réalisation
- **Étapes** :
  1. **Modules** en toiture (pose/étanchéité = **Couverture**). `[C]` → [poser-modules-toiture](poser-modules-toiture.md)
  2. **Chaînes DC** → **onduleur** (DC→AC). `[C]` → [installer-onduleur](installer-onduleur.md)
  3. **Raccordement AC** / autoconsommation (**Électricité**). `[C]` → [raccorder-autoconsommation-reseau](raccorder-autoconsommation-reseau.md)
  4. **≠ Solaire thermique** (chaleur) — technologies distinctes. `[C]` `relation:solaire-thermique`
- **Points critiques** : PV = **électricité** (≠ thermique) ; **courant fort DC** ; toiture ; raccordement AC réservé habilité.
- **Sécurité** : tension DC permanente ; arc DC ; toiture/chute. **Tension continue (DC) permanente** : dès qu'il y a de la lumière, les **modules produisent** — on **ne peut pas supprimer totalement la tension** côté panneaux/chaîne DC en plein jour (couper l'AC **ne suffit pas**). **Arc électrique DC** : un arc DC **s'auto-entretient** (contrairement à l'AC) — connectique de qualité, **jamais débrancher un connecteur DC en charge**. **Consignation adaptée** : côté AC consignable (habilité), côté DC **procédure spécifique** — habilitation **photovoltaïque (BP/BR)**. **Incendie** : risque spécifique (dispositif de coupure d'urgence, sécurité des intervenants/pompiers). **Travail en toiture** : **chute** (protections/EPI), **manutention** des modules (lourds, prise au vent), météo. **Arrêt immédiat en cas de danger.** Opérations réservées à un professionnel **qualifié/habilité (RGE QualiPV)**.** `[A]`

## Cadre & suites
- **Normes** : installations photovoltaïques raccordées au réseau **NF C 15-712-1** ; installation électrique BT (raccordement AC) **NF C 15-100** ; opérations / habilitation photovoltaïque (**NF C 18-510**, habilitation **BP/BR**) ; contrôle/mise en service **IEC 62446**, attestation **Consuel**, raccordement **Enedis**, label **RGE QualiPV** ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Monitoring / maintenance** : `cite-carte` → [monitorer-diagnostiquer-controler](monitorer-diagnostiquer-controler.md)

## Relations & tags
- **Tags** : `metier:photovoltaique famille:electricite sous-famille:photovoltaique intervention:comprendre cluster:panneaux-photovoltaiques cluster:modules cluster:chaines-dc cluster:onduleurs cluster:production-electrique type:principe securite:dc relation:couverture relation:solaire-thermique`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
