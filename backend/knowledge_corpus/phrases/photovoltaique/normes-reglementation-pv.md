# Phrase — normes & réglementation photovoltaïque

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `normes-reglementation-pv` |
| Titre | Phrase — normes & réglementation photovoltaïque |
| Profession | `metier:photovoltaique` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:photovoltaique` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Formulation (clusters « Normes » / « Réglementation »)
> « Nos installations photovoltaïques respectent les règles de l'art : PV raccordé au réseau (**NF C 15-712-1**), raccordement AC (**NF C 15-100**), habilitation photovoltaïque (**NF C 18-510**, **BP/BR**), contrôle/mise en service (**IEC 62446**), attestation **Consuel** et convention **Enedis** ; posées par un installateur **RGE QualiPV**. » `[C]` ⟦versions/démarches exactes à valider par un expert⟧

> **Distinction technologique** : le photovoltaïque produit de l'**électricité** — à **ne pas confondre** avec le **Solaire Thermique** (production de **chaleur**), qui est une activité distincte. `[C]`

> **Relations inter-Livres** : raccordement/protections AC → **Électricité générale** ; pose/étanchéité en toiture → **Couverture** ; pilotage énergétique/autoconsommation → **Domotique**. `[C]`

## Cadre
- **Normes** : installations photovoltaïques raccordées au réseau **NF C 15-712-1** ; installation électrique BT (raccordement AC) **NF C 15-100** ; opérations / habilitation photovoltaïque (**NF C 18-510**, habilitation **BP/BR**) ; contrôle/mise en service **IEC 62446**, attestation **Consuel**, raccordement **Enedis**, label **RGE QualiPV** ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [controler-tableau-electrique](../../professions/electricite-generale/cards/controler-tableau-electrique.md).
- **Tags** : `metier:photovoltaique famille:electricite type:phrase usage:normes cluster:normes cluster:reglementation relation:electricite-generale relation:couverture relation:domotique relation:solaire-thermique`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
