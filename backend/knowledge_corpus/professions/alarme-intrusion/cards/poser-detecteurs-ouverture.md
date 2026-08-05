# Poser des détecteurs d'ouverture (contacts)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `poser-detecteurs-ouverture` |
| Titre | Poser des détecteurs d'ouverture (contacts) |
| Profession | `metier:alarme-intrusion` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:alarme-intrusion` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : poser des **contacts d'ouverture** (portes/fenêtres) pour la protection **périmétrique**. `[C]`
- **Résumé** : poser les **contacts** magnétiques (ou détecteurs d'ouverture) sur les ouvrants à protéger, régler l'entrefer, câbler ou appairer à la centrale, et affecter chaque contact à une **zone** (temporisée pour l'entrée/sortie) ; protection **périmétrique** (avant intrusion dans le volume). `[C]` ⟦type/entrefer selon ouvrant à confirmer⟧

## Réalisation
- **Étapes** :
  1. Poser les **contacts** sur les ouvrants (entrefer correct). `[C]` ⟦à confirmer⟧
  2. Câbler / appairer à la centrale ; **autoprotection** du câblage. `[C]`
  3. Affecter chaque contact à une **zone** (temporisation entrée/sortie). `[C]`
  4. Tester chaque contact. `[C]` → [essai-reception-alarme](../../../procedures/alarme-intrusion/essai-reception-alarme.md)
- **Points critiques** : entrefer/pose fiables (éviter faux positifs) ; **zones**/temporisations cohérentes ; autoprotection du câblage.
- **Sécurité** : autoprotection ; faux déclenchements ; cyber (radio). **Consignation** si intervention sur l'**alimentation électrique** de la centrale/des équipements — par une personne **habilitée** (NF C 18-510). **Continuité de fonctionnement** : une alarme protège — la mettre hors service pendant une intervention laisse le site **non protégé** (prévenir, planifier), **batterie de secours** vérifiée. **Autoprotection (tamper) / sabotage** : ne jamais neutraliser les autoprotections ; toute ouverture de boîtier doit déclencher l'autoprotection. **Faux déclenchements** : emplacement/réglage des détecteurs (animaux, chaleur, courants d'air) pour éviter les alarmes intempestives. **Cybersécurité des systèmes connectés** : centrale/transmetteur IP → mots de passe, mises à jour, segmentation (système compromis = protection contournée). **Confidentialité / RGPD** : codes, badges, journaux d'événements = données à protéger. **Arrêt immédiat en cas de danger.** Les interventions sur l'alimentation électrique sont **réservées aux professionnels habilités**.** `[A]`

## Cadre & suites
- **Normes** : alimentation électrique de la centrale **NF C 15-100** ; consignation à l'intervention **NF C 18-510** ; systèmes d'alarme intrusion **EN 50131** (grades), règles **APSAD** (R81/R82) / certification **NF&A2P** (**CNPP**), données **RGPD** et cybersécurité (**ANSSI**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Volumétriques** : `cite-carte` → [poser-detecteurs-volumetriques](poser-detecteurs-volumetriques.md)

## Relations & tags
- **Tags** : `metier:alarme-intrusion famille:electricite sous-famille:alarme-intrusion intervention:poser cluster:contacts-d-ouverture cluster:detecteurs complexite:moyenne type:installation securite:autoprotection`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
