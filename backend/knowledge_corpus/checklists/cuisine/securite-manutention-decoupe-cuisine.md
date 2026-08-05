# Sécurité — manutention, découpe & interfaces (cuisine)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `securite-manutention-decoupe-cuisine` |
| Titre | Sécurité — manutention, découpe & interfaces (cuisine) |
| Profession | `metier:cuisine` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## Points à vérifier
- [ ] **Manutention des plans** (pierre/quartz lourds) : ventouses/binôme. `[A]`
- [ ] **Découpes** : **silice** (pierre → eau/aspiration) et **bois** (aspiration/masque). `[A]`
- [ ] **Machines électroportatives** : capots/entretien ; **bruit**. `[A]`
- [ ] **Repérage réseaux** avant percement ; **fixation** meubles hauts (chute). `[A]`
- [ ] **Raccordements** eau/élec = **interfaces** (Plomberie/Élec) ; **ventilation** des appareils. `[A]`
- [ ] **Amiante** (rénovation) : diagnostic ; retrait = **certifié** (jamais ici) ; **arrêt** si danger. `[A]`

## Cadre
- **Normes** : meubles / caissons (menuiserie intérieure) **DTU 36.2** ; électricité de la cuisine (circuits spécialisés, **interface**) **NF C 15-100** ; plomberie évier / robinetterie (**interface**) **DTU 60.1** ; diagnostic **amiante** (ouvrages anciens) et **ventilation** des appareils ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-procedure` → [reperage-reseaux-amiante-avant-pose-cuisine](../../procedures/cuisine/reperage-reseaux-amiante-avant-pose-cuisine.md).
- **Tags** : `metier:cuisine famille:finition sous-famille:securite type:checklist cluster:decoupes securite:silice securite:amiante`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
