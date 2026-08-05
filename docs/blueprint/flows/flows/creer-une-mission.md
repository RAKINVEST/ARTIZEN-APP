# Flow — Créer une mission

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [../FLOW_CATALOG.md](../FLOW_CATALOG.md) — **Used By:** implementation, ui — **Niveau:** 2 · Architecture · **Catégorie:** Mission

## Nom
Créer une mission

## Mission
Ouvrir la mission (unité de travail).

## Objectif métier
Ouvrir la mission (unité de travail).

## Déclencheur
« Ouvrir la mission »

## Préconditions
Utilisateur authentifié ; tenant Company ; droits requis (voir FLOW_PERMISSIONS).

## Acteur principal
Artisan

## Acteurs secondaires
—

## Objets concernés
Mission

## Engines concernés
Mission

## Entrées
Client, site

## Sorties
Mission en Prospect

## Étapes détaillées
1. **Mission** — Créer la mission → événement `MissionCreated` (contrôle : invariants ; résultat : étape validée).

## Décisions & branches possibles
Voir machine Mission (FLOW_STATES)

## Diagramme de séquence
```mermaid
sequenceDiagram
  actor A as Artisan
  participant E_Mission as Mission
  participant BUS as Bus d'événements
  A->>E_Mission: Créer la mission
  E_Mission-->>BUS: MissionCreated
```

## États
Voir les machines canoniques : [../FLOW_STATES.md](../FLOW_STATES.md).

## Événements publiés
- `MissionCreated`

## Événements consommés
MissionOpened

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
Objectif clair ; **≤ 2 étapes** ; retour immédiat (progression, confirmation, annulation) ; langage artisan.

## Performance
Synchrone.

## Fin du processus
Mission créée, au tableau de bord

## Critères de réussite
La mission apparaît, prête à composer.

## Related Documents
[../FLOW_STATES.md](../FLOW_STATES.md) · [../FLOW_EVENTS.md](../FLOW_EVENTS.md) · [../FLOW_ERRORS.md](../FLOW_ERRORS.md) · [../FLOW_PERMISSIONS.md](../FLOW_PERMISSIONS.md)

## Next Reading
[../FLOW_CATALOG.md](../FLOW_CATALOG.md)

## Changelog
- 1.0 (2026-08-02) — Fiche de flux initiale.
