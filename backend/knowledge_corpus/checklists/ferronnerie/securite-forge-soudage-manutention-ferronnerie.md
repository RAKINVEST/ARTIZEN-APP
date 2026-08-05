# Sécurité — forge, soudage & manutention (ferronnerie)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `securite-forge-soudage-manutention-ferronnerie` |
| Titre | Sécurité — forge, soudage & manutention (ferronnerie) |
| Profession | `metier:ferronnerie` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## Points à vérifier
- [ ] **Forge/chauffe** : métal au rouge = **brûlures** ; pinces/gants cuir/écran ; sol incombustible. `[A]`
- [ ] **Soudage/meulage** : permis de feu, extincteur, combustibles éloignés, surveillance. `[A]`
- [ ] **Fumées métalliques** : ventilation/aspiration, masque ; **rayonnement** → écran. `[A]`
- [ ] **EPI adaptés** : lunettes/écran, gants anti-chaleur/coupure, protection auditive. `[A]`
- [ ] **Manutention** ouvrages lourds : binôme/levage ; **hauteur** à la pose. `[A]`
- [ ] **Réseaux** repérés ; **amiante/plomb** (restauration) = certifié (jamais ici). `[A]`

## Cadre
- **Normes** : ouvrages métalliques (mise en œuvre, **interface** métallerie) **DTU 37.1** ; garde-corps **NF P01-012** ; exécution des structures acier **NF EN 1090**, qualification de soudage **NF EN ISO 9606**, protection anticorrosion **NF EN ISO 12944** ; motorisation éventuelle d'un portail (**interface** Électricité) **NF C 15-100** ⟦EN 1090 / EN ISO 9606 / ISO 12944 et versions exactes en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-procedure` → [permis-feu-forge-reseaux-avant-travaux-ferronnerie](../../procedures/ferronnerie/permis-feu-forge-reseaux-avant-travaux-ferronnerie.md).
- **Tags** : `metier:ferronnerie famille:specialises sous-famille:securite type:checklist cluster:forge cluster:soudage securite:brulure securite:incendie`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
