# Conduit encrassé / bistre

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `conduit-encrasse-bistre` |
| Titre | Conduit encrassé / bistre |
| Profession | `metier:ramonage` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:ramonage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Conduit **très encrassé**, **bistre** (goudron dur brillant), écoulements, odeur âcre. `[C]`

> **Risque de feu de conduit** : le bistre est **inflammable** → ne pas faire de flambée avant traitement. `[A]`

## Causes probables
1. **Mauvaise combustion** (bois humide, allure réduite, tirage faible). `[C]` → [traiter-bistre-prevenir-feu-conduit](../../professions/ramonage/cards/traiter-bistre-prevenir-feu-conduit.md)
2. Conduit **froid**/mal isolé (condensation des goudrons). `[C]`
3. Ramonage **insuffisant** (fréquence). `[C]` → [entretenir-diagnostiquer-conduit](../../professions/ramonage/cards/entretenir-diagnostiquer-conduit.md)

## Résolution
- **Débistrage** (mécanique/rotatif), conseiller bois sec/bonne combustion, isoler/tuber si conduit froid, ramoner régulièrement. `[C]`

## Cadre
- **Normes** : évacuation des produits de combustion / fumisterie **DTU 24.1** ; âtrerie (cheminées/foyers) **DTU 24.2** ; conduits métalliques **NF EN 1856**, dimensionnement / tirage **NF EN 13384**, obligation de ramonage et **certificat** (**Règlement sanitaire départemental**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [traiter-bistre-prevenir-feu-conduit](../../professions/ramonage/cards/traiter-bistre-prevenir-feu-conduit.md).
- **Tags** : `metier:ramonage famille:specialises sous-famille:ramonage probleme:bistre cluster:bistre cluster:diagnostic type:diagnostic securite:incendie`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
