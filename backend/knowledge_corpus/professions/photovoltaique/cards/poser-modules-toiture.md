# Poser les modules en toiture

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `poser-modules-toiture` |
| Titre | Poser les modules en toiture |
| Profession | `metier:photovoltaique` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:photovoltaique` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : poser les modules PV en toiture (surimposition/intégration) en assurant étanchéité et tenue au vent. `[C]`
- **Résumé** : fixer les **rails/supports** sur la couverture (surimposé ou intégré), poser les **modules** à l'orientation/inclinaison utiles, en assurant l'**étanchéité des traversées** et la tenue au vent (interface **Couverture**), et la **liaison équipotentielle**/mise à la terre des masses ; manutention lourde en hauteur. `[C]` ⟦fixation/étanchéité selon toiture à confirmer⟧

## Réalisation
- **Étapes** :
  1. Sécuriser la toiture (protections/EPI antichute). `[A]`
  2. Fixer rails/supports ; **étanchéité des traversées** (Couverture). `[C]` → [poser-fenetre-de-toit](../../../professions/couverture/cards/poser-fenetre-de-toit.md)
  3. Poser les **modules** ; **mise à la terre**/équipotentialité des masses. `[A]`
  4. Ne pas mettre en charge sans onduleur/protection. `[C]` → [cabler-chaines-dc](cabler-chaines-dc.md)
- **Points critiques** : **étanchéité des traversées** (interface couverture) ; tenue au vent ; **mise à la terre** ; manutention sécurisée.
- **Sécurité** : **toiture/chute** ; manutention (modules lourds) ; dès la pose, les modules **produisent (DC)**. **Tension continue (DC) permanente** : dès qu'il y a de la lumière, les **modules produisent** — on **ne peut pas supprimer totalement la tension** côté panneaux/chaîne DC en plein jour (couper l'AC **ne suffit pas**). **Arc électrique DC** : un arc DC **s'auto-entretient** (contrairement à l'AC) — connectique de qualité, **jamais débrancher un connecteur DC en charge**. **Consignation adaptée** : côté AC consignable (habilité), côté DC **procédure spécifique** — habilitation **photovoltaïque (BP/BR)**. **Incendie** : risque spécifique (dispositif de coupure d'urgence, sécurité des intervenants/pompiers). **Travail en toiture** : **chute** (protections/EPI), **manutention** des modules (lourds, prise au vent), météo. **Arrêt immédiat en cas de danger.** Opérations réservées à un professionnel **qualifié/habilité (RGE QualiPV)**.** `[A]`

## Cadre & suites
- **Normes** : installations photovoltaïques raccordées au réseau **NF C 15-712-1** ; installation électrique BT (raccordement AC) **NF C 15-100** ; opérations / habilitation photovoltaïque (**NF C 18-510**, habilitation **BP/BR**) ; contrôle/mise en service **IEC 62446**, attestation **Consuel**, raccordement **Enedis**, label **RGE QualiPV** ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Chaînes DC** : `cite-carte` → [cabler-chaines-dc](cabler-chaines-dc.md)

## Relations & tags
- **Tags** : `metier:photovoltaique famille:electricite sous-famille:photovoltaique intervention:poser cluster:panneaux-photovoltaiques cluster:modules complexite:avancee type:installation securite:hauteur relation:couverture`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
