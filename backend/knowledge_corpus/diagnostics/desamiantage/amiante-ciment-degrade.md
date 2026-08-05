# Amiante-ciment / fibrociment dégradé

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `amiante-ciment-degrade` |
| Titre | Amiante-ciment / fibrociment dégradé |
| Profession | `metier:desamiantage` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Plaques ondulées de toiture, ardoises artificielles, conduits ou canalisations en **amiante-ciment** **cassés / moussés / friables**. `[C]`

> **Ne pas nettoyer au jet HP, ne pas découper, ne pas marcher dessus** (chute + fibres) → **arrêt**, baliser, signaler. `[A]`

## Conduite à tenir
1. **Ne pas intervenir** ; interface **Couverture** (toiture). `[A]` → [remplacer-tuiles-ardoises](../../professions/couverture/cards/remplacer-tuiles-ardoises.md)
2. **Signaler** + faire repérer/analyser. `[A]` → [comprendre-reperage-diagnostics](../../professions/desamiantage/cards/comprendre-reperage-diagnostics.md)
3. **Orienter** vers une entreprise certifiée ; déchets = filière dédiée. `[A]`

> Le retrait de toiture amiantée est **réservé** (jamais décrit ici).

## Cadre
- **Normes** : **cadre réglementaire amiante** : **Code du travail** (R.4412-94 et s. — **SS3/SS4**), **Code de la santé publique** (repérage / DTA), **NF X46-020** (repérage avant travaux) et arrêtés (8 avril 2013, 26 juin 2019) ⟦références non détectées — à confirmer par un expert⟧ ; côté **interfaces** où l'amiante est fréquent : conduits / fumisterie **DTU 24.1**, anciens équipements électriques **NF C 15-100** ⟦interfaces, à confirmer⟧ `[B]` ⟦cadre réglementaire à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [reconnaitre-materiaux-mpca](../../professions/desamiantage/cards/reconnaitre-materiaux-mpca.md).
- **Tags** : `metier:desamiantage famille:specialises sous-famille:securite probleme:amiante-ciment cluster:materiaux-mpca cluster:diagnostic type:diagnostic securite:amiante relation:couverture`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
