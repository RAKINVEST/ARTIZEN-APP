# Repérage réseaux & amiante avant pose de cuisine

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `reperage-reseaux-amiante-avant-pose-cuisine` |
| Titre | Repérage réseaux & amiante avant pose de cuisine |
| Profession | `metier:cuisine` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## But
- Sécuriser les perçages/découpes (réseaux) et, en rénovation, l'amiante — sans jamais réaliser retrait ni raccordement réglementé. `[A]`

## Étapes
1. **Repérer les réseaux** (élec/eau/gaz) avant de percer/découper (meubles hauts, plan). `[A]` → [remplacer-prise-courant](../../professions/electricite-generale/cards/remplacer-prise-courant.md)
2. **Raccordements** eau/élec = **interfaces** → Plomberie / Électricité (jamais décrits/réalisés ici). `[A]`
3. Ouvrages **anciens** : **diagnostic amiante avant travaux**. `[A]` `relation:desamiantage`
4. Matériau **suspect** → **arrêt** ; retrait par **entreprise certifiée**. `[A]`

> Percer sans repérer = risque électrique/gaz ; **raccordements** et **retrait d'amiante** ne sont **jamais** réalisés en pose de cuisine. `[A]`

## Cadre
- **Normes** : meubles / caissons (menuiserie intérieure) **DTU 36.2** ; électricité de la cuisine (circuits spécialisés, **interface**) **NF C 15-100** ; plomberie évier / robinetterie (**interface**) **DTU 60.1** ; diagnostic **amiante** (ouvrages anciens) et **ventilation** des appareils ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [implanter-poser-caissons](../../professions/cuisine/cards/implanter-poser-caissons.md).
- **Tags** : `metier:cuisine famille:finition sous-famille:securite intervention:controler cluster:implantation-de-cuisine cluster:reglementation type:procedure securite:electrique securite:amiante relation:desamiantage relation:plomberie relation:electricite-generale`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
