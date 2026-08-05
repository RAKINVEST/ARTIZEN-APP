# Feu de forge, permis de feu & réseaux avant travaux de ferronnerie

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `permis-feu-forge-reseaux-avant-travaux-ferronnerie` |
| Titre | Feu de forge, permis de feu & réseaux avant travaux de ferronnerie |
| Profession | `metier:ferronnerie` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## But
- Sécuriser la forge et les travaux à chaud (soudage/meulage), le percement et l'amiante/plomb — sans retrait ni raccordement réglementé. `[A]`

## Étapes
1. **Feu de forge / poste à chaud** : sol incombustible, extincteur, combustibles éloignés ; métal au rouge = **brûlures**. `[A]`
2. **Permis de feu** (soudage/meulage) : surveillance pendant/après ; **fumées** aspirées ; écran. `[A]`
3. **Repérer les réseaux** avant scellement/percement à la pose. `[A]`
4. **Restauration** : revêtements anciens → **diagnostic amiante / plomb** avant décapage/chauffe ; suspect → **arrêt**, retrait = **certifié**. `[A]` `relation:desamiantage`
5. **Raccordement électrique** (motorisation éventuelle) = **interface** Électricité (jamais réalisé ici). `[A]`

## Cadre
- **Normes** : ouvrages métalliques (mise en œuvre, **interface** métallerie) **DTU 37.1** ; garde-corps **NF P01-012** ; exécution des structures acier **NF EN 1090**, qualification de soudage **NF EN ISO 9606**, protection anticorrosion **NF EN ISO 12944** ; motorisation éventuelle d'un portail (**interface** Électricité) **NF C 15-100** ⟦EN 1090 / EN ISO 9606 / ISO 12944 et versions exactes en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [assembler-souder-ouvrage](../../professions/ferronnerie/cards/assembler-souder-ouvrage.md).
- **Tags** : `metier:ferronnerie famille:specialises sous-famille:securite intervention:securiser cluster:soudage cluster:forge type:procedure securite:incendie securite:amiante relation:desamiantage`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
