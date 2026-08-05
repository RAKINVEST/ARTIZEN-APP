# Flow — Partager un document

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [../FLOW_CATALOG.md](../FLOW_CATALOG.md) — **Used By:** implementation, ui — **Niveau:** 2 · Architecture · **Catégorie:** Média

## Nom
Partager un document

## Mission
Partager une ressource (savoir-faire).

## Objectif métier
Partager une ressource (savoir-faire).

## Déclencheur
« Partager »

## Préconditions
Utilisateur authentifié ; tenant Company ; droits requis (voir FLOW_PERMISSIONS).

## Acteur principal
Artisan

## Acteurs secondaires
Communauté

## Objets concernés
Document, Resource

## Engines concernés
Import/Export

## Entrées
Document, visibilité

## Sorties
Ressource publiée

## Étapes détaillées
1. **Import/Export** — Publier une copie selon la visibilité → événement `ResourcePublished` (contrôle : invariants ; résultat : étape validée).

## Décisions & branches possibles
Privé/Entreprise/Groupe/Public

## Diagramme de séquence
```mermaid
sequenceDiagram
  actor A as Artisan
  participant E_ImportExport as Import/Export
  participant BUS as Bus d'événements
  A->>E_ImportExport: Publier une copie selon la visibilité
  E_ImportExport-->>BUS: ResourcePublished
```

## États
Voir les machines canoniques : [../FLOW_STATES.md](../FLOW_STATES.md).

## Événements publiés
- `ResourcePublished`

## Événements consommés
—

## Permissions
Voir [../FLOW_PERMISSIONS.md](../FLOW_PERMISSIONS.md) (famille **Média**). Action irréversible → confirmation explicite.

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
Asynchrone.

## Fin du processus
Ressource publiée

## Critères de réussite
Partage du savoir, jamais des données client.

## Related Documents
[../FLOW_STATES.md](../FLOW_STATES.md) · [../FLOW_EVENTS.md](../FLOW_EVENTS.md) · [../FLOW_ERRORS.md](../FLOW_ERRORS.md) · [../FLOW_PERMISSIONS.md](../FLOW_PERMISSIONS.md)

## Next Reading
[../FLOW_CATALOG.md](../FLOW_CATALOG.md)

## Changelog
- 1.0 (2026-08-02) — Fiche de flux initiale.
