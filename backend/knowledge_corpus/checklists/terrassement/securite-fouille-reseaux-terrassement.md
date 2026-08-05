# Sécurité — fouilles, réseaux & engins (terrassement)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `securite-fouille-reseaux-terrassement` |
| Titre | Sécurité — fouilles, réseaux & engins (terrassement) |
| Profession | `metier:terrassement` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## Points à vérifier
- [ ] **DICT/AIPR** effectuées ; marquage-piquetage en place. `[A]`
- [ ] **Blindage / talutage** de toute fouille où l'on pénètre (>1,30 m). `[A]`
- [ ] **Jamais** de personnel dans une fouille non protégée (**ensevelissement**). `[A]`
- [ ] **Engins / levage** : zones balisées, angles morts, personne dans le rayon. `[A]`
- [ ] **Bords de fouille** déchargés (déblais/engins à distance). `[A]`
- [ ] **Météo** (pluie) ; **arrêt immédiat** en cas de mouvement de terrain. `[A]`

## Cadre
- **Normes** : terrassements pour le bâtiment **DTU 12** ; fondations superficielles **DTU 13.11 / 13.12** ; réglementation réseaux (**DICT** / guichet unique, **AIPR**) et géotechnique **Eurocode 7 (NF EN 1997)** ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-procedure` → [dict-avant-terrassement](../../procedures/terrassement/dict-avant-terrassement.md).
- **Tags** : `metier:terrassement famille:gros-oeuvre sous-famille:securite type:checklist cluster:securite cluster:blindage cluster:reseaux-enterres securite:effondrement securite:reseaux`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
