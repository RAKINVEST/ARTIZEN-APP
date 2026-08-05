# Principe de la menuiserie extérieure

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `principe-menuiserie-exterieure` |
| Titre | Principe de la menuiserie extérieure |
| Profession | `metier:menuiserie-exterieure` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:menuiserie-exterieure` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : comprendre le rôle des menuiseries extérieures (clore les baies : étanchéité AEV, thermique, acoustique, sécurité) et leurs composants. `[C]`
- **Résumé** : une menuiserie extérieure (fenêtre, porte, baie, châssis) clot la baie et assure l'**étanchéité air-eau-vent (AEV)**, l'isolation thermique/acoustique et la sécurité ; composants : **dormant**, **ouvrant**, **vitrage**, **quincaillerie** et **joints** ; matériaux PVC/alu/bois/mixte. Le **pont thermique du tableau** relève de l'Isolation. `[C]` ⟦performances (Uw/AEV) selon produit à confirmer⟧

## Réalisation
- **Étapes** :
  1. **Dormant / ouvrant / vitrage / quincaillerie**. `[C]` → [regler-ouvrant-quincaillerie](regler-ouvrant-quincaillerie.md)
  2. **Étanchéité AEV** (air-eau-vent) + calfeutrement. `[C]` → [calfeutrer-etancheite-menuiserie](calfeutrer-etancheite-menuiserie.md)
  3. **Vitrages** (double/triple, performances). `[C]` → [remplacer-vitrage](remplacer-vitrage.md)
  4. **Pont thermique du tableau** → Isolation (`relation:isolation`). `[C]` → [traiter-ponts-thermiques](../../../professions/isolation/cards/traiter-ponts-thermiques.md)
- **Points critiques** : étanchéité **AEV** et calfeutrement du dormant ; drainage ; ne pas empiéter sur Isolation/Façade (tableau/finition).
- **Sécurité** : manutention/coupure (verre) ; hauteur ; produits. **Manutention** de menuiseries/**vitrages lourds** : risque d'écrasement / **coupure** (verre) — moyens de levage, gants anti-coupure, travail en binôme. **Travail en **hauteur** (baies d'étage, dépose) : protections collectives / EPI. **Produits** (mousse PU, mastics, solvants) : EPI / ventilation. **Motorisation de volet** : le **raccordement électrique** relève d'un professionnel (voir Électricité). **Stabilité** du support/de la baie vérifiée avant dépose. **Arrêt immédiat en cas de danger.** Une intervention relève de **compétences adaptées**.** `[A]`

## Cadre & suites
- **Normes** : mise en œuvre des fenêtres et portes extérieures **DTU 36.5** ; vitrerie-miroiterie **DTU 39** ; fermetures / volets **DTU 34.1** ; performance **classement AEV (Air-Eau-Vent)** ⟦à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Pose** : `cite-carte` → [poser-fenetre-porte](poser-fenetre-porte.md)

## Relations & tags
- **Tags** : `metier:menuiserie-exterieure famille:enveloppe sous-famille:menuiserie-exterieure intervention:comprendre cluster:fenetres cluster:portes cluster:baies-vitrees cluster:dormants cluster:ouvrants cluster:vitrages cluster:quincaillerie type:principe securite:manutention relation:isolation`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
