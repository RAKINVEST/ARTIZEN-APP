# Sécurité — entrée en espace confiné (assainissement)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `securite-espace-confine-assainissement` |
| Titre | Sécurité — entrée en espace confiné (assainissement) |
| Profession | `metier:assainissement` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## But
- Encadrer toute intervention en **espace confiné** (regard, poste, fosse) — risque **mortel**. `[A]`

## Étapes (opération réservée à des intervenants formés/équipés)
1. **Privilégier l'intervention depuis la surface** (caméra, perche) — éviter la descente. `[A]`
2. Si descente inévitable : **détection d'atmosphère** (O₂, **H₂S**, LIE) + **ventilation forcée**. `[A]` ⟦seuils/matériel à confirmer⟧
3. **Surveillant** en permanence à l'extérieur ; **harnais + treuil** ; moyens de secours. `[A]`
4. Autorisation/procédure ; **arrêt immédiat** si alarme. `[A]`

> Une entrée en espace confiné sans détection/ventilation/surveillant = **accident mortel** (H₂S/anoxie). Réservé aux **professionnels qualifiés**. `[A]`

## Cadre
- **Normes** : assainissement non collectif **DTU 64.1** ; évacuation EU/EP **DTU 60.11** ; mise en œuvre/essais des collecteurs **NF EN 1610**, réglementation ANC (**arrêté du 7 sept. 2009**, contrôle **SPANC**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [entretenir-vidanger-assainissement](../../professions/assainissement/cards/entretenir-vidanger-assainissement.md).
- **Tags** : `metier:assainissement famille:gros-oeuvre sous-famille:securite intervention:securiser cluster:securite cluster:postes-de-relevage type:procedure securite:confine`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
