# Peindre boiseries et appliquer des laques

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `peindre-boiseries-laques` |
| Titre | Peindre boiseries et appliquer des laques |
| Profession | `metier:peinture` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:peinture` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : peindre des **boiseries** (portes, plinthes, huisseries) et appliquer des **laques** (finition tendue). `[C]`
- **Résumé** : préparer le bois (**égrenage**, rebouchage, sous-couche adaptée), appliquer la **laque** (glycéro ou **aqueuse**) en couches fines tendues, en égrenant entre couches pour une finition lisse, en soignant l'absence de coul ures ; privilégier les produits **faible COV**. `[C]` ⟦système laque/sous-couche selon bois à confirmer⟧

## Réalisation
- **Étapes** :
  1. Préparer le bois (**égrenage**, rebouchage, sous-couche). `[C]` → [preparer-support-peinture](preparer-support-peinture.md)
  2. Appliquer la **laque** en couches fines **tendues**. `[C]`
  3. Égrener entre couches ; éviter coulures. `[C]`
  4. Contrôler la finition (tendu/brillance). `[C]` → [defaut-application-peinture](../../../diagnostics/peinture/defaut-application-peinture.md)
- **Points critiques** : égrenage entre couches (tendu) ; couches fines (anti-coulure) ; sous-couche adaptée ; produits faible COV.
- **Sécurité** : COV/solvants (glycéro) ; ventilation ; poussières. **Poussières de ponçage** (enduits/anciennes peintures) : masque adapté, ponçage à **aspiration**, ventilation. **COV et solvants** : privilégier la **phase aqueuse / faible COV**, **ventiler** pendant et après, EPI (masque solvants, gants) — risque respiratoire/neurotoxique. **Inflammabilité** : produits solvantés/aérosols **inflammables** → pas de flamme/source d'ignition ; **chiffons imprégnés = risque d'auto-échauffement** (stockage/immersion). **Travail en hauteur** (plafonds/cages) : échafaudage/plateforme, EPI. **Électricité** : avant de peindre à proximité des appareillages, **couper / déposer et protéger** prises/interrupteurs (ne pas peindre sous tension/sur bornes) — NF C 15-100. **Plomb en rénovation** : sur bâti ancien (avant 1949), **diagnostic plomb (CREP)** avant travaux ; en présence de plomb, **ne pas poncer à sec** (empoussièrement toxique) → **arrêt** ; traitement réservé à une **activité spécialisée** (jamais ici). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : travaux de peinture des bâtiments **DTU 59.1** ; électricité (dépose/protection des appareillages) **NF C 15-100** ; teneur en **COV** (**directive 2004/42/CE**, étiquetage émissions A+/A/B/C), diagnostic **plomb (CREP)** avant travaux (Code de la santé) et prévention (**INRS**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Métaux** : `cite-carte` → [peindre-metaux](peindre-metaux.md)

## Relations & tags
- **Tags** : `metier:peinture famille:finition sous-famille:peinture intervention:realiser cluster:peintures-boiseries cluster:laques complexite:avancee type:realisation securite:cov`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
