# Principe de l'isolation thermique (ITI, ITE, matériaux, R/λ)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `principe-isolation` |
| Titre | Principe de l'isolation thermique (ITI, ITE, matériaux, R/λ) |
| Profession | `metier:isolation` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:isolation` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : comprendre le rôle de l'isolation (réduire les déperditions), les stratégies (intérieure vs extérieure) et les indicateurs (R, λ). `[C]`
- **Résumé** : l'isolation réduit les déperditions et supprime les **ponts thermiques** ; deux stratégies : **ITI** (intérieure) et **ITE** (extérieure — activité dédiée `isolation-exterieure`, finition **façade**) ; performance mesurée par **R** (résistance) et **λ** (conductivité). `[C]` ⟦R visés selon paroi/réglementation à confirmer⟧

## Réalisation
- **Étapes** :
  1. **Combles** (souvent le meilleur ratio). `[C]` → [isoler-combles](isoler-combles.md)
  2. **Murs** : ITI (doublage) ou **ITE** (finition façade, `relation:facade`). `[C]` → [controler-ite-facade](../../../professions/facade/cards/controler-ite-facade.md)
  3. **Planchers** (bas / entre étages). `[C]` → [isoler-planchers](isoler-planchers.md)
  4. Choix du **matériau** (R/λ, comportement à la vapeur). `[C]` → [choisir-isolant](choisir-isolant.md)
- **Points critiques** : supprimer les **ponts thermiques** et assurer la **continuité** ; gérer la vapeur d'eau ; ne pas dégrader la ventilation.
- **Sécurité** : poussières/fibres ; hauteur (combles) ; humidité. **Poussières et fibres** (laines minérales/bois, ouate) : risque **respiratoire** — **EPI adaptés** (masque FFP adapté, combinaison, gants, lunettes), ventilation du chantier. **Travail en hauteur** (combles, murs) : **stabilité des supports** (circuler uniquement sur zones porteuses — risque de **chute à travers le plafond**). **Humidité / moisissures** : traiter la cause **avant** d'isoler (jamais isoler sur support humide/moisi). **Arrêt immédiat en cas de danger.** Une intervention relève de **compétences adaptées**.** `[A]`

## Cadre & suites
- **Normes** : isolation des combles par soufflage **DTU 45.10** ; isolation thermique de combles **DTU 45.11** ; doublage / plaques de plâtre (isolation intérieure) **DTU 25.41** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Ponts thermiques** : `cite-carte` → [traiter-ponts-thermiques](traiter-ponts-thermiques.md)

## Relations & tags
- **Tags** : `metier:isolation famille:enveloppe sous-famille:isolation intervention:comprendre cluster:isolation-interieure cluster:isolation-exterieure cluster:isolation-des-combles cluster:isolation-des-murs cluster:ponts-thermiques type:principe securite:respiratoire relation:facade relation:etancheite`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
