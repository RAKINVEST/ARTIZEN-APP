# Isoler des combles

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `isoler-combles` |
| Titre | Isoler des combles |
| Profession | `metier:isolation` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:isolation` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : isoler des combles (perdus par soufflage/déroulé, ou aménagés sous rampants) en assurant continuité et ventilation. `[C]`
- **Résumé** : préparer le comble (contrôle charpente, ventilation, réseaux), poser l'isolant (soufflage vrac ou déroulé/panneaux sous rampants) à l'épaisseur visée, gérer le **pare/frein-vapeur** et la ventilation de sous-toiture. `[C]` ⟦épaisseur/R visé selon réglementation à confirmer⟧

## Réalisation
- **Étapes** :
  1. Contrôler la **charpente**/support et la ventilation de toiture. `[C]` → [inspecter-charpente](../../../professions/charpente/cards/inspecter-charpente.md)
  2. Protéger les points sensibles (spots, conduits) ; conserver la **ventilation de sous-toiture**. `[C]` → [principe-couverture](../../../professions/couverture/cards/principe-couverture.md)
  3. Poser l'isolant (**soufflage** vrac / **déroulé** / panneaux sous rampants). `[C]`
  4. Assurer **pare/frein-vapeur** côté chaud et la continuité. `[C]` → [poser-pare-vapeur](poser-pare-vapeur.md)
- **Points critiques** : ne pas obstruer la **ventilation de sous-toiture** ; épaisseur/R visé ; circuler **uniquement sur zones porteuses**.
- **Sécurité** : poussières/fibres (respiratoire) ; hauteur/comble (chute à travers plafond) ; éclairage. **Poussières et fibres** (laines minérales/bois, ouate) : risque **respiratoire** — **EPI adaptés** (masque FFP adapté, combinaison, gants, lunettes), ventilation du chantier. **Travail en hauteur** (combles, murs) : **stabilité des supports** (circuler uniquement sur zones porteuses — risque de **chute à travers le plafond**). **Humidité / moisissures** : traiter la cause **avant** d'isoler (jamais isoler sur support humide/moisi). **Arrêt immédiat en cas de danger.** Une intervention relève de **compétences adaptées**.** `[A]`

## Cadre & suites
- **Normes** : isolation des combles par soufflage **DTU 45.10** ; isolation thermique de combles **DTU 45.11** ; doublage / plaques de plâtre (isolation intérieure) **DTU 25.41** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Contrôle continuité** : `cite-procedure` → [controle-continuite-isolation](../../../procedures/isolation/controle-continuite-isolation.md)

## Relations & tags
- **Tags** : `metier:isolation famille:enveloppe sous-famille:isolation intervention:poser intervention:realiser cluster:isolation-des-combles cluster:laine-minerale cluster:ouate-de-cellulose complexite:moyenne type:installation securite:respiratoire securite:hauteur relation:charpente relation:couverture`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
