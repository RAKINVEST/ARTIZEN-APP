# Préparer le support (ponçage, dépoussiérage)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `preparer-support-peinture` |
| Titre | Préparer le support (ponçage, dépoussiérage) |
| Profession | `metier:peinture` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:peinture` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : préparer le support avant peinture : nettoyage, **ponçage**, dépoussiérage, traitement des défauts. `[C]`
- **Résumé** : diagnostiquer le support (ancien/neuf, adhérence, humidité), le nettoyer/**dégraisser**, **poncer** (aspiration), reboucher/ratisser si besoin, dépoussiérer soigneusement, et vérifier qu'il est **sec et sain** ; en rénovation ancienne, **diagnostic plomb** préalable (pas de ponçage à sec si plomb). `[C]` ⟦préparation selon support à confirmer⟧

## Réalisation
- **Étapes** :
  1. Diagnostiquer le support (adhérence/humidité). `[C]` → [cloquage-ecaillage-peinture](../../../diagnostics/peinture/cloquage-ecaillage-peinture.md)
  2. Nettoyer/dégraisser ; **poncer** (aspiration) ; reboucher. `[C]` → [reboucher-ratisser-enduire](reboucher-ratisser-enduire.md)
  3. **Dépoussiérer** ; vérifier support **sec et sain**. `[C]`
  4. Rénovation ancienne : **diagnostic plomb** (CREP). `[A]` → [diagnostic-plomb-cov-avant-travaux](../../../procedures/peinture/diagnostic-plomb-cov-avant-travaux.md)
- **Points critiques** : support **sec/sain/propre** (85 % du résultat) ; ponçage aspiré ; **plomb** en rénovation (pas de ponçage à sec).
- **Sécurité** : **poussières** (dont plomb) ; COV (dégraissants) ; hauteur. **Poussières de ponçage** (enduits/anciennes peintures) : masque adapté, ponçage à **aspiration**, ventilation. **COV et solvants** : privilégier la **phase aqueuse / faible COV**, **ventiler** pendant et après, EPI (masque solvants, gants) — risque respiratoire/neurotoxique. **Inflammabilité** : produits solvantés/aérosols **inflammables** → pas de flamme/source d'ignition ; **chiffons imprégnés = risque d'auto-échauffement** (stockage/immersion). **Travail en hauteur** (plafonds/cages) : échafaudage/plateforme, EPI. **Électricité** : avant de peindre à proximité des appareillages, **couper / déposer et protéger** prises/interrupteurs (ne pas peindre sous tension/sur bornes) — NF C 15-100. **Plomb en rénovation** : sur bâti ancien (avant 1949), **diagnostic plomb (CREP)** avant travaux ; en présence de plomb, **ne pas poncer à sec** (empoussièrement toxique) → **arrêt** ; traitement réservé à une **activité spécialisée** (jamais ici). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : travaux de peinture des bâtiments **DTU 59.1** ; électricité (dépose/protection des appareillages) **NF C 15-100** ; teneur en **COV** (**directive 2004/42/CE**, étiquetage émissions A+/A/B/C), diagnostic **plomb (CREP)** avant travaux (Code de la santé) et prévention (**INRS**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Impression** : `cite-carte` → [appliquer-impression](appliquer-impression.md)

## Relations & tags
- **Tags** : `metier:peinture famille:finition sous-famille:peinture intervention:realiser cluster:preparation-des-supports cluster:poncage complexite:moyenne type:realisation securite:poussieres`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
