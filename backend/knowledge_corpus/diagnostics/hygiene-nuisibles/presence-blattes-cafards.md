# Présence de blattes / cafards

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `presence-blattes-cafards` |
| Titre | Présence de blattes / cafards |
| Profession | `metier:hygiene-nuisibles` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:hygiene-nuisibles` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- **Blattes** nocturnes (cuisine/gaines), déjections, odeur, allergies/asthme des occupants. `[C]`

## Causes probables
1. **Hygiène** (denrées/déchets) + **chaleur/humidité**. `[C]` → [identifier-cafards-fourmis](../../professions/hygiene-nuisibles/cards/identifier-cafards-fourmis.md)
2. **Humidité / ventilation** insuffisante. `[C]` → [principe-ventilation](../../professions/ventilation/cards/principe-ventilation.md)
3. Diffusion par **gaines / mitoyenneté**. `[C]`

## Conduite à tenir
- Renforcer **hygiène** et **ventilation**, obturer les passages, surveiller ; traitement = **qualifié** (présentation).

> Blattes = **allergies/asthme** ; souillure des denrées. `[A]`

## Cadre
- **Normes** : accès des nuisibles par les réseaux (siphons / clapets anti-rongeurs, **interface** plomberie) **DTU 60.1** ; **ventilation** contre l'humidité favorisant les nuisibles (**interface**) **DTU 68.3** ; services de lutte antiparasitaire **NF EN 16636** (certification CEPA), **Règlement Sanitaire Départemental**, **Règlement Biocides UE 528/2012 / Certibiocide** et **HACCP** (locaux alimentaires) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [identifier-cafards-fourmis](../../professions/hygiene-nuisibles/cards/identifier-cafards-fourmis.md).
- **Tags** : `metier:hygiene-nuisibles famille:specialises sous-famille:hygiene-nuisibles probleme:blattes cluster:cafards cluster:diagnostic type:diagnostic securite:biocides relation:ventilation`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
