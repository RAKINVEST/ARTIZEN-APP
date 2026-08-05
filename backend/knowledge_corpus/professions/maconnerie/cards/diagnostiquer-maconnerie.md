# Diagnostiquer une maçonnerie

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `diagnostiquer-maconnerie` |
| Titre | Diagnostiquer une maçonnerie |
| Profession | `metier:maconnerie` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:maconnerie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : diagnostiquer l'état d'une maçonnerie (fissures, humidité, désordre structurel) avant intervention. `[C]`
- **Résumé** : observer et qualifier les **fissures** (retrait / structurelle / tassement), rechercher l'**humidité** (remontées capillaires, salpêtre) et les désordres structurels (linteau/chaînage), puis orienter ; tout doute structurel → étude. `[C]`

## Réalisation
- **Étapes** :
  1. Qualifier les **fissures** (nature, évolutivité). `[C]` → [fissure-mur-maconnerie](../../../diagnostics/maconnerie/fissure-mur-maconnerie.md)
  2. Rechercher l'**humidité** (remontées, salpêtre). `[C]` → [humidite-remontee-capillaire](../../../diagnostics/maconnerie/humidite-remontee-capillaire.md)
  3. Contrôler linteaux/chaînages/appuis (**désordre porteur**). `[C]` → [affaissement-desordre-porteur](../../../diagnostics/maconnerie/affaissement-desordre-porteur.md)
  4. Doute structurel → **étude** (bureau d'études). `[C]`
- **Points critiques** : distinguer fissure **structurelle** (→ étude) et de revêtement ; localiser l'origine de l'humidité ; ne pas masquer un désordre porteur.
- **Sécurité** : hauteur ; stabilité (évaluer avant de sonder) ; poussières. **Ouvrage porteur** : toute **ouverture / reprise en sous-œuvre** d'un mur porteur engage la **stabilité** — **étaiement** et **étude** préalables **obligatoires** (risque d'effondrement). **Manutention lourde** (blocs, pierres) : écrasement / TMS — moyens de levage. **Poussières** (découpe = **silice**) : masque/aspiration. **Produits** (ciment/mortier **caustique**) : gants/lunettes. **Travail en hauteur** (échafaudage). **Arrêt immédiat en cas de danger.** Une intervention **structurelle** relève de **compétences adaptées**.** `[A]`

## Cadre & suites
- **Normes** : ouvrages en maçonnerie de petits éléments **DTU 20.1** ; cloisons en maçonnerie **DTU 20.13** ; chaînages / éléments en béton **DTU 21** ; calcul **Eurocode 6 (NF EN 1996)** ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Contrôle** : `a-checklist` → [controle-maintenance-maconnerie](../../../checklists/maconnerie/controle-maintenance-maconnerie.md)

## Relations & tags
- **Tags** : `metier:maconnerie famille:gros-oeuvre sous-famille:maconnerie intervention:diagnostiquer intervention:controler cluster:diagnostic cluster:controle cluster:reparations complexite:moyenne type:diagnostic securite:structure`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
