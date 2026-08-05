# Câbler les chaînes DC

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `cabler-chaines-dc` |
| Titre | Câbler les chaînes DC |
| Profession | `metier:photovoltaique` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:photovoltaique` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : câbler les **chaînes DC** (strings) : polarité, connectique, tension de chaîne — opération à haut risque électrique. `[C]`
- **Résumé** : raccorder les modules en **série** (respect strict de la **polarité**), avec une **connectique DC** de qualité (même marque, sertissage), en vérifiant la **tension de chaîne** (Voc) compatible avec l'onduleur, en posant un **coffret DC** avec protections/**parafoudre** et **sectionneur DC** ; ne jamais débrancher un connecteur DC **en charge** (arc). `[C]` ⟦tension/nombre de modules par chaîne selon onduleur à confirmer⟧

## Réalisation
- **Étapes** :
  1. Raccorder en **série** ; **polarité** stricte ; connectique certifiée. `[A]`
  2. Vérifier la **tension de chaîne (Voc)** vs onduleur. `[B]` ⟦à confirmer⟧
  3. Coffret DC : **protections / parafoudre / sectionneur DC**. `[A]`
  4. **Jamais débrancher un connecteur DC en charge** (arc). `[A]`
- **Points critiques** : **polarité/tension de chaîne** (Voc) ; connectique certifiée (arcs) ; protections DC ; ne pas ouvrir sous charge.
- **Sécurité** : **arc DC** (auto-entretenu) ; tension DC permanente ; toiture. **Tension continue (DC) permanente** : dès qu'il y a de la lumière, les **modules produisent** — on **ne peut pas supprimer totalement la tension** côté panneaux/chaîne DC en plein jour (couper l'AC **ne suffit pas**). **Arc électrique DC** : un arc DC **s'auto-entretient** (contrairement à l'AC) — connectique de qualité, **jamais débrancher un connecteur DC en charge**. **Consignation adaptée** : côté AC consignable (habilité), côté DC **procédure spécifique** — habilitation **photovoltaïque (BP/BR)**. **Incendie** : risque spécifique (dispositif de coupure d'urgence, sécurité des intervenants/pompiers). **Travail en toiture** : **chute** (protections/EPI), **manutention** des modules (lourds, prise au vent), météo. **Arrêt immédiat en cas de danger.** Opérations réservées à un professionnel **qualifié/habilité (RGE QualiPV)**.** `[A]`

## Cadre & suites
- **Normes** : installations photovoltaïques raccordées au réseau **NF C 15-712-1** ; installation électrique BT (raccordement AC) **NF C 15-100** ; opérations / habilitation photovoltaïque (**NF C 18-510**, habilitation **BP/BR**) ; contrôle/mise en service **IEC 62446**, attestation **Consuel**, raccordement **Enedis**, label **RGE QualiPV** ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Onduleur** : `cite-carte` → [installer-onduleur](installer-onduleur.md)

## Relations & tags
- **Tags** : `metier:photovoltaique famille:electricite sous-famille:photovoltaique intervention:realiser cluster:chaines-dc complexite:expert type:installation securite:dc`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
