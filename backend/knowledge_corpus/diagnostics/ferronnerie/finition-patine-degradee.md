# Finition / patine dégradée

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `finition-patine-degradee` |
| Titre | Finition / patine dégradée |
| Profession | `metier:ferronnerie` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:ferronnerie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- **Patine** ternie/tachée, peinture qui **cloque/s'écaille**, aspect hétérogène. `[C]`

## Causes probables
1. **Préparation** insuffisante (dégraissage/accroche). `[C]` → [proteger-patiner-finir](../../professions/ferronnerie/cards/proteger-patiner-finir.md)
2. **Corrosion** sous-jacente qui pousse la finition. `[C]` → [ouvrage-forge-corrode](ouvrage-forge-corrode.md)
3. Finition inadaptée à l'exposition (UV/humidité). `[C]`

## Résolution
- Poncer/reprendre la zone, traiter la corrosion, réappliquer **protection + patine/finition** adaptées à l'exposition ; harmoniser.

## Cadre
- **Normes** : ouvrages métalliques (mise en œuvre, **interface** métallerie) **DTU 37.1** ; garde-corps **NF P01-012** ; exécution des structures acier **NF EN 1090**, qualification de soudage **NF EN ISO 9606**, protection anticorrosion **NF EN ISO 12944** ; motorisation éventuelle d'un portail (**interface** Électricité) **NF C 15-100** ⟦EN 1090 / EN ISO 9606 / ISO 12944 et versions exactes en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [proteger-patiner-finir](../../professions/ferronnerie/cards/proteger-patiner-finir.md).
- **Tags** : `metier:ferronnerie famille:specialises sous-famille:ferronnerie probleme:finition cluster:finitions cluster:diagnostic type:diagnostic securite:produits-chimiques`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
