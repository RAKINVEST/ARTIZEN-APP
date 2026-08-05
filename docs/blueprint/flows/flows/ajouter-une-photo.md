# Flow — Ajouter une photo

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [../FLOW_CATALOG.md](../FLOW_CATALOG.md) — **Used By:** implementation, ui — **Niveau:** 2 · Architecture · **Catégorie:** Média

## Nom
Ajouter une photo

## Mission
Attacher une photo à un objet.

## Objectif métier
Attacher une photo à un objet.

## Déclencheur
Prise de photo

## Préconditions
Utilisateur authentifié ; tenant Company ; droits requis (voir FLOW_PERMISSIONS).

## Acteur principal
Artisan

## Acteurs secondaires
—

## Objets concernés
Photo

## Engines concernés
Media, Storage

## Entrées
Image, contexte

## Sorties
Photo attachée

## Étapes détaillées
1. **Storage** — Stocker l'image (contrôle : invariants ; résultat : étape validée).
2. **Media** — Attacher + annoter → événement `PhotoAdded` (contrôle : invariants ; résultat : étape validée).

## Décisions & branches possibles
Avant/pendant/après/défaut

## Diagramme de séquence
```mermaid
sequenceDiagram
  actor A as Artisan
  participant E_Storage as Storage
  participant E_Media as Media
  participant BUS as Bus d'événements
  A->>E_Storage: Stocker l'image
  A->>E_Media: Attacher + annoter
  E_Media-->>BUS: PhotoAdded
```

## États
Voir les machines canoniques : [../FLOW_STATES.md](../FLOW_STATES.md).

## Événements publiés
- `PhotoAdded`

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
Objectif clair ; **≤ 2 étapes** ; retour immédiat (progression, confirmation, annulation) ; langage artisan.

## Performance
Upload asynchrone.

## Fin du processus
Photo attachée

## Critères de réussite
Photo classée, annotable.

## Related Documents
[../FLOW_STATES.md](../FLOW_STATES.md) · [../FLOW_EVENTS.md](../FLOW_EVENTS.md) · [../FLOW_ERRORS.md](../FLOW_ERRORS.md) · [../FLOW_PERMISSIONS.md](../FLOW_PERMISSIONS.md)

## Next Reading
[../FLOW_CATALOG.md](../FLOW_CATALOG.md)

## Changelog
- 1.0 (2026-08-02) — Fiche de flux initiale.
