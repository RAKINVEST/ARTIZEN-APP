# Kit photovoltaïque (contrôle/maintenance)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `kit-photovoltaique` |
| Titre | Kit photovoltaïque (contrôle/maintenance) |
| Profession | `metier:photovoltaique` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:photovoltaique` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Composition conseillée (contrôle ; pose/raccordement = pro habilité)
- **Pince ampèremétrique DC**, multimètre, testeur d'isolement, caméra thermique (points chauds). `[C]`
- Outil de sertissage connectique DC certifiée, clés de déconnexion. `[C]`
- Accès au **monitoring** ; kit de nettoyage modules. `[C]`
- **EPI** : antichute (toiture), **gants isolants/écran anti-arc (DC)**, chaussures. `[A]`

## Cadre
- **Normes** : installations photovoltaïques raccordées au réseau **NF C 15-712-1** ; installation électrique BT (raccordement AC) **NF C 15-100** ; opérations / habilitation photovoltaïque (**NF C 18-510**, habilitation **BP/BR**) ; contrôle/mise en service **IEC 62446**, attestation **Consuel**, raccordement **Enedis**, label **RGE QualiPV** ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `utilise-kit` → [monitorer-diagnostiquer-controler](../../professions/photovoltaique/cards/monitorer-diagnostiquer-controler.md).
- **Tags** : `metier:photovoltaique famille:electricite sous-famille:photovoltaique type:kit cluster:monitoring cluster:maintenance equipement:pince-amperemetrique-dc`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
