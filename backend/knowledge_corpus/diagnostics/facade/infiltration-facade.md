# Infiltration en façade

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `infiltration-facade` |
| Titre | Infiltration en façade |
| Profession | `metier:facade` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:facade` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Traces d'**humidité**, auréoles, salpêtre, dégradation du revêtement. `[C]`

## Causes probables
1. **Fissure** / joint dégradé laissant pénétrer l'eau. `[C]` → [fissure-facade](fissure-facade.md)
2. Point singulier défaillant (appui, encadrement, **solin/rive**). `[C]` → [realiser-solin-abergement](../../professions/zinguerie/cards/realiser-solin-abergement.md)
3. Revêtement non respirant piégeant l'humidité. `[C]`

## Résolution
- Localiser l'entrée d'eau, rétablir l'étanchéité (joint, imperméabilité), réparer les points singuliers. `[C]`

## Cadre
- **Normes** : enduits de mortiers **DTU 26.1** ; réfection de façades par revêtements d'imperméabilité **DTU 42.1** ; maçonnerie de petits éléments **DTU 20.1** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [traiter-fissures-facade](../../professions/facade/cards/traiter-fissures-facade.md).
- **Tags** : `metier:facade famille:enveloppe sous-famille:facade probleme:infiltration probleme:humidite cluster:infiltrations cluster:diagnostic type:diagnostic securite:hauteur relation:zinguerie relation:etancheite`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
