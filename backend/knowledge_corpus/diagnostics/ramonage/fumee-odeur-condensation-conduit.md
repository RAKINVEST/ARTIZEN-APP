# Fumée / odeur / condensation dans le logement

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `fumee-odeur-condensation-conduit` |
| Titre | Fumée / odeur / condensation dans le logement |
| Profession | `metier:ramonage` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:ramonage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- **Odeur** de fumée/suie, **traces d'humidité** ou de goudron sur le conduit intérieur, taches au plafond. `[C]`

## Causes probables
1. **Étanchéité** du conduit défaillante (fissures, joints). `[C]` → [tuber-mettre-en-conformite-conduit](../../professions/ramonage/cards/tuber-mettre-en-conformite-conduit.md)
2. **Condensation** (conduit froid, appareil basse température sur conduit inadapté). `[C]`
3. **Débouché/souche** en toiture défectueux (→ Couvreur). `[C]` → [traiter-noues-emergences](../../professions/couverture/cards/traiter-noues-emergences.md)

## Résolution
- Étancher/**tuber** le conduit, adapter au type d'appareil (condensation), reprendre la souche (Couvreur) ; contrôle CO. `[C]`

## Cadre
- **Normes** : évacuation des produits de combustion / fumisterie **DTU 24.1** ; âtrerie (cheminées/foyers) **DTU 24.2** ; conduits métalliques **NF EN 1856**, dimensionnement / tirage **NF EN 13384**, obligation de ramonage et **certificat** (**Règlement sanitaire départemental**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [tuber-mettre-en-conformite-conduit](../../professions/ramonage/cards/tuber-mettre-en-conformite-conduit.md).
- **Tags** : `metier:ramonage famille:specialises sous-famille:ramonage probleme:etancheite cluster:conduits-de-fumee cluster:diagnostic type:diagnostic securite:monoxyde relation:couverture`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
