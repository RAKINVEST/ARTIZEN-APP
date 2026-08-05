# Sécuriser le système connecté (cyber & données)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `securiser-systeme-connecte` |
| Titre | Sécuriser le système connecté (cyber & données) |
| Profession | `metier:alarme-intrusion` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:alarme-intrusion` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : sécuriser la centrale/le transmetteur connectés (cybersécurité) et protéger les **données** (codes/badges/journaux). `[C]`
- **Résumé** : changer les **mots de passe** par défaut, appliquer les **mises à jour**, segmenter la liaison IP du transmetteur, limiter les accès à distance, et protéger les **données personnelles** (codes, badges, journaux d'événements) conformément au **RGPD** ; un système compromis = **protection contournée**. `[C]` ⟦mesures selon équipement à confirmer⟧

## Réalisation
- **Étapes** :
  1. **Mots de passe** (changer par défaut) + **mises à jour**. `[A]`
  2. **Segmenter** la liaison IP ; limiter l'accès distant. `[C]` → [securiser-maintenir-domotique](../../../professions/domotique/cards/securiser-maintenir-domotique.md)
  3. Protéger les **données** (codes/badges/journaux) — **RGPD**. `[A]`
  4. Vérifier l'**autoprotection**/anti-sabotage. `[C]`
- **Points critiques** : cyber = maintien de la protection (système compromis = contourné) ; **RGPD** (données) ; autoprotection.
- **Sécurité** : cyber ; confidentialité/**RGPD** ; sabotage. **Consignation** si intervention sur l'**alimentation électrique** de la centrale/des équipements — par une personne **habilitée** (NF C 18-510). **Continuité de fonctionnement** : une alarme protège — la mettre hors service pendant une intervention laisse le site **non protégé** (prévenir, planifier), **batterie de secours** vérifiée. **Autoprotection (tamper) / sabotage** : ne jamais neutraliser les autoprotections ; toute ouverture de boîtier doit déclencher l'autoprotection. **Faux déclenchements** : emplacement/réglage des détecteurs (animaux, chaleur, courants d'air) pour éviter les alarmes intempestives. **Cybersécurité des systèmes connectés** : centrale/transmetteur IP → mots de passe, mises à jour, segmentation (système compromis = protection contournée). **Confidentialité / RGPD** : codes, badges, journaux d'événements = données à protéger. **Arrêt immédiat en cas de danger.** Les interventions sur l'alimentation électrique sont **réservées aux professionnels habilités**.** `[A]`

## Cadre & suites
- **Normes** : alimentation électrique de la centrale **NF C 15-100** ; consignation à l'intervention **NF C 18-510** ; systèmes d'alarme intrusion **EN 50131** (grades), règles **APSAD** (R81/R82) / certification **NF&A2P** (**CNPP**), données **RGPD** et cybersécurité (**ANSSI**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Maintenance** : `cite-carte` → [essayer-maintenir-alarme](essayer-maintenir-alarme.md)

## Relations & tags
- **Tags** : `metier:alarme-intrusion famille:electricite sous-famille:alarme-intrusion intervention:securiser cluster:centrales-d-alarme cluster:transmetteurs complexite:avancee type:configuration securite:cyber securite:donnees relation:domotique`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
