# Affaissement / désordre porteur

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `affaissement-desordre-porteur` |
| Titre | Affaissement / désordre porteur |
| Profession | `metier:maconnerie` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:maconnerie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Fissuration importante, **linteau** fléchi, appui écrasé, mur qui bombe. `[C]`

> **Danger structurel potentiel** : évaluer la stabilité, **étayer/évacuer** si nécessaire, faire appel à une **étude**. `[A]`

## Causes probables
1. **Linteau / chaînage** sous-dimensionné ou dégradé. `[C]` → [realiser-ouverture-linteau](../../professions/maconnerie/cards/realiser-ouverture-linteau.md)
2. Surcharge / modification (ouverture non étudiée). `[C]`
3. Tassement de fondation. `[C]` ⟦étude requise⟧

## Résolution
- **Étude structurelle** puis étaiement + reprise (linteau/chaînage/reprise en sous-œuvre). `[A]` → [etaiement-avant-ouverture](../../procedures/maconnerie/etaiement-avant-ouverture.md)

## Cadre
- **Normes** : ouvrages en maçonnerie de petits éléments **DTU 20.1** ; cloisons en maçonnerie **DTU 20.13** ; chaînages / éléments en béton **DTU 21** ; calcul **Eurocode 6 (NF EN 1996)** ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [etaiement-avant-ouverture](../../procedures/maconnerie/etaiement-avant-ouverture.md).
- **Tags** : `metier:maconnerie famille:gros-oeuvre sous-famille:maconnerie probleme:affaissement cluster:diagnostic cluster:murs-porteurs cluster:linteaux type:diagnostic securite:structure relation:charpente`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
