# Façade / tiroir déréglé

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `facade-tiroir-deregle` |
| Titre | Façade / tiroir déréglé |
| Profession | `metier:agencement` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:agencement` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Façades **désalignées**, tiroir qui coince, porte coulissante qui déraille. `[C]`

## Causes probables
1. **Charnières/coulisses** à régler (3 axes). `[C]` → [installer-regler-quincaillerie-agencement](../../professions/agencement/cards/installer-regler-quincaillerie-agencement.md)
2. Caisson non de niveau / déformé. `[C]` → [fabriquer-poser-caissons-dressing](../../professions/agencement/cards/fabriquer-poser-caissons-dressing.md)
3. Quincaillerie usée / rail de coulissant déréglé. `[C]`

## Résolution
- Régler charnières/coulisses/rails, reprendre le niveau du caisson si besoin. `[C]`

## Cadre
- **Normes** : menuiseries intérieures / meubles en bois **DTU 36.2**, **DTU 36.1** ; électricité (éclairage intégré / percement, **interface**) **NF C 15-100** ; stabilité des meubles de rangement (**EN 14749**), anti-basculement et diagnostic **amiante** (ouvrages anciens) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [installer-regler-quincaillerie-agencement](../../professions/agencement/cards/installer-regler-quincaillerie-agencement.md).
- **Tags** : `metier:agencement famille:finition sous-famille:agencement probleme:desalignement cluster:reglages cluster:diagnostic type:diagnostic securite:manutention`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
