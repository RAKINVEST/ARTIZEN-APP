# Principe de l'alarme intrusion

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `principe-alarme-intrusion` |
| Titre | Principe de l'alarme intrusion |
| Profession | `metier:alarme-intrusion` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:alarme-intrusion` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : comprendre l'architecture d'une alarme intrusion : **centrale + détecteurs + organes d'alerte**, et la notion de **grade**. `[C]`
- **Résumé** : un système d'alarme détecte l'intrusion et alerte : une **centrale** collecte les **détecteurs** (contacts d'ouverture, **volumétriques**) et commande les **organes d'alerte** (**sirènes**, **transmetteur**), pilotée par **claviers/badges/télécommandes** et des **scénarios d'armement** ; le niveau de protection se qualifie par un **grade (EN 50131)** ; filaire ou radio. `[C]` ⟦grade/architecture selon site à confirmer⟧

## Réalisation
- **Étapes** :
  1. **Centrale + claviers** (cœur, alimentation secourue). `[C]` → [installer-centrale-clavier](installer-centrale-clavier.md)
  2. **Détecteurs** : ouverture + volumétriques. `[C]` → [poser-detecteurs-volumetriques](poser-detecteurs-volumetriques.md)
  3. **Sirènes + transmetteur** (alerte locale + à distance). `[C]` → [installer-sirenes-transmetteur](installer-sirenes-transmetteur.md)
  4. **Scénarios d'armement** (total/partiel/zones). `[C]` → [configurer-badges-telecommandes-armement](configurer-badges-telecommandes-armement.md)
- **Points critiques** : **grade** adapté au risque ; **autoprotection** partout ; **continuité** (batterie secours) ; éviter les faux déclenchements.
- **Sécurité** : alimentation (consignation) ; autoprotection ; cyber. **Consignation** si intervention sur l'**alimentation électrique** de la centrale/des équipements — par une personne **habilitée** (NF C 18-510). **Continuité de fonctionnement** : une alarme protège — la mettre hors service pendant une intervention laisse le site **non protégé** (prévenir, planifier), **batterie de secours** vérifiée. **Autoprotection (tamper) / sabotage** : ne jamais neutraliser les autoprotections ; toute ouverture de boîtier doit déclencher l'autoprotection. **Faux déclenchements** : emplacement/réglage des détecteurs (animaux, chaleur, courants d'air) pour éviter les alarmes intempestives. **Cybersécurité des systèmes connectés** : centrale/transmetteur IP → mots de passe, mises à jour, segmentation (système compromis = protection contournée). **Confidentialité / RGPD** : codes, badges, journaux d'événements = données à protéger. **Arrêt immédiat en cas de danger.** Les interventions sur l'alimentation électrique sont **réservées aux professionnels habilités**.** `[A]`

## Cadre & suites
- **Normes** : alimentation électrique de la centrale **NF C 15-100** ; consignation à l'intervention **NF C 18-510** ; systèmes d'alarme intrusion **EN 50131** (grades), règles **APSAD** (R81/R82) / certification **NF&A2P** (**CNPP**), données **RGPD** et cybersécurité (**ANSSI**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Essais / maintenance** : `cite-carte` → [essayer-maintenir-alarme](essayer-maintenir-alarme.md)

## Relations & tags
- **Tags** : `metier:alarme-intrusion famille:electricite sous-famille:alarme-intrusion intervention:comprendre cluster:centrales-d-alarme cluster:detecteurs cluster:sirenes cluster:transmetteurs cluster:scenarios-d-armement type:principe securite:autoprotection`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
