# Principe de la peinture (systèmes & finitions)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `principe-peinture` |
| Titre | Principe de la peinture (systèmes & finitions) |
| Profession | `metier:peinture` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:peinture` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : comprendre un système de peinture : **préparation → impression → finition**, selon le support et l'aspect visé. `[C]`
- **Résumé** : peindre, c'est appliquer un **système** adapté au **support** (plâtre, bois, métal) : **préparation** (rebouchage/ponçage), **impression** (accrochage), puis **finition** dans l'aspect choisi (**mat / satiné / brillant**, laque) ; le support (issu de la **Plâtrerie**) conditionne le résultat — la peinture révèle les défauts. `[C]` ⟦système/aspect selon support et local à confirmer⟧

## Réalisation
- **Étapes** :
  1. **Préparer** le support (le point clé). `[C]` → [preparer-support-peinture](preparer-support-peinture.md)
  2. **Impression** (primaire d'accrochage). `[C]` → [appliquer-impression](appliquer-impression.md)
  3. **Finition** (mat/satiné/brillant) sur murs/plafonds. `[C]` → [peindre-murs-plafonds](peindre-murs-plafonds.md)
  4. Support issu de la **Plâtrerie** (bandes/enduit). `[C]` → [realiser-bandes-jointoiement](../../../professions/platrerie/cards/realiser-bandes-jointoiement.md)
- **Points critiques** : **support** adapté/sain (la finition révèle tout) ; système cohérent (impression/finition) ; aspect selon usage.
- **Sécurité** : poussières/COV ; hauteur ; — **Poussières de ponçage** (enduits/anciennes peintures) : masque adapté, ponçage à **aspiration**, ventilation. **COV et solvants** : privilégier la **phase aqueuse / faible COV**, **ventiler** pendant et après, EPI (masque solvants, gants) — risque respiratoire/neurotoxique. **Inflammabilité** : produits solvantés/aérosols **inflammables** → pas de flamme/source d'ignition ; **chiffons imprégnés = risque d'auto-échauffement** (stockage/immersion). **Travail en hauteur** (plafonds/cages) : échafaudage/plateforme, EPI. **Électricité** : avant de peindre à proximité des appareillages, **couper / déposer et protéger** prises/interrupteurs (ne pas peindre sous tension/sur bornes) — NF C 15-100. **Plomb en rénovation** : sur bâti ancien (avant 1949), **diagnostic plomb (CREP)** avant travaux ; en présence de plomb, **ne pas poncer à sec** (empoussièrement toxique) → **arrêt** ; traitement réservé à une **activité spécialisée** (jamais ici). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : travaux de peinture des bâtiments **DTU 59.1** ; électricité (dépose/protection des appareillages) **NF C 15-100** ; teneur en **COV** (**directive 2004/42/CE**, étiquetage émissions A+/A/B/C), diagnostic **plomb (CREP)** avant travaux (Code de la santé) et prévention (**INRS**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Entretien / reprises** : `cite-carte` → [entretenir-reprendre-peinture](entretenir-reprendre-peinture.md)

## Relations & tags
- **Tags** : `metier:peinture famille:finition sous-famille:peinture intervention:comprendre cluster:preparation-des-supports cluster:impression cluster:finitions-mates-satinees-brillantes type:principe securite:cov relation:platrerie`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
