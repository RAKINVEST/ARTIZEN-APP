# Installer la centrale et les claviers

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `installer-centrale-clavier` |
| Titre | Installer la centrale et les claviers |
| Profession | `metier:alarme-intrusion` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:alarme-intrusion` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : installer la **centrale** (cœur du système) et les **claviers**, avec alimentation secourue et autoprotection. `[C]`
- **Résumé** : poser la centrale à un emplacement **discret/protégé** (autoprotection à l'ouverture/l'arrachement), la raccorder à une **alimentation** dédiée avec **batterie de secours**, poser les **claviers** (armement/programmation), et paramétrer les zones ; le raccordement électrique relève d'un **électricien habilité**. `[C]` ⟦grade/alimentation selon système à confirmer⟧

## Réalisation
- **Étapes** :
  1. Poser la centrale (emplacement protégé ; **autoprotection**). `[C]`
  2. **Alimentation** dédiée + **batterie de secours** ; raccordement = **habilité**. `[A]` → [controler-tableau-electrique](../../../professions/electricite-generale/cards/controler-tableau-electrique.md)
  3. Poser les **claviers** ; paramétrer les zones. `[C]`
  4. Vérifier l'**autoprotection** (ouverture/arrachement). `[A]`
- **Points critiques** : **autoprotection** active ; **batterie de secours** (continuité) ; alimentation dédiée (habilité) ; emplacement discret.
- **Sécurité** : alimentation (consignation/habilité) ; autoprotection ; cyber. **Consignation** si intervention sur l'**alimentation électrique** de la centrale/des équipements — par une personne **habilitée** (NF C 18-510). **Continuité de fonctionnement** : une alarme protège — la mettre hors service pendant une intervention laisse le site **non protégé** (prévenir, planifier), **batterie de secours** vérifiée. **Autoprotection (tamper) / sabotage** : ne jamais neutraliser les autoprotections ; toute ouverture de boîtier doit déclencher l'autoprotection. **Faux déclenchements** : emplacement/réglage des détecteurs (animaux, chaleur, courants d'air) pour éviter les alarmes intempestives. **Cybersécurité des systèmes connectés** : centrale/transmetteur IP → mots de passe, mises à jour, segmentation (système compromis = protection contournée). **Confidentialité / RGPD** : codes, badges, journaux d'événements = données à protéger. **Arrêt immédiat en cas de danger.** Les interventions sur l'alimentation électrique sont **réservées aux professionnels habilités**.** `[A]`

## Cadre & suites
- **Normes** : alimentation électrique de la centrale **NF C 15-100** ; consignation à l'intervention **NF C 18-510** ; systèmes d'alarme intrusion **EN 50131** (grades), règles **APSAD** (R81/R82) / certification **NF&A2P** (**CNPP**), données **RGPD** et cybersécurité (**ANSSI**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Détecteurs d'ouverture** : `cite-carte` → [poser-detecteurs-ouverture](poser-detecteurs-ouverture.md)

## Relations & tags
- **Tags** : `metier:alarme-intrusion famille:electricite sous-famille:alarme-intrusion intervention:poser cluster:centrales-d-alarme cluster:claviers complexite:avancee type:installation securite:autoprotection relation:electricite-generale`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
