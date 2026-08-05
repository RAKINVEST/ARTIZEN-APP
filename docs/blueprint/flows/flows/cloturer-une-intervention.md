# Flow — Clôturer une intervention

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [../FLOW_CATALOG.md](../FLOW_CATALOG.md) — **Used By:** implementation, ui — **Niveau:** 2 · Architecture · **Catégorie:** Mission

## Nom
Clôturer une intervention

## Mission
Terminer l'intervention et capitaliser.

## Objectif métier
Terminer l'intervention et capitaliser.

## Déclencheur
Fin de chantier

## Préconditions
Utilisateur authentifié ; tenant Company ; droits requis (voir FLOW_PERMISSIONS).

## Acteur principal
Artisan

## Acteurs secondaires
—

## Objets concernés
Mission, Intervention

## Engines concernés
Mission, Performance, Knowledge

## Entrées
Temps réel, photos

## Sorties
Intervention contrôlée

## Étapes détaillées
1. **Mission** — Passer l'intervention à Contrôlée → événement `MissionStateChanged` (contrôle : invariants ; résultat : étape validée).
2. **Mission** — Consigner le temps réel → événement `TimeRecorded` (contrôle : invariants ; résultat : étape validée).
3. **Knowledge** — Proposer une fiche d'expérience (opt-in) (contrôle : invariants ; résultat : étape validée).

## Décisions & branches possibles
Rentable / à améliorer (Performance)

## Diagramme de séquence
```mermaid
sequenceDiagram
  actor A as Artisan
  participant E_Mission as Mission
  participant E_Knowledge as Knowledge
  participant BUS as Bus d'événements
  A->>E_Mission: Passer l'intervention à Contrôlée
  E_Mission-->>BUS: MissionStateChanged
  A->>E_Mission: Consigner le temps réel
  E_Mission-->>BUS: TimeRecorded
  A->>E_Knowledge: Proposer une fiche d'expérience (opt-in)
```

## États
Voir les machines canoniques : [../FLOW_STATES.md](../FLOW_STATES.md).

## Événements publiés
- `MissionStateChanged`
- `TimeRecorded`

## Événements consommés
—

## Permissions
Voir [../FLOW_PERMISSIONS.md](../FLOW_PERMISSIONS.md) (famille **Mission**). Action irréversible → confirmation explicite.

## Validation
Invariants du Domain Model (Step 2) vérifiés ; aucune donnée inventée ; le PDF/source fait foi le cas échéant.

## Erreurs possibles
Voir [../FLOW_ERRORS.md](../FLOW_ERRORS.md) : validation, permission (404 cross-tenant), conflit, ressource absente, échec IA/OCR/stockage/réseau.

## Rollback
Tant que l'objet est un brouillon : annulation directe. Après figement : compensation tracée (ex. avoir), jamais de destruction.

## Historisation
Chaque étape est journalisée (History, append-only — Loi 5).

## UX
Objectif clair ; **≤ 3 étapes** ; retour immédiat (progression, confirmation, annulation) ; langage artisan.

## Performance
Analyse asynchrone.

## Fin du processus
Intervention clôturée

## Critères de réussite
5 temps enregistrés, savoir capitalisé.

## Related Documents
[../FLOW_STATES.md](../FLOW_STATES.md) · [../FLOW_EVENTS.md](../FLOW_EVENTS.md) · [../FLOW_ERRORS.md](../FLOW_ERRORS.md) · [../FLOW_PERMISSIONS.md](../FLOW_PERMISSIONS.md)

## Next Reading
[../FLOW_CATALOG.md](../FLOW_CATALOG.md)

## Changelog
- 1.0 (2026-08-02) — Fiche de flux initiale.
