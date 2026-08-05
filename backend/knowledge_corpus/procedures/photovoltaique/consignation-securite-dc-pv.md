# Consignation & sécurité DC photovoltaïque

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `consignation-securite-dc-pv` |
| Titre | Consignation & sécurité DC photovoltaïque |
| Profession | `metier:photovoltaique` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## But
- Intervenir en sécurité sur une installation PV malgré la **tension DC permanente**. `[A]`

## Étapes (habilitation photovoltaïque requise)
1. **Côté AC** : consignation classique par un **habilité** (BR). `[A]`
2. **Côté DC** : on **ne peut pas éteindre les modules** en journée — utiliser **sectionneur DC**, dispositifs de **coupure/arrêt au module** (optimiseurs), et procédure spécifique ; **jamais débrancher un connecteur DC en charge**. `[A]` ⟦procédure exacte à confirmer⟧
3. EPI adaptés (arc/DC), sécurité **incendie**, sécurité **toiture**. `[A]`
4. **Arrêt immédiat** en cas d'arc/défaut ; opération **réservée habilité (BP/BR PV)**. `[A]`

> La tension DC subsiste tant qu'il y a de la lumière : **couper l'AC ne suffit pas**. `[A]`

## Cadre
- **Normes** : installations photovoltaïques raccordées au réseau **NF C 15-712-1** ; installation électrique BT (raccordement AC) **NF C 15-100** ; opérations / habilitation photovoltaïque (**NF C 18-510**, habilitation **BP/BR**) ; contrôle/mise en service **IEC 62446**, attestation **Consuel**, raccordement **Enedis**, label **RGE QualiPV** ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [cabler-chaines-dc](../../professions/photovoltaique/cards/cabler-chaines-dc.md).
- **Tags** : `metier:photovoltaique famille:electricite sous-famille:securite intervention:securiser cluster:chaines-dc cluster:controle type:procedure securite:dc securite:incendie`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
