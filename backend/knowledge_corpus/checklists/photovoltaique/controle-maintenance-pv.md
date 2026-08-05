# Contrôle / maintenance PV

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controle-maintenance-pv` |
| Titre | Contrôle / maintenance PV |
| Profession | `metier:photovoltaique` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:photovoltaique` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Points à vérifier
- [ ] **Production** conforme (monitoring, par chaîne/module). `[C]`
- [ ] **Modules** : propreté, pas de casse/point chaud, fixations. `[C]`
- [ ] **Connectique DC** / câbles : état, pas de trace d'**arc**. `[A]`
- [ ] **Onduleur** : état/ventilation ; pas de défaut. `[C]`
- [ ] **Protections** (DC/AC, parafoudre) + mise à la terre. `[A]`
- [ ] **Étanchéité** des traversées (Couverture) OK. `[C]`

> DC **toujours présent** en journée ; toiture : **protections/EPI** ; intervention DC = **habilité**.

## Cadre
- **Normes** : installations photovoltaïques raccordées au réseau **NF C 15-712-1** ; installation électrique BT (raccordement AC) **NF C 15-100** ; opérations / habilitation photovoltaïque (**NF C 18-510**, habilitation **BP/BR**) ; contrôle/mise en service **IEC 62446**, attestation **Consuel**, raccordement **Enedis**, label **RGE QualiPV** ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `verifie` → [monitorer-diagnostiquer-controler](../../professions/photovoltaique/cards/monitorer-diagnostiquer-controler.md).
- **Tags** : `metier:photovoltaique famille:electricite sous-famille:photovoltaique type:checklist cluster:maintenance cluster:monitoring cluster:controle securite:dc relation:couverture`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
