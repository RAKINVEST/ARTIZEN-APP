# Permis de feu, réseaux & amiante avant travaux serrurerie/métallerie

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `permis-feu-reseaux-avant-travaux-serrurerie` |
| Titre | Permis de feu, réseaux & amiante avant travaux serrurerie/métallerie |
| Profession | `metier:serrurerie-metallerie` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## But
- Sécuriser les travaux à chaud (soudage/meulage), le percement et l'amiante — sans retrait ni raccordement réglementé. `[A]`

## Étapes
1. **Permis de feu** avant soudage/meulage : éloigner les **combustibles**, **extincteur** à portée, surveillance après travaux. `[A]`
2. **Ventilation/aspiration** des fumées de soudage ; **écran** (rayonnement, protection des tiers). `[A]`
3. **Repérer les réseaux** avant percement/scellement. `[A]`
4. **Raccordement électrique** (gâche/serrure/motorisation) = **interface** Électricité (jamais réalisé ici). `[A]` → [remplacer-prise-courant](../../professions/electricite-generale/cards/remplacer-prise-courant.md)
5. Ouvrages **anciens** : **diagnostic amiante** ; suspect → **arrêt**, retrait par **entreprise certifiée**. `[A]` `relation:desamiantage`

## Cadre
- **Normes** : menuiseries métalliques / ouvrages de métallerie **DTU 37.1** ; électricité (gâche / serrure électrique, **interface**) **NF C 15-100** ; garde-corps **NF P01-012**, serrures / cylindres / anti-effraction **EN 12209 / EN 1303 / EN 1627** et certification **A2P** (CNPP), issues de secours **EN 179 / EN 1125** ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [fabriquer-ouvrage-metallique](../../professions/serrurerie-metallerie/cards/fabriquer-ouvrage-metallique.md).
- **Tags** : `metier:serrurerie-metallerie famille:specialises sous-famille:securite intervention:securiser cluster:soudage cluster:reglementation type:procedure securite:incendie securite:amiante relation:desamiantage relation:electricite-generale`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
