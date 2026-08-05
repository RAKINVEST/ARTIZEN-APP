# Principe de la maçonnerie (murs, matériaux, mortiers)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `principe-maconnerie` |
| Titre | Principe de la maçonnerie (murs, matériaux, mortiers) |
| Profession | `metier:maconnerie` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:maconnerie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : comprendre les ouvrages de maçonnerie (murs porteurs, cloisons), leurs matériaux et le rôle structurel. `[C]`
- **Résumé** : la maçonnerie de **petits éléments** (**briques**, **blocs béton**, **pierres**) hourdés au **mortier** constitue murs porteurs et cloisons ; les **chaînages** et **linteaux** (béton armé intégré à l'ouvrage) assurent la solidité d'ensemble. `[C]` ⟦appareillage/épaisseur selon ouvrage à confirmer⟧

## Réalisation
- **Étapes** :
  1. **Murs porteurs / cloisons** (petits éléments). `[C]` → [monter-mur-cloison](monter-mur-cloison.md)
  2. Matériaux : **briques / blocs béton / pierres** + **mortier**. `[C]`
  3. **Chaînages / linteaux** (béton armé dans l'ouvrage — DTU 21). `[C]` → [realiser-chainage](realiser-chainage.md)
  4. **Finition** (enduit) = côté Façade (frontière). `[C]` → [reprendre-enduit-facade](../../../professions/facade/cards/reprendre-enduit-facade.md)
- **Points critiques** : distinguer **porteur** et cloison ; chaînage/linteau dimensionnés ; ne pas empiéter sur Façade (enduit) / Charpente (appuis).
- **Sécurité** : manutention lourde ; poussières/silice ; charges (porteur). **Ouvrage porteur** : toute **ouverture / reprise en sous-œuvre** d'un mur porteur engage la **stabilité** — **étaiement** et **étude** préalables **obligatoires** (risque d'effondrement). **Manutention lourde** (blocs, pierres) : écrasement / TMS — moyens de levage. **Poussières** (découpe = **silice**) : masque/aspiration. **Produits** (ciment/mortier **caustique**) : gants/lunettes. **Travail en hauteur** (échafaudage). **Arrêt immédiat en cas de danger.** Une intervention **structurelle** relève de **compétences adaptées**.** `[A]`

## Cadre & suites
- **Normes** : ouvrages en maçonnerie de petits éléments **DTU 20.1** ; cloisons en maçonnerie **DTU 20.13** ; chaînages / éléments en béton **DTU 21** ; calcul **Eurocode 6 (NF EN 1996)** ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Diagnostic** : `cite-carte` → [diagnostiquer-maconnerie](diagnostiquer-maconnerie.md)

## Relations & tags
- **Tags** : `metier:maconnerie famille:gros-oeuvre sous-famille:maconnerie intervention:comprendre cluster:murs-porteurs cluster:cloisons-maconnees cluster:briques cluster:blocs-beton cluster:pierres cluster:mortiers type:principe securite:structure relation:facade`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
