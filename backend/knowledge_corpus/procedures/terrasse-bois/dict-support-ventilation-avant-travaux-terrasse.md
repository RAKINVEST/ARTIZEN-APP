# DICT, support & ventilation avant travaux de terrasse

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `dict-support-ventilation-avant-travaux-terrasse` |
| Titre | DICT, support & ventilation avant travaux de terrasse |
| Profession | `metier:terrasse-bois` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## But
- Sécuriser les ancrages (réseaux), garantir support/ventilation/drainage et l'amiante — sans raccordement réglementé ni retrait d'amiante. `[A]`

## Étapes
1. **DT-DICT** : repérer les **réseaux** avant ancrage de plots / terrassement. `[A]` → [terrasser-reseaux-dict](../../professions/terrassement/cards/terrasser-reseaux-dict.md)
2. **Support** : portance/planéité vérifiées ; **dalle** = Maçonnerie (interface). `[A]` → [sceller-fixer-maconnerie](../../professions/maconnerie/cards/sceller-fixer-maconnerie.md)
3. **Pente + drainage + ventilation** de sous-face garantis (durée de vie du bois). `[A]`
4. **Éclairage intégré** éventuel = **interface** Électricité (jamais réalisé ici). `[A]`
5. **Rénovation** : ancien support/revêtement → **diagnostic amiante** ; suspect → **arrêt**, retrait = **certifié**. `[A]` `relation:desamiantage`

## Cadre
- **Normes** : platelages extérieurs en bois **DTU 51.4** ; dalle / support béton (**interface** maçonnerie) **DTU 21** ; classes d'emploi du bois **NF EN 335**, durabilité **NF EN 350**, bois composite **NF EN 15534**, éclairage intégré (**interface** électricité) **NF C 15-100** et **DT-DICT** (réseaux) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [etudier-support-implanter](../../professions/terrasse-bois/cards/etudier-support-implanter.md).
- **Tags** : `metier:terrasse-bois famille:specialises sous-famille:securite intervention:securiser cluster:support cluster:reglementation type:procedure securite:reseaux securite:amiante relation:desamiantage relation:maconnerie relation:terrassement`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
