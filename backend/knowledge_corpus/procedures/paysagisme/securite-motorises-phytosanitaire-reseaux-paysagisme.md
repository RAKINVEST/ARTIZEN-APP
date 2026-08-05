# Sécurité outils motorisés, phytosanitaire & réseaux avant travaux paysagers

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `securite-motorises-phytosanitaire-reseaux-paysagisme` |
| Titre | Sécurité outils motorisés, phytosanitaire & réseaux avant travaux paysagers |
| Profession | `metier:paysagisme` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## But
- Sécuriser l'usage des outils motorisés, l'emploi des phytosanitaires, le terrassement léger et la biodiversité — sans retrait d'amiante. `[A]`

## Étapes
1. **Outils motorisés** : **tronçonneuse** (EPI anti-coupure, technique anti-rebond), **débroussailleuse** (écran, périmètre) ; formation. `[A]`
2. **Phytosanitaire** : **Certiphyto**, **ZNT**, protection de l'eau ; privilégier les alternatives ; EPI/stockage. `[A]`
3. **Terrassement léger** : **repérer les réseaux** (DICT si concerné) avant de creuser. `[A]` → [terrasser-reseaux-dict](../../professions/terrassement/cards/terrasser-reseaux-dict.md)
4. **Biodiversité** : respecter les **périodes de taille** (nidification) et espèces protégées. `[A]`
5. **Hauteur** (élagage grimpé) : métier spécialisé (cordiste). `[A]`
6. **Rénovation** : revêtements anciens → **diagnostic amiante** ; retrait = **certifié**. `[A]` `relation:desamiantage`

## Cadre
- **Normes** : petits ouvrages maçonnés / soutènements légers (**interface** maçonnerie) **DTU 20.1** ; évacuation / gestion des **eaux pluviales** (**interface**) **DTU 60.11** ; **Règles professionnelles des travaux du paysage** (UNEP/QUALIPAYSAGE), supports de culture **NF U44-551**, réglementation **phytosanitaire** (Certiphyto, ZNT) et **périodes de taille** (Code de l'environnement, nidification) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [tailler-entretenir-espaces-verts](../../professions/paysagisme/cards/tailler-entretenir-espaces-verts.md).
- **Tags** : `metier:paysagisme famille:specialises sous-famille:securite intervention:securiser cluster:securite cluster:biodiversite type:procedure securite:outils-motorises securite:amiante relation:desamiantage relation:terrassement relation:cordiste`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
