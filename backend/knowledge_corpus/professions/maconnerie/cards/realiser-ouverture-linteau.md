# Réaliser une ouverture / poser un linteau

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `realiser-ouverture-linteau` |
| Titre | Réaliser une ouverture / poser un linteau |
| Profession | `metier:maconnerie` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:maconnerie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : créer une ouverture dans un mur (porteur ou non) et poser un **linteau** — opération **structurelle** à étayer. `[C]`
- **Résumé** : après **étude** (mur porteur ?), mettre en place l'**étaiement**, ouvrir progressivement, poser le **linteau** dimensionné (béton/métal) avec ses appuis, réaliser la reprise, puis retirer l'étaiement une fois la reprise de charge assurée. `[C]` ⟦dimensionnement linteau par un bureau d'études à confirmer⟧

## Réalisation
- **Étapes** :
  1. **Étude** préalable (porteur ? dimensionnement linteau). `[A]` ⟦requise⟧
  2. Mettre en place l'**étaiement**. `[A]` → [etaiement-avant-ouverture](../../../procedures/maconnerie/etaiement-avant-ouverture.md)
  3. Ouvrir ; poser le **linteau** dimensionné avec appuis suffisants. `[B]` ⟦à confirmer⟧
  4. Reprise/calage ; retirer l'étaiement **progressivement**. `[B]`
- **Points critiques** : opération **structurelle** → étude + étaiement obligatoires ; appuis de linteau suffisants ; ne jamais ouvrir un porteur sans étayer.
- **Sécurité** : **effondrement** (porteur) ; étaiement ; manutention linteau ; poussières. **Ouvrage porteur** : toute **ouverture / reprise en sous-œuvre** d'un mur porteur engage la **stabilité** — **étaiement** et **étude** préalables **obligatoires** (risque d'effondrement). **Manutention lourde** (blocs, pierres) : écrasement / TMS — moyens de levage. **Poussières** (découpe = **silice**) : masque/aspiration. **Produits** (ciment/mortier **caustique**) : gants/lunettes. **Travail en hauteur** (échafaudage). **Arrêt immédiat en cas de danger.** Une intervention **structurelle** relève de **compétences adaptées**.** `[A]`

## Cadre & suites
- **Normes** : ouvrages en maçonnerie de petits éléments **DTU 20.1** ; cloisons en maçonnerie **DTU 20.13** ; chaînages / éléments en béton **DTU 21** ; calcul **Eurocode 6 (NF EN 1996)** ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Désordre structurel** : `traite-diagnostic` → [affaissement-desordre-porteur](../../../diagnostics/maconnerie/affaissement-desordre-porteur.md)

## Relations & tags
- **Tags** : `metier:maconnerie famille:gros-oeuvre sous-famille:maconnerie intervention:realiser intervention:reparer cluster:ouvertures cluster:linteaux cluster:murs-porteurs complexite:expert type:installation securite:structure relation:charpente relation:demolition`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
