# Blueprint Repository — ARTIZEN

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** — (racine) — **Used By:** tout le projet
> **Niveau documentaire:** 1 · Vision

## Objective
Ce dépôt est la **source de vérité officielle** d'Artizen. Aucune architecture
importante ne peut exister hors du Blueprint. Il est conçu pour être lu aussi
bien par des humains que par des IA : versionné, modulaire, navigable,
maintenable, extensible et cohérent.

## Qu'est-ce qu'Artizen ?
Artizen n'est pas un logiciel de devis. C'est un **système d'exploitation de
l'entreprise artisanale** (Constitution, Loi 20) : une **mémoire**, un
**compagnon**, un **conseiller** et un **moteur métier**. L'unité de pensée est
l'**intervention** ; l'unité de travail est la **mission** ; le devis n'en est
qu'une projection commerciale.

## Comment le Blueprint est organisé (3 niveaux)
| Niveau | Contenu | Stabilité | Dossiers |
|---|---|---|---|
| **1 · Vision** | intention durable | très stable | `manifesto/` `constitution/` `product/` `ai/` |
| **2 · Architecture** | structure du domaine | stable | `architecture/` `domain/` `engines/` `events/` `contracts/` `adr/` |
| **3 · Implémentation** | exécution | évolutif | `implementation/` `ui/` `quality/` `templates/` `glossary/` |

## Comment naviguer
La porte d'entrée est **[INDEX.md](INDEX.md)**. Chaque document déclare
`Depends On`, `Used By`, `Next Reading` : la lecture est guidée de proche en
proche. Le vocabulaire de référence est dans **[glossary/](glossary/README.md)**.

## Ordre de lecture recommandé
1. `manifesto/` → 2. `constitution/` → 3. `architecture/` → 4. `domain/` →
5. `engines/` → 6. `events/` → 7. `contracts/` → 8. `product/` →
9. `implementation/` → 10. `templates/` → 11. `adr/`.

## Documents prioritaires
La **Constitution** (`constitution/`) prime sur tout. Toute nouvelle idée qui
viole une loi est rejetée, même utile. En cas de conflit : Législation →
Entreprise → Utilisateur → Statistiques (Constitution, priorité).

## Conventions
Format unique, versionnement et règles qualité : voir
**[quality/](quality/README.md)**. Chaque nouveau document part d'un modèle de
**[templates/](templates/README.md)**.

## Forbidden
- Créer une architecture importante hors Blueprint.
- Dupliquer une information (une seule source de vérité).
- Mélanger données métier et interface.
- Introduire une fonctionnalité dans ce dépôt : le Blueprint **décrit**, il
  n'**implémente** pas.

## Acceptance Criteria
Arborescence complète · tous les README présents · tous les templates présents ·
conventions écrites · navigation complète · liens cohérents.

## Related Documents
[INDEX.md](INDEX.md) · [CHANGELOG.md](CHANGELOG.md) · [constitution/](constitution/README.md)

## Next Reading
[INDEX.md](INDEX.md)

## Changelog
- 1.0 (2026-08-02) — Création du Blueprint Repository.
