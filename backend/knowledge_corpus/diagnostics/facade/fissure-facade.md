# Fissure de façade

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `fissure-facade` |
| Titre | Fissure de façade |
| Profession | `metier:facade` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:facade` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- **Fissure** en façade : microfissure, faïençage, ou ouverture large. `[C]`

> Une fissure **large/évolutive/en escalier** peut être **structurelle** → étude (ne pas masquer). `[B]`

## Causes probables
1. Retrait/vieillissement du revêtement (microfissure/faïençage). `[C]`
2. Mouvement du **support** (tassement, structure). `[C]` ⟦à confirmer par étude⟧
3. Infiltration ayant dégradé le support. `[C]` → [infiltration-facade](infiltration-facade.md)

## Résolution
- Qualifier puis traiter (pontage/imperméabilité) ou étude si structurel. `[C]` → [traiter-fissures-facade](../../professions/facade/cards/traiter-fissures-facade.md)

## Cadre
- **Normes** : enduits de mortiers **DTU 26.1** ; réfection de façades par revêtements d'imperméabilité **DTU 42.1** ; maçonnerie de petits éléments **DTU 20.1** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [traiter-fissures-facade](../../professions/facade/cards/traiter-fissures-facade.md).
- **Tags** : `metier:facade famille:enveloppe sous-famille:facade probleme:fissure cluster:fissures cluster:diagnostic type:diagnostic securite:hauteur`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
