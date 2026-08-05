# Peindre murs et plafonds

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `peindre-murs-plafonds` |
| Titre | Peindre murs et plafonds |
| Profession | `metier:peinture` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:peinture` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : appliquer la peinture de finition sur murs et plafonds (mat/satiné/brillant) selon le **DTU 59.1**. `[C]`
- **Résumé** : protéger/**déposer** les appareillages (élec) et masquer, appliquer la finition (rouleau/brosse/pistolet) en **passes croisées** et « humide sur humide » pour éviter les reprises, respecter la couche/l'épaisseur et le nombre de couches, en **ventilant** ; l'aspect (mat masque, brillant révèle) guide la finition. `[C]` ⟦nombre de couches/dilution selon produit à confirmer⟧

## Réalisation
- **Étapes** :
  1. **Déposer/protéger** les appareillages ; masquer. `[A]` → [remplacer-interrupteur-eclairage](../../../professions/electricite-generale/cards/remplacer-interrupteur-eclairage.md)
  2. Appliquer en **passes croisées** / humide sur humide (anti-reprise). `[C]`
  3. Respecter couches/épaisseur ; **ventiler**. `[C]`
  4. Vérifier l'aspect (uniformité/brillance). `[C]` → [defaut-application-peinture](../../../diagnostics/peinture/defaut-application-peinture.md)
- **Points critiques** : éviter les **reprises** (humide sur humide) ; couches respectées ; ventilation ; appareillages déposés/protégés.
- **Sécurité** : COV/solvants ; hauteur (plafonds) ; **électricité** (appareillages). **Poussières de ponçage** (enduits/anciennes peintures) : masque adapté, ponçage à **aspiration**, ventilation. **COV et solvants** : privilégier la **phase aqueuse / faible COV**, **ventiler** pendant et après, EPI (masque solvants, gants) — risque respiratoire/neurotoxique. **Inflammabilité** : produits solvantés/aérosols **inflammables** → pas de flamme/source d'ignition ; **chiffons imprégnés = risque d'auto-échauffement** (stockage/immersion). **Travail en hauteur** (plafonds/cages) : échafaudage/plateforme, EPI. **Électricité** : avant de peindre à proximité des appareillages, **couper / déposer et protéger** prises/interrupteurs (ne pas peindre sous tension/sur bornes) — NF C 15-100. **Plomb en rénovation** : sur bâti ancien (avant 1949), **diagnostic plomb (CREP)** avant travaux ; en présence de plomb, **ne pas poncer à sec** (empoussièrement toxique) → **arrêt** ; traitement réservé à une **activité spécialisée** (jamais ici). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : travaux de peinture des bâtiments **DTU 59.1** ; électricité (dépose/protection des appareillages) **NF C 15-100** ; teneur en **COV** (**directive 2004/42/CE**, étiquetage émissions A+/A/B/C), diagnostic **plomb (CREP)** avant travaux (Code de la santé) et prévention (**INRS**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Boiseries / laques** : `cite-carte` → [peindre-boiseries-laques](peindre-boiseries-laques.md)

## Relations & tags
- **Tags** : `metier:peinture famille:finition sous-famille:peinture intervention:realiser cluster:peintures-murs-et-plafonds cluster:finitions-mates-satinees-brillantes complexite:moyenne type:realisation securite:cov relation:electricite-generale`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
