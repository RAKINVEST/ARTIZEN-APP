# Poser une trappe / réparer une plaque

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `poser-trappe-reparer` |
| Titre | Poser une trappe / réparer une plaque |
| Profession | `metier:platrerie` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:platrerie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : poser une **trappe de visite** ou **réparer** une plaque de plâtre endommagée (trou, impact). `[C]`
- **Résumé** : poser une **trappe de visite** (accès réseaux/combles) découpée proprement et cadrée, ou **réparer** une plaque (rebouchage petit trou ; pièce rapportée sur tasseaux pour un trou important) puis bande/enduit et ponçage, prêt à peindre. `[C]` ⟦méthode selon dimension du dégât à confirmer⟧

## Réalisation
- **Étapes** :
  1. **Trappe** : découper proprement ; cadrer ; poser. `[C]`
  2. **Petit trou** : rebouchage enduit + bande. `[C]`
  3. **Trou important** : pièce sur **tasseaux** ; jointoyer. `[C]` → [realiser-bandes-jointoiement](realiser-bandes-jointoiement.md)
  4. Poncer ; prêt à peindre. `[C]`
- **Points critiques** : découpe propre (trappe) ; reprise affleurante ; support de la pièce (tasseaux) ; finition invisible avant peinture.
- **Sécurité** : coupures (cutter/scie) ; poussières ; élec (si percement). **Poussières de plâtre** (découpe/ponçage des bandes) : masque, aspiration, ventilation. **Manutention des plaques** (lourdes/encombrantes) : lève-plaque, binôme, gestes — **TMS**. **Travail en hauteur** (plafonds suspendus) : échafaudage/plateforme, EPI. **Coupures** (cutter, plaques, rails métalliques — arêtes vives) : gants. **Électricité lors des percements** : repérer/consigner circuits et gaines **avant de percer/visser** (risque de percer un câble sous tension) — NF C 15-100. **Amiante en rénovation** : sur un bâti ancien, le **diagnostic amiante avant travaux est obligatoire** ; en présence d'amiante (anciens plâtres/colles/flocages), **arrêt** → le retrait est **réservé à une entreprise certifiée** (activité Désamiantage, **jamais réalisée ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : ouvrages en plaques de plâtre **DTU 25.41** ; doublages / habillages **DTU 25.42** ; plafonds suspendus **DTU 58.1** ; électricité (perc ements / boîtes) **NF C 15-100** ; en rénovation, diagnostic **amiante** avant travaux (Code de la santé) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Diagnostic** : `traite-diagnostic` → [plaque-degradee-humidite](../../../diagnostics/platrerie/plaque-degradee-humidite.md)

## Relations & tags
- **Tags** : `metier:platrerie famille:finition sous-famille:platrerie intervention:reparer cluster:trappes cluster:reparations complexite:simple type:reparation securite:poussieres`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
