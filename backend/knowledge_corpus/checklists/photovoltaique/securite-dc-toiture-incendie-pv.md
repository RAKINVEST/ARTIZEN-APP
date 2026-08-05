# Sécurité — DC, toiture & incendie (PV)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `securite-dc-toiture-incendie-pv` |
| Titre | Sécurité — DC, toiture & incendie (PV) |
| Profession | `metier:photovoltaique` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## Points à vérifier
- [ ] **Tension DC permanente** : couper l'AC **ne suffit pas** ; procédure DC. `[A]`
- [ ] **Arc DC** : connectique certifiée, jamais débrancher en charge. `[A]`
- [ ] **Consignation** : habilitation **photovoltaïque (BP/BR)**. `[A]`
- [ ] **Incendie** : coupure d'urgence, sécurité des intervenants/pompiers. `[A]`
- [ ] **Toiture** : protections collectives/EPI ; **manutention** modules (vent). `[A]`
- [ ] **Arrêt immédiat** en cas de danger. `[A]`

## Cadre
- **Normes** : installations photovoltaïques raccordées au réseau **NF C 15-712-1** ; installation électrique BT (raccordement AC) **NF C 15-100** ; opérations / habilitation photovoltaïque (**NF C 18-510**, habilitation **BP/BR**) ; contrôle/mise en service **IEC 62446**, attestation **Consuel**, raccordement **Enedis**, label **RGE QualiPV** ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-procedure` → [consignation-securite-dc-pv](../../procedures/photovoltaique/consignation-securite-dc-pv.md).
- **Tags** : `metier:photovoltaique famille:electricite sous-famille:securite type:checklist cluster:chaines-dc securite:dc securite:incendie securite:hauteur`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
