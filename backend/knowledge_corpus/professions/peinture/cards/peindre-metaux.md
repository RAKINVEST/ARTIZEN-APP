# Peindre les métaux (protection)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `peindre-metaux` |
| Titre | Peindre les métaux (protection) |
| Profession | `metier:peinture` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:peinture` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : peindre des ouvrages **métalliques** (protection anticorrosion + finition). `[C]`
- **Résumé** : préparer le métal (dégraissage, **dérouillage**/brossage, poussières), appliquer un **primaire antirouille** adapté (le fer/l'acier rouille sans protection ; galvanisé/alu = primaires spécifiques), puis la **finition** ; le système anticorrosion dépend de l'exposition (intérieur/extérieur). `[C]` ⟦système anticorrosion/primaire selon métal et exposition à confirmer⟧

## Réalisation
- **Étapes** :
  1. Préparer (dégraissage, **dérouillage**/brossage). `[C]`
  2. **Primaire antirouille** adapté (fer/galva/alu). `[C]` ⟦à confirmer⟧
  3. Finition (épaisseur/nombre de couches selon exposition). `[C]` → [peindre-boiseries-laques](peindre-boiseries-laques.md)
  4. Contrôler l'anticorrosion (pas de point de rouille). `[C]` → [cloquage-ecaillage-peinture](../../../diagnostics/peinture/cloquage-ecaillage-peinture.md)
- **Points critiques** : **primaire adapté au métal** (galva/alu ≠ fer) ; dérouillage ; système selon exposition ; anticorrosion.
- **Sécurité** : COV/solvants (primaires) ; poussières (dérouillage) ; ventilation. **Poussières de ponçage** (enduits/anciennes peintures) : masque adapté, ponçage à **aspiration**, ventilation. **COV et solvants** : privilégier la **phase aqueuse / faible COV**, **ventiler** pendant et après, EPI (masque solvants, gants) — risque respiratoire/neurotoxique. **Inflammabilité** : produits solvantés/aérosols **inflammables** → pas de flamme/source d'ignition ; **chiffons imprégnés = risque d'auto-échauffement** (stockage/immersion). **Travail en hauteur** (plafonds/cages) : échafaudage/plateforme, EPI. **Électricité** : avant de peindre à proximité des appareillages, **couper / déposer et protéger** prises/interrupteurs (ne pas peindre sous tension/sur bornes) — NF C 15-100. **Plomb en rénovation** : sur bâti ancien (avant 1949), **diagnostic plomb (CREP)** avant travaux ; en présence de plomb, **ne pas poncer à sec** (empoussièrement toxique) → **arrêt** ; traitement réservé à une **activité spécialisée** (jamais ici). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : travaux de peinture des bâtiments **DTU 59.1** ; électricité (dépose/protection des appareillages) **NF C 15-100** ; teneur en **COV** (**directive 2004/42/CE**, étiquetage émissions A+/A/B/C), diagnostic **plomb (CREP)** avant travaux (Code de la santé) et prévention (**INRS**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Entretien** : `cite-carte` → [entretenir-reprendre-peinture](entretenir-reprendre-peinture.md)

## Relations & tags
- **Tags** : `metier:peinture famille:finition sous-famille:peinture intervention:realiser cluster:peintures-metalliques complexite:avancee type:realisation securite:cov`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
