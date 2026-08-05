# Schedule

> **Version** 1.0 — **Status** Frozen — **Owner** Mission — **Last Update** 2026-08-02
> **Depends On:** [../OBJECT_CATALOG.md](../OBJECT_CATALOG.md) — **Used By:** engines, events — **Niveau:** 2 · Architecture

## Nom
Schedule

## Mission
La planification d'une Mission (créneaux, intervenants).

## Description
La planification d'une Mission (créneaux, intervenants).

## Responsabilité
Responsabilité **unique** : La planification d'une Mission (créneaux, intervenants). Aucune autre.

## Pourquoi cet objet existe
Il porte une signification métier propre qu'aucun autre objet ne doit assumer (Loi 1 : source unique).

## Pourquoi il est indépendant
Frontière de cohérence distincte ; il référence les autres par id (Loi 1/11), sans les contenir.

## Moteur propriétaire
**Mission** (unique — Loi 1 ; aucun propriétaire secondaire).

## Autres moteurs autorisés
Moteurs read-side (Decision, Companion, Knowledge, Performance) — **en lecture seule, via événements** (Loi 7).

## Objets liés
Mission, Task, User, Vehicle

## Agrégats
Racine d'agrégat.

## Valeurs métier
DateRange

## Identifiant
UUID.

## Cycle de vie
Voir OBJECT_LIFECYCLE. Résumé : Planifié → Réalisé → Reporté

## États
Planifié → Réalisé → Reporté

## Transitions
En avant uniquement lorsque le cycle est commercial/opérationnel ; toute transition émet un événement + une entrée d'historique.

## Création
Naît avec id + propriétaire (Company) + événement de création + entrée d'historique.

## Modification
Autorisée tant que les invariants le permettent ; chaque modification est historisée.

## Archivage
Archivage/désactivation (soft) plutôt que destruction (Loi 5).

## Suppression
Réservée aux brouillons ; **interdite** pour cette donnée métier (archivage uniquement — Loi 5).

## Événements publiés
- `SlotScheduled` — déclencheur, consommateurs et impact : voir events/.
- `SlotRescheduled` — déclencheur, consommateurs et impact : voir events/.

## Événements consommés
En principe aucun (les objets cœur publient ; les moteurs consomment). Voir events/.

## Contraintes
Un créneau n'appartient qu'à une Mission.

## Invariants
Un créneau n'appartient qu'à une Mission.

## Validation
Invariants vérifiés à la création et à chaque transition ; aucune valeur inventée.

## Historisation
Append-only via **History** (date, utilisateur, action) ; structurant → **Event** (Loi 4/5).

## Permissions
Tenant **Company** ; `company_id` du contexte d'auth, jamais du client ; mismatch → introuvable. Voir OBJECT_RULES § Permissions.

## API concernées
À définir en Step 3+ (hors périmètre du Domain Model).

## Persistance
À définir en Step 3+ (hors périmètre du Domain Model).

## Tests attendus
À définir en Step 3+ (hors périmètre du Domain Model).

## Évolutions prévues
Optimisation de tournées.

## Related Documents
[../OBJECT_RULES.md](../OBJECT_RULES.md) · [../OBJECT_RELATIONSHIPS.md](../OBJECT_RELATIONSHIPS.md) · [../DOMAIN_GLOSSARY.md](../DOMAIN_GLOSSARY.md)

## Next Reading
[../OBJECT_CATALOG.md](../OBJECT_CATALOG.md)

## Changelog
- 1.0 (2026-08-02) — Fiche initiale (Agrégat racine).
