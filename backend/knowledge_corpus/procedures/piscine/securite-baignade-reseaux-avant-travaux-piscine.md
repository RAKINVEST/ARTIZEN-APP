# Sécurité anti-noyade, réseaux & amiante avant/pendant travaux piscine

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `securite-baignade-reseaux-avant-travaux-piscine` |
| Titre | Sécurité anti-noyade, réseaux & amiante avant/pendant travaux piscine |
| Profession | `metier:piscine` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## But
- Sécuriser le chantier piscine (noyade, fouille, réseaux, électricité, amiante) sans jamais réaliser un retrait ni un raccordement réglementé. `[A]`

## Étapes
1. **Anti-noyade** : bassin/fouille en eau **jamais laissé accessible** ; dispositif de sécurité normalisé opérationnel **avant mise en eau**. `[A]` → [securiser-piscine-dispositifs](../../professions/piscine/cards/securiser-piscine-dispositifs.md)
2. **Fouille** : blindage/talutage (interface Terrassement). `[A]` → [blinder-securiser-fouille](../../professions/terrassement/cards/blinder-securiser-fouille.md)
3. **Électricité** : raccordement/liaison équipotentielle/volumes = **interface** Électricité (jamais réalisé ici). `[A]`
4. **Produits** : chlore/acide **jamais mélangés** ; local ventilé. `[A]`
5. Ouvrages **anciens** : **diagnostic amiante** ; suspect → **arrêt**, retrait par **entreprise certifiée**. `[A]` `relation:desamiantage`

## Cadre
- **Normes** : sécurité électrique des piscines (volumes 0/1/2, liaison équipotentielle) **NF C 15-100** (partie 7-702) ; structure béton du bassin (**interface** maçonnerie) **DTU 21** ; **sécurité des piscines** — barrières / alarmes / couvertures / abris **NF P 90-306 à 90-309** et **obligation légale** (Code de la construction), norme européenne **NF EN 16582** ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [securiser-piscine-dispositifs](../../professions/piscine/cards/securiser-piscine-dispositifs.md).
- **Tags** : `metier:piscine famille:specialises sous-famille:securite intervention:securiser cluster:securite cluster:reglementation type:procedure securite:noyade securite:amiante relation:desamiantage relation:terrassement relation:electricite-generale`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
