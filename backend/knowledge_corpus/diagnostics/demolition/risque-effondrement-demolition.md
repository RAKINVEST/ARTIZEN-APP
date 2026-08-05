# Risque d'effondrement pendant la démolition

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `risque-effondrement-demolition` |
| Titre | Risque d'effondrement pendant la démolition |
| Profession | `metier:demolition` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:demolition` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Mouvement/fissuration soudaine, élément qui **flambe** ou se déverse pendant la démolition. `[C]`

> **DANGER VITAL.** Évacuer, interdire l'accès, ne pas poursuivre sans **étude/étaiement**. `[A]`

## Causes probables
1. **Ordre de démolition** incorrect (porteur avant reprise). `[C]` → [ordre-demolition-etaiement](../../procedures/demolition/ordre-demolition-etaiement.md)
2. **Étaiement** absent/insuffisant. `[C]` → [demolir-partiel-porteur-etaiement](../../professions/demolition/cards/demolir-partiel-porteur-etaiement.md)
3. Structure dégradée non anticipée (diagnostic). `[C]`

## Résolution
- **Évacuer + sécuriser** ; reprendre l'étaiement/l'ordre après étude structurelle. `[A]`

## Cadre
- **Normes** : démolition/reprise d'ouvrages en maçonnerie **DTU 20.1** et en béton **DTU 21** ; diagnostics réglementaires avant travaux (**PEMD** déchets, **amiante**, **plomb/CREP**) et **Code du travail** (étaiement/protection) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [ordre-demolition-etaiement](../../procedures/demolition/ordre-demolition-etaiement.md).
- **Tags** : `metier:demolition famille:gros-oeuvre sous-famille:demolition probleme:effondrement cluster:demolition-partielle cluster:diagnostic type:diagnostic securite:effondrement relation:maconnerie`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
