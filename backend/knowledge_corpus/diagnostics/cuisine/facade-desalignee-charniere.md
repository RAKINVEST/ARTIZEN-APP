# Façade désalignée / charnière déréglée

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `facade-desalignee-charniere` |
| Titre | Façade désalignée / charnière déréglée |
| Profession | `metier:cuisine` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:cuisine` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Façades **désalignées**, jeux irréguliers, porte qui frotte, tiroir qui coince. `[C]`

## Causes probables
1. **Charnières/coulisses** à régler (3 axes). `[C]` → [regler-facades-quincaillerie](../../professions/cuisine/cards/regler-facades-quincaillerie.md)
2. **Caisson** non de niveau / non solidarisé. `[C]` → [implanter-poser-caissons](../../professions/cuisine/cards/implanter-poser-caissons.md)
3. Quincaillerie usée / vis desserrées. `[C]`

## Résolution
- Régler charnières/coulisses (alignement/jeux), reprendre le niveau des caissons si besoin. `[C]`

## Cadre
- **Normes** : meubles / caissons (menuiserie intérieure) **DTU 36.2** ; électricité de la cuisine (circuits spécialisés, **interface**) **NF C 15-100** ; plomberie évier / robinetterie (**interface**) **DTU 60.1** ; diagnostic **amiante** (ouvrages anciens) et **ventilation** des appareils ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [regler-facades-quincaillerie](../../professions/cuisine/cards/regler-facades-quincaillerie.md).
- **Tags** : `metier:cuisine famille:finition sous-famille:cuisine probleme:desalignement cluster:reglages-de-facades cluster:diagnostic type:diagnostic securite:manutention`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
