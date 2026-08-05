# Reboucher, ratisser, enduire

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `reboucher-ratisser-enduire` |
| Titre | Reboucher, ratisser, enduire |
| Profession | `metier:peinture` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:peinture` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : traiter la planéité : **rebouchage** des trous, **ratissage** et **enduits de finition** pour un support prêt à peindre. `[C]`
- **Résumé** : reboucher fissures/trous (enduit de rebouchage), **ratisser** pour égaliser, appliquer un **enduit de finition** (lissage) sur les défauts ou en pleine surface selon le niveau visé, poncer entre les passes (aspiration) et dépoussiérer ; le niveau de finition dépend de l'éclairage/l'aspect (mat masque, brillant révèle). `[C]` ⟦niveau de finition selon exigence à confirmer⟧

## Réalisation
- **Étapes** :
  1. **Reboucher** trous/fissures (enduit de rebouchage). `[C]`
  2. **Ratisser** / **enduit de finition** (égalisation/lissage). `[C]`
  3. Poncer entre passes (**aspiration**) ; dépoussiérer. `[C]` → [preparer-support-peinture](preparer-support-peinture.md)
  4. Adapter le **niveau de finition** à l'aspect (mat/brillant). `[C]`
- **Points critiques** : planéité (le brillant révèle) ; séchage entre passes ; niveau de finition adapté ; poussières de ponçage.
- **Sécurité** : **poussières** ; postures/TMS ; — **Poussières de ponçage** (enduits/anciennes peintures) : masque adapté, ponçage à **aspiration**, ventilation. **COV et solvants** : privilégier la **phase aqueuse / faible COV**, **ventiler** pendant et après, EPI (masque solvants, gants) — risque respiratoire/neurotoxique. **Inflammabilité** : produits solvantés/aérosols **inflammables** → pas de flamme/source d'ignition ; **chiffons imprégnés = risque d'auto-échauffement** (stockage/immersion). **Travail en hauteur** (plafonds/cages) : échafaudage/plateforme, EPI. **Électricité** : avant de peindre à proximité des appareillages, **couper / déposer et protéger** prises/interrupteurs (ne pas peindre sous tension/sur bornes) — NF C 15-100. **Plomb en rénovation** : sur bâti ancien (avant 1949), **diagnostic plomb (CREP)** avant travaux ; en présence de plomb, **ne pas poncer à sec** (empoussièrement toxique) → **arrêt** ; traitement réservé à une **activité spécialisée** (jamais ici). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : travaux de peinture des bâtiments **DTU 59.1** ; électricité (dépose/protection des appareillages) **NF C 15-100** ; teneur en **COV** (**directive 2004/42/CE**, étiquetage émissions A+/A/B/C), diagnostic **plomb (CREP)** avant travaux (Code de la santé) et prévention (**INRS**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Défauts d'aspect** : `traite-diagnostic` → [defaut-application-peinture](../../../diagnostics/peinture/defaut-application-peinture.md)

## Relations & tags
- **Tags** : `metier:peinture famille:finition sous-famille:peinture intervention:realiser cluster:enduits-de-finition cluster:rebouchage cluster:ratissage complexite:moyenne type:realisation securite:poussieres`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
