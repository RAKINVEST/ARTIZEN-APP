# Traces de rongeurs / infestation

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `traces-rongeurs-infestation` |
| Titre | Traces de rongeurs / infestation |
| Profession | `metier:hygiene-nuisibles` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:hygiene-nuisibles` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- **Crottes**, **rongements** (câbles/denrées), bruits nocturnes, traces de graisse, odeur, nids. `[C]`

## Causes probables
1. **Points d'entrée** (réseaux, gaines, toiture) + nourriture accessible. `[C]` → [prevenir-hygiene-lutte-integree](../../professions/hygiene-nuisibles/cards/prevenir-hygiene-lutte-integree.md)
2. **Rat / souris** installé(e)s (nid/reproduction). `[C]` → [identifier-rongeurs](../../professions/hygiene-nuisibles/cards/identifier-rongeurs.md)
3. Accès par les **évacuations** (Plomberie). `[C]` → [deboucher-evacuation-sanitaire](../../professions/plomberie/cards/deboucher-evacuation-sanitaire.md)

## Conduite à tenir
- Supprimer sources/points d'entrée (**exclusion/hygiène**), surveiller ; traitement = **applicateur qualifié** (appâts sécurisés, présentation).

> Risque **leptospirose** / rongement de câbles (incendie). `[A]`

## Cadre
- **Normes** : accès des nuisibles par les réseaux (siphons / clapets anti-rongeurs, **interface** plomberie) **DTU 60.1** ; **ventilation** contre l'humidité favorisant les nuisibles (**interface**) **DTU 68.3** ; services de lutte antiparasitaire **NF EN 16636** (certification CEPA), **Règlement Sanitaire Départemental**, **Règlement Biocides UE 528/2012 / Certibiocide** et **HACCP** (locaux alimentaires) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [identifier-rongeurs](../../professions/hygiene-nuisibles/cards/identifier-rongeurs.md).
- **Tags** : `metier:hygiene-nuisibles famille:specialises sous-famille:hygiene-nuisibles probleme:rongeurs cluster:rongeurs cluster:diagnostic type:diagnostic securite:biocides relation:plomberie`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
