# Végétal qui dépérit / jaunit

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `vegetal-deperit-jaunit` |
| Titre | Végétal qui dépérit / jaunit |
| Profession | `metier:paysagisme` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:paysagisme` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Végétal qui **jaunit**, se dessèche, ne reprend pas, feuillage clé. `[C]`

## Causes probables
1. **Plantation** (collet enterré, fosse trop petite, arrosage de reprise insuffisant). `[C]` → [planter-arbres-arbustes-vivaces](../../professions/paysagisme/cards/planter-arbres-arbustes-vivaces.md)
2. **Sol** inadapté (pH, drainage, compaction). `[C]` → [preparer-ameliorer-sol](../../professions/paysagisme/cards/preparer-ameliorer-sol.md)
3. Excès/manque d'**eau**, maladie/ravageur, espèce inadaptée. `[C]`

## Résolution
- Corriger niveau du collet/arrosage, améliorer le sol/drainage, adapter l'espèce à l'exposition ; traiter (méthodes encadrées). `[C]`

## Cadre
- **Normes** : petits ouvrages maçonnés / soutènements légers (**interface** maçonnerie) **DTU 20.1** ; évacuation / gestion des **eaux pluviales** (**interface**) **DTU 60.11** ; **Règles professionnelles des travaux du paysage** (UNEP/QUALIPAYSAGE), supports de culture **NF U44-551**, réglementation **phytosanitaire** (Certiphyto, ZNT) et **périodes de taille** (Code de l'environnement, nidification) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [planter-arbres-arbustes-vivaces](../../professions/paysagisme/cards/planter-arbres-arbustes-vivaces.md).
- **Tags** : `metier:paysagisme famille:specialises sous-famille:paysagisme probleme:deperissement cluster:plantations cluster:diagnostic type:diagnostic securite:manutention`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
