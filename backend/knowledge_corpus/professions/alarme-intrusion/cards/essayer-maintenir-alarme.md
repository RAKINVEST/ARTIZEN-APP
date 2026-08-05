# Essayer / maintenir une alarme

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `essayer-maintenir-alarme` |
| Titre | Essayer / maintenir une alarme |
| Profession | `metier:alarme-intrusion` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:alarme-intrusion` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : réaliser les **essais** périodiques et la **maintenance** (détecteurs, batterie, autoprotection, transmission). `[C]`
- **Résumé** : tester chaque **détecteur** (marche/zone), vérifier l'**autoprotection**, l'état de la **batterie de secours** (autonomie), la **transmission** (test cyclique), les piles des éléments radio, et documenter ; prévenir avant toute mise hors service (**continuité**). `[C]`

## Réalisation
- **Étapes** :
  1. Tester chaque **détecteur** + **autoprotection**. `[C]`
  2. Vérifier **batterie de secours** (autonomie) + piles radio. `[C]` → [defaut-alimentation-batterie](../../../diagnostics/alarme-intrusion/defaut-alimentation-batterie.md)
  3. Tester la **transmission** (cyclique/notification). `[C]`
  4. Prévenir avant mise hors service (**continuité**) ; documenter. `[C]`
- **Points critiques** : essais réguliers (une alarme non testée = protection illusoire) ; batterie/piles ; continuité (prévenir).
- **Sécurité** : continuité (site non protégé) ; alimentation ; cyber. **Consignation** si intervention sur l'**alimentation électrique** de la centrale/des équipements — par une personne **habilitée** (NF C 18-510). **Continuité de fonctionnement** : une alarme protège — la mettre hors service pendant une intervention laisse le site **non protégé** (prévenir, planifier), **batterie de secours** vérifiée. **Autoprotection (tamper) / sabotage** : ne jamais neutraliser les autoprotections ; toute ouverture de boîtier doit déclencher l'autoprotection. **Faux déclenchements** : emplacement/réglage des détecteurs (animaux, chaleur, courants d'air) pour éviter les alarmes intempestives. **Cybersécurité des systèmes connectés** : centrale/transmetteur IP → mots de passe, mises à jour, segmentation (système compromis = protection contournée). **Confidentialité / RGPD** : codes, badges, journaux d'événements = données à protéger. **Arrêt immédiat en cas de danger.** Les interventions sur l'alimentation électrique sont **réservées aux professionnels habilités**.** `[A]`

## Cadre & suites
- **Normes** : alimentation électrique de la centrale **NF C 15-100** ; consignation à l'intervention **NF C 18-510** ; systèmes d'alarme intrusion **EN 50131** (grades), règles **APSAD** (R81/R82) / certification **NF&A2P** (**CNPP**), données **RGPD** et cybersécurité (**ANSSI**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Kit** : `utilise-kit` → [kit-alarme-intrusion](../../../kits/alarme-intrusion/kit-alarme-intrusion.md)

## Relations & tags
- **Tags** : `metier:alarme-intrusion famille:electricite sous-famille:alarme-intrusion intervention:entretenir intervention:controler cluster:essais cluster:maintenance cluster:diagnostic complexite:moyenne type:entretien securite:autoprotection`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
