# Pression d'eau insuffisante

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `pression-eau-insuffisante` |
| Titre | Pression d'eau insuffisante |
| Profession | `metier:plomberie` |
| Famille | `famille:fluides` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Débit faible à un ou plusieurs points de puisage. `[C]`

## Causes probables
1. **Mousseur/cartouche entartré** (point unique). `[C]` → [remplacer-cartouche-mitigeur](../../professions/plomberie/cards/remplacer-cartouche-mitigeur.md)
2. Réducteur de pression déréglé ou filtre colmaté (toute l'installation). `[C]`
3. Vanne partiellement fermée / réseau entartré. `[C]`

## Démarche de diagnostic
- Comparer point unique vs général ; mesurer la pression au manomètre ; contrôler filtre et réducteur. `[C]`

## Résolution
- Détartrer le point concerné, nettoyer le filtre, régler/remplacer le réducteur. `[C]`
- Contrôle global du réseau si généralisé. → [controler-etancheite-reseau](../../professions/plomberie/cards/controler-etancheite-reseau.md)

## Cadre
- **Normes** : dimensionnement / pression — **DTU 60.11** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic`.
- **Tags** : `metier:plomberie famille:fluides probleme:pression probleme:debit probleme:calcaire equipement:reseau type:diagnostic`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
